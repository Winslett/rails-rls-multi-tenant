SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: user_roles; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.user_roles AS ENUM (
    'salesperson',
    'salesmanager'
);


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: contacts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.contacts (
    id bigint NOT NULL,
    name character varying,
    email character varying,
    team_id bigint,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: contacts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.contacts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: contacts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.contacts_id_seq OWNED BY public.contacts.id;


--
-- Name: opportunities; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.opportunities (
    id bigint NOT NULL,
    name character varying,
    status character varying,
    team_id bigint,
    user_id bigint,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: opportunities_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.opportunities_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: opportunities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.opportunities_id_seq OWNED BY public.opportunities.id;


--
-- Name: opportunity_contacts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.opportunity_contacts (
    id bigint NOT NULL,
    opportunity_id bigint,
    contact_id bigint,
    team_id bigint,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: opportunity_contacts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.opportunity_contacts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: opportunity_contacts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.opportunity_contacts_id_seq OWNED BY public.opportunity_contacts.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: teams; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.teams (
    id bigint NOT NULL,
    name character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    subdomain character varying
);


--
-- Name: teams_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.teams_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: teams_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.teams_id_seq OWNED BY public.teams.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    name character varying,
    email character varying,
    team_id bigint,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    role public.user_roles DEFAULT 'salesperson'::public.user_roles NOT NULL
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: contacts id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contacts ALTER COLUMN id SET DEFAULT nextval('public.contacts_id_seq'::regclass);


--
-- Name: opportunities id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.opportunities ALTER COLUMN id SET DEFAULT nextval('public.opportunities_id_seq'::regclass);


--
-- Name: opportunity_contacts id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.opportunity_contacts ALTER COLUMN id SET DEFAULT nextval('public.opportunity_contacts_id_seq'::regclass);


--
-- Name: teams id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.teams ALTER COLUMN id SET DEFAULT nextval('public.teams_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: contacts contacts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contacts
    ADD CONSTRAINT contacts_pkey PRIMARY KEY (id);


--
-- Name: opportunities opportunities_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.opportunities
    ADD CONSTRAINT opportunities_pkey PRIMARY KEY (id);


--
-- Name: opportunity_contacts opportunity_contacts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.opportunity_contacts
    ADD CONSTRAINT opportunity_contacts_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: teams teams_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.teams
    ADD CONSTRAINT teams_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_contacts_on_team_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_contacts_on_team_id ON public.contacts USING btree (team_id);


--
-- Name: index_opportunities_on_team_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_opportunities_on_team_id ON public.opportunities USING btree (team_id);


--
-- Name: index_opportunities_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_opportunities_on_user_id ON public.opportunities USING btree (user_id);


--
-- Name: index_opportunity_contacts_on_contact_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_opportunity_contacts_on_contact_id ON public.opportunity_contacts USING btree (contact_id);


--
-- Name: index_opportunity_contacts_on_opportunity_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_opportunity_contacts_on_opportunity_id ON public.opportunity_contacts USING btree (opportunity_id);


--
-- Name: index_opportunity_contacts_on_team_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_opportunity_contacts_on_team_id ON public.opportunity_contacts USING btree (team_id);


--
-- Name: index_teams_on_subdomain; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_teams_on_subdomain ON public.teams USING btree (subdomain);


--
-- Name: index_users_on_team_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_on_team_id ON public.users USING btree (team_id);


--
-- Name: opportunity_contacts fk_rails_443367352b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.opportunity_contacts
    ADD CONSTRAINT fk_rails_443367352b FOREIGN KEY (opportunity_id) REFERENCES public.opportunities(id);


--
-- Name: opportunities fk_rails_5677d87d29; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.opportunities
    ADD CONSTRAINT fk_rails_5677d87d29 FOREIGN KEY (team_id) REFERENCES public.teams(id);


--
-- Name: opportunities fk_rails_7a1e18e277; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.opportunities
    ADD CONSTRAINT fk_rails_7a1e18e277 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: opportunity_contacts fk_rails_9f884b177e; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.opportunity_contacts
    ADD CONSTRAINT fk_rails_9f884b177e FOREIGN KEY (team_id) REFERENCES public.teams(id);


--
-- Name: opportunity_contacts fk_rails_b0c61d3508; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.opportunity_contacts
    ADD CONSTRAINT fk_rails_b0c61d3508 FOREIGN KEY (contact_id) REFERENCES public.contacts(id);


--
-- Name: users fk_rails_b2bbf87303; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT fk_rails_b2bbf87303 FOREIGN KEY (team_id) REFERENCES public.teams(id);


--
-- Name: contacts fk_rails_c3c0f1ba1a; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contacts
    ADD CONSTRAINT fk_rails_c3c0f1ba1a FOREIGN KEY (team_id) REFERENCES public.teams(id);


--
-- Name: contacts; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.contacts ENABLE ROW LEVEL SECURITY;

--
-- Name: opportunities; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.opportunities ENABLE ROW LEVEL SECURITY;

--
-- Name: opportunity_contacts; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.opportunity_contacts ENABLE ROW LEVEL SECURITY;

--
-- Name: contacts salesmanager_contacts_policy; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY salesmanager_contacts_policy ON public.contacts TO salesmanager USING ((team_id = (NULLIF(current_setting('rls.team_id'::text, false), ''::text))::integer));


--
-- Name: opportunities salesmanager_opportunities_policy; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY salesmanager_opportunities_policy ON public.opportunities TO salesmanager USING ((team_id = (NULLIF(current_setting('rls.team_id'::text, false), ''::text))::integer));


--
-- Name: opportunity_contacts salesmanager_opportunity_contacts_policy; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY salesmanager_opportunity_contacts_policy ON public.opportunity_contacts TO salesmanager USING ((team_id = (NULLIF(current_setting('rls.team_id'::text, false), ''::text))::integer));


--
-- Name: users salesmanager_users_policy; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY salesmanager_users_policy ON public.users TO salesmanager USING ((team_id = (NULLIF(current_setting('rls.team_id'::text, false), ''::text))::integer));


--
-- Name: contacts salesperson_contacts_policy; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY salesperson_contacts_policy ON public.contacts TO salesperson USING ((team_id = (NULLIF(current_setting('rls.team_id'::text, false), ''::text))::integer));


--
-- Name: opportunities salesperson_opportunities_policy; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY salesperson_opportunities_policy ON public.opportunities TO salesperson USING ((user_id = (NULLIF(current_setting('rls.user_id'::text, false), ''::text))::integer));


--
-- Name: opportunity_contacts salesperson_opportunity_contacts_policy; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY salesperson_opportunity_contacts_policy ON public.opportunity_contacts TO salesperson USING ((team_id = (NULLIF(current_setting('rls.team_id'::text, false), ''::text))::integer));


--
-- Name: users salesperson_users_policy; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY salesperson_users_policy ON public.users TO salesperson USING ((team_id = (NULLIF(current_setting('rls.team_id'::text, false), ''::text))::integer));


--
-- Name: users; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.users ENABLE ROW LEVEL SECURITY;

--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20240216161312'),
('20240216160730'),
('20240214170118'),
('20240129183928'),
('20240129182842'),
('20240129182834'),
('20240129182741'),
('20240129182740');

