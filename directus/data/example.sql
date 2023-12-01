--
-- PostgreSQL database dump
--

-- Dumped from database version 15.5
-- Dumped by pg_dump version 15.5

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: Organisation; Type: TABLE; Schema: public; Owner: default
--

CREATE TABLE public."Organisation" (
    name character varying(255) NOT NULL,
    status character varying(255) DEFAULT 'draft'::character varying NOT NULL,
    date_created timestamp with time zone,
    user_updated uuid,
    date_updated timestamp with time zone,
    color_scheme character varying(255),
    image uuid,
    description text,
    point_units character varying(255) DEFAULT 'pts'::character varying
);


ALTER TABLE public."Organisation" OWNER TO "default";

--
-- Name: directus_activity; Type: TABLE; Schema: public; Owner: default
--

CREATE TABLE public.directus_activity (
    id integer NOT NULL,
    action character varying(45) NOT NULL,
    "user" uuid,
    "timestamp" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    ip character varying(50),
    user_agent character varying(255),
    collection character varying(64) NOT NULL,
    item character varying(255) NOT NULL,
    comment text,
    origin character varying(255)
);


ALTER TABLE public.directus_activity OWNER TO "default";

--
-- Name: directus_activity_id_seq; Type: SEQUENCE; Schema: public; Owner: default
--

CREATE SEQUENCE public.directus_activity_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_activity_id_seq OWNER TO "default";

--
-- Name: directus_activity_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: default
--

ALTER SEQUENCE public.directus_activity_id_seq OWNED BY public.directus_activity.id;


--
-- Name: directus_collections; Type: TABLE; Schema: public; Owner: default
--

CREATE TABLE public.directus_collections (
    collection character varying(64) NOT NULL,
    icon character varying(30),
    note text,
    display_template character varying(255),
    hidden boolean DEFAULT false NOT NULL,
    singleton boolean DEFAULT false NOT NULL,
    translations json,
    archive_field character varying(64),
    archive_app_filter boolean DEFAULT true NOT NULL,
    archive_value character varying(255),
    unarchive_value character varying(255),
    sort_field character varying(64),
    accountability character varying(255) DEFAULT 'all'::character varying,
    color character varying(255),
    item_duplication_fields json,
    sort integer,
    "group" character varying(64),
    collapse character varying(255) DEFAULT 'open'::character varying NOT NULL,
    preview_url character varying(255),
    versioning boolean DEFAULT false NOT NULL
);


ALTER TABLE public.directus_collections OWNER TO "default";

--
-- Name: directus_dashboards; Type: TABLE; Schema: public; Owner: default
--

CREATE TABLE public.directus_dashboards (
    id uuid NOT NULL,
    name character varying(255) NOT NULL,
    icon character varying(30) DEFAULT 'dashboard'::character varying NOT NULL,
    note text,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid,
    color character varying(255)
);


ALTER TABLE public.directus_dashboards OWNER TO "default";

--
-- Name: directus_extensions; Type: TABLE; Schema: public; Owner: default
--

CREATE TABLE public.directus_extensions (
    name character varying(255) NOT NULL,
    enabled boolean DEFAULT true NOT NULL
);


ALTER TABLE public.directus_extensions OWNER TO "default";

--
-- Name: directus_fields; Type: TABLE; Schema: public; Owner: default
--

CREATE TABLE public.directus_fields (
    id integer NOT NULL,
    collection character varying(64) NOT NULL,
    field character varying(64) NOT NULL,
    special character varying(64),
    interface character varying(64),
    options json,
    display character varying(64),
    display_options json,
    readonly boolean DEFAULT false NOT NULL,
    hidden boolean DEFAULT false NOT NULL,
    sort integer,
    width character varying(30) DEFAULT 'full'::character varying,
    translations json,
    note text,
    conditions json,
    required boolean DEFAULT false,
    "group" character varying(64),
    validation json,
    validation_message text
);


ALTER TABLE public.directus_fields OWNER TO "default";

--
-- Name: directus_fields_id_seq; Type: SEQUENCE; Schema: public; Owner: default
--

CREATE SEQUENCE public.directus_fields_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_fields_id_seq OWNER TO "default";

--
-- Name: directus_fields_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: default
--

ALTER SEQUENCE public.directus_fields_id_seq OWNED BY public.directus_fields.id;


--
-- Name: directus_files; Type: TABLE; Schema: public; Owner: default
--

CREATE TABLE public.directus_files (
    id uuid NOT NULL,
    storage character varying(255) NOT NULL,
    filename_disk character varying(255),
    filename_download character varying(255) NOT NULL,
    title character varying(255),
    type character varying(255),
    folder uuid,
    uploaded_by uuid,
    uploaded_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    modified_by uuid,
    modified_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    charset character varying(50),
    filesize bigint,
    width integer,
    height integer,
    duration integer,
    embed character varying(200),
    description text,
    location text,
    tags text,
    metadata json
);


ALTER TABLE public.directus_files OWNER TO "default";

--
-- Name: directus_flows; Type: TABLE; Schema: public; Owner: default
--

CREATE TABLE public.directus_flows (
    id uuid NOT NULL,
    name character varying(255) NOT NULL,
    icon character varying(30),
    color character varying(255),
    description text,
    status character varying(255) DEFAULT 'active'::character varying NOT NULL,
    trigger character varying(255),
    accountability character varying(255) DEFAULT 'all'::character varying,
    options json,
    operation uuid,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid
);


ALTER TABLE public.directus_flows OWNER TO "default";

--
-- Name: directus_folders; Type: TABLE; Schema: public; Owner: default
--

CREATE TABLE public.directus_folders (
    id uuid NOT NULL,
    name character varying(255) NOT NULL,
    parent uuid
);


ALTER TABLE public.directus_folders OWNER TO "default";

--
-- Name: directus_migrations; Type: TABLE; Schema: public; Owner: default
--

CREATE TABLE public.directus_migrations (
    version character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    "timestamp" timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.directus_migrations OWNER TO "default";

--
-- Name: directus_notifications; Type: TABLE; Schema: public; Owner: default
--

CREATE TABLE public.directus_notifications (
    id integer NOT NULL,
    "timestamp" timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    status character varying(255) DEFAULT 'inbox'::character varying,
    recipient uuid NOT NULL,
    sender uuid,
    subject character varying(255) NOT NULL,
    message text,
    collection character varying(64),
    item character varying(255)
);


ALTER TABLE public.directus_notifications OWNER TO "default";

--
-- Name: directus_notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: default
--

CREATE SEQUENCE public.directus_notifications_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_notifications_id_seq OWNER TO "default";

--
-- Name: directus_notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: default
--

ALTER SEQUENCE public.directus_notifications_id_seq OWNED BY public.directus_notifications.id;


--
-- Name: directus_operations; Type: TABLE; Schema: public; Owner: default
--

CREATE TABLE public.directus_operations (
    id uuid NOT NULL,
    name character varying(255),
    key character varying(255) NOT NULL,
    type character varying(255) NOT NULL,
    position_x integer NOT NULL,
    position_y integer NOT NULL,
    options json,
    resolve uuid,
    reject uuid,
    flow uuid NOT NULL,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid
);


ALTER TABLE public.directus_operations OWNER TO "default";

--
-- Name: directus_panels; Type: TABLE; Schema: public; Owner: default
--

CREATE TABLE public.directus_panels (
    id uuid NOT NULL,
    dashboard uuid NOT NULL,
    name character varying(255),
    icon character varying(30) DEFAULT NULL::character varying,
    color character varying(10),
    show_header boolean DEFAULT false NOT NULL,
    note text,
    type character varying(255) NOT NULL,
    position_x integer NOT NULL,
    position_y integer NOT NULL,
    width integer NOT NULL,
    height integer NOT NULL,
    options json,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid
);


ALTER TABLE public.directus_panels OWNER TO "default";

--
-- Name: directus_permissions; Type: TABLE; Schema: public; Owner: default
--

CREATE TABLE public.directus_permissions (
    id integer NOT NULL,
    role uuid,
    collection character varying(64) NOT NULL,
    action character varying(10) NOT NULL,
    permissions json,
    validation json,
    presets json,
    fields text
);


ALTER TABLE public.directus_permissions OWNER TO "default";

--
-- Name: directus_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: default
--

CREATE SEQUENCE public.directus_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_permissions_id_seq OWNER TO "default";

--
-- Name: directus_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: default
--

ALTER SEQUENCE public.directus_permissions_id_seq OWNED BY public.directus_permissions.id;


--
-- Name: directus_presets; Type: TABLE; Schema: public; Owner: default
--

CREATE TABLE public.directus_presets (
    id integer NOT NULL,
    bookmark character varying(255),
    "user" uuid,
    role uuid,
    collection character varying(64),
    search character varying(100),
    layout character varying(100) DEFAULT 'tabular'::character varying,
    layout_query json,
    layout_options json,
    refresh_interval integer,
    filter json,
    icon character varying(30) DEFAULT 'bookmark'::character varying,
    color character varying(255)
);


ALTER TABLE public.directus_presets OWNER TO "default";

--
-- Name: directus_presets_id_seq; Type: SEQUENCE; Schema: public; Owner: default
--

CREATE SEQUENCE public.directus_presets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_presets_id_seq OWNER TO "default";

--
-- Name: directus_presets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: default
--

ALTER SEQUENCE public.directus_presets_id_seq OWNED BY public.directus_presets.id;


--
-- Name: directus_relations; Type: TABLE; Schema: public; Owner: default
--

CREATE TABLE public.directus_relations (
    id integer NOT NULL,
    many_collection character varying(64) NOT NULL,
    many_field character varying(64) NOT NULL,
    one_collection character varying(64),
    one_field character varying(64),
    one_collection_field character varying(64),
    one_allowed_collections text,
    junction_field character varying(64),
    sort_field character varying(64),
    one_deselect_action character varying(255) DEFAULT 'nullify'::character varying NOT NULL
);


ALTER TABLE public.directus_relations OWNER TO "default";

--
-- Name: directus_relations_id_seq; Type: SEQUENCE; Schema: public; Owner: default
--

CREATE SEQUENCE public.directus_relations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_relations_id_seq OWNER TO "default";

--
-- Name: directus_relations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: default
--

ALTER SEQUENCE public.directus_relations_id_seq OWNED BY public.directus_relations.id;


--
-- Name: directus_revisions; Type: TABLE; Schema: public; Owner: default
--

CREATE TABLE public.directus_revisions (
    id integer NOT NULL,
    activity integer NOT NULL,
    collection character varying(64) NOT NULL,
    item character varying(255) NOT NULL,
    data json,
    delta json,
    parent integer,
    version uuid
);


ALTER TABLE public.directus_revisions OWNER TO "default";

--
-- Name: directus_revisions_id_seq; Type: SEQUENCE; Schema: public; Owner: default
--

CREATE SEQUENCE public.directus_revisions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_revisions_id_seq OWNER TO "default";

--
-- Name: directus_revisions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: default
--

ALTER SEQUENCE public.directus_revisions_id_seq OWNED BY public.directus_revisions.id;


--
-- Name: directus_roles; Type: TABLE; Schema: public; Owner: default
--

CREATE TABLE public.directus_roles (
    id uuid NOT NULL,
    name character varying(100) NOT NULL,
    icon character varying(30) DEFAULT 'supervised_user_circle'::character varying NOT NULL,
    description text,
    ip_access text,
    enforce_tfa boolean DEFAULT false NOT NULL,
    admin_access boolean DEFAULT false NOT NULL,
    app_access boolean DEFAULT true NOT NULL
);


ALTER TABLE public.directus_roles OWNER TO "default";

--
-- Name: directus_sessions; Type: TABLE; Schema: public; Owner: default
--

CREATE TABLE public.directus_sessions (
    token character varying(64) NOT NULL,
    "user" uuid,
    expires timestamp with time zone NOT NULL,
    ip character varying(255),
    user_agent character varying(255),
    share uuid,
    origin character varying(255)
);


ALTER TABLE public.directus_sessions OWNER TO "default";

--
-- Name: directus_settings; Type: TABLE; Schema: public; Owner: default
--

CREATE TABLE public.directus_settings (
    id integer NOT NULL,
    project_name character varying(100) DEFAULT 'Directus'::character varying NOT NULL,
    project_url character varying(255),
    project_color character varying(255) DEFAULT '#6644FF'::character varying NOT NULL,
    project_logo uuid,
    public_foreground uuid,
    public_background uuid,
    public_note text,
    auth_login_attempts integer DEFAULT 25,
    auth_password_policy character varying(100),
    storage_asset_transform character varying(7) DEFAULT 'all'::character varying,
    storage_asset_presets json,
    custom_css text,
    storage_default_folder uuid,
    basemaps json,
    mapbox_key character varying(255),
    module_bar json,
    project_descriptor character varying(100),
    default_language character varying(255) DEFAULT 'en-US'::character varying NOT NULL,
    custom_aspect_ratios json,
    public_favicon uuid,
    default_appearance character varying(255) DEFAULT 'auto'::character varying NOT NULL,
    default_theme_light character varying(255),
    theme_light_overrides json,
    default_theme_dark character varying(255),
    theme_dark_overrides json
);


ALTER TABLE public.directus_settings OWNER TO "default";

--
-- Name: directus_settings_id_seq; Type: SEQUENCE; Schema: public; Owner: default
--

CREATE SEQUENCE public.directus_settings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_settings_id_seq OWNER TO "default";

--
-- Name: directus_settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: default
--

ALTER SEQUENCE public.directus_settings_id_seq OWNED BY public.directus_settings.id;


--
-- Name: directus_shares; Type: TABLE; Schema: public; Owner: default
--

CREATE TABLE public.directus_shares (
    id uuid NOT NULL,
    name character varying(255),
    collection character varying(64) NOT NULL,
    item character varying(255) NOT NULL,
    role uuid,
    password character varying(255),
    user_created uuid,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    date_start timestamp with time zone,
    date_end timestamp with time zone,
    times_used integer DEFAULT 0,
    max_uses integer
);


ALTER TABLE public.directus_shares OWNER TO "default";

--
-- Name: directus_translations; Type: TABLE; Schema: public; Owner: default
--

CREATE TABLE public.directus_translations (
    id uuid NOT NULL,
    language character varying(255) NOT NULL,
    key character varying(255) NOT NULL,
    value text NOT NULL
);


ALTER TABLE public.directus_translations OWNER TO "default";

--
-- Name: directus_users; Type: TABLE; Schema: public; Owner: default
--

CREATE TABLE public.directus_users (
    id uuid NOT NULL,
    first_name character varying(50),
    last_name character varying(50),
    email character varying(128),
    password character varying(255),
    location character varying(255),
    title character varying(50),
    description text,
    tags json,
    avatar uuid,
    language character varying(255) DEFAULT NULL::character varying,
    tfa_secret character varying(255),
    status character varying(16) DEFAULT 'active'::character varying NOT NULL,
    role uuid,
    token character varying(255),
    last_access timestamp with time zone,
    last_page character varying(255),
    provider character varying(128) DEFAULT 'default'::character varying NOT NULL,
    external_identifier character varying(255),
    auth_data json,
    email_notifications boolean DEFAULT true,
    appearance character varying(255),
    theme_dark character varying(255),
    theme_light character varying(255),
    theme_light_overrides json,
    theme_dark_overrides json
);


ALTER TABLE public.directus_users OWNER TO "default";

--
-- Name: directus_versions; Type: TABLE; Schema: public; Owner: default
--

CREATE TABLE public.directus_versions (
    id uuid NOT NULL,
    key character varying(64) NOT NULL,
    name character varying(255),
    collection character varying(64) NOT NULL,
    item character varying(255) NOT NULL,
    hash character varying(255),
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    date_updated timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid,
    user_updated uuid
);


ALTER TABLE public.directus_versions OWNER TO "default";

--
-- Name: directus_webhooks; Type: TABLE; Schema: public; Owner: default
--

CREATE TABLE public.directus_webhooks (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    method character varying(10) DEFAULT 'POST'::character varying NOT NULL,
    url character varying(255) NOT NULL,
    status character varying(10) DEFAULT 'active'::character varying NOT NULL,
    data boolean DEFAULT true NOT NULL,
    actions character varying(100) NOT NULL,
    collections character varying(255) NOT NULL,
    headers json
);


ALTER TABLE public.directus_webhooks OWNER TO "default";

--
-- Name: directus_webhooks_id_seq; Type: SEQUENCE; Schema: public; Owner: default
--

CREATE SEQUENCE public.directus_webhooks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_webhooks_id_seq OWNER TO "default";

--
-- Name: directus_webhooks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: default
--

ALTER SEQUENCE public.directus_webhooks_id_seq OWNED BY public.directus_webhooks.id;


--
-- Name: directus_activity id; Type: DEFAULT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.directus_activity ALTER COLUMN id SET DEFAULT nextval('public.directus_activity_id_seq'::regclass);


--
-- Name: directus_fields id; Type: DEFAULT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.directus_fields ALTER COLUMN id SET DEFAULT nextval('public.directus_fields_id_seq'::regclass);


--
-- Name: directus_notifications id; Type: DEFAULT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.directus_notifications ALTER COLUMN id SET DEFAULT nextval('public.directus_notifications_id_seq'::regclass);


--
-- Name: directus_permissions id; Type: DEFAULT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.directus_permissions ALTER COLUMN id SET DEFAULT nextval('public.directus_permissions_id_seq'::regclass);


--
-- Name: directus_presets id; Type: DEFAULT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.directus_presets ALTER COLUMN id SET DEFAULT nextval('public.directus_presets_id_seq'::regclass);


--
-- Name: directus_relations id; Type: DEFAULT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.directus_relations ALTER COLUMN id SET DEFAULT nextval('public.directus_relations_id_seq'::regclass);


--
-- Name: directus_revisions id; Type: DEFAULT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.directus_revisions ALTER COLUMN id SET DEFAULT nextval('public.directus_revisions_id_seq'::regclass);


--
-- Name: directus_settings id; Type: DEFAULT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.directus_settings ALTER COLUMN id SET DEFAULT nextval('public.directus_settings_id_seq'::regclass);


--
-- Name: directus_webhooks id; Type: DEFAULT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.directus_webhooks ALTER COLUMN id SET DEFAULT nextval('public.directus_webhooks_id_seq'::regclass);


--
-- Data for Name: Organisation; Type: TABLE DATA; Schema: public; Owner: default
--

COPY public."Organisation" (name, status, date_created, user_updated, date_updated, color_scheme, image, description, point_units) FROM stdin;
\.


--
-- Data for Name: directus_activity; Type: TABLE DATA; Schema: public; Owner: default
--

COPY public.directus_activity (id, action, "user", "timestamp", ip, user_agent, collection, item, comment, origin) FROM stdin;
2	login	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 00:39:50.858+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_users	322b0f19-d22f-44e8-a368-dbe6c84c9619	\N	http://localhost:8001
3	login	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 01:49:45.717+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_users	322b0f19-d22f-44e8-a368-dbe6c84c9619	\N	http://localhost:8001
4	create	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 01:51:25.089+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_files	5bfcbf5e-4d34-421b-aea4-9fad500e6227	\N	http://localhost:8001
5	create	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 01:51:29.98+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_files	013f4c2b-3b40-4a2a-89f7-251bbd9c2190	\N	http://localhost:8001
6	delete	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:01:20.051+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_files	013f4c2b-3b40-4a2a-89f7-251bbd9c2190	\N	http://localhost:8001
7	delete	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:01:20.054+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_files	5bfcbf5e-4d34-421b-aea4-9fad500e6227	\N	http://localhost:8001
8	create	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:09:45.877+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_settings	1	\N	http://localhost:8001
9	create	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:11:16.06+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_files	a4a04573-ed55-4c7d-b81f-efb13d5b768c	\N	http://localhost:8001
10	update	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:12:33.535+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_settings	1	\N	http://localhost:8001
11	create	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:13:37.085+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_files	f092b078-c2d1-4e8a-9648-27ccfdde2002	\N	http://localhost:8001
12	create	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:13:53.735+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_files	73e18cd9-e89b-406d-b3df-67d515ce8a2c	\N	http://localhost:8001
13	update	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:13:55.224+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_settings	1	\N	http://localhost:8001
14	update	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:14:57.316+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_files	73e18cd9-e89b-406d-b3df-67d515ce8a2c	\N	http://localhost:8001
15	update	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:14:57.339+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_files	73e18cd9-e89b-406d-b3df-67d515ce8a2c	\N	http://localhost:8001
16	update	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:15:01.262+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_settings	1	\N	http://localhost:8001
17	create	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:15:47.09+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_files	e012cca9-3214-4c56-a919-87a2b2811be0	\N	http://localhost:8001
18	update	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:15:48.818+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_settings	1	\N	http://localhost:8001
19	create	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:16:09.329+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_files	29f1e786-3bce-4310-a825-47a5d385eebe	\N	http://localhost:8001
20	update	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:16:10.674+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_settings	1	\N	http://localhost:8001
21	update	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:16:48.768+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_settings	1	\N	http://localhost:8001
22	delete	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:17:14.592+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_files	e012cca9-3214-4c56-a919-87a2b2811be0	\N	http://localhost:8001
23	delete	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:17:14.594+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_files	73e18cd9-e89b-406d-b3df-67d515ce8a2c	\N	http://localhost:8001
24	update	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:17:52.022+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_files	a4a04573-ed55-4c7d-b81f-efb13d5b768c	\N	http://localhost:8001
25	update	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:17:52.036+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_files	a4a04573-ed55-4c7d-b81f-efb13d5b768c	\N	http://localhost:8001
26	update	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:18:22.366+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_settings	1	\N	http://localhost:8001
27	update	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:18:31.688+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_settings	1	\N	http://localhost:8001
28	update	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:18:44.83+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_settings	1	\N	http://localhost:8001
29	delete	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:18:51.108+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_files	29f1e786-3bce-4310-a825-47a5d385eebe	\N	http://localhost:8001
30	create	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:20:12.914+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_files	8b4720a8-0811-414d-80bb-b53c54bca47f	\N	http://localhost:8001
31	update	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:20:26.719+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_settings	1	\N	http://localhost:8001
32	create	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:21:12.218+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_files	e532ef31-d2a1-4ad9-b2a7-b609bf6fc355	\N	http://localhost:8001
33	update	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:21:13.836+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_settings	1	\N	http://localhost:8001
34	update	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:21:40.611+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_settings	1	\N	http://localhost:8001
35	update	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:22:44.542+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_settings	1	\N	http://localhost:8001
36	update	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:22:48.478+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_settings	1	\N	http://localhost:8001
37	create	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:28:57.578+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_fields	1	\N	http://localhost:8001
38	create	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:28:57.583+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_fields	2	\N	http://localhost:8001
39	create	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:28:57.588+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_fields	3	\N	http://localhost:8001
40	create	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:28:57.592+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_fields	4	\N	http://localhost:8001
41	create	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:28:57.597+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_fields	5	\N	http://localhost:8001
42	create	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:28:57.601+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_collections	Organisation	\N	http://localhost:8001
43	create	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:30:20.94+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_fields	6	\N	http://localhost:8001
44	create	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:31:01.995+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_fields	7	\N	http://localhost:8001
45	create	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:31:24.28+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_fields	8	\N	http://localhost:8001
46	create	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:31:55.155+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_fields	9	\N	http://localhost:8001
47	update	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:34:38.438+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_collections	Organisation	\N	http://localhost:8001
48	update	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:35:18.282+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_fields	1	\N	http://localhost:8001
49	update	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:35:18.31+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_fields	2	\N	http://localhost:8001
50	update	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:35:18.329+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_fields	3	\N	http://localhost:8001
51	update	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:35:18.349+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_fields	4	\N	http://localhost:8001
52	update	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:35:18.369+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_fields	5	\N	http://localhost:8001
53	update	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:35:18.388+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_fields	6	\N	http://localhost:8001
54	update	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:35:18.411+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_fields	8	\N	http://localhost:8001
55	update	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:35:18.434+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_fields	7	\N	http://localhost:8001
56	update	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:35:18.454+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_fields	9	\N	http://localhost:8001
57	update	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:35:20.655+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_fields	1	\N	http://localhost:8001
58	update	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:35:20.687+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_fields	2	\N	http://localhost:8001
59	update	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:35:20.707+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_fields	3	\N	http://localhost:8001
60	update	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:35:20.73+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_fields	4	\N	http://localhost:8001
61	update	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:35:20.759+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_fields	5	\N	http://localhost:8001
62	update	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:35:20.78+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_fields	6	\N	http://localhost:8001
63	update	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:35:20.803+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_fields	7	\N	http://localhost:8001
64	update	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:35:20.821+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_fields	8	\N	http://localhost:8001
65	update	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:35:20.841+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_fields	9	\N	http://localhost:8001
66	update	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:35:25.528+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_fields	1	\N	http://localhost:8001
67	update	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:35:25.557+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_fields	8	\N	http://localhost:8001
68	update	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:35:25.578+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_fields	2	\N	http://localhost:8001
69	update	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:35:25.596+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_fields	3	\N	http://localhost:8001
70	update	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:35:25.614+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_fields	4	\N	http://localhost:8001
71	update	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:35:25.633+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_fields	5	\N	http://localhost:8001
72	update	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:35:25.653+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_fields	6	\N	http://localhost:8001
73	update	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:35:25.672+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_fields	7	\N	http://localhost:8001
74	update	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:35:25.694+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_fields	9	\N	http://localhost:8001
75	update	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:35:28.499+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_fields	1	\N	http://localhost:8001
76	update	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:35:28.517+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_fields	8	\N	http://localhost:8001
77	update	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:35:28.535+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_fields	7	\N	http://localhost:8001
78	update	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:35:28.556+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_fields	2	\N	http://localhost:8001
79	update	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:35:28.575+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_fields	3	\N	http://localhost:8001
80	update	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:35:28.594+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_fields	4	\N	http://localhost:8001
81	update	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:35:28.616+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_fields	5	\N	http://localhost:8001
82	update	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:35:28.635+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_fields	6	\N	http://localhost:8001
83	update	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:35:28.656+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_fields	9	\N	http://localhost:8001
93	update	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:35:32.238+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_fields	1	\N	http://localhost:8001
94	update	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:35:32.267+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_fields	8	\N	http://localhost:8001
95	update	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:35:32.285+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_fields	7	\N	http://localhost:8001
96	update	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:35:32.301+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_fields	6	\N	http://localhost:8001
97	update	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:35:32.319+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_fields	9	\N	http://localhost:8001
98	update	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:35:32.348+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_fields	2	\N	http://localhost:8001
99	update	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:35:32.365+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_fields	3	\N	http://localhost:8001
100	update	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:35:32.382+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_fields	4	\N	http://localhost:8001
101	update	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:35:32.403+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_fields	5	\N	http://localhost:8001
84	update	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:35:30.683+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_fields	1	\N	http://localhost:8001
85	update	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:35:30.713+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_fields	8	\N	http://localhost:8001
86	update	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:35:30.736+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_fields	7	\N	http://localhost:8001
87	update	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:35:30.753+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_fields	6	\N	http://localhost:8001
88	update	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:35:30.77+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_fields	2	\N	http://localhost:8001
89	update	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:35:30.788+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_fields	3	\N	http://localhost:8001
90	update	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:35:30.805+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_fields	4	\N	http://localhost:8001
91	update	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:35:30.822+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_fields	5	\N	http://localhost:8001
92	update	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:35:30.842+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_fields	9	\N	http://localhost:8001
102	create	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:36:42.466+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_translations	26e6a51a-4ef6-4986-ad0e-d5cd71dacf89	\N	http://localhost:8001
103	update	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:38:03.715+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_fields	9	\N	http://localhost:8001
104	create	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:39:00.622+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_translations	34837161-f9ff-4ac1-bee5-d326153ebe7c	\N	http://localhost:8001
105	update	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:39:17.944+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_fields	6	\N	http://localhost:8001
106	update	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:39:38.307+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_fields	8	\N	http://localhost:8001
107	update	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:39:53.947+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_fields	7	\N	http://localhost:8001
108	update	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:40:10.563+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_settings	1	\N	http://localhost:8001
109	update	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:40:39.172+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_fields	1	\N	http://localhost:8001
110	update	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:41:24.408+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_translations	26e6a51a-4ef6-4986-ad0e-d5cd71dacf89	\N	http://localhost:8001
111	create	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:42:07.984+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_translations	2eafdd21-22c6-4d82-bb8d-4018909b3b92	\N	http://localhost:8001
112	create	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:42:26.749+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_translations	136fa258-da37-47fd-804e-ecc59674ef26	\N	http://localhost:8001
113	update	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:43:04.396+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_fields	9	\N	http://localhost:8001
114	create	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:43:58.016+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_translations	e75dd4a4-ed4d-4944-b24a-0cc66b100c5c	\N	http://localhost:8001
115	update	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:44:01.392+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_fields	2	\N	http://localhost:8001
116	update	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:44:18.561+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_fields	9	\N	http://localhost:8001
117	create	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:44:50.346+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_translations	28628c5f-3832-4c47-be31-6d140e55e373	\N	http://localhost:8001
118	create	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:45:19.048+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_roles	6daea05b-a2e4-4191-8fd9-6aa623563b17	\N	http://localhost:8001
119	create	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:45:19.068+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_permissions	1	\N	http://localhost:8001
120	create	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:45:19.072+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_permissions	2	\N	http://localhost:8001
121	create	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:45:19.077+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_permissions	3	\N	http://localhost:8001
122	create	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:45:19.081+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_permissions	4	\N	http://localhost:8001
123	create	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:45:19.086+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_permissions	5	\N	http://localhost:8001
124	create	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:45:19.092+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_permissions	6	\N	http://localhost:8001
125	create	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:45:19.097+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_permissions	7	\N	http://localhost:8001
126	create	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:45:19.102+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_permissions	8	\N	http://localhost:8001
127	create	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:45:19.108+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_permissions	9	\N	http://localhost:8001
128	create	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:45:19.112+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_permissions	10	\N	http://localhost:8001
129	create	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:45:19.119+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_permissions	11	\N	http://localhost:8001
130	create	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:45:19.126+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_permissions	12	\N	http://localhost:8001
131	create	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:45:19.131+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_permissions	13	\N	http://localhost:8001
132	create	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:45:19.136+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_permissions	14	\N	http://localhost:8001
133	create	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:45:19.139+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_permissions	15	\N	http://localhost:8001
134	create	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:45:19.144+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_permissions	16	\N	http://localhost:8001
135	create	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:45:19.148+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_permissions	17	\N	http://localhost:8001
136	create	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:45:19.152+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_permissions	18	\N	http://localhost:8001
137	create	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:45:19.156+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_permissions	19	\N	http://localhost:8001
138	create	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:45:19.16+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_permissions	20	\N	http://localhost:8001
139	create	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:45:19.164+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_permissions	21	\N	http://localhost:8001
140	create	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:45:19.168+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_permissions	22	\N	http://localhost:8001
141	create	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:45:19.172+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_permissions	23	\N	http://localhost:8001
142	create	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:45:19.177+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_permissions	24	\N	http://localhost:8001
143	create	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:45:51.522+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_permissions	25	\N	http://localhost:8001
144	update	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:46:13.501+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_permissions	25	\N	http://localhost:8001
145	update	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:46:38.807+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_roles	6daea05b-a2e4-4191-8fd9-6aa623563b17	\N	http://localhost:8001
146	delete	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:47:05.853+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_files	8b4720a8-0811-414d-80bb-b53c54bca47f	\N	http://localhost:8001
147	update	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:47:21.01+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_settings	1	\N	http://localhost:8001
148	update	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:47:28.711+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_settings	1	\N	http://localhost:8001
149	delete	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:47:35.251+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	directus_files	e532ef31-d2a1-4ad9-b2a7-b609bf6fc355	\N	http://localhost:8001
\.


--
-- Data for Name: directus_collections; Type: TABLE DATA; Schema: public; Owner: default
--

COPY public.directus_collections (collection, icon, note, display_template, hidden, singleton, translations, archive_field, archive_app_filter, archive_value, unarchive_value, sort_field, accountability, color, item_duplication_fields, sort, "group", collapse, preview_url, versioning) FROM stdin;
Organisation	info	\N	\N	f	t	[{"language":"en-US","translation":"Organisation"},{"language":"fi-FI","translation":"Organisaatio"}]	status	t	archived	draft	\N	all	\N	\N	\N	\N	open	\N	t
\.


--
-- Data for Name: directus_dashboards; Type: TABLE DATA; Schema: public; Owner: default
--

COPY public.directus_dashboards (id, name, icon, note, date_created, user_created, color) FROM stdin;
\.


--
-- Data for Name: directus_extensions; Type: TABLE DATA; Schema: public; Owner: default
--

COPY public.directus_extensions (name, enabled) FROM stdin;
\.


--
-- Data for Name: directus_fields; Type: TABLE DATA; Schema: public; Owner: default
--

COPY public.directus_fields (id, collection, field, special, interface, options, display, display_options, readonly, hidden, sort, width, translations, note, conditions, required, "group", validation, validation_message) FROM stdin;
3	Organisation	date_created	date-created	datetime	\N	datetime	{"relative":true}	t	t	7	half	\N	\N	\N	f	\N	\N	\N
4	Organisation	user_updated	user-updated	select-dropdown-m2o	{"template":"{{avatar.$thumbnail}} {{first_name}} {{last_name}}"}	user	\N	t	t	8	half	\N	\N	\N	f	\N	\N	\N
5	Organisation	date_updated	date-updated	datetime	\N	datetime	{"relative":true}	t	t	9	half	\N	\N	\N	f	\N	\N	\N
6	Organisation	color_scheme	\N	select-color	{"presets":null}	\N	\N	f	f	4	full	[{"language":"fi-FI","translation":"Väriteema"}]	$t:color_scheme_tooltip	\N	t	\N	\N	\N
8	Organisation	description	\N	input-multiline	\N	\N	\N	f	f	2	full	[{"language":"fi-FI","translation":"Kuvaus"}]	\N	\N	f	\N	\N	\N
7	Organisation	image	file	file-image	{"folder":null}	\N	\N	f	f	3	full	[{"language":"fi-FI","translation":"Kuva"}]	\N	\N	t	\N	\N	\N
1	Organisation	name	\N	input	\N	\N	\N	f	f	1	full	[{"language":"fi-FI","translation":"Nimi"}]	\N	\N	f	\N	\N	\N
2	Organisation	status	\N	select-dropdown	{"choices":[{"text":"$t:published","value":"published"},{"text":"$t:draft","value":"draft"},{"text":"$t:archived","value":"archived"}]}	labels	{"showAsDot":true,"choices":[{"text":"$t:published","value":"published","foreground":"#FFFFFF","background":"var(--theme--primary)"},{"text":"$t:draft","value":"draft","foreground":"#18222F","background":"#D3DAE4"},{"text":"$t:archived","value":"archived","foreground":"#FFFFFF","background":"var(--theme--warning)"}]}	f	f	6	full	\N	Is the organisation visible publicly	\N	f	\N	\N	\N
9	Organisation	point_units	\N	input	{"iconLeft":"visibility"}	\N	\N	f	f	5	full	[{"language":"fi-FI","translation":"Pisteiden yksikkö"}]	$t:name_of_unit	\N	f	\N	\N	\N
\.


--
-- Data for Name: directus_files; Type: TABLE DATA; Schema: public; Owner: default
--

COPY public.directus_files (id, storage, filename_disk, filename_download, title, type, folder, uploaded_by, uploaded_on, modified_by, modified_on, charset, filesize, width, height, duration, embed, description, location, tags, metadata) FROM stdin;
f092b078-c2d1-4e8a-9648-27ccfdde2002	local	f092b078-c2d1-4e8a-9648-27ccfdde2002.svg	Logo.svg	Logo	image/svg+xml	\N	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:13:37.082516+00	\N	2023-12-01 02:13:37.091+00	\N	570	\N	\N	\N	\N	\N	\N	\N	\N
a4a04573-ed55-4c7d-b81f-efb13d5b768c	local	a4a04573-ed55-4c7d-b81f-efb13d5b768c.jpg	34bf4c6e-89a2-4b3d-9ed5-659a0eb834dc.jpg	34bf4c6e 89a2 4b3d 9ed5 659a0eb834dc	image/jpeg	\N	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:11:16.05726+00	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-01 02:17:52.034+00	\N	120822	927	927	\N	\N	\N	\N	\N	{}
\.


--
-- Data for Name: directus_flows; Type: TABLE DATA; Schema: public; Owner: default
--

COPY public.directus_flows (id, name, icon, color, description, status, trigger, accountability, options, operation, date_created, user_created) FROM stdin;
\.


--
-- Data for Name: directus_folders; Type: TABLE DATA; Schema: public; Owner: default
--

COPY public.directus_folders (id, name, parent) FROM stdin;
\.


--
-- Data for Name: directus_migrations; Type: TABLE DATA; Schema: public; Owner: default
--

COPY public.directus_migrations (version, name, "timestamp") FROM stdin;
20201028A	Remove Collection Foreign Keys	2023-12-01 00:15:40.037202+00
20201029A	Remove System Relations	2023-12-01 00:15:40.040454+00
20201029B	Remove System Collections	2023-12-01 00:15:40.043371+00
20201029C	Remove System Fields	2023-12-01 00:15:40.049553+00
20201105A	Add Cascade System Relations	2023-12-01 00:15:40.091747+00
20201105B	Change Webhook URL Type	2023-12-01 00:15:40.097738+00
20210225A	Add Relations Sort Field	2023-12-01 00:15:40.10124+00
20210304A	Remove Locked Fields	2023-12-01 00:15:40.103896+00
20210312A	Webhooks Collections Text	2023-12-01 00:15:40.108285+00
20210331A	Add Refresh Interval	2023-12-01 00:15:40.110753+00
20210415A	Make Filesize Nullable	2023-12-01 00:15:40.11631+00
20210416A	Add Collections Accountability	2023-12-01 00:15:40.119485+00
20210422A	Remove Files Interface	2023-12-01 00:15:40.121759+00
20210506A	Rename Interfaces	2023-12-01 00:15:40.136502+00
20210510A	Restructure Relations	2023-12-01 00:15:40.155253+00
20210518A	Add Foreign Key Constraints	2023-12-01 00:15:40.160311+00
20210519A	Add System Fk Triggers	2023-12-01 00:15:40.18448+00
20210521A	Add Collections Icon Color	2023-12-01 00:15:40.186844+00
20210525A	Add Insights	2023-12-01 00:15:40.2042+00
20210608A	Add Deep Clone Config	2023-12-01 00:15:40.206799+00
20210626A	Change Filesize Bigint	2023-12-01 00:15:40.216706+00
20210716A	Add Conditions to Fields	2023-12-01 00:15:40.22047+00
20210721A	Add Default Folder	2023-12-01 00:15:40.226498+00
20210802A	Replace Groups	2023-12-01 00:15:40.229478+00
20210803A	Add Required to Fields	2023-12-01 00:15:40.231847+00
20210805A	Update Groups	2023-12-01 00:15:40.234675+00
20210805B	Change Image Metadata Structure	2023-12-01 00:15:40.237675+00
20210811A	Add Geometry Config	2023-12-01 00:15:40.240271+00
20210831A	Remove Limit Column	2023-12-01 00:15:40.242733+00
20210903A	Add Auth Provider	2023-12-01 00:15:40.257274+00
20210907A	Webhooks Collections Not Null	2023-12-01 00:15:40.262664+00
20210910A	Move Module Setup	2023-12-01 00:15:40.26659+00
20210920A	Webhooks URL Not Null	2023-12-01 00:15:40.272669+00
20210924A	Add Collection Organization	2023-12-01 00:15:40.27681+00
20210927A	Replace Fields Group	2023-12-01 00:15:40.28343+00
20210927B	Replace M2M Interface	2023-12-01 00:15:40.285435+00
20210929A	Rename Login Action	2023-12-01 00:15:40.287267+00
20211007A	Update Presets	2023-12-01 00:15:40.292296+00
20211009A	Add Auth Data	2023-12-01 00:15:40.295198+00
20211016A	Add Webhook Headers	2023-12-01 00:15:40.297485+00
20211103A	Set Unique to User Token	2023-12-01 00:15:40.301894+00
20211103B	Update Special Geometry	2023-12-01 00:15:40.304088+00
20211104A	Remove Collections Listing	2023-12-01 00:15:40.306754+00
20211118A	Add Notifications	2023-12-01 00:15:40.318303+00
20211211A	Add Shares	2023-12-01 00:15:40.335772+00
20211230A	Add Project Descriptor	2023-12-01 00:15:40.338903+00
20220303A	Remove Default Project Color	2023-12-01 00:15:40.346115+00
20220308A	Add Bookmark Icon and Color	2023-12-01 00:15:40.34924+00
20220314A	Add Translation Strings	2023-12-01 00:15:40.352195+00
20220322A	Rename Field Typecast Flags	2023-12-01 00:15:40.355792+00
20220323A	Add Field Validation	2023-12-01 00:15:40.358619+00
20220325A	Fix Typecast Flags	2023-12-01 00:15:40.361325+00
20220325B	Add Default Language	2023-12-01 00:15:40.36813+00
20220402A	Remove Default Value Panel Icon	2023-12-01 00:15:40.374541+00
20220429A	Add Flows	2023-12-01 00:15:40.403903+00
20220429B	Add Color to Insights Icon	2023-12-01 00:15:40.40658+00
20220429C	Drop Non Null From IP of Activity	2023-12-01 00:15:40.408665+00
20220429D	Drop Non Null From Sender of Notifications	2023-12-01 00:15:40.410847+00
20220614A	Rename Hook Trigger to Event	2023-12-01 00:15:40.41284+00
20220801A	Update Notifications Timestamp Column	2023-12-01 00:15:40.418989+00
20220802A	Add Custom Aspect Ratios	2023-12-01 00:15:40.422015+00
20220826A	Add Origin to Accountability	2023-12-01 00:15:40.425738+00
20230401A	Update Material Icons	2023-12-01 00:15:40.431946+00
20230525A	Add Preview Settings	2023-12-01 00:15:40.434879+00
20230526A	Migrate Translation Strings	2023-12-01 00:15:40.445622+00
20230721A	Require Shares Fields	2023-12-01 00:15:40.450642+00
20230823A	Add Content Versioning	2023-12-01 00:15:40.473447+00
20230927A	Themes	2023-12-01 00:15:40.489379+00
20231009A	Update CSV Fields to Text	2023-12-01 00:15:40.492233+00
20231009B	Update Panel Options	2023-12-01 00:15:40.494481+00
20231010A	Add Extensions	2023-12-01 00:15:40.499167+00
\.


--
-- Data for Name: directus_notifications; Type: TABLE DATA; Schema: public; Owner: default
--

COPY public.directus_notifications (id, "timestamp", status, recipient, sender, subject, message, collection, item) FROM stdin;
\.


--
-- Data for Name: directus_operations; Type: TABLE DATA; Schema: public; Owner: default
--

COPY public.directus_operations (id, name, key, type, position_x, position_y, options, resolve, reject, flow, date_created, user_created) FROM stdin;
\.


--
-- Data for Name: directus_panels; Type: TABLE DATA; Schema: public; Owner: default
--

COPY public.directus_panels (id, dashboard, name, icon, color, show_header, note, type, position_x, position_y, width, height, options, date_created, user_created) FROM stdin;
\.


--
-- Data for Name: directus_permissions; Type: TABLE DATA; Schema: public; Owner: default
--

COPY public.directus_permissions (id, role, collection, action, permissions, validation, presets, fields) FROM stdin;
1	6daea05b-a2e4-4191-8fd9-6aa623563b17	directus_files	create	{}	\N	\N	*
2	6daea05b-a2e4-4191-8fd9-6aa623563b17	directus_files	read	{}	\N	\N	*
3	6daea05b-a2e4-4191-8fd9-6aa623563b17	directus_files	update	{}	\N	\N	*
4	6daea05b-a2e4-4191-8fd9-6aa623563b17	directus_files	delete	{}	\N	\N	*
5	6daea05b-a2e4-4191-8fd9-6aa623563b17	directus_dashboards	create	{}	\N	\N	*
6	6daea05b-a2e4-4191-8fd9-6aa623563b17	directus_dashboards	read	{}	\N	\N	*
7	6daea05b-a2e4-4191-8fd9-6aa623563b17	directus_dashboards	update	{}	\N	\N	*
8	6daea05b-a2e4-4191-8fd9-6aa623563b17	directus_dashboards	delete	{}	\N	\N	*
9	6daea05b-a2e4-4191-8fd9-6aa623563b17	directus_panels	create	{}	\N	\N	*
10	6daea05b-a2e4-4191-8fd9-6aa623563b17	directus_panels	read	{}	\N	\N	*
11	6daea05b-a2e4-4191-8fd9-6aa623563b17	directus_panels	update	{}	\N	\N	*
12	6daea05b-a2e4-4191-8fd9-6aa623563b17	directus_panels	delete	{}	\N	\N	*
13	6daea05b-a2e4-4191-8fd9-6aa623563b17	directus_folders	create	{}	\N	\N	*
14	6daea05b-a2e4-4191-8fd9-6aa623563b17	directus_folders	read	{}	\N	\N	*
15	6daea05b-a2e4-4191-8fd9-6aa623563b17	directus_folders	update	{}	\N	\N	*
16	6daea05b-a2e4-4191-8fd9-6aa623563b17	directus_folders	delete	{}	\N	\N	\N
17	6daea05b-a2e4-4191-8fd9-6aa623563b17	directus_users	read	{}	\N	\N	*
18	6daea05b-a2e4-4191-8fd9-6aa623563b17	directus_users	update	{"id":{"_eq":"$CURRENT_USER"}}	\N	\N	first_name,last_name,email,password,location,title,description,avatar,language,appearance,theme_light,theme_dark,theme_light_overrides,theme_dark_overrides,tfa_secret
19	6daea05b-a2e4-4191-8fd9-6aa623563b17	directus_roles	read	{}	\N	\N	*
20	6daea05b-a2e4-4191-8fd9-6aa623563b17	directus_shares	read	{"_or":[{"role":{"_eq":"$CURRENT_ROLE"}},{"role":{"_null":true}}]}	\N	\N	*
21	6daea05b-a2e4-4191-8fd9-6aa623563b17	directus_shares	create	{}	\N	\N	*
22	6daea05b-a2e4-4191-8fd9-6aa623563b17	directus_shares	update	{"user_created":{"_eq":"$CURRENT_USER"}}	\N	\N	*
23	6daea05b-a2e4-4191-8fd9-6aa623563b17	directus_shares	delete	{"user_created":{"_eq":"$CURRENT_USER"}}	\N	\N	*
24	6daea05b-a2e4-4191-8fd9-6aa623563b17	directus_flows	read	{"trigger":{"_eq":"manual"}}	\N	\N	id,status,name,icon,color,options,trigger
25	6daea05b-a2e4-4191-8fd9-6aa623563b17	Organisation	read	{"_and":[{"status":{"_eq":"published"}}]}	\N	\N	name,description,image,color_scheme,point_units
\.


--
-- Data for Name: directus_presets; Type: TABLE DATA; Schema: public; Owner: default
--

COPY public.directus_presets (id, bookmark, "user", role, collection, search, layout, layout_query, layout_options, refresh_interval, filter, icon, color) FROM stdin;
1	\N	322b0f19-d22f-44e8-a368-dbe6c84c9619	\N	directus_files	\N	cards	{"cards":{"sort":["-uploaded_on"],"page":1}}	{"cards":{"icon":"insert_drive_file","title":"{{ title }}","subtitle":"{{ type }} • {{ filesize }}","size":4,"imageFit":"crop"}}	\N	\N	bookmark	\N
2	\N	322b0f19-d22f-44e8-a368-dbe6c84c9619	\N	directus_translations	\N	\N	{"tabular":{"sort":["key"],"page":1}}	\N	\N	\N	bookmark	\N
3	\N	322b0f19-d22f-44e8-a368-dbe6c84c9619	\N	directus_users	\N	cards	{"cards":{"sort":["email"],"page":1}}	{"cards":{"icon":"account_circle","title":"{{ first_name }} {{ last_name }}","subtitle":"{{ email }}","size":4}}	\N	\N	bookmark	\N
\.


--
-- Data for Name: directus_relations; Type: TABLE DATA; Schema: public; Owner: default
--

COPY public.directus_relations (id, many_collection, many_field, one_collection, one_field, one_collection_field, one_allowed_collections, junction_field, sort_field, one_deselect_action) FROM stdin;
1	Organisation	user_updated	directus_users	\N	\N	\N	\N	\N	nullify
2	Organisation	image	directus_files	\N	\N	\N	\N	\N	nullify
\.


--
-- Data for Name: directus_revisions; Type: TABLE DATA; Schema: public; Owner: default
--

COPY public.directus_revisions (id, activity, collection, item, data, delta, parent, version) FROM stdin;
1	4	directus_files	5bfcbf5e-4d34-421b-aea4-9fad500e6227	{"title":"Daddy","filename_download":"daddy.png","type":"image/png","storage":"local"}	{"title":"Daddy","filename_download":"daddy.png","type":"image/png","storage":"local"}	\N	\N
2	5	directus_files	013f4c2b-3b40-4a2a-89f7-251bbd9c2190	{"title":"Dall·e 2022 11 04 20.22.52","filename_download":"DALL·E 2022-11-04 20.22.52.png","type":"image/png","storage":"local"}	{"title":"Dall·e 2022 11 04 20.22.52","filename_download":"DALL·E 2022-11-04 20.22.52.png","type":"image/png","storage":"local"}	\N	\N
3	8	directus_settings	1	{"project_descriptor":"System that allows users to manage, track and complete tasks in a digital environment. ","project_name":"Digital Task-Tracking Platform","auth_password_policy":"/^.{8,}$/"}	{"project_descriptor":"System that allows users to manage, track and complete tasks in a digital environment. ","project_name":"Digital Task-Tracking Platform","auth_password_policy":"/^.{8,}$/"}	\N	\N
4	9	directus_files	a4a04573-ed55-4c7d-b81f-efb13d5b768c	{"title":"34bf4c6e 89a2 4b3d 9ed5 659a0eb834dc","filename_download":"34bf4c6e-89a2-4b3d-9ed5-659a0eb834dc.jpg","type":"image/jpeg","storage":"local"}	{"title":"34bf4c6e 89a2 4b3d 9ed5 659a0eb834dc","filename_download":"34bf4c6e-89a2-4b3d-9ed5-659a0eb834dc.jpg","type":"image/jpeg","storage":"local"}	\N	\N
5	10	directus_settings	1	{"id":1,"project_name":"Digital Task-Tracking Platform","project_url":null,"project_color":"#FF8000","project_logo":"a4a04573-ed55-4c7d-b81f-efb13d5b768c","public_foreground":null,"public_background":null,"public_note":"Digital Task-Tracking Platform is a web-based system that allows users to manage, track, and complete tasks in a digital environment.","auth_login_attempts":25,"auth_password_policy":"/^.{8,}$/","storage_asset_transform":"all","storage_asset_presets":null,"custom_css":null,"storage_default_folder":null,"basemaps":null,"mapbox_key":null,"module_bar":null,"project_descriptor":"System that allows users to manage, track and complete tasks in a digital environment. ","default_language":"en-US","custom_aspect_ratios":null,"public_favicon":null,"default_appearance":"auto","default_theme_light":null,"theme_light_overrides":null,"default_theme_dark":null,"theme_dark_overrides":null}	{"project_color":"#FF8000","project_logo":"a4a04573-ed55-4c7d-b81f-efb13d5b768c","public_note":"Digital Task-Tracking Platform is a web-based system that allows users to manage, track, and complete tasks in a digital environment."}	\N	\N
6	11	directus_files	f092b078-c2d1-4e8a-9648-27ccfdde2002	{"title":"Logo","filename_download":"Logo.svg","type":"image/svg+xml","storage":"local"}	{"title":"Logo","filename_download":"Logo.svg","type":"image/svg+xml","storage":"local"}	\N	\N
7	12	directus_files	73e18cd9-e89b-406d-b3df-67d515ce8a2c	{"title":"Logo","filename_download":"Logo.svg","type":"image/svg+xml","storage":"local"}	{"title":"Logo","filename_download":"Logo.svg","type":"image/svg+xml","storage":"local"}	\N	\N
8	13	directus_settings	1	{"id":1,"project_name":"Digital Task-Tracking Platform","project_url":null,"project_color":"#FF8000","project_logo":"f092b078-c2d1-4e8a-9648-27ccfdde2002","public_foreground":null,"public_background":null,"public_note":"Digital Task-Tracking Platform is a web-based system that allows users to manage, track, and complete tasks in a digital environment.","auth_login_attempts":25,"auth_password_policy":"/^.{8,}$/","storage_asset_transform":"all","storage_asset_presets":null,"custom_css":null,"storage_default_folder":null,"basemaps":null,"mapbox_key":null,"module_bar":null,"project_descriptor":"System that allows users to manage, track and complete tasks in a digital environment. ","default_language":"en-US","custom_aspect_ratios":null,"public_favicon":"73e18cd9-e89b-406d-b3df-67d515ce8a2c","default_appearance":"auto","default_theme_light":null,"theme_light_overrides":null,"default_theme_dark":null,"theme_dark_overrides":null}	{"project_logo":"f092b078-c2d1-4e8a-9648-27ccfdde2002","public_favicon":"73e18cd9-e89b-406d-b3df-67d515ce8a2c"}	\N	\N
9	14	directus_files	73e18cd9-e89b-406d-b3df-67d515ce8a2c	{"id":"73e18cd9-e89b-406d-b3df-67d515ce8a2c","storage":"local","filename_disk":"73e18cd9-e89b-406d-b3df-67d515ce8a2c.svg","filename_download":"Logo(1).svg","title":"Logo","type":"image/svg+xml","folder":null,"uploaded_by":"322b0f19-d22f-44e8-a368-dbe6c84c9619","uploaded_on":"2023-12-01T02:13:53.732Z","modified_by":"322b0f19-d22f-44e8-a368-dbe6c84c9619","modified_on":"2023-12-01T02:14:57.313Z","charset":null,"filesize":"570","width":null,"height":null,"duration":null,"embed":null,"description":null,"location":null,"tags":null,"metadata":null}	{"storage":"local","filename_disk":"73e18cd9-e89b-406d-b3df-67d515ce8a2c.svg","filename_download":"Logo(1).svg","title":"Logo","type":"image/svg+xml","folder":null,"description":null,"metadata":null,"modified_by":"322b0f19-d22f-44e8-a368-dbe6c84c9619","modified_on":"2023-12-01T02:14:57.313Z"}	\N	\N
10	15	directus_files	73e18cd9-e89b-406d-b3df-67d515ce8a2c	{"id":"73e18cd9-e89b-406d-b3df-67d515ce8a2c","storage":"local","filename_disk":"73e18cd9-e89b-406d-b3df-67d515ce8a2c.svg","filename_download":"Logo(1).svg","title":"Logo","type":"image/svg+xml","folder":null,"uploaded_by":"322b0f19-d22f-44e8-a368-dbe6c84c9619","uploaded_on":"2023-12-01T02:13:53.732Z","modified_by":"322b0f19-d22f-44e8-a368-dbe6c84c9619","modified_on":"2023-12-01T02:14:57.337Z","charset":null,"filesize":"8859","width":null,"height":null,"duration":null,"embed":null,"description":null,"location":null,"tags":null,"metadata":null}	{"modified_by":"322b0f19-d22f-44e8-a368-dbe6c84c9619","modified_on":"2023-12-01T02:14:57.337Z"}	\N	\N
11	16	directus_settings	1	{"id":1,"project_name":"Digital Task-Tracking Platform","project_url":null,"project_color":"#FF8000","project_logo":"f092b078-c2d1-4e8a-9648-27ccfdde2002","public_foreground":null,"public_background":null,"public_note":"Digital Task-Tracking Platform is a web-based system that allows users to manage, track, and complete tasks in a digital environment.","auth_login_attempts":25,"auth_password_policy":"/^.{8,}$/","storage_asset_transform":"all","storage_asset_presets":null,"custom_css":null,"storage_default_folder":null,"basemaps":null,"mapbox_key":null,"module_bar":null,"project_descriptor":"System that allows users to manage, track and complete tasks in a digital environment. ","default_language":"en-US","custom_aspect_ratios":null,"public_favicon":"73e18cd9-e89b-406d-b3df-67d515ce8a2c","default_appearance":"auto","default_theme_light":null,"theme_light_overrides":null,"default_theme_dark":null,"theme_dark_overrides":null}	{"public_favicon":"73e18cd9-e89b-406d-b3df-67d515ce8a2c"}	\N	\N
12	17	directus_files	e012cca9-3214-4c56-a919-87a2b2811be0	{"title":"Icon","filename_download":"icon.ico","type":"image/x-icon","storage":"local"}	{"title":"Icon","filename_download":"icon.ico","type":"image/x-icon","storage":"local"}	\N	\N
32	40	directus_fields	4	{"sort":4,"special":["user-updated"],"interface":"select-dropdown-m2o","options":{"template":"{{avatar.$thumbnail}} {{first_name}} {{last_name}}"},"display":"user","readonly":true,"hidden":true,"width":"half","field":"user_updated","collection":"Organisation"}	{"sort":4,"special":["user-updated"],"interface":"select-dropdown-m2o","options":{"template":"{{avatar.$thumbnail}} {{first_name}} {{last_name}}"},"display":"user","readonly":true,"hidden":true,"width":"half","field":"user_updated","collection":"Organisation"}	\N	\N
13	18	directus_settings	1	{"id":1,"project_name":"Digital Task-Tracking Platform","project_url":null,"project_color":"#FF8000","project_logo":"f092b078-c2d1-4e8a-9648-27ccfdde2002","public_foreground":null,"public_background":null,"public_note":"Digital Task-Tracking Platform is a web-based system that allows users to manage, track, and complete tasks in a digital environment.","auth_login_attempts":25,"auth_password_policy":"/^.{8,}$/","storage_asset_transform":"all","storage_asset_presets":null,"custom_css":null,"storage_default_folder":null,"basemaps":null,"mapbox_key":null,"module_bar":null,"project_descriptor":"System that allows users to manage, track and complete tasks in a digital environment. ","default_language":"en-US","custom_aspect_ratios":null,"public_favicon":"e012cca9-3214-4c56-a919-87a2b2811be0","default_appearance":"auto","default_theme_light":null,"theme_light_overrides":null,"default_theme_dark":null,"theme_dark_overrides":null}	{"public_favicon":"e012cca9-3214-4c56-a919-87a2b2811be0"}	\N	\N
14	19	directus_files	29f1e786-3bce-4310-a825-47a5d385eebe	{"title":"Logo","filename_download":"Logo.svg","type":"image/svg+xml","storage":"local"}	{"title":"Logo","filename_download":"Logo.svg","type":"image/svg+xml","storage":"local"}	\N	\N
15	20	directus_settings	1	{"id":1,"project_name":"Digital Task-Tracking Platform","project_url":null,"project_color":"#FF8000","project_logo":"f092b078-c2d1-4e8a-9648-27ccfdde2002","public_foreground":null,"public_background":null,"public_note":"Digital Task-Tracking Platform is a web-based system that allows users to manage, track, and complete tasks in a digital environment.","auth_login_attempts":25,"auth_password_policy":"/^.{8,}$/","storage_asset_transform":"all","storage_asset_presets":null,"custom_css":null,"storage_default_folder":null,"basemaps":null,"mapbox_key":null,"module_bar":null,"project_descriptor":"System that allows users to manage, track and complete tasks in a digital environment. ","default_language":"en-US","custom_aspect_ratios":null,"public_favicon":"29f1e786-3bce-4310-a825-47a5d385eebe","default_appearance":"auto","default_theme_light":null,"theme_light_overrides":null,"default_theme_dark":null,"theme_dark_overrides":null}	{"public_favicon":"29f1e786-3bce-4310-a825-47a5d385eebe"}	\N	\N
16	21	directus_settings	1	{"id":1,"project_name":"Digital Task-Tracking Platform","project_url":null,"project_color":"#FF8000","project_logo":"f092b078-c2d1-4e8a-9648-27ccfdde2002","public_foreground":"a4a04573-ed55-4c7d-b81f-efb13d5b768c","public_background":null,"public_note":"Digital Task-Tracking Platform is a web-based system that allows users to manage, track, and complete tasks in a digital environment.","auth_login_attempts":25,"auth_password_policy":"/^.{8,}$/","storage_asset_transform":"all","storage_asset_presets":null,"custom_css":null,"storage_default_folder":null,"basemaps":null,"mapbox_key":null,"module_bar":null,"project_descriptor":"System that allows users to manage, track and complete tasks in a digital environment. ","default_language":"en-US","custom_aspect_ratios":null,"public_favicon":"29f1e786-3bce-4310-a825-47a5d385eebe","default_appearance":"auto","default_theme_light":null,"theme_light_overrides":null,"default_theme_dark":null,"theme_dark_overrides":null}	{"public_foreground":"a4a04573-ed55-4c7d-b81f-efb13d5b768c"}	\N	\N
17	24	directus_files	a4a04573-ed55-4c7d-b81f-efb13d5b768c	{"id":"a4a04573-ed55-4c7d-b81f-efb13d5b768c","storage":"local","filename_disk":"a4a04573-ed55-4c7d-b81f-efb13d5b768c.jpg","filename_download":"34bf4c6e-89a2-4b3d-9ed5-659a0eb834dc.jpg","title":"34bf4c6e 89a2 4b3d 9ed5 659a0eb834dc","type":"image/jpeg","folder":null,"uploaded_by":"322b0f19-d22f-44e8-a368-dbe6c84c9619","uploaded_on":"2023-12-01T02:11:16.057Z","modified_by":"322b0f19-d22f-44e8-a368-dbe6c84c9619","modified_on":"2023-12-01T02:17:52.021Z","charset":null,"filesize":"51204","width":1024,"height":1024,"duration":null,"embed":null,"description":null,"location":null,"tags":null,"metadata":{}}	{"storage":"local","filename_disk":"a4a04573-ed55-4c7d-b81f-efb13d5b768c.jpg","filename_download":"34bf4c6e-89a2-4b3d-9ed5-659a0eb834dc.jpg","title":"34bf4c6e 89a2 4b3d 9ed5 659a0eb834dc","type":"image/jpeg","folder":null,"description":null,"metadata":{},"modified_by":"322b0f19-d22f-44e8-a368-dbe6c84c9619","modified_on":"2023-12-01T02:17:52.021Z"}	\N	\N
18	25	directus_files	a4a04573-ed55-4c7d-b81f-efb13d5b768c	{"id":"a4a04573-ed55-4c7d-b81f-efb13d5b768c","storage":"local","filename_disk":"a4a04573-ed55-4c7d-b81f-efb13d5b768c.jpg","filename_download":"34bf4c6e-89a2-4b3d-9ed5-659a0eb834dc.jpg","title":"34bf4c6e 89a2 4b3d 9ed5 659a0eb834dc","type":"image/jpeg","folder":null,"uploaded_by":"322b0f19-d22f-44e8-a368-dbe6c84c9619","uploaded_on":"2023-12-01T02:11:16.057Z","modified_by":"322b0f19-d22f-44e8-a368-dbe6c84c9619","modified_on":"2023-12-01T02:17:52.034Z","charset":null,"filesize":"120822","width":927,"height":927,"duration":null,"embed":null,"description":null,"location":null,"tags":null,"metadata":{}}	{"modified_by":"322b0f19-d22f-44e8-a368-dbe6c84c9619","modified_on":"2023-12-01T02:17:52.034Z"}	\N	\N
19	26	directus_settings	1	{"id":1,"project_name":"Digital Task-Tracking Platform","project_url":null,"project_color":"#800040","project_logo":"f092b078-c2d1-4e8a-9648-27ccfdde2002","public_foreground":"a4a04573-ed55-4c7d-b81f-efb13d5b768c","public_background":null,"public_note":"Digital Task-Tracking Platform is a web-based system that allows users to manage, track, and complete tasks in a digital environment.","auth_login_attempts":25,"auth_password_policy":"/^.{8,}$/","storage_asset_transform":"all","storage_asset_presets":null,"custom_css":null,"storage_default_folder":null,"basemaps":null,"mapbox_key":null,"module_bar":null,"project_descriptor":"System that allows users to manage, track and complete tasks in a digital environment. ","default_language":"en-US","custom_aspect_ratios":null,"public_favicon":"29f1e786-3bce-4310-a825-47a5d385eebe","default_appearance":"auto","default_theme_light":null,"theme_light_overrides":null,"default_theme_dark":null,"theme_dark_overrides":null}	{"project_color":"#800040"}	\N	\N
20	27	directus_settings	1	{"id":1,"project_name":"Digital Task-Tracking Platform","project_url":null,"project_color":"#FF80C0","project_logo":"f092b078-c2d1-4e8a-9648-27ccfdde2002","public_foreground":"a4a04573-ed55-4c7d-b81f-efb13d5b768c","public_background":null,"public_note":"Digital Task-Tracking Platform is a web-based system that allows users to manage, track, and complete tasks in a digital environment.","auth_login_attempts":25,"auth_password_policy":"/^.{8,}$/","storage_asset_transform":"all","storage_asset_presets":null,"custom_css":null,"storage_default_folder":null,"basemaps":null,"mapbox_key":null,"module_bar":null,"project_descriptor":"System that allows users to manage, track and complete tasks in a digital environment. ","default_language":"en-US","custom_aspect_ratios":null,"public_favicon":"29f1e786-3bce-4310-a825-47a5d385eebe","default_appearance":"auto","default_theme_light":null,"theme_light_overrides":null,"default_theme_dark":null,"theme_dark_overrides":null}	{"project_color":"#FF80C0"}	\N	\N
21	28	directus_settings	1	{"id":1,"project_name":"Digital Task-Tracking Platform","project_url":null,"project_color":"#FF80C0","project_logo":"f092b078-c2d1-4e8a-9648-27ccfdde2002","public_foreground":"a4a04573-ed55-4c7d-b81f-efb13d5b768c","public_background":null,"public_note":"Digital Task-Tracking Platform is a web-based system that allows users to manage, track, and complete tasks in a digital environment.","auth_login_attempts":25,"auth_password_policy":"/^.{8,}$/","storage_asset_transform":"all","storage_asset_presets":null,"custom_css":null,"storage_default_folder":null,"basemaps":null,"mapbox_key":null,"module_bar":null,"project_descriptor":"System that allows users to manage, track and complete tasks in a digital environment. ","default_language":"en-US","custom_aspect_ratios":null,"public_favicon":null,"default_appearance":"auto","default_theme_light":null,"theme_light_overrides":null,"default_theme_dark":null,"theme_dark_overrides":null}	{"public_favicon":null}	\N	\N
22	30	directus_files	8b4720a8-0811-414d-80bb-b53c54bca47f	{"title":"White Logo","filename_download":"White_logo.png","type":"image/png","storage":"local"}	{"title":"White Logo","filename_download":"White_logo.png","type":"image/png","storage":"local"}	\N	\N
33	41	directus_fields	5	{"sort":5,"special":["date-updated"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"Organisation"}	{"sort":5,"special":["date-updated"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"Organisation"}	\N	\N
23	31	directus_settings	1	{"id":1,"project_name":"Digital Task-Tracking Platform","project_url":null,"project_color":"#FF80C0","project_logo":"f092b078-c2d1-4e8a-9648-27ccfdde2002","public_foreground":"a4a04573-ed55-4c7d-b81f-efb13d5b768c","public_background":null,"public_note":"Digital Task-Tracking Platform is a web-based system that allows users to manage, track, and complete tasks in a digital environment.","auth_login_attempts":25,"auth_password_policy":"/^.{8,}$/","storage_asset_transform":"all","storage_asset_presets":null,"custom_css":null,"storage_default_folder":null,"basemaps":null,"mapbox_key":null,"module_bar":null,"project_descriptor":"System that allows users to manage, track and complete tasks in a digital environment. ","default_language":"en-US","custom_aspect_ratios":null,"public_favicon":"8b4720a8-0811-414d-80bb-b53c54bca47f","default_appearance":"auto","default_theme_light":null,"theme_light_overrides":null,"default_theme_dark":null,"theme_dark_overrides":null}	{"public_favicon":"8b4720a8-0811-414d-80bb-b53c54bca47f"}	\N	\N
24	32	directus_files	e532ef31-d2a1-4ad9-b2a7-b609bf6fc355	{"title":"White Logo","filename_download":"White_logo.ico","type":"image/x-icon","storage":"local"}	{"title":"White Logo","filename_download":"White_logo.ico","type":"image/x-icon","storage":"local"}	\N	\N
25	33	directus_settings	1	{"id":1,"project_name":"Digital Task-Tracking Platform","project_url":null,"project_color":"#FF80C0","project_logo":"f092b078-c2d1-4e8a-9648-27ccfdde2002","public_foreground":"a4a04573-ed55-4c7d-b81f-efb13d5b768c","public_background":null,"public_note":"Digital Task-Tracking Platform is a web-based system that allows users to manage, track, and complete tasks in a digital environment.","auth_login_attempts":25,"auth_password_policy":"/^.{8,}$/","storage_asset_transform":"all","storage_asset_presets":null,"custom_css":null,"storage_default_folder":null,"basemaps":null,"mapbox_key":null,"module_bar":null,"project_descriptor":"System that allows users to manage, track and complete tasks in a digital environment. ","default_language":"en-US","custom_aspect_ratios":null,"public_favicon":"e532ef31-d2a1-4ad9-b2a7-b609bf6fc355","default_appearance":"auto","default_theme_light":null,"theme_light_overrides":null,"default_theme_dark":null,"theme_dark_overrides":null}	{"public_favicon":"e532ef31-d2a1-4ad9-b2a7-b609bf6fc355"}	\N	\N
26	34	directus_settings	1	{"id":1,"project_name":"Digital Task-Tracking Platform","project_url":null,"project_color":"#FF80C0","project_logo":"f092b078-c2d1-4e8a-9648-27ccfdde2002","public_foreground":"a4a04573-ed55-4c7d-b81f-efb13d5b768c","public_background":null,"public_note":"Digital Task-Tracking Platform is a web-based system that allows users to manage, track, and complete tasks in a digital environment.","auth_login_attempts":25,"auth_password_policy":"/^.{8,}$/","storage_asset_transform":"all","storage_asset_presets":null,"custom_css":null,"storage_default_folder":null,"basemaps":null,"mapbox_key":null,"module_bar":null,"project_descriptor":"System that allows users to manage, track and complete tasks in a digital environment. ","default_language":"en-US","custom_aspect_ratios":null,"public_favicon":"e532ef31-d2a1-4ad9-b2a7-b609bf6fc355","default_appearance":"auto","default_theme_light":null,"theme_light_overrides":null,"default_theme_dark":null,"theme_dark_overrides":null}	{"public_favicon":"e532ef31-d2a1-4ad9-b2a7-b609bf6fc355"}	\N	\N
27	35	directus_settings	1	{"id":1,"project_name":"CCMS: Digital Task-Tracking Platform","project_url":null,"project_color":"#FF80C0","project_logo":"f092b078-c2d1-4e8a-9648-27ccfdde2002","public_foreground":"a4a04573-ed55-4c7d-b81f-efb13d5b768c","public_background":null,"public_note":"Digital Task-Tracking Platform is a web-based system that allows users to manage, track, and complete tasks in a digital environment.","auth_login_attempts":25,"auth_password_policy":"/^.{8,}$/","storage_asset_transform":"all","storage_asset_presets":null,"custom_css":null,"storage_default_folder":null,"basemaps":null,"mapbox_key":null,"module_bar":null,"project_descriptor":"System that allows users to manage, track and complete tasks in a digital environment. ","default_language":"en-US","custom_aspect_ratios":null,"public_favicon":"e532ef31-d2a1-4ad9-b2a7-b609bf6fc355","default_appearance":"auto","default_theme_light":null,"theme_light_overrides":null,"default_theme_dark":null,"theme_dark_overrides":null}	{"project_name":"CCMS: Digital Task-Tracking Platform"}	\N	\N
28	36	directus_settings	1	{"id":1,"project_name":"CMS: Digital Task-Tracking Platform","project_url":null,"project_color":"#FF80C0","project_logo":"f092b078-c2d1-4e8a-9648-27ccfdde2002","public_foreground":"a4a04573-ed55-4c7d-b81f-efb13d5b768c","public_background":null,"public_note":"Digital Task-Tracking Platform is a web-based system that allows users to manage, track, and complete tasks in a digital environment.","auth_login_attempts":25,"auth_password_policy":"/^.{8,}$/","storage_asset_transform":"all","storage_asset_presets":null,"custom_css":null,"storage_default_folder":null,"basemaps":null,"mapbox_key":null,"module_bar":null,"project_descriptor":"System that allows users to manage, track and complete tasks in a digital environment. ","default_language":"en-US","custom_aspect_ratios":null,"public_favicon":"e532ef31-d2a1-4ad9-b2a7-b609bf6fc355","default_appearance":"auto","default_theme_light":null,"theme_light_overrides":null,"default_theme_dark":null,"theme_dark_overrides":null}	{"project_name":"CMS: Digital Task-Tracking Platform"}	\N	\N
29	37	directus_fields	1	{"sort":1,"interface":"input","readonly":false,"hidden":false,"field":"name","collection":"Organisation"}	{"sort":1,"interface":"input","readonly":false,"hidden":false,"field":"name","collection":"Organisation"}	\N	\N
30	38	directus_fields	2	{"sort":2,"width":"full","options":{"choices":[{"text":"$t:published","value":"published"},{"text":"$t:draft","value":"draft"},{"text":"$t:archived","value":"archived"}]},"interface":"select-dropdown","display":"labels","display_options":{"showAsDot":true,"choices":[{"text":"$t:published","value":"published","foreground":"#FFFFFF","background":"var(--theme--primary)"},{"text":"$t:draft","value":"draft","foreground":"#18222F","background":"#D3DAE4"},{"text":"$t:archived","value":"archived","foreground":"#FFFFFF","background":"var(--theme--warning)"}]},"field":"status","collection":"Organisation"}	{"sort":2,"width":"full","options":{"choices":[{"text":"$t:published","value":"published"},{"text":"$t:draft","value":"draft"},{"text":"$t:archived","value":"archived"}]},"interface":"select-dropdown","display":"labels","display_options":{"showAsDot":true,"choices":[{"text":"$t:published","value":"published","foreground":"#FFFFFF","background":"var(--theme--primary)"},{"text":"$t:draft","value":"draft","foreground":"#18222F","background":"#D3DAE4"},{"text":"$t:archived","value":"archived","foreground":"#FFFFFF","background":"var(--theme--warning)"}]},"field":"status","collection":"Organisation"}	\N	\N
31	39	directus_fields	3	{"sort":3,"special":["date-created"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_created","collection":"Organisation"}	{"sort":3,"special":["date-created"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_created","collection":"Organisation"}	\N	\N
34	42	directus_collections	Organisation	{"archive_field":"status","archive_value":"archived","unarchive_value":"draft","singleton":true,"collection":"Organisation"}	{"archive_field":"status","archive_value":"archived","unarchive_value":"draft","singleton":true,"collection":"Organisation"}	\N	\N
35	43	directus_fields	6	{"sort":6,"interface":"select-color","special":null,"options":{"presets":null},"required":true,"collection":"Organisation","field":"color_scheme"}	{"sort":6,"interface":"select-color","special":null,"options":{"presets":null},"required":true,"collection":"Organisation","field":"color_scheme"}	\N	\N
36	44	directus_fields	7	{"sort":7,"interface":"file-image","special":["file"],"options":{"folder":null},"required":true,"collection":"Organisation","field":"image"}	{"sort":7,"interface":"file-image","special":["file"],"options":{"folder":null},"required":true,"collection":"Organisation","field":"image"}	\N	\N
37	45	directus_fields	8	{"sort":8,"interface":"input-multiline","special":null,"collection":"Organisation","field":"description"}	{"sort":8,"interface":"input-multiline","special":null,"collection":"Organisation","field":"description"}	\N	\N
38	46	directus_fields	9	{"sort":9,"interface":"input","special":null,"collection":"Organisation","field":"point_units"}	{"sort":9,"interface":"input","special":null,"collection":"Organisation","field":"point_units"}	\N	\N
39	47	directus_collections	Organisation	{"collection":"Organisation","icon":"info","note":null,"display_template":null,"hidden":false,"singleton":true,"translations":[{"language":"en-US","translation":"Organisation"},{"language":"fi-FI","translation":"Organisaatio"}],"archive_field":"status","archive_app_filter":true,"archive_value":"archived","unarchive_value":"draft","sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":null,"group":null,"collapse":"open","preview_url":null,"versioning":true}	{"icon":"info","translations":[{"language":"en-US","translation":"Organisation"},{"language":"fi-FI","translation":"Organisaatio"}],"versioning":true}	\N	\N
40	48	directus_fields	1	{"id":1,"collection":"Organisation","field":"name","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"Organisation","field":"name","sort":1,"group":null}	\N	\N
41	49	directus_fields	2	{"id":2,"collection":"Organisation","field":"status","special":null,"interface":"select-dropdown","options":{"choices":[{"text":"$t:published","value":"published"},{"text":"$t:draft","value":"draft"},{"text":"$t:archived","value":"archived"}]},"display":"labels","display_options":{"showAsDot":true,"choices":[{"text":"$t:published","value":"published","foreground":"#FFFFFF","background":"var(--theme--primary)"},{"text":"$t:draft","value":"draft","foreground":"#18222F","background":"#D3DAE4"},{"text":"$t:archived","value":"archived","foreground":"#FFFFFF","background":"var(--theme--warning)"}]},"readonly":false,"hidden":false,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"Organisation","field":"status","sort":2,"group":null}	\N	\N
42	50	directus_fields	3	{"id":3,"collection":"Organisation","field":"date_created","special":["date-created"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":3,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"Organisation","field":"date_created","sort":3,"group":null}	\N	\N
43	51	directus_fields	4	{"id":4,"collection":"Organisation","field":"user_updated","special":["user-updated"],"interface":"select-dropdown-m2o","options":{"template":"{{avatar.$thumbnail}} {{first_name}} {{last_name}}"},"display":"user","display_options":null,"readonly":true,"hidden":true,"sort":4,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"Organisation","field":"user_updated","sort":4,"group":null}	\N	\N
44	52	directus_fields	5	{"id":5,"collection":"Organisation","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":5,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"Organisation","field":"date_updated","sort":5,"group":null}	\N	\N
45	53	directus_fields	6	{"id":6,"collection":"Organisation","field":"color_scheme","special":null,"interface":"select-color","options":{"presets":null},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":null,"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"Organisation","field":"color_scheme","sort":6,"group":null}	\N	\N
46	54	directus_fields	8	{"id":8,"collection":"Organisation","field":"description","special":null,"interface":"input-multiline","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":7,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"Organisation","field":"description","sort":7,"group":null}	\N	\N
47	55	directus_fields	7	{"id":7,"collection":"Organisation","field":"image","special":["file"],"interface":"file-image","options":{"folder":null},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":8,"width":"full","translations":null,"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"Organisation","field":"image","sort":8,"group":null}	\N	\N
48	56	directus_fields	9	{"id":9,"collection":"Organisation","field":"point_units","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":9,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"Organisation","field":"point_units","sort":9,"group":null}	\N	\N
49	57	directus_fields	1	{"id":1,"collection":"Organisation","field":"name","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"Organisation","field":"name","sort":1,"group":null}	\N	\N
50	58	directus_fields	2	{"id":2,"collection":"Organisation","field":"status","special":null,"interface":"select-dropdown","options":{"choices":[{"text":"$t:published","value":"published"},{"text":"$t:draft","value":"draft"},{"text":"$t:archived","value":"archived"}]},"display":"labels","display_options":{"showAsDot":true,"choices":[{"text":"$t:published","value":"published","foreground":"#FFFFFF","background":"var(--theme--primary)"},{"text":"$t:draft","value":"draft","foreground":"#18222F","background":"#D3DAE4"},{"text":"$t:archived","value":"archived","foreground":"#FFFFFF","background":"var(--theme--warning)"}]},"readonly":false,"hidden":false,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"Organisation","field":"status","sort":2,"group":null}	\N	\N
51	59	directus_fields	3	{"id":3,"collection":"Organisation","field":"date_created","special":["date-created"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":3,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"Organisation","field":"date_created","sort":3,"group":null}	\N	\N
52	60	directus_fields	4	{"id":4,"collection":"Organisation","field":"user_updated","special":["user-updated"],"interface":"select-dropdown-m2o","options":{"template":"{{avatar.$thumbnail}} {{first_name}} {{last_name}}"},"display":"user","display_options":null,"readonly":true,"hidden":true,"sort":4,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"Organisation","field":"user_updated","sort":4,"group":null}	\N	\N
53	61	directus_fields	5	{"id":5,"collection":"Organisation","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":5,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"Organisation","field":"date_updated","sort":5,"group":null}	\N	\N
54	62	directus_fields	6	{"id":6,"collection":"Organisation","field":"color_scheme","special":null,"interface":"select-color","options":{"presets":null},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":null,"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"Organisation","field":"color_scheme","sort":6,"group":null}	\N	\N
55	63	directus_fields	7	{"id":7,"collection":"Organisation","field":"image","special":["file"],"interface":"file-image","options":{"folder":null},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":7,"width":"full","translations":null,"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"Organisation","field":"image","sort":7,"group":null}	\N	\N
56	64	directus_fields	8	{"id":8,"collection":"Organisation","field":"description","special":null,"interface":"input-multiline","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":8,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"Organisation","field":"description","sort":8,"group":null}	\N	\N
57	65	directus_fields	9	{"id":9,"collection":"Organisation","field":"point_units","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":9,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"Organisation","field":"point_units","sort":9,"group":null}	\N	\N
67	75	directus_fields	1	{"id":1,"collection":"Organisation","field":"name","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"Organisation","field":"name","sort":1,"group":null}	\N	\N
68	76	directus_fields	8	{"id":8,"collection":"Organisation","field":"description","special":null,"interface":"input-multiline","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"Organisation","field":"description","sort":2,"group":null}	\N	\N
69	77	directus_fields	7	{"id":7,"collection":"Organisation","field":"image","special":["file"],"interface":"file-image","options":{"folder":null},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":null,"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"Organisation","field":"image","sort":3,"group":null}	\N	\N
70	78	directus_fields	2	{"id":2,"collection":"Organisation","field":"status","special":null,"interface":"select-dropdown","options":{"choices":[{"text":"$t:published","value":"published"},{"text":"$t:draft","value":"draft"},{"text":"$t:archived","value":"archived"}]},"display":"labels","display_options":{"showAsDot":true,"choices":[{"text":"$t:published","value":"published","foreground":"#FFFFFF","background":"var(--theme--primary)"},{"text":"$t:draft","value":"draft","foreground":"#18222F","background":"#D3DAE4"},{"text":"$t:archived","value":"archived","foreground":"#FFFFFF","background":"var(--theme--warning)"}]},"readonly":false,"hidden":false,"sort":4,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"Organisation","field":"status","sort":4,"group":null}	\N	\N
71	79	directus_fields	3	{"id":3,"collection":"Organisation","field":"date_created","special":["date-created"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":5,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"Organisation","field":"date_created","sort":5,"group":null}	\N	\N
72	80	directus_fields	4	{"id":4,"collection":"Organisation","field":"user_updated","special":["user-updated"],"interface":"select-dropdown-m2o","options":{"template":"{{avatar.$thumbnail}} {{first_name}} {{last_name}}"},"display":"user","display_options":null,"readonly":true,"hidden":true,"sort":6,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"Organisation","field":"user_updated","sort":6,"group":null}	\N	\N
73	81	directus_fields	5	{"id":5,"collection":"Organisation","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":7,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"Organisation","field":"date_updated","sort":7,"group":null}	\N	\N
74	82	directus_fields	6	{"id":6,"collection":"Organisation","field":"color_scheme","special":null,"interface":"select-color","options":{"presets":null},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":8,"width":"full","translations":null,"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"Organisation","field":"color_scheme","sort":8,"group":null}	\N	\N
123	131	directus_permissions	13	{"collection":"directus_folders","action":"create","permissions":{},"fields":["*"],"role":"6daea05b-a2e4-4191-8fd9-6aa623563b17"}	{"collection":"directus_folders","action":"create","permissions":{},"fields":["*"],"role":"6daea05b-a2e4-4191-8fd9-6aa623563b17"}	\N	\N
58	66	directus_fields	1	{"id":1,"collection":"Organisation","field":"name","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"Organisation","field":"name","sort":1,"group":null}	\N	\N
59	67	directus_fields	8	{"id":8,"collection":"Organisation","field":"description","special":null,"interface":"input-multiline","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"Organisation","field":"description","sort":2,"group":null}	\N	\N
60	68	directus_fields	2	{"id":2,"collection":"Organisation","field":"status","special":null,"interface":"select-dropdown","options":{"choices":[{"text":"$t:published","value":"published"},{"text":"$t:draft","value":"draft"},{"text":"$t:archived","value":"archived"}]},"display":"labels","display_options":{"showAsDot":true,"choices":[{"text":"$t:published","value":"published","foreground":"#FFFFFF","background":"var(--theme--primary)"},{"text":"$t:draft","value":"draft","foreground":"#18222F","background":"#D3DAE4"},{"text":"$t:archived","value":"archived","foreground":"#FFFFFF","background":"var(--theme--warning)"}]},"readonly":false,"hidden":false,"sort":3,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"Organisation","field":"status","sort":3,"group":null}	\N	\N
61	69	directus_fields	3	{"id":3,"collection":"Organisation","field":"date_created","special":["date-created"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":4,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"Organisation","field":"date_created","sort":4,"group":null}	\N	\N
62	70	directus_fields	4	{"id":4,"collection":"Organisation","field":"user_updated","special":["user-updated"],"interface":"select-dropdown-m2o","options":{"template":"{{avatar.$thumbnail}} {{first_name}} {{last_name}}"},"display":"user","display_options":null,"readonly":true,"hidden":true,"sort":5,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"Organisation","field":"user_updated","sort":5,"group":null}	\N	\N
63	71	directus_fields	5	{"id":5,"collection":"Organisation","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":6,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"Organisation","field":"date_updated","sort":6,"group":null}	\N	\N
64	72	directus_fields	6	{"id":6,"collection":"Organisation","field":"color_scheme","special":null,"interface":"select-color","options":{"presets":null},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":7,"width":"full","translations":null,"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"Organisation","field":"color_scheme","sort":7,"group":null}	\N	\N
65	73	directus_fields	7	{"id":7,"collection":"Organisation","field":"image","special":["file"],"interface":"file-image","options":{"folder":null},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":8,"width":"full","translations":null,"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"Organisation","field":"image","sort":8,"group":null}	\N	\N
66	74	directus_fields	9	{"id":9,"collection":"Organisation","field":"point_units","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":9,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"Organisation","field":"point_units","sort":9,"group":null}	\N	\N
76	84	directus_fields	1	{"id":1,"collection":"Organisation","field":"name","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"Organisation","field":"name","sort":1,"group":null}	\N	\N
77	85	directus_fields	8	{"id":8,"collection":"Organisation","field":"description","special":null,"interface":"input-multiline","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"Organisation","field":"description","sort":2,"group":null}	\N	\N
78	86	directus_fields	7	{"id":7,"collection":"Organisation","field":"image","special":["file"],"interface":"file-image","options":{"folder":null},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":null,"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"Organisation","field":"image","sort":3,"group":null}	\N	\N
79	87	directus_fields	6	{"id":6,"collection":"Organisation","field":"color_scheme","special":null,"interface":"select-color","options":{"presets":null},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":null,"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"Organisation","field":"color_scheme","sort":4,"group":null}	\N	\N
80	88	directus_fields	2	{"id":2,"collection":"Organisation","field":"status","special":null,"interface":"select-dropdown","options":{"choices":[{"text":"$t:published","value":"published"},{"text":"$t:draft","value":"draft"},{"text":"$t:archived","value":"archived"}]},"display":"labels","display_options":{"showAsDot":true,"choices":[{"text":"$t:published","value":"published","foreground":"#FFFFFF","background":"var(--theme--primary)"},{"text":"$t:draft","value":"draft","foreground":"#18222F","background":"#D3DAE4"},{"text":"$t:archived","value":"archived","foreground":"#FFFFFF","background":"var(--theme--warning)"}]},"readonly":false,"hidden":false,"sort":5,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"Organisation","field":"status","sort":5,"group":null}	\N	\N
81	89	directus_fields	3	{"id":3,"collection":"Organisation","field":"date_created","special":["date-created"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":6,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"Organisation","field":"date_created","sort":6,"group":null}	\N	\N
75	83	directus_fields	9	{"id":9,"collection":"Organisation","field":"point_units","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":9,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"Organisation","field":"point_units","sort":9,"group":null}	\N	\N
85	93	directus_fields	1	{"id":1,"collection":"Organisation","field":"name","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"Organisation","field":"name","sort":1,"group":null}	\N	\N
86	94	directus_fields	8	{"id":8,"collection":"Organisation","field":"description","special":null,"interface":"input-multiline","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"Organisation","field":"description","sort":2,"group":null}	\N	\N
87	95	directus_fields	7	{"id":7,"collection":"Organisation","field":"image","special":["file"],"interface":"file-image","options":{"folder":null},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":null,"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"Organisation","field":"image","sort":3,"group":null}	\N	\N
88	96	directus_fields	6	{"id":6,"collection":"Organisation","field":"color_scheme","special":null,"interface":"select-color","options":{"presets":null},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":null,"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"Organisation","field":"color_scheme","sort":4,"group":null}	\N	\N
89	97	directus_fields	9	{"id":9,"collection":"Organisation","field":"point_units","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"Organisation","field":"point_units","sort":5,"group":null}	\N	\N
90	98	directus_fields	2	{"id":2,"collection":"Organisation","field":"status","special":null,"interface":"select-dropdown","options":{"choices":[{"text":"$t:published","value":"published"},{"text":"$t:draft","value":"draft"},{"text":"$t:archived","value":"archived"}]},"display":"labels","display_options":{"showAsDot":true,"choices":[{"text":"$t:published","value":"published","foreground":"#FFFFFF","background":"var(--theme--primary)"},{"text":"$t:draft","value":"draft","foreground":"#18222F","background":"#D3DAE4"},{"text":"$t:archived","value":"archived","foreground":"#FFFFFF","background":"var(--theme--warning)"}]},"readonly":false,"hidden":false,"sort":6,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"Organisation","field":"status","sort":6,"group":null}	\N	\N
91	99	directus_fields	3	{"id":3,"collection":"Organisation","field":"date_created","special":["date-created"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":7,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"Organisation","field":"date_created","sort":7,"group":null}	\N	\N
92	100	directus_fields	4	{"id":4,"collection":"Organisation","field":"user_updated","special":["user-updated"],"interface":"select-dropdown-m2o","options":{"template":"{{avatar.$thumbnail}} {{first_name}} {{last_name}}"},"display":"user","display_options":null,"readonly":true,"hidden":true,"sort":8,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"Organisation","field":"user_updated","sort":8,"group":null}	\N	\N
93	101	directus_fields	5	{"id":5,"collection":"Organisation","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":9,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"Organisation","field":"date_updated","sort":9,"group":null}	\N	\N
82	90	directus_fields	4	{"id":4,"collection":"Organisation","field":"user_updated","special":["user-updated"],"interface":"select-dropdown-m2o","options":{"template":"{{avatar.$thumbnail}} {{first_name}} {{last_name}}"},"display":"user","display_options":null,"readonly":true,"hidden":true,"sort":7,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"Organisation","field":"user_updated","sort":7,"group":null}	\N	\N
83	91	directus_fields	5	{"id":5,"collection":"Organisation","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":8,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"Organisation","field":"date_updated","sort":8,"group":null}	\N	\N
84	92	directus_fields	9	{"id":9,"collection":"Organisation","field":"point_units","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":9,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"Organisation","field":"point_units","sort":9,"group":null}	\N	\N
94	102	directus_translations	26e6a51a-4ef6-4986-ad0e-d5cd71dacf89	{"key":"name_of_unit","language":"fi-FI","value":"s"}	{"key":"name_of_unit","language":"fi-FI","value":"s"}	\N	\N
95	103	directus_fields	9	{"id":9,"collection":"Organisation","field":"point_units","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"full","translations":[{"language":"fi-FI","translation":"Pisteiden yksikkö (nimi)"}],"note":"$t:name_of_unit","conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"Organisation","field":"point_units","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"full","translations":[{"language":"fi-FI","translation":"Pisteiden yksikkö (nimi)"}],"note":"$t:name_of_unit","conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	\N	\N
96	104	directus_translations	34837161-f9ff-4ac1-bee5-d326153ebe7c	{"value":"What color scheme you want your app to be","language":"en-US","key":"color_scheme_tooltip"}	{"value":"What color scheme you want your app to be","language":"en-US","key":"color_scheme_tooltip"}	\N	\N
97	105	directus_fields	6	{"id":6,"collection":"Organisation","field":"color_scheme","special":null,"interface":"select-color","options":{"presets":null},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":[{"language":"fi-FI","translation":"Väriteema"}],"note":"$t:color_scheme_tooltip","conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"Organisation","field":"color_scheme","special":null,"interface":"select-color","options":{"presets":null},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":[{"language":"fi-FI","translation":"Väriteema"}],"note":"$t:color_scheme_tooltip","conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	\N	\N
98	106	directus_fields	8	{"id":8,"collection":"Organisation","field":"description","special":null,"interface":"input-multiline","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":[{"language":"fi-FI","translation":"Kuvaus"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"Organisation","field":"description","special":null,"interface":"input-multiline","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":[{"language":"fi-FI","translation":"Kuvaus"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	\N	\N
99	107	directus_fields	7	{"id":7,"collection":"Organisation","field":"image","special":["file"],"interface":"file-image","options":{"folder":null},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"fi-FI","translation":"Kuva"}],"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"Organisation","field":"image","special":["file"],"interface":"file-image","options":{"folder":null},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"fi-FI","translation":"Kuva"}],"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	\N	\N
100	108	directus_settings	1	{"id":1,"project_name":"CMS: Digital Task-Tracking Platform","project_url":null,"project_color":"#FF80C0","project_logo":"f092b078-c2d1-4e8a-9648-27ccfdde2002","public_foreground":"a4a04573-ed55-4c7d-b81f-efb13d5b768c","public_background":null,"public_note":"Digital Task-Tracking Platform is a web-based system that allows users to manage, track, and complete tasks in a digital environment.","auth_login_attempts":25,"auth_password_policy":"/^.{8,}$/","storage_asset_transform":"all","storage_asset_presets":null,"custom_css":null,"storage_default_folder":null,"basemaps":null,"mapbox_key":null,"module_bar":null,"project_descriptor":"System that allows users to manage, track and complete tasks in a digital environment. ","default_language":"fi-FI","custom_aspect_ratios":null,"public_favicon":"e532ef31-d2a1-4ad9-b2a7-b609bf6fc355","default_appearance":"auto","default_theme_light":null,"theme_light_overrides":null,"default_theme_dark":null,"theme_dark_overrides":null}	{"default_language":"fi-FI"}	\N	\N
101	109	directus_fields	1	{"id":1,"collection":"Organisation","field":"name","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":[{"language":"fi-FI","translation":"Nimi"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"Organisation","field":"name","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":[{"language":"fi-FI","translation":"Nimi"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	\N	\N
102	110	directus_translations	26e6a51a-4ef6-4986-ad0e-d5cd71dacf89	{"id":"26e6a51a-4ef6-4986-ad0e-d5cd71dacf89","language":"fi-FI","key":"name_of_unit","value":"Pisteiden yksikkö, esim piste, tähti, bitti..."}	{"value":"Pisteiden yksikkö, esim piste, tähti, bitti..."}	\N	\N
103	111	directus_translations	2eafdd21-22c6-4d82-bb8d-4018909b3b92	{"key":"name_of_unit","language":"en-US","value":"Unit of collectable points like point, star, bit..."}	{"key":"name_of_unit","language":"en-US","value":"Unit of collectable points like point, star, bit..."}	\N	\N
104	112	directus_translations	136fa258-da37-47fd-804e-ecc59674ef26	{"key":"color_scheme_tooltip","language":"fi-FI","value":"Sovelluksesi väriteema"}	{"key":"color_scheme_tooltip","language":"fi-FI","value":"Sovelluksesi väriteema"}	\N	\N
105	113	directus_fields	9	{"id":9,"collection":"Organisation","field":"point_units","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"full","translations":[{"language":"fi-FI","translation":"Pisteiden yksikkö"}],"note":"$t:name_of_unit","conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"Organisation","field":"point_units","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"full","translations":[{"language":"fi-FI","translation":"Pisteiden yksikkö"}],"note":"$t:name_of_unit","conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	\N	\N
106	114	directus_translations	e75dd4a4-ed4d-4944-b24a-0cc66b100c5c	{"key":"org_status","language":"en-US","value":"Is the organisation visible publicly?"}	{"key":"org_status","language":"en-US","value":"Is the organisation visible publicly?"}	\N	\N
107	115	directus_fields	2	{"id":2,"collection":"Organisation","field":"status","special":null,"interface":"select-dropdown","options":{"choices":[{"text":"$t:published","value":"published"},{"text":"$t:draft","value":"draft"},{"text":"$t:archived","value":"archived"}]},"display":"labels","display_options":{"showAsDot":true,"choices":[{"text":"$t:published","value":"published","foreground":"#FFFFFF","background":"var(--theme--primary)"},{"text":"$t:draft","value":"draft","foreground":"#18222F","background":"#D3DAE4"},{"text":"$t:archived","value":"archived","foreground":"#FFFFFF","background":"var(--theme--warning)"}]},"readonly":false,"hidden":false,"sort":6,"width":"full","translations":null,"note":"Is the organisation visible publicly","conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"Organisation","field":"status","special":null,"interface":"select-dropdown","options":{"choices":[{"text":"$t:published","value":"published"},{"text":"$t:draft","value":"draft"},{"text":"$t:archived","value":"archived"}]},"display":"labels","display_options":{"showAsDot":true,"choices":[{"text":"$t:published","value":"published","foreground":"#FFFFFF","background":"var(--theme--primary)"},{"text":"$t:draft","value":"draft","foreground":"#18222F","background":"#D3DAE4"},{"text":"$t:archived","value":"archived","foreground":"#FFFFFF","background":"var(--theme--warning)"}]},"readonly":false,"hidden":false,"sort":6,"width":"full","translations":null,"note":"Is the organisation visible publicly","conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	\N	\N
108	116	directus_fields	9	{"id":9,"collection":"Organisation","field":"point_units","special":null,"interface":"input","options":{"iconLeft":"visibility"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"full","translations":[{"language":"fi-FI","translation":"Pisteiden yksikkö"}],"note":"$t:name_of_unit","conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"Organisation","field":"point_units","special":null,"interface":"input","options":{"iconLeft":"visibility"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"full","translations":[{"language":"fi-FI","translation":"Pisteiden yksikkö"}],"note":"$t:name_of_unit","conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	\N	\N
109	117	directus_translations	28628c5f-3832-4c47-be31-6d140e55e373	{"key":"org_status","language":"fi-FI","value":"Onko organisaatiosi julkisesti näkyvissä?"}	{"key":"org_status","language":"fi-FI","value":"Onko organisaatiosi julkisesti näkyvissä?"}	\N	\N
110	118	directus_roles	6daea05b-a2e4-4191-8fd9-6aa623563b17	{"name":"application","admin_access":false,"app_access":true}	{"name":"application","admin_access":false,"app_access":true}	\N	\N
111	119	directus_permissions	1	{"collection":"directus_files","action":"create","permissions":{},"fields":["*"],"role":"6daea05b-a2e4-4191-8fd9-6aa623563b17"}	{"collection":"directus_files","action":"create","permissions":{},"fields":["*"],"role":"6daea05b-a2e4-4191-8fd9-6aa623563b17"}	\N	\N
112	120	directus_permissions	2	{"collection":"directus_files","action":"read","permissions":{},"fields":["*"],"role":"6daea05b-a2e4-4191-8fd9-6aa623563b17"}	{"collection":"directus_files","action":"read","permissions":{},"fields":["*"],"role":"6daea05b-a2e4-4191-8fd9-6aa623563b17"}	\N	\N
113	121	directus_permissions	3	{"collection":"directus_files","action":"update","permissions":{},"fields":["*"],"role":"6daea05b-a2e4-4191-8fd9-6aa623563b17"}	{"collection":"directus_files","action":"update","permissions":{},"fields":["*"],"role":"6daea05b-a2e4-4191-8fd9-6aa623563b17"}	\N	\N
114	122	directus_permissions	4	{"collection":"directus_files","action":"delete","permissions":{},"fields":["*"],"role":"6daea05b-a2e4-4191-8fd9-6aa623563b17"}	{"collection":"directus_files","action":"delete","permissions":{},"fields":["*"],"role":"6daea05b-a2e4-4191-8fd9-6aa623563b17"}	\N	\N
115	123	directus_permissions	5	{"collection":"directus_dashboards","action":"create","permissions":{},"fields":["*"],"role":"6daea05b-a2e4-4191-8fd9-6aa623563b17"}	{"collection":"directus_dashboards","action":"create","permissions":{},"fields":["*"],"role":"6daea05b-a2e4-4191-8fd9-6aa623563b17"}	\N	\N
116	124	directus_permissions	6	{"collection":"directus_dashboards","action":"read","permissions":{},"fields":["*"],"role":"6daea05b-a2e4-4191-8fd9-6aa623563b17"}	{"collection":"directus_dashboards","action":"read","permissions":{},"fields":["*"],"role":"6daea05b-a2e4-4191-8fd9-6aa623563b17"}	\N	\N
117	125	directus_permissions	7	{"collection":"directus_dashboards","action":"update","permissions":{},"fields":["*"],"role":"6daea05b-a2e4-4191-8fd9-6aa623563b17"}	{"collection":"directus_dashboards","action":"update","permissions":{},"fields":["*"],"role":"6daea05b-a2e4-4191-8fd9-6aa623563b17"}	\N	\N
118	126	directus_permissions	8	{"collection":"directus_dashboards","action":"delete","permissions":{},"fields":["*"],"role":"6daea05b-a2e4-4191-8fd9-6aa623563b17"}	{"collection":"directus_dashboards","action":"delete","permissions":{},"fields":["*"],"role":"6daea05b-a2e4-4191-8fd9-6aa623563b17"}	\N	\N
119	127	directus_permissions	9	{"collection":"directus_panels","action":"create","permissions":{},"fields":["*"],"role":"6daea05b-a2e4-4191-8fd9-6aa623563b17"}	{"collection":"directus_panels","action":"create","permissions":{},"fields":["*"],"role":"6daea05b-a2e4-4191-8fd9-6aa623563b17"}	\N	\N
120	128	directus_permissions	10	{"collection":"directus_panels","action":"read","permissions":{},"fields":["*"],"role":"6daea05b-a2e4-4191-8fd9-6aa623563b17"}	{"collection":"directus_panels","action":"read","permissions":{},"fields":["*"],"role":"6daea05b-a2e4-4191-8fd9-6aa623563b17"}	\N	\N
121	129	directus_permissions	11	{"collection":"directus_panels","action":"update","permissions":{},"fields":["*"],"role":"6daea05b-a2e4-4191-8fd9-6aa623563b17"}	{"collection":"directus_panels","action":"update","permissions":{},"fields":["*"],"role":"6daea05b-a2e4-4191-8fd9-6aa623563b17"}	\N	\N
122	130	directus_permissions	12	{"collection":"directus_panels","action":"delete","permissions":{},"fields":["*"],"role":"6daea05b-a2e4-4191-8fd9-6aa623563b17"}	{"collection":"directus_panels","action":"delete","permissions":{},"fields":["*"],"role":"6daea05b-a2e4-4191-8fd9-6aa623563b17"}	\N	\N
124	132	directus_permissions	14	{"collection":"directus_folders","action":"read","permissions":{},"fields":["*"],"role":"6daea05b-a2e4-4191-8fd9-6aa623563b17"}	{"collection":"directus_folders","action":"read","permissions":{},"fields":["*"],"role":"6daea05b-a2e4-4191-8fd9-6aa623563b17"}	\N	\N
125	133	directus_permissions	15	{"collection":"directus_folders","action":"update","permissions":{},"fields":["*"],"role":"6daea05b-a2e4-4191-8fd9-6aa623563b17"}	{"collection":"directus_folders","action":"update","permissions":{},"fields":["*"],"role":"6daea05b-a2e4-4191-8fd9-6aa623563b17"}	\N	\N
126	134	directus_permissions	16	{"collection":"directus_folders","action":"delete","permissions":{},"role":"6daea05b-a2e4-4191-8fd9-6aa623563b17"}	{"collection":"directus_folders","action":"delete","permissions":{},"role":"6daea05b-a2e4-4191-8fd9-6aa623563b17"}	\N	\N
127	135	directus_permissions	17	{"collection":"directus_users","action":"read","permissions":{},"fields":["*"],"role":"6daea05b-a2e4-4191-8fd9-6aa623563b17"}	{"collection":"directus_users","action":"read","permissions":{},"fields":["*"],"role":"6daea05b-a2e4-4191-8fd9-6aa623563b17"}	\N	\N
128	136	directus_permissions	18	{"collection":"directus_users","action":"update","permissions":{"id":{"_eq":"$CURRENT_USER"}},"fields":["first_name","last_name","email","password","location","title","description","avatar","language","appearance","theme_light","theme_dark","theme_light_overrides","theme_dark_overrides","tfa_secret"],"role":"6daea05b-a2e4-4191-8fd9-6aa623563b17"}	{"collection":"directus_users","action":"update","permissions":{"id":{"_eq":"$CURRENT_USER"}},"fields":["first_name","last_name","email","password","location","title","description","avatar","language","appearance","theme_light","theme_dark","theme_light_overrides","theme_dark_overrides","tfa_secret"],"role":"6daea05b-a2e4-4191-8fd9-6aa623563b17"}	\N	\N
129	137	directus_permissions	19	{"collection":"directus_roles","action":"read","permissions":{},"fields":["*"],"role":"6daea05b-a2e4-4191-8fd9-6aa623563b17"}	{"collection":"directus_roles","action":"read","permissions":{},"fields":["*"],"role":"6daea05b-a2e4-4191-8fd9-6aa623563b17"}	\N	\N
130	138	directus_permissions	20	{"collection":"directus_shares","action":"read","permissions":{"_or":[{"role":{"_eq":"$CURRENT_ROLE"}},{"role":{"_null":true}}]},"fields":["*"],"role":"6daea05b-a2e4-4191-8fd9-6aa623563b17"}	{"collection":"directus_shares","action":"read","permissions":{"_or":[{"role":{"_eq":"$CURRENT_ROLE"}},{"role":{"_null":true}}]},"fields":["*"],"role":"6daea05b-a2e4-4191-8fd9-6aa623563b17"}	\N	\N
131	139	directus_permissions	21	{"collection":"directus_shares","action":"create","permissions":{},"fields":["*"],"role":"6daea05b-a2e4-4191-8fd9-6aa623563b17"}	{"collection":"directus_shares","action":"create","permissions":{},"fields":["*"],"role":"6daea05b-a2e4-4191-8fd9-6aa623563b17"}	\N	\N
132	140	directus_permissions	22	{"collection":"directus_shares","action":"update","permissions":{"user_created":{"_eq":"$CURRENT_USER"}},"fields":["*"],"role":"6daea05b-a2e4-4191-8fd9-6aa623563b17"}	{"collection":"directus_shares","action":"update","permissions":{"user_created":{"_eq":"$CURRENT_USER"}},"fields":["*"],"role":"6daea05b-a2e4-4191-8fd9-6aa623563b17"}	\N	\N
133	141	directus_permissions	23	{"collection":"directus_shares","action":"delete","permissions":{"user_created":{"_eq":"$CURRENT_USER"}},"fields":["*"],"role":"6daea05b-a2e4-4191-8fd9-6aa623563b17"}	{"collection":"directus_shares","action":"delete","permissions":{"user_created":{"_eq":"$CURRENT_USER"}},"fields":["*"],"role":"6daea05b-a2e4-4191-8fd9-6aa623563b17"}	\N	\N
134	142	directus_permissions	24	{"collection":"directus_flows","action":"read","permissions":{"trigger":{"_eq":"manual"}},"fields":["id","status","name","icon","color","options","trigger"],"role":"6daea05b-a2e4-4191-8fd9-6aa623563b17"}	{"collection":"directus_flows","action":"read","permissions":{"trigger":{"_eq":"manual"}},"fields":["id","status","name","icon","color","options","trigger"],"role":"6daea05b-a2e4-4191-8fd9-6aa623563b17"}	\N	\N
135	143	directus_permissions	25	{"role":"6daea05b-a2e4-4191-8fd9-6aa623563b17","collection":"Organisation","action":"read"}	{"role":"6daea05b-a2e4-4191-8fd9-6aa623563b17","collection":"Organisation","action":"read"}	\N	\N
136	144	directus_permissions	25	{"id":25,"role":"6daea05b-a2e4-4191-8fd9-6aa623563b17","collection":"Organisation","action":"read","permissions":{"_and":[{"status":{"_eq":"published"}}]},"validation":null,"presets":null,"fields":["name","description","image","color_scheme","point_units"]}	{"role":"6daea05b-a2e4-4191-8fd9-6aa623563b17","collection":"Organisation","action":"read","permissions":{"_and":[{"status":{"_eq":"published"}}]},"validation":null,"presets":null,"fields":["name","description","image","color_scheme","point_units"]}	\N	\N
137	145	directus_roles	6daea05b-a2e4-4191-8fd9-6aa623563b17	{"id":"6daea05b-a2e4-4191-8fd9-6aa623563b17","name":"application","icon":"supervised_user_circle","description":"The Vue Application","ip_access":null,"enforce_tfa":false,"admin_access":false,"app_access":true,"users":[]}	{"description":"The Vue Application"}	\N	\N
138	147	directus_settings	1	{"id":1,"project_name":"CMS: Digital Task-Tracking Platform","project_url":null,"project_color":"#FF80C0","project_logo":"f092b078-c2d1-4e8a-9648-27ccfdde2002","public_foreground":"a4a04573-ed55-4c7d-b81f-efb13d5b768c","public_background":null,"public_note":"Digital Task-Tracking Platform is a web-based system that allows users to manage, track, and complete tasks in a digital environment.","auth_login_attempts":25,"auth_password_policy":"/^.{8,}$/","storage_asset_transform":"all","storage_asset_presets":null,"custom_css":null,"storage_default_folder":null,"basemaps":null,"mapbox_key":null,"module_bar":null,"project_descriptor":"System that allows users to manage, track and complete tasks in a digital environment. ","default_language":"fi-FI","custom_aspect_ratios":null,"public_favicon":"f092b078-c2d1-4e8a-9648-27ccfdde2002","default_appearance":"auto","default_theme_light":null,"theme_light_overrides":null,"default_theme_dark":null,"theme_dark_overrides":null}	{"public_favicon":"f092b078-c2d1-4e8a-9648-27ccfdde2002"}	\N	\N
139	148	directus_settings	1	{"id":1,"project_name":"CMS: Digital Task-Tracking Platform","project_url":null,"project_color":"#FF80C0","project_logo":"f092b078-c2d1-4e8a-9648-27ccfdde2002","public_foreground":"a4a04573-ed55-4c7d-b81f-efb13d5b768c","public_background":null,"public_note":"Digital Task-Tracking Platform is a web-based system that allows users to manage, track, and complete tasks in a digital environment.","auth_login_attempts":25,"auth_password_policy":"/^.{8,}$/","storage_asset_transform":"all","storage_asset_presets":null,"custom_css":null,"storage_default_folder":null,"basemaps":null,"mapbox_key":null,"module_bar":null,"project_descriptor":"System that allows users to manage, track and complete tasks in a digital environment. ","default_language":"fi-FI","custom_aspect_ratios":null,"public_favicon":null,"default_appearance":"auto","default_theme_light":null,"theme_light_overrides":null,"default_theme_dark":null,"theme_dark_overrides":null}	{"public_favicon":null}	\N	\N
\.


--
-- Data for Name: directus_roles; Type: TABLE DATA; Schema: public; Owner: default
--

COPY public.directus_roles (id, name, icon, description, ip_access, enforce_tfa, admin_access, app_access) FROM stdin;
2c2472aa-19e6-441c-be5f-37e95784abe5	Administrator	verified	$t:admin_description	\N	f	t	t
6daea05b-a2e4-4191-8fd9-6aa623563b17	application	supervised_user_circle	The Vue Application	\N	f	f	t
\.


--
-- Data for Name: directus_sessions; Type: TABLE DATA; Schema: public; Owner: default
--

COPY public.directus_sessions (token, "user", expires, ip, user_agent, share, origin) FROM stdin;
eJV-BX-bOK8WukHrvn8pziq6wRi1KzF1luACaLEn9LUXPdn1MdqkjTYCUNRBN7Te	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-08 00:16:15.249+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	\N	http://localhost:8001
fnvV8d-WEA8eVMHPrGC83_6cyM2fNP0CQZA8fxl-EVYfO9z94olZW9AbgwjcSi00	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-08 00:39:50.852+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	\N	http://localhost:8001
5dbCNGzKzoUfz0y7mx0oKzSo3v_vySKA0jbDJ71dsPPSdy0S-xub2Pbj7ncCB8QO	322b0f19-d22f-44e8-a368-dbe6c84c9619	2023-12-08 02:47:24.772+00	10.10.1.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:120.0) Gecko/20100101 Firefox/120.0	\N	http://localhost:8001
\.


--
-- Data for Name: directus_settings; Type: TABLE DATA; Schema: public; Owner: default
--

COPY public.directus_settings (id, project_name, project_url, project_color, project_logo, public_foreground, public_background, public_note, auth_login_attempts, auth_password_policy, storage_asset_transform, storage_asset_presets, custom_css, storage_default_folder, basemaps, mapbox_key, module_bar, project_descriptor, default_language, custom_aspect_ratios, public_favicon, default_appearance, default_theme_light, theme_light_overrides, default_theme_dark, theme_dark_overrides) FROM stdin;
1	CMS: Digital Task-Tracking Platform	\N	#FF80C0	f092b078-c2d1-4e8a-9648-27ccfdde2002	a4a04573-ed55-4c7d-b81f-efb13d5b768c	\N	Digital Task-Tracking Platform is a web-based system that allows users to manage, track, and complete tasks in a digital environment.	25	/^.{8,}$/	all	\N	\N	\N	\N	\N	\N	System that allows users to manage, track and complete tasks in a digital environment. 	fi-FI	\N	\N	auto	\N	\N	\N	\N
\.


--
-- Data for Name: directus_shares; Type: TABLE DATA; Schema: public; Owner: default
--

COPY public.directus_shares (id, name, collection, item, role, password, user_created, date_created, date_start, date_end, times_used, max_uses) FROM stdin;
\.


--
-- Data for Name: directus_translations; Type: TABLE DATA; Schema: public; Owner: default
--

COPY public.directus_translations (id, language, key, value) FROM stdin;
34837161-f9ff-4ac1-bee5-d326153ebe7c	en-US	color_scheme_tooltip	What color scheme you want your app to be
26e6a51a-4ef6-4986-ad0e-d5cd71dacf89	fi-FI	name_of_unit	Pisteiden yksikkö, esim piste, tähti, bitti...
2eafdd21-22c6-4d82-bb8d-4018909b3b92	en-US	name_of_unit	Unit of collectable points like point, star, bit...
136fa258-da37-47fd-804e-ecc59674ef26	fi-FI	color_scheme_tooltip	Sovelluksesi väriteema
e75dd4a4-ed4d-4944-b24a-0cc66b100c5c	en-US	org_status	Is the organisation visible publicly?
28628c5f-3832-4c47-be31-6d140e55e373	fi-FI	org_status	Onko organisaatiosi julkisesti näkyvissä?
\.


--
-- Data for Name: directus_users; Type: TABLE DATA; Schema: public; Owner: default
--

COPY public.directus_users (id, first_name, last_name, email, password, location, title, description, tags, avatar, language, tfa_secret, status, role, token, last_access, last_page, provider, external_identifier, auth_data, email_notifications, appearance, theme_dark, theme_light, theme_light_overrides, theme_dark_overrides) FROM stdin;
322b0f19-d22f-44e8-a368-dbe6c84c9619	Admin	User	admin@jeb4.dev	$argon2id$v=19$m=65536,t=3,p=4$gTJPQuGAjSFk67kuRiPQ1A$B3ql+2pTLryPM2hi6iOdWUiIvx11CS/7gbQWucGdsxg	\N	\N	\N	\N	\N	\N	\N	active	2c2472aa-19e6-441c-be5f-37e95784abe5	\N	2023-12-01 02:47:24.778+00	/content/Organisation	default	\N	\N	t	\N	\N	\N	\N	\N
\.


--
-- Data for Name: directus_versions; Type: TABLE DATA; Schema: public; Owner: default
--

COPY public.directus_versions (id, key, name, collection, item, hash, date_created, date_updated, user_created, user_updated) FROM stdin;
\.


--
-- Data for Name: directus_webhooks; Type: TABLE DATA; Schema: public; Owner: default
--

COPY public.directus_webhooks (id, name, method, url, status, data, actions, collections, headers) FROM stdin;
\.


--
-- Name: directus_activity_id_seq; Type: SEQUENCE SET; Schema: public; Owner: default
--

SELECT pg_catalog.setval('public.directus_activity_id_seq', 149, true);


--
-- Name: directus_fields_id_seq; Type: SEQUENCE SET; Schema: public; Owner: default
--

SELECT pg_catalog.setval('public.directus_fields_id_seq', 9, true);


--
-- Name: directus_notifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: default
--

SELECT pg_catalog.setval('public.directus_notifications_id_seq', 1, false);


--
-- Name: directus_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: default
--

SELECT pg_catalog.setval('public.directus_permissions_id_seq', 25, true);


--
-- Name: directus_presets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: default
--

SELECT pg_catalog.setval('public.directus_presets_id_seq', 3, true);


--
-- Name: directus_relations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: default
--

SELECT pg_catalog.setval('public.directus_relations_id_seq', 2, true);


--
-- Name: directus_revisions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: default
--

SELECT pg_catalog.setval('public.directus_revisions_id_seq', 139, true);


--
-- Name: directus_settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: default
--

SELECT pg_catalog.setval('public.directus_settings_id_seq', 1, true);


--
-- Name: directus_webhooks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: default
--

SELECT pg_catalog.setval('public.directus_webhooks_id_seq', 1, false);


--
-- Name: Organisation Organisation_pkey; Type: CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public."Organisation"
    ADD CONSTRAINT "Organisation_pkey" PRIMARY KEY (name);


--
-- Name: directus_activity directus_activity_pkey; Type: CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.directus_activity
    ADD CONSTRAINT directus_activity_pkey PRIMARY KEY (id);


--
-- Name: directus_collections directus_collections_pkey; Type: CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.directus_collections
    ADD CONSTRAINT directus_collections_pkey PRIMARY KEY (collection);


--
-- Name: directus_dashboards directus_dashboards_pkey; Type: CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.directus_dashboards
    ADD CONSTRAINT directus_dashboards_pkey PRIMARY KEY (id);


--
-- Name: directus_extensions directus_extensions_pkey; Type: CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.directus_extensions
    ADD CONSTRAINT directus_extensions_pkey PRIMARY KEY (name);


--
-- Name: directus_fields directus_fields_pkey; Type: CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.directus_fields
    ADD CONSTRAINT directus_fields_pkey PRIMARY KEY (id);


--
-- Name: directus_files directus_files_pkey; Type: CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT directus_files_pkey PRIMARY KEY (id);


--
-- Name: directus_flows directus_flows_operation_unique; Type: CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.directus_flows
    ADD CONSTRAINT directus_flows_operation_unique UNIQUE (operation);


--
-- Name: directus_flows directus_flows_pkey; Type: CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.directus_flows
    ADD CONSTRAINT directus_flows_pkey PRIMARY KEY (id);


--
-- Name: directus_folders directus_folders_pkey; Type: CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.directus_folders
    ADD CONSTRAINT directus_folders_pkey PRIMARY KEY (id);


--
-- Name: directus_migrations directus_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.directus_migrations
    ADD CONSTRAINT directus_migrations_pkey PRIMARY KEY (version);


--
-- Name: directus_notifications directus_notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.directus_notifications
    ADD CONSTRAINT directus_notifications_pkey PRIMARY KEY (id);


--
-- Name: directus_operations directus_operations_pkey; Type: CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_pkey PRIMARY KEY (id);


--
-- Name: directus_operations directus_operations_reject_unique; Type: CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_reject_unique UNIQUE (reject);


--
-- Name: directus_operations directus_operations_resolve_unique; Type: CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_resolve_unique UNIQUE (resolve);


--
-- Name: directus_panels directus_panels_pkey; Type: CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.directus_panels
    ADD CONSTRAINT directus_panels_pkey PRIMARY KEY (id);


--
-- Name: directus_permissions directus_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.directus_permissions
    ADD CONSTRAINT directus_permissions_pkey PRIMARY KEY (id);


--
-- Name: directus_presets directus_presets_pkey; Type: CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.directus_presets
    ADD CONSTRAINT directus_presets_pkey PRIMARY KEY (id);


--
-- Name: directus_relations directus_relations_pkey; Type: CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.directus_relations
    ADD CONSTRAINT directus_relations_pkey PRIMARY KEY (id);


--
-- Name: directus_revisions directus_revisions_pkey; Type: CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.directus_revisions
    ADD CONSTRAINT directus_revisions_pkey PRIMARY KEY (id);


--
-- Name: directus_roles directus_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.directus_roles
    ADD CONSTRAINT directus_roles_pkey PRIMARY KEY (id);


--
-- Name: directus_sessions directus_sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.directus_sessions
    ADD CONSTRAINT directus_sessions_pkey PRIMARY KEY (token);


--
-- Name: directus_settings directus_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_pkey PRIMARY KEY (id);


--
-- Name: directus_shares directus_shares_pkey; Type: CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.directus_shares
    ADD CONSTRAINT directus_shares_pkey PRIMARY KEY (id);


--
-- Name: directus_translations directus_translations_pkey; Type: CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.directus_translations
    ADD CONSTRAINT directus_translations_pkey PRIMARY KEY (id);


--
-- Name: directus_users directus_users_email_unique; Type: CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_email_unique UNIQUE (email);


--
-- Name: directus_users directus_users_external_identifier_unique; Type: CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_external_identifier_unique UNIQUE (external_identifier);


--
-- Name: directus_users directus_users_pkey; Type: CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_pkey PRIMARY KEY (id);


--
-- Name: directus_users directus_users_token_unique; Type: CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_token_unique UNIQUE (token);


--
-- Name: directus_versions directus_versions_pkey; Type: CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.directus_versions
    ADD CONSTRAINT directus_versions_pkey PRIMARY KEY (id);


--
-- Name: directus_webhooks directus_webhooks_pkey; Type: CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.directus_webhooks
    ADD CONSTRAINT directus_webhooks_pkey PRIMARY KEY (id);


--
-- Name: directus_collections directus_collections_group_foreign; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.directus_collections
    ADD CONSTRAINT directus_collections_group_foreign FOREIGN KEY ("group") REFERENCES public.directus_collections(collection);


--
-- Name: directus_dashboards directus_dashboards_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.directus_dashboards
    ADD CONSTRAINT directus_dashboards_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_files directus_files_folder_foreign; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT directus_files_folder_foreign FOREIGN KEY (folder) REFERENCES public.directus_folders(id) ON DELETE SET NULL;


--
-- Name: directus_files directus_files_modified_by_foreign; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT directus_files_modified_by_foreign FOREIGN KEY (modified_by) REFERENCES public.directus_users(id);


--
-- Name: directus_files directus_files_uploaded_by_foreign; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT directus_files_uploaded_by_foreign FOREIGN KEY (uploaded_by) REFERENCES public.directus_users(id);


--
-- Name: directus_flows directus_flows_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.directus_flows
    ADD CONSTRAINT directus_flows_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_folders directus_folders_parent_foreign; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.directus_folders
    ADD CONSTRAINT directus_folders_parent_foreign FOREIGN KEY (parent) REFERENCES public.directus_folders(id);


--
-- Name: directus_notifications directus_notifications_recipient_foreign; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.directus_notifications
    ADD CONSTRAINT directus_notifications_recipient_foreign FOREIGN KEY (recipient) REFERENCES public.directus_users(id) ON DELETE CASCADE;


--
-- Name: directus_notifications directus_notifications_sender_foreign; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.directus_notifications
    ADD CONSTRAINT directus_notifications_sender_foreign FOREIGN KEY (sender) REFERENCES public.directus_users(id);


--
-- Name: directus_operations directus_operations_flow_foreign; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_flow_foreign FOREIGN KEY (flow) REFERENCES public.directus_flows(id) ON DELETE CASCADE;


--
-- Name: directus_operations directus_operations_reject_foreign; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_reject_foreign FOREIGN KEY (reject) REFERENCES public.directus_operations(id);


--
-- Name: directus_operations directus_operations_resolve_foreign; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_resolve_foreign FOREIGN KEY (resolve) REFERENCES public.directus_operations(id);


--
-- Name: directus_operations directus_operations_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_panels directus_panels_dashboard_foreign; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.directus_panels
    ADD CONSTRAINT directus_panels_dashboard_foreign FOREIGN KEY (dashboard) REFERENCES public.directus_dashboards(id) ON DELETE CASCADE;


--
-- Name: directus_panels directus_panels_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.directus_panels
    ADD CONSTRAINT directus_panels_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_permissions directus_permissions_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.directus_permissions
    ADD CONSTRAINT directus_permissions_role_foreign FOREIGN KEY (role) REFERENCES public.directus_roles(id) ON DELETE CASCADE;


--
-- Name: directus_presets directus_presets_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.directus_presets
    ADD CONSTRAINT directus_presets_role_foreign FOREIGN KEY (role) REFERENCES public.directus_roles(id) ON DELETE CASCADE;


--
-- Name: directus_presets directus_presets_user_foreign; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.directus_presets
    ADD CONSTRAINT directus_presets_user_foreign FOREIGN KEY ("user") REFERENCES public.directus_users(id) ON DELETE CASCADE;


--
-- Name: directus_revisions directus_revisions_activity_foreign; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.directus_revisions
    ADD CONSTRAINT directus_revisions_activity_foreign FOREIGN KEY (activity) REFERENCES public.directus_activity(id) ON DELETE CASCADE;


--
-- Name: directus_revisions directus_revisions_parent_foreign; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.directus_revisions
    ADD CONSTRAINT directus_revisions_parent_foreign FOREIGN KEY (parent) REFERENCES public.directus_revisions(id);


--
-- Name: directus_revisions directus_revisions_version_foreign; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.directus_revisions
    ADD CONSTRAINT directus_revisions_version_foreign FOREIGN KEY (version) REFERENCES public.directus_versions(id) ON DELETE CASCADE;


--
-- Name: directus_sessions directus_sessions_share_foreign; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.directus_sessions
    ADD CONSTRAINT directus_sessions_share_foreign FOREIGN KEY (share) REFERENCES public.directus_shares(id) ON DELETE CASCADE;


--
-- Name: directus_sessions directus_sessions_user_foreign; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.directus_sessions
    ADD CONSTRAINT directus_sessions_user_foreign FOREIGN KEY ("user") REFERENCES public.directus_users(id) ON DELETE CASCADE;


--
-- Name: directus_settings directus_settings_project_logo_foreign; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_project_logo_foreign FOREIGN KEY (project_logo) REFERENCES public.directus_files(id);


--
-- Name: directus_settings directus_settings_public_background_foreign; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_public_background_foreign FOREIGN KEY (public_background) REFERENCES public.directus_files(id);


--
-- Name: directus_settings directus_settings_public_favicon_foreign; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_public_favicon_foreign FOREIGN KEY (public_favicon) REFERENCES public.directus_files(id);


--
-- Name: directus_settings directus_settings_public_foreground_foreign; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_public_foreground_foreign FOREIGN KEY (public_foreground) REFERENCES public.directus_files(id);


--
-- Name: directus_settings directus_settings_storage_default_folder_foreign; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_storage_default_folder_foreign FOREIGN KEY (storage_default_folder) REFERENCES public.directus_folders(id) ON DELETE SET NULL;


--
-- Name: directus_shares directus_shares_collection_foreign; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.directus_shares
    ADD CONSTRAINT directus_shares_collection_foreign FOREIGN KEY (collection) REFERENCES public.directus_collections(collection) ON DELETE CASCADE;


--
-- Name: directus_shares directus_shares_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.directus_shares
    ADD CONSTRAINT directus_shares_role_foreign FOREIGN KEY (role) REFERENCES public.directus_roles(id) ON DELETE CASCADE;


--
-- Name: directus_shares directus_shares_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.directus_shares
    ADD CONSTRAINT directus_shares_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_users directus_users_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_role_foreign FOREIGN KEY (role) REFERENCES public.directus_roles(id) ON DELETE SET NULL;


--
-- Name: directus_versions directus_versions_collection_foreign; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.directus_versions
    ADD CONSTRAINT directus_versions_collection_foreign FOREIGN KEY (collection) REFERENCES public.directus_collections(collection) ON DELETE CASCADE;


--
-- Name: directus_versions directus_versions_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.directus_versions
    ADD CONSTRAINT directus_versions_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_versions directus_versions_user_updated_foreign; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.directus_versions
    ADD CONSTRAINT directus_versions_user_updated_foreign FOREIGN KEY (user_updated) REFERENCES public.directus_users(id);


--
-- Name: Organisation organisation_image_foreign; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public."Organisation"
    ADD CONSTRAINT organisation_image_foreign FOREIGN KEY (image) REFERENCES public.directus_files(id) ON DELETE SET NULL;


--
-- Name: Organisation organisation_user_updated_foreign; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public."Organisation"
    ADD CONSTRAINT organisation_user_updated_foreign FOREIGN KEY (user_updated) REFERENCES public.directus_users(id);


--
-- PostgreSQL database dump complete
--

