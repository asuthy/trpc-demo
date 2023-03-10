import {
  createTRPCProxyClient,
  createWSClient,
  httpLink,
  splitLink,
  wsLink
} from '@trpc/client'
import ws from 'ws'
import { AppRouter } from '/workspace/apis/test-api/src'

globalThis.WebSocket = ws as any

const wsClient = createWSClient({
  url: `ws://test-api:3000`
})
const trpc = createTRPCProxyClient<AppRouter>({
  links: [
    // call subscriptions through websockets and the rest over http
    splitLink({
      condition(op) {
        return op.type === 'subscription'
      },
      true: wsLink({
        client: wsClient
      }),
      false: httpLink({
        url: `http://test-api:3000`
      })
    })
  ]
})

async function main() {
  const helloResponse = await trpc.greeting.hello.query({
    name: 'world'
  })

  console.log('helloResponse', helloResponse)

  const permissionResponse = await trpc.permission.getAll.query()

  console.log('permissionResponse', permissionResponse)

  const createPostRes = await trpc.post.createPost.mutate({
    title: 'hello world',
    text: 'check out https://tRPC.io'
  })
  console.log('createPostResponse', createPostRes)

  let count = 0
  await new Promise<void>(resolve => {
    const subscription = trpc.post.randomNumber.subscribe(undefined, {
      onData(data) {
        // ^ note that `data` here is inferred
        console.log('received', data)
        count++
        if (count > 3) {
          // stop after 3 pulls
          subscription.unsubscribe()
          resolve()
        }
      },
      onError(err) {
        console.error('error', err)
      }
    })
  })
  wsClient.close()
}

void main()
