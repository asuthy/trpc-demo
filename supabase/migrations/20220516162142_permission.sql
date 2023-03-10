CREATE TABLE IF NOT EXISTS public.permission
(
    id bigint NOT NULL GENERATED BY DEFAULT AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    name text COLLATE pg_catalog."default" NOT NULL,
    code text COLLATE pg_catalog."default" NOT NULL,
    area text COLLATE pg_catalog."default" NOT NULL,
    description text COLLATE pg_catalog."default",
    created_at date DEFAULT now(),
    CONSTRAINT permission_pkey PRIMARY KEY (id),
    CONSTRAINT permission_name_key UNIQUE (name)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.permission
    OWNER to postgres;

GRANT ALL ON TABLE public.permission TO anon;

GRANT ALL ON TABLE public.permission TO authenticated;

GRANT ALL ON TABLE public.permission TO postgres;

GRANT ALL ON TABLE public.permission TO service_role;

INSERT INTO public.permission
(
    name,
    description,
    code,
    area
) VALUES
(
    'Allow Member Add',
    'Allow an invite to be sent to a user to join the network or team',
    'ALLOW_MEMBER_ADD',
    'Member'
),
(
    'Allow Member Role Change',
    'Allow a member''s role to be changed',
    'ALLOW_MEMBER_ROLE_CHANGE',
    'Member'
),
(
    'Allow Member Remove',
    'Allow a member to be removed from the network or team',
    'ALLOW_MEMBER_REMOVE',
    'Member'
),
(
    'Allow Role Create',
    'Allow a role to be created against the network',
    'ALLOW_ROLE_CREATE',
    'Role'
),
(
    'Allow Role Edit',
    'Allow a network role to be edited',
    'ALLOW_ROLE_EDIT',
    'Role'
),
(
    'Allow Role Delete',
    'Allow an unused role to be deleted',
    'ALLOW_ROLE_DELETE',
    'Role'
),
(
    'Allow Team Create',
    'Allow a team to be created against the current team/network',
    'ALLOW_TEAM_CREATE',
    'Team'
),
(
    'Allow Team Edit',
    'Allow a child team to be edited',
    'ALLOW_TEAM_EDIT',
    'Team'
),
(
    'Allow Team Delete',
    'Allow a child team to be deleted',
    'ALLOW_TEAM_DELETE',
    'Team'
),
(
    'Allow Network Edit',
    'Allow a network to be edited',
    'ALLOW_NETWORK_EDIT',
    'Network'
),
(
    'Allow Network Delete',
    'Allow the network to be deleted',
    'ALLOW_NETWORK_DELETE',
    'Network'
)
ON CONFLICT(id)
DO NOTHING
RETURNING *;
