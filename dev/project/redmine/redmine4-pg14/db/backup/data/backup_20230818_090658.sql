--
-- PostgreSQL database dump
--

-- Dumped from database version 14.5 (Debian 14.5-2.pgdg110+2)
-- Dumped by pg_dump version 15.4

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
-- Name: public; Type: SCHEMA; Schema: -; Owner: redmine_user
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO redmine_user;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: redmine_user
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.ar_internal_metadata OWNER TO redmine_user;

--
-- Name: attachments; Type: TABLE; Schema: public; Owner: redmine_user
--

CREATE TABLE public.attachments (
    id integer NOT NULL,
    container_id integer,
    container_type character varying(30),
    filename character varying DEFAULT ''::character varying NOT NULL,
    disk_filename character varying DEFAULT ''::character varying NOT NULL,
    filesize bigint DEFAULT 0 NOT NULL,
    content_type character varying DEFAULT ''::character varying,
    digest character varying(64) DEFAULT ''::character varying NOT NULL,
    downloads integer DEFAULT 0 NOT NULL,
    author_id integer DEFAULT 0 NOT NULL,
    created_on timestamp without time zone,
    description character varying,
    disk_directory character varying
);


ALTER TABLE public.attachments OWNER TO redmine_user;

--
-- Name: attachments_id_seq; Type: SEQUENCE; Schema: public; Owner: redmine_user
--

CREATE SEQUENCE public.attachments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.attachments_id_seq OWNER TO redmine_user;

--
-- Name: attachments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: redmine_user
--

ALTER SEQUENCE public.attachments_id_seq OWNED BY public.attachments.id;


--
-- Name: auth_sources; Type: TABLE; Schema: public; Owner: redmine_user
--

CREATE TABLE public.auth_sources (
    id integer NOT NULL,
    type character varying(30) DEFAULT ''::character varying NOT NULL,
    name character varying(60) DEFAULT ''::character varying NOT NULL,
    host character varying(60),
    port integer,
    account character varying,
    account_password character varying DEFAULT ''::character varying,
    base_dn character varying(255),
    attr_login character varying(30),
    attr_firstname character varying(30),
    attr_lastname character varying(30),
    attr_mail character varying(30),
    onthefly_register boolean DEFAULT false NOT NULL,
    tls boolean DEFAULT false NOT NULL,
    filter text,
    timeout integer,
    verify_peer boolean DEFAULT true NOT NULL
);


ALTER TABLE public.auth_sources OWNER TO redmine_user;

--
-- Name: auth_sources_id_seq; Type: SEQUENCE; Schema: public; Owner: redmine_user
--

CREATE SEQUENCE public.auth_sources_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_sources_id_seq OWNER TO redmine_user;

--
-- Name: auth_sources_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: redmine_user
--

ALTER SEQUENCE public.auth_sources_id_seq OWNED BY public.auth_sources.id;


--
-- Name: boards; Type: TABLE; Schema: public; Owner: redmine_user
--

CREATE TABLE public.boards (
    id integer NOT NULL,
    project_id integer NOT NULL,
    name character varying DEFAULT ''::character varying NOT NULL,
    description character varying,
    "position" integer,
    topics_count integer DEFAULT 0 NOT NULL,
    messages_count integer DEFAULT 0 NOT NULL,
    last_message_id integer,
    parent_id integer
);


ALTER TABLE public.boards OWNER TO redmine_user;

--
-- Name: boards_id_seq; Type: SEQUENCE; Schema: public; Owner: redmine_user
--

CREATE SEQUENCE public.boards_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.boards_id_seq OWNER TO redmine_user;

--
-- Name: boards_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: redmine_user
--

ALTER SEQUENCE public.boards_id_seq OWNED BY public.boards.id;


--
-- Name: changes; Type: TABLE; Schema: public; Owner: redmine_user
--

CREATE TABLE public.changes (
    id integer NOT NULL,
    changeset_id integer NOT NULL,
    action character varying(1) DEFAULT ''::character varying NOT NULL,
    path text NOT NULL,
    from_path text,
    from_revision character varying,
    revision character varying,
    branch character varying
);


ALTER TABLE public.changes OWNER TO redmine_user;

--
-- Name: changes_id_seq; Type: SEQUENCE; Schema: public; Owner: redmine_user
--

CREATE SEQUENCE public.changes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.changes_id_seq OWNER TO redmine_user;

--
-- Name: changes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: redmine_user
--

ALTER SEQUENCE public.changes_id_seq OWNED BY public.changes.id;


--
-- Name: changeset_parents; Type: TABLE; Schema: public; Owner: redmine_user
--

CREATE TABLE public.changeset_parents (
    changeset_id integer NOT NULL,
    parent_id integer NOT NULL
);


ALTER TABLE public.changeset_parents OWNER TO redmine_user;

--
-- Name: changesets; Type: TABLE; Schema: public; Owner: redmine_user
--

CREATE TABLE public.changesets (
    id integer NOT NULL,
    repository_id integer NOT NULL,
    revision character varying NOT NULL,
    committer character varying,
    committed_on timestamp without time zone NOT NULL,
    comments text,
    commit_date date,
    scmid character varying,
    user_id integer
);


ALTER TABLE public.changesets OWNER TO redmine_user;

--
-- Name: changesets_id_seq; Type: SEQUENCE; Schema: public; Owner: redmine_user
--

CREATE SEQUENCE public.changesets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.changesets_id_seq OWNER TO redmine_user;

--
-- Name: changesets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: redmine_user
--

ALTER SEQUENCE public.changesets_id_seq OWNED BY public.changesets.id;


--
-- Name: changesets_issues; Type: TABLE; Schema: public; Owner: redmine_user
--

CREATE TABLE public.changesets_issues (
    changeset_id integer NOT NULL,
    issue_id integer NOT NULL
);


ALTER TABLE public.changesets_issues OWNER TO redmine_user;

--
-- Name: comments; Type: TABLE; Schema: public; Owner: redmine_user
--

CREATE TABLE public.comments (
    id integer NOT NULL,
    commented_type character varying(30) DEFAULT ''::character varying NOT NULL,
    commented_id integer DEFAULT 0 NOT NULL,
    author_id integer DEFAULT 0 NOT NULL,
    content text,
    created_on timestamp without time zone NOT NULL,
    updated_on timestamp without time zone NOT NULL
);


ALTER TABLE public.comments OWNER TO redmine_user;

--
-- Name: comments_id_seq; Type: SEQUENCE; Schema: public; Owner: redmine_user
--

CREATE SEQUENCE public.comments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.comments_id_seq OWNER TO redmine_user;

--
-- Name: comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: redmine_user
--

ALTER SEQUENCE public.comments_id_seq OWNED BY public.comments.id;


--
-- Name: custom_field_enumerations; Type: TABLE; Schema: public; Owner: redmine_user
--

CREATE TABLE public.custom_field_enumerations (
    id integer NOT NULL,
    custom_field_id integer NOT NULL,
    name character varying NOT NULL,
    active boolean DEFAULT true NOT NULL,
    "position" integer DEFAULT 1 NOT NULL
);


ALTER TABLE public.custom_field_enumerations OWNER TO redmine_user;

--
-- Name: custom_field_enumerations_id_seq; Type: SEQUENCE; Schema: public; Owner: redmine_user
--

CREATE SEQUENCE public.custom_field_enumerations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.custom_field_enumerations_id_seq OWNER TO redmine_user;

--
-- Name: custom_field_enumerations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: redmine_user
--

ALTER SEQUENCE public.custom_field_enumerations_id_seq OWNED BY public.custom_field_enumerations.id;


--
-- Name: custom_fields; Type: TABLE; Schema: public; Owner: redmine_user
--

CREATE TABLE public.custom_fields (
    id integer NOT NULL,
    type character varying(30) DEFAULT ''::character varying NOT NULL,
    name character varying(30) DEFAULT ''::character varying NOT NULL,
    field_format character varying(30) DEFAULT ''::character varying NOT NULL,
    possible_values text,
    regexp character varying DEFAULT ''::character varying,
    min_length integer,
    max_length integer,
    is_required boolean DEFAULT false NOT NULL,
    is_for_all boolean DEFAULT false NOT NULL,
    is_filter boolean DEFAULT false NOT NULL,
    "position" integer,
    searchable boolean DEFAULT false,
    default_value text,
    editable boolean DEFAULT true,
    visible boolean DEFAULT true NOT NULL,
    multiple boolean DEFAULT false,
    format_store text,
    description text
);


ALTER TABLE public.custom_fields OWNER TO redmine_user;

--
-- Name: custom_fields_id_seq; Type: SEQUENCE; Schema: public; Owner: redmine_user
--

CREATE SEQUENCE public.custom_fields_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.custom_fields_id_seq OWNER TO redmine_user;

--
-- Name: custom_fields_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: redmine_user
--

ALTER SEQUENCE public.custom_fields_id_seq OWNED BY public.custom_fields.id;


--
-- Name: custom_fields_projects; Type: TABLE; Schema: public; Owner: redmine_user
--

CREATE TABLE public.custom_fields_projects (
    custom_field_id integer DEFAULT 0 NOT NULL,
    project_id integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.custom_fields_projects OWNER TO redmine_user;

--
-- Name: custom_fields_roles; Type: TABLE; Schema: public; Owner: redmine_user
--

CREATE TABLE public.custom_fields_roles (
    custom_field_id integer NOT NULL,
    role_id integer NOT NULL
);


ALTER TABLE public.custom_fields_roles OWNER TO redmine_user;

--
-- Name: custom_fields_trackers; Type: TABLE; Schema: public; Owner: redmine_user
--

CREATE TABLE public.custom_fields_trackers (
    custom_field_id integer DEFAULT 0 NOT NULL,
    tracker_id integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.custom_fields_trackers OWNER TO redmine_user;

--
-- Name: custom_values; Type: TABLE; Schema: public; Owner: redmine_user
--

CREATE TABLE public.custom_values (
    id integer NOT NULL,
    customized_type character varying(30) DEFAULT ''::character varying NOT NULL,
    customized_id integer DEFAULT 0 NOT NULL,
    custom_field_id integer DEFAULT 0 NOT NULL,
    value text
);


ALTER TABLE public.custom_values OWNER TO redmine_user;

--
-- Name: custom_values_id_seq; Type: SEQUENCE; Schema: public; Owner: redmine_user
--

CREATE SEQUENCE public.custom_values_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.custom_values_id_seq OWNER TO redmine_user;

--
-- Name: custom_values_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: redmine_user
--

ALTER SEQUENCE public.custom_values_id_seq OWNED BY public.custom_values.id;


--
-- Name: documents; Type: TABLE; Schema: public; Owner: redmine_user
--

CREATE TABLE public.documents (
    id integer NOT NULL,
    project_id integer DEFAULT 0 NOT NULL,
    category_id integer DEFAULT 0 NOT NULL,
    title character varying DEFAULT ''::character varying NOT NULL,
    description text,
    created_on timestamp without time zone
);


ALTER TABLE public.documents OWNER TO redmine_user;

--
-- Name: documents_id_seq; Type: SEQUENCE; Schema: public; Owner: redmine_user
--

CREATE SEQUENCE public.documents_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.documents_id_seq OWNER TO redmine_user;

--
-- Name: documents_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: redmine_user
--

ALTER SEQUENCE public.documents_id_seq OWNED BY public.documents.id;


--
-- Name: email_addresses; Type: TABLE; Schema: public; Owner: redmine_user
--

CREATE TABLE public.email_addresses (
    id integer NOT NULL,
    user_id integer NOT NULL,
    address character varying NOT NULL,
    is_default boolean DEFAULT false NOT NULL,
    notify boolean DEFAULT true NOT NULL,
    created_on timestamp without time zone NOT NULL,
    updated_on timestamp without time zone NOT NULL
);


ALTER TABLE public.email_addresses OWNER TO redmine_user;

--
-- Name: email_addresses_id_seq; Type: SEQUENCE; Schema: public; Owner: redmine_user
--

CREATE SEQUENCE public.email_addresses_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.email_addresses_id_seq OWNER TO redmine_user;

--
-- Name: email_addresses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: redmine_user
--

ALTER SEQUENCE public.email_addresses_id_seq OWNED BY public.email_addresses.id;


--
-- Name: enabled_modules; Type: TABLE; Schema: public; Owner: redmine_user
--

CREATE TABLE public.enabled_modules (
    id integer NOT NULL,
    project_id integer,
    name character varying NOT NULL
);


ALTER TABLE public.enabled_modules OWNER TO redmine_user;

--
-- Name: enabled_modules_id_seq; Type: SEQUENCE; Schema: public; Owner: redmine_user
--

CREATE SEQUENCE public.enabled_modules_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.enabled_modules_id_seq OWNER TO redmine_user;

--
-- Name: enabled_modules_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: redmine_user
--

ALTER SEQUENCE public.enabled_modules_id_seq OWNED BY public.enabled_modules.id;


--
-- Name: enumerations; Type: TABLE; Schema: public; Owner: redmine_user
--

CREATE TABLE public.enumerations (
    id integer NOT NULL,
    name character varying(30) DEFAULT ''::character varying NOT NULL,
    "position" integer,
    is_default boolean DEFAULT false NOT NULL,
    type character varying,
    active boolean DEFAULT true NOT NULL,
    project_id integer,
    parent_id integer,
    position_name character varying(30)
);


ALTER TABLE public.enumerations OWNER TO redmine_user;

--
-- Name: enumerations_id_seq; Type: SEQUENCE; Schema: public; Owner: redmine_user
--

CREATE SEQUENCE public.enumerations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.enumerations_id_seq OWNER TO redmine_user;

--
-- Name: enumerations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: redmine_user
--

ALTER SEQUENCE public.enumerations_id_seq OWNED BY public.enumerations.id;


--
-- Name: groups_users; Type: TABLE; Schema: public; Owner: redmine_user
--

CREATE TABLE public.groups_users (
    group_id integer NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.groups_users OWNER TO redmine_user;

--
-- Name: import_items; Type: TABLE; Schema: public; Owner: redmine_user
--

CREATE TABLE public.import_items (
    id integer NOT NULL,
    import_id integer NOT NULL,
    "position" integer NOT NULL,
    obj_id integer,
    message text,
    unique_id character varying
);


ALTER TABLE public.import_items OWNER TO redmine_user;

--
-- Name: import_items_id_seq; Type: SEQUENCE; Schema: public; Owner: redmine_user
--

CREATE SEQUENCE public.import_items_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.import_items_id_seq OWNER TO redmine_user;

--
-- Name: import_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: redmine_user
--

ALTER SEQUENCE public.import_items_id_seq OWNED BY public.import_items.id;


--
-- Name: imports; Type: TABLE; Schema: public; Owner: redmine_user
--

CREATE TABLE public.imports (
    id integer NOT NULL,
    type character varying,
    user_id integer NOT NULL,
    filename character varying,
    settings text,
    total_items integer,
    finished boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.imports OWNER TO redmine_user;

--
-- Name: imports_id_seq; Type: SEQUENCE; Schema: public; Owner: redmine_user
--

CREATE SEQUENCE public.imports_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.imports_id_seq OWNER TO redmine_user;

--
-- Name: imports_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: redmine_user
--

ALTER SEQUENCE public.imports_id_seq OWNED BY public.imports.id;


--
-- Name: issue_categories; Type: TABLE; Schema: public; Owner: redmine_user
--

CREATE TABLE public.issue_categories (
    id integer NOT NULL,
    project_id integer DEFAULT 0 NOT NULL,
    name character varying(60) DEFAULT ''::character varying NOT NULL,
    assigned_to_id integer
);


ALTER TABLE public.issue_categories OWNER TO redmine_user;

--
-- Name: issue_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: redmine_user
--

CREATE SEQUENCE public.issue_categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.issue_categories_id_seq OWNER TO redmine_user;

--
-- Name: issue_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: redmine_user
--

ALTER SEQUENCE public.issue_categories_id_seq OWNED BY public.issue_categories.id;


--
-- Name: issue_relations; Type: TABLE; Schema: public; Owner: redmine_user
--

CREATE TABLE public.issue_relations (
    id integer NOT NULL,
    issue_from_id integer NOT NULL,
    issue_to_id integer NOT NULL,
    relation_type character varying DEFAULT ''::character varying NOT NULL,
    delay integer
);


ALTER TABLE public.issue_relations OWNER TO redmine_user;

--
-- Name: issue_relations_id_seq; Type: SEQUENCE; Schema: public; Owner: redmine_user
--

CREATE SEQUENCE public.issue_relations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.issue_relations_id_seq OWNER TO redmine_user;

--
-- Name: issue_relations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: redmine_user
--

ALTER SEQUENCE public.issue_relations_id_seq OWNED BY public.issue_relations.id;


--
-- Name: issue_statuses; Type: TABLE; Schema: public; Owner: redmine_user
--

CREATE TABLE public.issue_statuses (
    id integer NOT NULL,
    name character varying(30) DEFAULT ''::character varying NOT NULL,
    is_closed boolean DEFAULT false NOT NULL,
    "position" integer,
    default_done_ratio integer
);


ALTER TABLE public.issue_statuses OWNER TO redmine_user;

--
-- Name: issue_statuses_id_seq; Type: SEQUENCE; Schema: public; Owner: redmine_user
--

CREATE SEQUENCE public.issue_statuses_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.issue_statuses_id_seq OWNER TO redmine_user;

--
-- Name: issue_statuses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: redmine_user
--

ALTER SEQUENCE public.issue_statuses_id_seq OWNED BY public.issue_statuses.id;


--
-- Name: issues; Type: TABLE; Schema: public; Owner: redmine_user
--

CREATE TABLE public.issues (
    id integer NOT NULL,
    tracker_id integer NOT NULL,
    project_id integer NOT NULL,
    subject character varying DEFAULT ''::character varying NOT NULL,
    description text,
    due_date date,
    category_id integer,
    status_id integer NOT NULL,
    assigned_to_id integer,
    priority_id integer NOT NULL,
    fixed_version_id integer,
    author_id integer NOT NULL,
    lock_version integer DEFAULT 0 NOT NULL,
    created_on timestamp without time zone,
    updated_on timestamp without time zone,
    start_date date,
    done_ratio integer DEFAULT 0 NOT NULL,
    estimated_hours double precision,
    parent_id integer,
    root_id integer,
    lft integer,
    rgt integer,
    is_private boolean DEFAULT false NOT NULL,
    closed_on timestamp without time zone
);


ALTER TABLE public.issues OWNER TO redmine_user;

--
-- Name: issues_id_seq; Type: SEQUENCE; Schema: public; Owner: redmine_user
--

CREATE SEQUENCE public.issues_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.issues_id_seq OWNER TO redmine_user;

--
-- Name: issues_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: redmine_user
--

ALTER SEQUENCE public.issues_id_seq OWNED BY public.issues.id;


--
-- Name: journal_details; Type: TABLE; Schema: public; Owner: redmine_user
--

CREATE TABLE public.journal_details (
    id integer NOT NULL,
    journal_id integer DEFAULT 0 NOT NULL,
    property character varying(30) DEFAULT ''::character varying NOT NULL,
    prop_key character varying(30) DEFAULT ''::character varying NOT NULL,
    old_value text,
    value text
);


ALTER TABLE public.journal_details OWNER TO redmine_user;

--
-- Name: journal_details_id_seq; Type: SEQUENCE; Schema: public; Owner: redmine_user
--

CREATE SEQUENCE public.journal_details_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.journal_details_id_seq OWNER TO redmine_user;

--
-- Name: journal_details_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: redmine_user
--

ALTER SEQUENCE public.journal_details_id_seq OWNED BY public.journal_details.id;


--
-- Name: journals; Type: TABLE; Schema: public; Owner: redmine_user
--

CREATE TABLE public.journals (
    id integer NOT NULL,
    journalized_id integer DEFAULT 0 NOT NULL,
    journalized_type character varying(30) DEFAULT ''::character varying NOT NULL,
    user_id integer DEFAULT 0 NOT NULL,
    notes text,
    created_on timestamp without time zone NOT NULL,
    private_notes boolean DEFAULT false NOT NULL
);


ALTER TABLE public.journals OWNER TO redmine_user;

--
-- Name: journals_id_seq; Type: SEQUENCE; Schema: public; Owner: redmine_user
--

CREATE SEQUENCE public.journals_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.journals_id_seq OWNER TO redmine_user;

--
-- Name: journals_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: redmine_user
--

ALTER SEQUENCE public.journals_id_seq OWNED BY public.journals.id;


--
-- Name: member_roles; Type: TABLE; Schema: public; Owner: redmine_user
--

CREATE TABLE public.member_roles (
    id integer NOT NULL,
    member_id integer NOT NULL,
    role_id integer NOT NULL,
    inherited_from integer
);


ALTER TABLE public.member_roles OWNER TO redmine_user;

--
-- Name: member_roles_id_seq; Type: SEQUENCE; Schema: public; Owner: redmine_user
--

CREATE SEQUENCE public.member_roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.member_roles_id_seq OWNER TO redmine_user;

--
-- Name: member_roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: redmine_user
--

ALTER SEQUENCE public.member_roles_id_seq OWNED BY public.member_roles.id;


--
-- Name: members; Type: TABLE; Schema: public; Owner: redmine_user
--

CREATE TABLE public.members (
    id integer NOT NULL,
    user_id integer DEFAULT 0 NOT NULL,
    project_id integer DEFAULT 0 NOT NULL,
    created_on timestamp without time zone,
    mail_notification boolean DEFAULT false NOT NULL
);


ALTER TABLE public.members OWNER TO redmine_user;

--
-- Name: members_id_seq; Type: SEQUENCE; Schema: public; Owner: redmine_user
--

CREATE SEQUENCE public.members_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.members_id_seq OWNER TO redmine_user;

--
-- Name: members_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: redmine_user
--

ALTER SEQUENCE public.members_id_seq OWNED BY public.members.id;


--
-- Name: messages; Type: TABLE; Schema: public; Owner: redmine_user
--

CREATE TABLE public.messages (
    id integer NOT NULL,
    board_id integer NOT NULL,
    parent_id integer,
    subject character varying DEFAULT ''::character varying NOT NULL,
    content text,
    author_id integer,
    replies_count integer DEFAULT 0 NOT NULL,
    last_reply_id integer,
    created_on timestamp without time zone NOT NULL,
    updated_on timestamp without time zone NOT NULL,
    locked boolean DEFAULT false,
    sticky integer DEFAULT 0
);


ALTER TABLE public.messages OWNER TO redmine_user;

--
-- Name: messages_id_seq; Type: SEQUENCE; Schema: public; Owner: redmine_user
--

CREATE SEQUENCE public.messages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.messages_id_seq OWNER TO redmine_user;

--
-- Name: messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: redmine_user
--

ALTER SEQUENCE public.messages_id_seq OWNED BY public.messages.id;


--
-- Name: news; Type: TABLE; Schema: public; Owner: redmine_user
--

CREATE TABLE public.news (
    id integer NOT NULL,
    project_id integer,
    title character varying(60) DEFAULT ''::character varying NOT NULL,
    summary character varying(255) DEFAULT ''::character varying,
    description text,
    author_id integer DEFAULT 0 NOT NULL,
    created_on timestamp without time zone,
    comments_count integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.news OWNER TO redmine_user;

--
-- Name: news_id_seq; Type: SEQUENCE; Schema: public; Owner: redmine_user
--

CREATE SEQUENCE public.news_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.news_id_seq OWNER TO redmine_user;

--
-- Name: news_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: redmine_user
--

ALTER SEQUENCE public.news_id_seq OWNED BY public.news.id;


--
-- Name: open_id_authentication_associations; Type: TABLE; Schema: public; Owner: redmine_user
--

CREATE TABLE public.open_id_authentication_associations (
    id integer NOT NULL,
    issued integer,
    lifetime integer,
    handle character varying,
    assoc_type character varying,
    server_url bytea,
    secret bytea
);


ALTER TABLE public.open_id_authentication_associations OWNER TO redmine_user;

--
-- Name: open_id_authentication_associations_id_seq; Type: SEQUENCE; Schema: public; Owner: redmine_user
--

CREATE SEQUENCE public.open_id_authentication_associations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.open_id_authentication_associations_id_seq OWNER TO redmine_user;

--
-- Name: open_id_authentication_associations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: redmine_user
--

ALTER SEQUENCE public.open_id_authentication_associations_id_seq OWNED BY public.open_id_authentication_associations.id;


--
-- Name: open_id_authentication_nonces; Type: TABLE; Schema: public; Owner: redmine_user
--

CREATE TABLE public.open_id_authentication_nonces (
    id integer NOT NULL,
    "timestamp" integer NOT NULL,
    server_url character varying,
    salt character varying NOT NULL
);


ALTER TABLE public.open_id_authentication_nonces OWNER TO redmine_user;

--
-- Name: open_id_authentication_nonces_id_seq; Type: SEQUENCE; Schema: public; Owner: redmine_user
--

CREATE SEQUENCE public.open_id_authentication_nonces_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.open_id_authentication_nonces_id_seq OWNER TO redmine_user;

--
-- Name: open_id_authentication_nonces_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: redmine_user
--

ALTER SEQUENCE public.open_id_authentication_nonces_id_seq OWNED BY public.open_id_authentication_nonces.id;


--
-- Name: projects; Type: TABLE; Schema: public; Owner: redmine_user
--

CREATE TABLE public.projects (
    id integer NOT NULL,
    name character varying DEFAULT ''::character varying NOT NULL,
    description text,
    homepage character varying DEFAULT ''::character varying,
    is_public boolean DEFAULT true NOT NULL,
    parent_id integer,
    created_on timestamp without time zone,
    updated_on timestamp without time zone,
    identifier character varying,
    status integer DEFAULT 1 NOT NULL,
    lft integer,
    rgt integer,
    inherit_members boolean DEFAULT false NOT NULL,
    default_version_id integer,
    default_assigned_to_id integer
);


ALTER TABLE public.projects OWNER TO redmine_user;

--
-- Name: projects_id_seq; Type: SEQUENCE; Schema: public; Owner: redmine_user
--

CREATE SEQUENCE public.projects_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.projects_id_seq OWNER TO redmine_user;

--
-- Name: projects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: redmine_user
--

ALTER SEQUENCE public.projects_id_seq OWNED BY public.projects.id;


--
-- Name: projects_trackers; Type: TABLE; Schema: public; Owner: redmine_user
--

CREATE TABLE public.projects_trackers (
    project_id integer DEFAULT 0 NOT NULL,
    tracker_id integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.projects_trackers OWNER TO redmine_user;

--
-- Name: queries; Type: TABLE; Schema: public; Owner: redmine_user
--

CREATE TABLE public.queries (
    id integer NOT NULL,
    project_id integer,
    name character varying DEFAULT ''::character varying NOT NULL,
    filters text,
    user_id integer DEFAULT 0 NOT NULL,
    column_names text,
    sort_criteria text,
    group_by character varying,
    type character varying,
    visibility integer DEFAULT 0,
    options text
);


ALTER TABLE public.queries OWNER TO redmine_user;

--
-- Name: queries_id_seq; Type: SEQUENCE; Schema: public; Owner: redmine_user
--

CREATE SEQUENCE public.queries_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.queries_id_seq OWNER TO redmine_user;

--
-- Name: queries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: redmine_user
--

ALTER SEQUENCE public.queries_id_seq OWNED BY public.queries.id;


--
-- Name: queries_roles; Type: TABLE; Schema: public; Owner: redmine_user
--

CREATE TABLE public.queries_roles (
    query_id integer NOT NULL,
    role_id integer NOT NULL
);


ALTER TABLE public.queries_roles OWNER TO redmine_user;

--
-- Name: repositories; Type: TABLE; Schema: public; Owner: redmine_user
--

CREATE TABLE public.repositories (
    id integer NOT NULL,
    project_id integer DEFAULT 0 NOT NULL,
    url character varying DEFAULT ''::character varying NOT NULL,
    login character varying(60) DEFAULT ''::character varying,
    password character varying DEFAULT ''::character varying,
    root_url character varying(255) DEFAULT ''::character varying,
    type character varying,
    path_encoding character varying(64) DEFAULT NULL::character varying,
    log_encoding character varying(64) DEFAULT NULL::character varying,
    extra_info text,
    identifier character varying,
    is_default boolean DEFAULT false,
    created_on timestamp without time zone
);


ALTER TABLE public.repositories OWNER TO redmine_user;

--
-- Name: repositories_id_seq; Type: SEQUENCE; Schema: public; Owner: redmine_user
--

CREATE SEQUENCE public.repositories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.repositories_id_seq OWNER TO redmine_user;

--
-- Name: repositories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: redmine_user
--

ALTER SEQUENCE public.repositories_id_seq OWNED BY public.repositories.id;


--
-- Name: roles; Type: TABLE; Schema: public; Owner: redmine_user
--

CREATE TABLE public.roles (
    id integer NOT NULL,
    name character varying(255) DEFAULT ''::character varying NOT NULL,
    "position" integer,
    assignable boolean DEFAULT true,
    builtin integer DEFAULT 0 NOT NULL,
    permissions text,
    issues_visibility character varying(30) DEFAULT 'default'::character varying NOT NULL,
    users_visibility character varying(30) DEFAULT 'all'::character varying NOT NULL,
    time_entries_visibility character varying(30) DEFAULT 'all'::character varying NOT NULL,
    all_roles_managed boolean DEFAULT true NOT NULL,
    settings text
);


ALTER TABLE public.roles OWNER TO redmine_user;

--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: redmine_user
--

CREATE SEQUENCE public.roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.roles_id_seq OWNER TO redmine_user;

--
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: redmine_user
--

ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;


--
-- Name: roles_managed_roles; Type: TABLE; Schema: public; Owner: redmine_user
--

CREATE TABLE public.roles_managed_roles (
    role_id integer NOT NULL,
    managed_role_id integer NOT NULL
);


ALTER TABLE public.roles_managed_roles OWNER TO redmine_user;

--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: redmine_user
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO redmine_user;

--
-- Name: settings; Type: TABLE; Schema: public; Owner: redmine_user
--

CREATE TABLE public.settings (
    id integer NOT NULL,
    name character varying(255) DEFAULT ''::character varying NOT NULL,
    value text,
    updated_on timestamp without time zone
);


ALTER TABLE public.settings OWNER TO redmine_user;

--
-- Name: settings_id_seq; Type: SEQUENCE; Schema: public; Owner: redmine_user
--

CREATE SEQUENCE public.settings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.settings_id_seq OWNER TO redmine_user;

--
-- Name: settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: redmine_user
--

ALTER SEQUENCE public.settings_id_seq OWNED BY public.settings.id;


--
-- Name: time_entries; Type: TABLE; Schema: public; Owner: redmine_user
--

CREATE TABLE public.time_entries (
    id integer NOT NULL,
    project_id integer NOT NULL,
    user_id integer NOT NULL,
    issue_id integer,
    hours double precision NOT NULL,
    comments character varying(1024),
    activity_id integer NOT NULL,
    spent_on date NOT NULL,
    tyear integer NOT NULL,
    tmonth integer NOT NULL,
    tweek integer NOT NULL,
    created_on timestamp without time zone NOT NULL,
    updated_on timestamp without time zone NOT NULL,
    author_id integer
);


ALTER TABLE public.time_entries OWNER TO redmine_user;

--
-- Name: time_entries_id_seq; Type: SEQUENCE; Schema: public; Owner: redmine_user
--

CREATE SEQUENCE public.time_entries_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.time_entries_id_seq OWNER TO redmine_user;

--
-- Name: time_entries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: redmine_user
--

ALTER SEQUENCE public.time_entries_id_seq OWNED BY public.time_entries.id;


--
-- Name: tokens; Type: TABLE; Schema: public; Owner: redmine_user
--

CREATE TABLE public.tokens (
    id integer NOT NULL,
    user_id integer DEFAULT 0 NOT NULL,
    action character varying(30) DEFAULT ''::character varying NOT NULL,
    value character varying(40) DEFAULT ''::character varying NOT NULL,
    created_on timestamp without time zone NOT NULL,
    updated_on timestamp without time zone
);


ALTER TABLE public.tokens OWNER TO redmine_user;

--
-- Name: tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: redmine_user
--

CREATE SEQUENCE public.tokens_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tokens_id_seq OWNER TO redmine_user;

--
-- Name: tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: redmine_user
--

ALTER SEQUENCE public.tokens_id_seq OWNED BY public.tokens.id;


--
-- Name: trackers; Type: TABLE; Schema: public; Owner: redmine_user
--

CREATE TABLE public.trackers (
    id integer NOT NULL,
    name character varying(30) DEFAULT ''::character varying NOT NULL,
    is_in_chlog boolean DEFAULT false NOT NULL,
    "position" integer,
    is_in_roadmap boolean DEFAULT true NOT NULL,
    fields_bits integer DEFAULT 0,
    default_status_id integer,
    description character varying
);


ALTER TABLE public.trackers OWNER TO redmine_user;

--
-- Name: trackers_id_seq; Type: SEQUENCE; Schema: public; Owner: redmine_user
--

CREATE SEQUENCE public.trackers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.trackers_id_seq OWNER TO redmine_user;

--
-- Name: trackers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: redmine_user
--

ALTER SEQUENCE public.trackers_id_seq OWNED BY public.trackers.id;


--
-- Name: user_preferences; Type: TABLE; Schema: public; Owner: redmine_user
--

CREATE TABLE public.user_preferences (
    id integer NOT NULL,
    user_id integer DEFAULT 0 NOT NULL,
    others text,
    hide_mail boolean DEFAULT true,
    time_zone character varying
);


ALTER TABLE public.user_preferences OWNER TO redmine_user;

--
-- Name: user_preferences_id_seq; Type: SEQUENCE; Schema: public; Owner: redmine_user
--

CREATE SEQUENCE public.user_preferences_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_preferences_id_seq OWNER TO redmine_user;

--
-- Name: user_preferences_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: redmine_user
--

ALTER SEQUENCE public.user_preferences_id_seq OWNED BY public.user_preferences.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: redmine_user
--

CREATE TABLE public.users (
    id integer NOT NULL,
    login character varying DEFAULT ''::character varying NOT NULL,
    hashed_password character varying(40) DEFAULT ''::character varying NOT NULL,
    firstname character varying(30) DEFAULT ''::character varying NOT NULL,
    lastname character varying(255) DEFAULT ''::character varying NOT NULL,
    admin boolean DEFAULT false NOT NULL,
    status integer DEFAULT 1 NOT NULL,
    last_login_on timestamp without time zone,
    language character varying(5) DEFAULT ''::character varying,
    auth_source_id integer,
    created_on timestamp without time zone,
    updated_on timestamp without time zone,
    type character varying,
    identity_url character varying,
    mail_notification character varying DEFAULT ''::character varying NOT NULL,
    salt character varying(64),
    must_change_passwd boolean DEFAULT false NOT NULL,
    passwd_changed_on timestamp without time zone,
    twofa_scheme character varying,
    twofa_totp_key character varying,
    twofa_totp_last_used_at integer
);


ALTER TABLE public.users OWNER TO redmine_user;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: redmine_user
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO redmine_user;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: redmine_user
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: versions; Type: TABLE; Schema: public; Owner: redmine_user
--

CREATE TABLE public.versions (
    id integer NOT NULL,
    project_id integer DEFAULT 0 NOT NULL,
    name character varying DEFAULT ''::character varying NOT NULL,
    description character varying DEFAULT ''::character varying,
    effective_date date,
    created_on timestamp without time zone,
    updated_on timestamp without time zone,
    wiki_page_title character varying,
    status character varying DEFAULT 'open'::character varying,
    sharing character varying DEFAULT 'none'::character varying NOT NULL
);


ALTER TABLE public.versions OWNER TO redmine_user;

--
-- Name: versions_id_seq; Type: SEQUENCE; Schema: public; Owner: redmine_user
--

CREATE SEQUENCE public.versions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.versions_id_seq OWNER TO redmine_user;

--
-- Name: versions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: redmine_user
--

ALTER SEQUENCE public.versions_id_seq OWNED BY public.versions.id;


--
-- Name: watchers; Type: TABLE; Schema: public; Owner: redmine_user
--

CREATE TABLE public.watchers (
    id integer NOT NULL,
    watchable_type character varying DEFAULT ''::character varying NOT NULL,
    watchable_id integer DEFAULT 0 NOT NULL,
    user_id integer
);


ALTER TABLE public.watchers OWNER TO redmine_user;

--
-- Name: watchers_id_seq; Type: SEQUENCE; Schema: public; Owner: redmine_user
--

CREATE SEQUENCE public.watchers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.watchers_id_seq OWNER TO redmine_user;

--
-- Name: watchers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: redmine_user
--

ALTER SEQUENCE public.watchers_id_seq OWNED BY public.watchers.id;


--
-- Name: wiki_content_versions; Type: TABLE; Schema: public; Owner: redmine_user
--

CREATE TABLE public.wiki_content_versions (
    id integer NOT NULL,
    wiki_content_id integer NOT NULL,
    page_id integer NOT NULL,
    author_id integer,
    data bytea,
    compression character varying(6) DEFAULT ''::character varying,
    comments character varying(1024) DEFAULT ''::character varying,
    updated_on timestamp without time zone NOT NULL,
    version integer NOT NULL
);


ALTER TABLE public.wiki_content_versions OWNER TO redmine_user;

--
-- Name: wiki_content_versions_id_seq; Type: SEQUENCE; Schema: public; Owner: redmine_user
--

CREATE SEQUENCE public.wiki_content_versions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wiki_content_versions_id_seq OWNER TO redmine_user;

--
-- Name: wiki_content_versions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: redmine_user
--

ALTER SEQUENCE public.wiki_content_versions_id_seq OWNED BY public.wiki_content_versions.id;


--
-- Name: wiki_contents; Type: TABLE; Schema: public; Owner: redmine_user
--

CREATE TABLE public.wiki_contents (
    id integer NOT NULL,
    page_id integer NOT NULL,
    author_id integer,
    text text,
    comments character varying(1024) DEFAULT ''::character varying,
    updated_on timestamp without time zone NOT NULL,
    version integer NOT NULL
);


ALTER TABLE public.wiki_contents OWNER TO redmine_user;

--
-- Name: wiki_contents_id_seq; Type: SEQUENCE; Schema: public; Owner: redmine_user
--

CREATE SEQUENCE public.wiki_contents_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wiki_contents_id_seq OWNER TO redmine_user;

--
-- Name: wiki_contents_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: redmine_user
--

ALTER SEQUENCE public.wiki_contents_id_seq OWNED BY public.wiki_contents.id;


--
-- Name: wiki_pages; Type: TABLE; Schema: public; Owner: redmine_user
--

CREATE TABLE public.wiki_pages (
    id integer NOT NULL,
    wiki_id integer NOT NULL,
    title character varying(255) NOT NULL,
    created_on timestamp without time zone NOT NULL,
    protected boolean DEFAULT false NOT NULL,
    parent_id integer
);


ALTER TABLE public.wiki_pages OWNER TO redmine_user;

--
-- Name: wiki_pages_id_seq; Type: SEQUENCE; Schema: public; Owner: redmine_user
--

CREATE SEQUENCE public.wiki_pages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wiki_pages_id_seq OWNER TO redmine_user;

--
-- Name: wiki_pages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: redmine_user
--

ALTER SEQUENCE public.wiki_pages_id_seq OWNED BY public.wiki_pages.id;


--
-- Name: wiki_redirects; Type: TABLE; Schema: public; Owner: redmine_user
--

CREATE TABLE public.wiki_redirects (
    id integer NOT NULL,
    wiki_id integer NOT NULL,
    title character varying,
    redirects_to character varying,
    created_on timestamp without time zone NOT NULL,
    redirects_to_wiki_id integer NOT NULL
);


ALTER TABLE public.wiki_redirects OWNER TO redmine_user;

--
-- Name: wiki_redirects_id_seq; Type: SEQUENCE; Schema: public; Owner: redmine_user
--

CREATE SEQUENCE public.wiki_redirects_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wiki_redirects_id_seq OWNER TO redmine_user;

--
-- Name: wiki_redirects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: redmine_user
--

ALTER SEQUENCE public.wiki_redirects_id_seq OWNED BY public.wiki_redirects.id;


--
-- Name: wikis; Type: TABLE; Schema: public; Owner: redmine_user
--

CREATE TABLE public.wikis (
    id integer NOT NULL,
    project_id integer NOT NULL,
    start_page character varying(255) NOT NULL,
    status integer DEFAULT 1 NOT NULL
);


ALTER TABLE public.wikis OWNER TO redmine_user;

--
-- Name: wikis_id_seq; Type: SEQUENCE; Schema: public; Owner: redmine_user
--

CREATE SEQUENCE public.wikis_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wikis_id_seq OWNER TO redmine_user;

--
-- Name: wikis_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: redmine_user
--

ALTER SEQUENCE public.wikis_id_seq OWNED BY public.wikis.id;


--
-- Name: workflows; Type: TABLE; Schema: public; Owner: redmine_user
--

CREATE TABLE public.workflows (
    id integer NOT NULL,
    tracker_id integer DEFAULT 0 NOT NULL,
    old_status_id integer DEFAULT 0 NOT NULL,
    new_status_id integer DEFAULT 0 NOT NULL,
    role_id integer DEFAULT 0 NOT NULL,
    assignee boolean DEFAULT false NOT NULL,
    author boolean DEFAULT false NOT NULL,
    type character varying(30),
    field_name character varying(30),
    rule character varying(30)
);


ALTER TABLE public.workflows OWNER TO redmine_user;

--
-- Name: workflows_id_seq; Type: SEQUENCE; Schema: public; Owner: redmine_user
--

CREATE SEQUENCE public.workflows_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.workflows_id_seq OWNER TO redmine_user;

--
-- Name: workflows_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: redmine_user
--

ALTER SEQUENCE public.workflows_id_seq OWNED BY public.workflows.id;


--
-- Name: attachments id; Type: DEFAULT; Schema: public; Owner: redmine_user
--

ALTER TABLE ONLY public.attachments ALTER COLUMN id SET DEFAULT nextval('public.attachments_id_seq'::regclass);


--
-- Name: auth_sources id; Type: DEFAULT; Schema: public; Owner: redmine_user
--

ALTER TABLE ONLY public.auth_sources ALTER COLUMN id SET DEFAULT nextval('public.auth_sources_id_seq'::regclass);


--
-- Name: boards id; Type: DEFAULT; Schema: public; Owner: redmine_user
--

ALTER TABLE ONLY public.boards ALTER COLUMN id SET DEFAULT nextval('public.boards_id_seq'::regclass);


--
-- Name: changes id; Type: DEFAULT; Schema: public; Owner: redmine_user
--

ALTER TABLE ONLY public.changes ALTER COLUMN id SET DEFAULT nextval('public.changes_id_seq'::regclass);


--
-- Name: changesets id; Type: DEFAULT; Schema: public; Owner: redmine_user
--

ALTER TABLE ONLY public.changesets ALTER COLUMN id SET DEFAULT nextval('public.changesets_id_seq'::regclass);


--
-- Name: comments id; Type: DEFAULT; Schema: public; Owner: redmine_user
--

ALTER TABLE ONLY public.comments ALTER COLUMN id SET DEFAULT nextval('public.comments_id_seq'::regclass);


--
-- Name: custom_field_enumerations id; Type: DEFAULT; Schema: public; Owner: redmine_user
--

ALTER TABLE ONLY public.custom_field_enumerations ALTER COLUMN id SET DEFAULT nextval('public.custom_field_enumerations_id_seq'::regclass);


--
-- Name: custom_fields id; Type: DEFAULT; Schema: public; Owner: redmine_user
--

ALTER TABLE ONLY public.custom_fields ALTER COLUMN id SET DEFAULT nextval('public.custom_fields_id_seq'::regclass);


--
-- Name: custom_values id; Type: DEFAULT; Schema: public; Owner: redmine_user
--

ALTER TABLE ONLY public.custom_values ALTER COLUMN id SET DEFAULT nextval('public.custom_values_id_seq'::regclass);


--
-- Name: documents id; Type: DEFAULT; Schema: public; Owner: redmine_user
--

ALTER TABLE ONLY public.documents ALTER COLUMN id SET DEFAULT nextval('public.documents_id_seq'::regclass);


--
-- Name: email_addresses id; Type: DEFAULT; Schema: public; Owner: redmine_user
--

ALTER TABLE ONLY public.email_addresses ALTER COLUMN id SET DEFAULT nextval('public.email_addresses_id_seq'::regclass);


--
-- Name: enabled_modules id; Type: DEFAULT; Schema: public; Owner: redmine_user
--

ALTER TABLE ONLY public.enabled_modules ALTER COLUMN id SET DEFAULT nextval('public.enabled_modules_id_seq'::regclass);


--
-- Name: enumerations id; Type: DEFAULT; Schema: public; Owner: redmine_user
--

ALTER TABLE ONLY public.enumerations ALTER COLUMN id SET DEFAULT nextval('public.enumerations_id_seq'::regclass);


--
-- Name: import_items id; Type: DEFAULT; Schema: public; Owner: redmine_user
--

ALTER TABLE ONLY public.import_items ALTER COLUMN id SET DEFAULT nextval('public.import_items_id_seq'::regclass);


--
-- Name: imports id; Type: DEFAULT; Schema: public; Owner: redmine_user
--

ALTER TABLE ONLY public.imports ALTER COLUMN id SET DEFAULT nextval('public.imports_id_seq'::regclass);


--
-- Name: issue_categories id; Type: DEFAULT; Schema: public; Owner: redmine_user
--

ALTER TABLE ONLY public.issue_categories ALTER COLUMN id SET DEFAULT nextval('public.issue_categories_id_seq'::regclass);


--
-- Name: issue_relations id; Type: DEFAULT; Schema: public; Owner: redmine_user
--

ALTER TABLE ONLY public.issue_relations ALTER COLUMN id SET DEFAULT nextval('public.issue_relations_id_seq'::regclass);


--
-- Name: issue_statuses id; Type: DEFAULT; Schema: public; Owner: redmine_user
--

ALTER TABLE ONLY public.issue_statuses ALTER COLUMN id SET DEFAULT nextval('public.issue_statuses_id_seq'::regclass);


--
-- Name: issues id; Type: DEFAULT; Schema: public; Owner: redmine_user
--

ALTER TABLE ONLY public.issues ALTER COLUMN id SET DEFAULT nextval('public.issues_id_seq'::regclass);


--
-- Name: journal_details id; Type: DEFAULT; Schema: public; Owner: redmine_user
--

ALTER TABLE ONLY public.journal_details ALTER COLUMN id SET DEFAULT nextval('public.journal_details_id_seq'::regclass);


--
-- Name: journals id; Type: DEFAULT; Schema: public; Owner: redmine_user
--

ALTER TABLE ONLY public.journals ALTER COLUMN id SET DEFAULT nextval('public.journals_id_seq'::regclass);


--
-- Name: member_roles id; Type: DEFAULT; Schema: public; Owner: redmine_user
--

ALTER TABLE ONLY public.member_roles ALTER COLUMN id SET DEFAULT nextval('public.member_roles_id_seq'::regclass);


--
-- Name: members id; Type: DEFAULT; Schema: public; Owner: redmine_user
--

ALTER TABLE ONLY public.members ALTER COLUMN id SET DEFAULT nextval('public.members_id_seq'::regclass);


--
-- Name: messages id; Type: DEFAULT; Schema: public; Owner: redmine_user
--

ALTER TABLE ONLY public.messages ALTER COLUMN id SET DEFAULT nextval('public.messages_id_seq'::regclass);


--
-- Name: news id; Type: DEFAULT; Schema: public; Owner: redmine_user
--

ALTER TABLE ONLY public.news ALTER COLUMN id SET DEFAULT nextval('public.news_id_seq'::regclass);


--
-- Name: open_id_authentication_associations id; Type: DEFAULT; Schema: public; Owner: redmine_user
--

ALTER TABLE ONLY public.open_id_authentication_associations ALTER COLUMN id SET DEFAULT nextval('public.open_id_authentication_associations_id_seq'::regclass);


--
-- Name: open_id_authentication_nonces id; Type: DEFAULT; Schema: public; Owner: redmine_user
--

ALTER TABLE ONLY public.open_id_authentication_nonces ALTER COLUMN id SET DEFAULT nextval('public.open_id_authentication_nonces_id_seq'::regclass);


--
-- Name: projects id; Type: DEFAULT; Schema: public; Owner: redmine_user
--

ALTER TABLE ONLY public.projects ALTER COLUMN id SET DEFAULT nextval('public.projects_id_seq'::regclass);


--
-- Name: queries id; Type: DEFAULT; Schema: public; Owner: redmine_user
--

ALTER TABLE ONLY public.queries ALTER COLUMN id SET DEFAULT nextval('public.queries_id_seq'::regclass);


--
-- Name: repositories id; Type: DEFAULT; Schema: public; Owner: redmine_user
--

ALTER TABLE ONLY public.repositories ALTER COLUMN id SET DEFAULT nextval('public.repositories_id_seq'::regclass);


--
-- Name: roles id; Type: DEFAULT; Schema: public; Owner: redmine_user
--

ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


--
-- Name: settings id; Type: DEFAULT; Schema: public; Owner: redmine_user
--

ALTER TABLE ONLY public.settings ALTER COLUMN id SET DEFAULT nextval('public.settings_id_seq'::regclass);


--
-- Name: time_entries id; Type: DEFAULT; Schema: public; Owner: redmine_user
--

ALTER TABLE ONLY public.time_entries ALTER COLUMN id SET DEFAULT nextval('public.time_entries_id_seq'::regclass);


--
-- Name: tokens id; Type: DEFAULT; Schema: public; Owner: redmine_user
--

ALTER TABLE ONLY public.tokens ALTER COLUMN id SET DEFAULT nextval('public.tokens_id_seq'::regclass);


--
-- Name: trackers id; Type: DEFAULT; Schema: public; Owner: redmine_user
--

ALTER TABLE ONLY public.trackers ALTER COLUMN id SET DEFAULT nextval('public.trackers_id_seq'::regclass);


--
-- Name: user_preferences id; Type: DEFAULT; Schema: public; Owner: redmine_user
--

ALTER TABLE ONLY public.user_preferences ALTER COLUMN id SET DEFAULT nextval('public.user_preferences_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: redmine_user
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: versions id; Type: DEFAULT; Schema: public; Owner: redmine_user
--

ALTER TABLE ONLY public.versions ALTER COLUMN id SET DEFAULT nextval('public.versions_id_seq'::regclass);


--
-- Name: watchers id; Type: DEFAULT; Schema: public; Owner: redmine_user
--

ALTER TABLE ONLY public.watchers ALTER COLUMN id SET DEFAULT nextval('public.watchers_id_seq'::regclass);


--
-- Name: wiki_content_versions id; Type: DEFAULT; Schema: public; Owner: redmine_user
--

ALTER TABLE ONLY public.wiki_content_versions ALTER COLUMN id SET DEFAULT nextval('public.wiki_content_versions_id_seq'::regclass);


--
-- Name: wiki_contents id; Type: DEFAULT; Schema: public; Owner: redmine_user
--

ALTER TABLE ONLY public.wiki_contents ALTER COLUMN id SET DEFAULT nextval('public.wiki_contents_id_seq'::regclass);


--
-- Name: wiki_pages id; Type: DEFAULT; Schema: public; Owner: redmine_user
--

ALTER TABLE ONLY public.wiki_pages ALTER COLUMN id SET DEFAULT nextval('public.wiki_pages_id_seq'::regclass);


--
-- Name: wiki_redirects id; Type: DEFAULT; Schema: public; Owner: redmine_user
--

ALTER TABLE ONLY public.wiki_redirects ALTER COLUMN id SET DEFAULT nextval('public.wiki_redirects_id_seq'::regclass);


--
-- Name: wikis id; Type: DEFAULT; Schema: public; Owner: redmine_user
--

ALTER TABLE ONLY public.wikis ALTER COLUMN id SET DEFAULT nextval('public.wikis_id_seq'::regclass);


--
-- Name: workflows id; Type: DEFAULT; Schema: public; Owner: redmine_user
--

ALTER TABLE ONLY public.workflows ALTER COLUMN id SET DEFAULT nextval('public.workflows_id_seq'::regclass);


--
-- Data for Name: ar_internal_metadata; Type: TABLE DATA; Schema: public; Owner: redmine_user
--

COPY public.ar_internal_metadata (key, value, created_at, updated_at) FROM stdin;
environment	production	2023-08-17 07:04:20.400563	2023-08-17 07:04:20.400563
\.


--
-- Data for Name: attachments; Type: TABLE DATA; Schema: public; Owner: redmine_user
--

COPY public.attachments (id, container_id, container_type, filename, disk_filename, filesize, content_type, digest, downloads, author_id, created_on, description, disk_directory) FROM stdin;
\.


--
-- Data for Name: auth_sources; Type: TABLE DATA; Schema: public; Owner: redmine_user
--

COPY public.auth_sources (id, type, name, host, port, account, account_password, base_dn, attr_login, attr_firstname, attr_lastname, attr_mail, onthefly_register, tls, filter, timeout, verify_peer) FROM stdin;
2	AuthSourceLdap	netssc	192.168.46.21	389	assist@netssc.local	NETssc-2005	OU=Staff,DC=netssc,DC=local	SamAccountName	GivenName	Sn	mail	t	f		\N	f
\.


--
-- Data for Name: boards; Type: TABLE DATA; Schema: public; Owner: redmine_user
--

COPY public.boards (id, project_id, name, description, "position", topics_count, messages_count, last_message_id, parent_id) FROM stdin;
\.


--
-- Data for Name: changes; Type: TABLE DATA; Schema: public; Owner: redmine_user
--

COPY public.changes (id, changeset_id, action, path, from_path, from_revision, revision, branch) FROM stdin;
\.


--
-- Data for Name: changeset_parents; Type: TABLE DATA; Schema: public; Owner: redmine_user
--

COPY public.changeset_parents (changeset_id, parent_id) FROM stdin;
\.


--
-- Data for Name: changesets; Type: TABLE DATA; Schema: public; Owner: redmine_user
--

COPY public.changesets (id, repository_id, revision, committer, committed_on, comments, commit_date, scmid, user_id) FROM stdin;
\.


--
-- Data for Name: changesets_issues; Type: TABLE DATA; Schema: public; Owner: redmine_user
--

COPY public.changesets_issues (changeset_id, issue_id) FROM stdin;
\.


--
-- Data for Name: comments; Type: TABLE DATA; Schema: public; Owner: redmine_user
--

COPY public.comments (id, commented_type, commented_id, author_id, content, created_on, updated_on) FROM stdin;
\.


--
-- Data for Name: custom_field_enumerations; Type: TABLE DATA; Schema: public; Owner: redmine_user
--

COPY public.custom_field_enumerations (id, custom_field_id, name, active, "position") FROM stdin;
\.


--
-- Data for Name: custom_fields; Type: TABLE DATA; Schema: public; Owner: redmine_user
--

COPY public.custom_fields (id, type, name, field_format, possible_values, regexp, min_length, max_length, is_required, is_for_all, is_filter, "position", searchable, default_value, editable, visible, multiple, format_store, description) FROM stdin;
\.


--
-- Data for Name: custom_fields_projects; Type: TABLE DATA; Schema: public; Owner: redmine_user
--

COPY public.custom_fields_projects (custom_field_id, project_id) FROM stdin;
\.


--
-- Data for Name: custom_fields_roles; Type: TABLE DATA; Schema: public; Owner: redmine_user
--

COPY public.custom_fields_roles (custom_field_id, role_id) FROM stdin;
\.


--
-- Data for Name: custom_fields_trackers; Type: TABLE DATA; Schema: public; Owner: redmine_user
--

COPY public.custom_fields_trackers (custom_field_id, tracker_id) FROM stdin;
\.


--
-- Data for Name: custom_values; Type: TABLE DATA; Schema: public; Owner: redmine_user
--

COPY public.custom_values (id, customized_type, customized_id, custom_field_id, value) FROM stdin;
\.


--
-- Data for Name: documents; Type: TABLE DATA; Schema: public; Owner: redmine_user
--

COPY public.documents (id, project_id, category_id, title, description, created_on) FROM stdin;
\.


--
-- Data for Name: email_addresses; Type: TABLE DATA; Schema: public; Owner: redmine_user
--

COPY public.email_addresses (id, user_id, address, is_default, notify, created_on, updated_on) FROM stdin;
1	1	admin@example.net	t	t	2023-08-17 07:04:20.117284	2023-08-17 07:04:20.117284
2	5	nomura@netssc.co.jp	t	t	2023-08-17 07:23:12.142188	2023-08-17 07:23:12.142188
\.


--
-- Data for Name: enabled_modules; Type: TABLE DATA; Schema: public; Owner: redmine_user
--

COPY public.enabled_modules (id, project_id, name) FROM stdin;
\.


--
-- Data for Name: enumerations; Type: TABLE DATA; Schema: public; Owner: redmine_user
--

COPY public.enumerations (id, name, "position", is_default, type, active, project_id, parent_id, position_name) FROM stdin;
\.


--
-- Data for Name: groups_users; Type: TABLE DATA; Schema: public; Owner: redmine_user
--

COPY public.groups_users (group_id, user_id) FROM stdin;
\.


--
-- Data for Name: import_items; Type: TABLE DATA; Schema: public; Owner: redmine_user
--

COPY public.import_items (id, import_id, "position", obj_id, message, unique_id) FROM stdin;
\.


--
-- Data for Name: imports; Type: TABLE DATA; Schema: public; Owner: redmine_user
--

COPY public.imports (id, type, user_id, filename, settings, total_items, finished, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: issue_categories; Type: TABLE DATA; Schema: public; Owner: redmine_user
--

COPY public.issue_categories (id, project_id, name, assigned_to_id) FROM stdin;
\.


--
-- Data for Name: issue_relations; Type: TABLE DATA; Schema: public; Owner: redmine_user
--

COPY public.issue_relations (id, issue_from_id, issue_to_id, relation_type, delay) FROM stdin;
\.


--
-- Data for Name: issue_statuses; Type: TABLE DATA; Schema: public; Owner: redmine_user
--

COPY public.issue_statuses (id, name, is_closed, "position", default_done_ratio) FROM stdin;
\.


--
-- Data for Name: issues; Type: TABLE DATA; Schema: public; Owner: redmine_user
--

COPY public.issues (id, tracker_id, project_id, subject, description, due_date, category_id, status_id, assigned_to_id, priority_id, fixed_version_id, author_id, lock_version, created_on, updated_on, start_date, done_ratio, estimated_hours, parent_id, root_id, lft, rgt, is_private, closed_on) FROM stdin;
\.


--
-- Data for Name: journal_details; Type: TABLE DATA; Schema: public; Owner: redmine_user
--

COPY public.journal_details (id, journal_id, property, prop_key, old_value, value) FROM stdin;
\.


--
-- Data for Name: journals; Type: TABLE DATA; Schema: public; Owner: redmine_user
--

COPY public.journals (id, journalized_id, journalized_type, user_id, notes, created_on, private_notes) FROM stdin;
\.


--
-- Data for Name: member_roles; Type: TABLE DATA; Schema: public; Owner: redmine_user
--

COPY public.member_roles (id, member_id, role_id, inherited_from) FROM stdin;
\.


--
-- Data for Name: members; Type: TABLE DATA; Schema: public; Owner: redmine_user
--

COPY public.members (id, user_id, project_id, created_on, mail_notification) FROM stdin;
\.


--
-- Data for Name: messages; Type: TABLE DATA; Schema: public; Owner: redmine_user
--

COPY public.messages (id, board_id, parent_id, subject, content, author_id, replies_count, last_reply_id, created_on, updated_on, locked, sticky) FROM stdin;
\.


--
-- Data for Name: news; Type: TABLE DATA; Schema: public; Owner: redmine_user
--

COPY public.news (id, project_id, title, summary, description, author_id, created_on, comments_count) FROM stdin;
\.


--
-- Data for Name: open_id_authentication_associations; Type: TABLE DATA; Schema: public; Owner: redmine_user
--

COPY public.open_id_authentication_associations (id, issued, lifetime, handle, assoc_type, server_url, secret) FROM stdin;
\.


--
-- Data for Name: open_id_authentication_nonces; Type: TABLE DATA; Schema: public; Owner: redmine_user
--

COPY public.open_id_authentication_nonces (id, "timestamp", server_url, salt) FROM stdin;
\.


--
-- Data for Name: projects; Type: TABLE DATA; Schema: public; Owner: redmine_user
--

COPY public.projects (id, name, description, homepage, is_public, parent_id, created_on, updated_on, identifier, status, lft, rgt, inherit_members, default_version_id, default_assigned_to_id) FROM stdin;
\.


--
-- Data for Name: projects_trackers; Type: TABLE DATA; Schema: public; Owner: redmine_user
--

COPY public.projects_trackers (project_id, tracker_id) FROM stdin;
\.


--
-- Data for Name: queries; Type: TABLE DATA; Schema: public; Owner: redmine_user
--

COPY public.queries (id, project_id, name, filters, user_id, column_names, sort_criteria, group_by, type, visibility, options) FROM stdin;
\.


--
-- Data for Name: queries_roles; Type: TABLE DATA; Schema: public; Owner: redmine_user
--

COPY public.queries_roles (query_id, role_id) FROM stdin;
\.


--
-- Data for Name: repositories; Type: TABLE DATA; Schema: public; Owner: redmine_user
--

COPY public.repositories (id, project_id, url, login, password, root_url, type, path_encoding, log_encoding, extra_info, identifier, is_default, created_on) FROM stdin;
\.


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: redmine_user
--

COPY public.roles (id, name, "position", assignable, builtin, permissions, issues_visibility, users_visibility, time_entries_visibility, all_roles_managed, settings) FROM stdin;
1	Non member	0	t	1	---\n- :view_issues\n- :view_news\n- :view_messages\n	default	all	all	t	\N
2	Anonymous	0	t	2	---\n- :view_issues\n- :view_news\n- :view_messages\n	default	all	all	t	\N
\.


--
-- Data for Name: roles_managed_roles; Type: TABLE DATA; Schema: public; Owner: redmine_user
--

COPY public.roles_managed_roles (role_id, managed_role_id) FROM stdin;
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: redmine_user
--

COPY public.schema_migrations (version) FROM stdin;
1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
20
21
22
23
24
25
26
27
28
29
30
31
32
33
34
35
36
37
38
39
40
41
42
43
44
45
46
47
48
49
50
51
52
53
54
55
56
57
58
59
60
61
62
63
64
65
66
67
68
69
70
71
72
73
74
75
76
77
78
79
80
81
82
83
84
85
86
87
88
89
90
91
92
93
94
95
96
97
98
99
100
101
102
103
104
105
106
107
108
20090214190337
20090312172426
20090312194159
20090318181151
20090323224724
20090401221305
20090401231134
20090403001910
20090406161854
20090425161243
20090503121501
20090503121505
20090503121510
20090614091200
20090704172350
20090704172355
20090704172358
20091010093521
20091017212227
20091017212457
20091017212644
20091017212938
20091017213027
20091017213113
20091017213151
20091017213228
20091017213257
20091017213332
20091017213444
20091017213536
20091017213642
20091017213716
20091017213757
20091017213835
20091017213910
20091017214015
20091017214107
20091017214136
20091017214236
20091017214308
20091017214336
20091017214406
20091017214440
20091017214519
20091017214611
20091017214644
20091017214720
20091017214750
20091025163651
20091108092559
20091114105931
20091123212029
20091205124427
20091220183509
20091220183727
20091220184736
20091225164732
20091227112908
20100129193402
20100129193813
20100221100219
20100313132032
20100313171051
20100705164950
20100819172912
20101104182107
20101107130441
20101114115114
20101114115359
20110220160626
20110223180944
20110223180953
20110224000000
20110226120112
20110226120132
20110227125750
20110228000000
20110228000100
20110401192910
20110408103312
20110412065600
20110511000000
20110902000000
20111201201315
20120115143024
20120115143100
20120115143126
20120127174243
20120205111326
20120223110929
20120301153455
20120422150750
20120705074331
20120707064544
20120714122000
20120714122100
20120714122200
20120731164049
20120930112914
20121026002032
20121026003537
20121209123234
20121209123358
20121213084931
20130110122628
20130201184705
20130202090625
20130207175206
20130207181455
20130215073721
20130215111127
20130215111141
20130217094251
20130602092539
20130710182539
20130713104233
20130713111657
20130729070143
20130911193200
20131004113137
20131005100610
20131124175346
20131210180802
20131214094309
20131215104612
20131218183023
20140228130325
20140903143914
20140920094058
20141029181752
20141029181824
20141109112308
20141122124142
20150113194759
20150113211532
20150113213922
20150113213955
20150208105930
20150510083747
20150525103953
20150526183158
20150528084820
20150528092912
20150528093249
20150725112753
20150730122707
20150730122735
20150921204850
20150921210243
20151020182334
20151020182731
20151021184614
20151021185456
20151021190616
20151024082034
20151025072118
20151031095005
20160404080304
20160416072926
20160529063352
20161001122012
20161002133421
20161010081301
20161010081528
20161010081600
20161126094932
20161220091118
20170207050700
20170302015225
20170309214320
20170320051650
20170418090031
20170419144536
20170723112801
20180501132547
20180913072918
20180923082945
20180923091603
20190315094151
20190315102101
20190510070108
20190620135549
20200826153401
20200826153402
\.


--
-- Data for Name: settings; Type: TABLE DATA; Schema: public; Owner: redmine_user
--

COPY public.settings (id, name, value, updated_on) FROM stdin;
\.


--
-- Data for Name: time_entries; Type: TABLE DATA; Schema: public; Owner: redmine_user
--

COPY public.time_entries (id, project_id, user_id, issue_id, hours, comments, activity_id, spent_on, tyear, tmonth, tweek, created_on, updated_on, author_id) FROM stdin;
\.


--
-- Data for Name: tokens; Type: TABLE DATA; Schema: public; Owner: redmine_user
--

COPY public.tokens (id, user_id, action, value, created_on, updated_on) FROM stdin;
2	1	session	e689b46b417c0de427310f642ae45969614d536e	2023-08-17 07:04:36.888073	2023-08-17 07:04:42.391045
4	1	feeds	81f6311086c79a8effc1f8f8a2ecc8419c1c65f6	2023-08-17 07:08:35.810887	2023-08-17 07:08:35.810887
5	1	session	507e17683d38c973a6184965e5840d26f83b4f81	2023-08-17 07:15:52.486783	2023-08-17 07:15:56.846197
6	1	session	d584942fc07319e20002944bfc7eaa7c309d71b1	2023-08-17 07:21:34.739002	2023-08-17 07:21:43.936423
7	1	session	4e09423c5f2e749bb3f90ebdf482d615fbcdf347	2023-08-17 07:22:40.135452	2023-08-17 07:22:49.166092
9	5	feeds	57a4ff8c6fa8f11209e4e5c60c36875e259ed7ea	2023-08-17 07:23:12.187893	2023-08-17 07:23:12.187893
10	1	session	0223969677c9408d3a4d110d63b174c05c086e36	2023-08-17 07:24:45.967363	2023-08-17 07:24:54.680606
\.


--
-- Data for Name: trackers; Type: TABLE DATA; Schema: public; Owner: redmine_user
--

COPY public.trackers (id, name, is_in_chlog, "position", is_in_roadmap, fields_bits, default_status_id, description) FROM stdin;
\.


--
-- Data for Name: user_preferences; Type: TABLE DATA; Schema: public; Owner: redmine_user
--

COPY public.user_preferences (id, user_id, others, hide_mail, time_zone) FROM stdin;
1	1	---\n:no_self_notified: '1'\n:my_page_layout:\n  left:\n  - issuesassignedtome\n  right:\n  - issuesreportedbyme\n:my_page_settings: {}\n:comments_sorting: asc\n:warn_on_leaving_unsaved: '1'\n:textarea_font: ''\n:recently_used_projects: 3\n:history_default_tab: notes\n:toolbar_language_options: c,cpp,csharp,css,diff,go,groovy,html,java,javascript,objc,perl,php,python,r,ruby,sass,scala,shell,sql,swift,xml,yaml\n	t	
2	5	---\n:no_self_notified: '1'\n:my_page_layout:\n  left:\n  - issuesassignedtome\n  right:\n  - issuesreportedbyme\n:my_page_settings: {}\n:comments_sorting: asc\n:warn_on_leaving_unsaved: '1'\n:textarea_font: ''\n:recently_used_projects: 3\n:history_default_tab: notes\n:toolbar_language_options: c,cpp,csharp,css,diff,go,groovy,html,java,javascript,objc,perl,php,python,r,ruby,sass,scala,shell,sql,swift,xml,yaml\n	t	
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: redmine_user
--

COPY public.users (id, login, hashed_password, firstname, lastname, admin, status, last_login_on, language, auth_source_id, created_on, updated_on, type, identity_url, mail_notification, salt, must_change_passwd, passwd_changed_on, twofa_scheme, twofa_totp_key, twofa_totp_last_used_at) FROM stdin;
2				Anonymous users	f	1	\N		\N	2023-08-17 07:04:20.068986	2023-08-17 07:04:20.068986	GroupAnonymous	\N		\N	f	\N	\N	\N	\N
3				Non member users	f	1	\N		\N	2023-08-17 07:04:20.087592	2023-08-17 07:04:20.087592	GroupNonMember	\N		\N	f	\N	\N	\N	\N
4				Anonymous	f	0	\N		\N	2023-08-17 07:04:23.381897	2023-08-17 07:04:23.381897	AnonymousUser	\N	only_my_events	\N	f	\N	\N	\N	\N
5	00181nomura		正寿	野村	f	1	2023-08-17 07:23:12.15015	ja	2	2023-08-17 07:23:12.141291	2023-08-17 07:23:33.641169	User	\N	only_my_events	\N	f	\N	\N	\N	\N
1	admin	2bf0fbf89ae409f7e181c3f6d5b4f2f34d4d3dc5	Redmine	Admin	t	1	2023-08-17 07:24:45.959071		\N	2023-08-17 07:04:17.72053	2023-08-17 07:04:36.881444	User	\N	all	335f8fc56374cb87f5a4deb05500f0d5	f	2023-08-17 07:04:36	\N	\N	\N
\.


--
-- Data for Name: versions; Type: TABLE DATA; Schema: public; Owner: redmine_user
--

COPY public.versions (id, project_id, name, description, effective_date, created_on, updated_on, wiki_page_title, status, sharing) FROM stdin;
\.


--
-- Data for Name: watchers; Type: TABLE DATA; Schema: public; Owner: redmine_user
--

COPY public.watchers (id, watchable_type, watchable_id, user_id) FROM stdin;
\.


--
-- Data for Name: wiki_content_versions; Type: TABLE DATA; Schema: public; Owner: redmine_user
--

COPY public.wiki_content_versions (id, wiki_content_id, page_id, author_id, data, compression, comments, updated_on, version) FROM stdin;
\.


--
-- Data for Name: wiki_contents; Type: TABLE DATA; Schema: public; Owner: redmine_user
--

COPY public.wiki_contents (id, page_id, author_id, text, comments, updated_on, version) FROM stdin;
\.


--
-- Data for Name: wiki_pages; Type: TABLE DATA; Schema: public; Owner: redmine_user
--

COPY public.wiki_pages (id, wiki_id, title, created_on, protected, parent_id) FROM stdin;
\.


--
-- Data for Name: wiki_redirects; Type: TABLE DATA; Schema: public; Owner: redmine_user
--

COPY public.wiki_redirects (id, wiki_id, title, redirects_to, created_on, redirects_to_wiki_id) FROM stdin;
\.


--
-- Data for Name: wikis; Type: TABLE DATA; Schema: public; Owner: redmine_user
--

COPY public.wikis (id, project_id, start_page, status) FROM stdin;
\.


--
-- Data for Name: workflows; Type: TABLE DATA; Schema: public; Owner: redmine_user
--

COPY public.workflows (id, tracker_id, old_status_id, new_status_id, role_id, assignee, author, type, field_name, rule) FROM stdin;
\.


--
-- Name: attachments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: redmine_user
--

SELECT pg_catalog.setval('public.attachments_id_seq', 1, false);


--
-- Name: auth_sources_id_seq; Type: SEQUENCE SET; Schema: public; Owner: redmine_user
--

SELECT pg_catalog.setval('public.auth_sources_id_seq', 2, true);


--
-- Name: boards_id_seq; Type: SEQUENCE SET; Schema: public; Owner: redmine_user
--

SELECT pg_catalog.setval('public.boards_id_seq', 1, false);


--
-- Name: changes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: redmine_user
--

SELECT pg_catalog.setval('public.changes_id_seq', 1, false);


--
-- Name: changesets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: redmine_user
--

SELECT pg_catalog.setval('public.changesets_id_seq', 1, false);


--
-- Name: comments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: redmine_user
--

SELECT pg_catalog.setval('public.comments_id_seq', 1, false);


--
-- Name: custom_field_enumerations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: redmine_user
--

SELECT pg_catalog.setval('public.custom_field_enumerations_id_seq', 1, false);


--
-- Name: custom_fields_id_seq; Type: SEQUENCE SET; Schema: public; Owner: redmine_user
--

SELECT pg_catalog.setval('public.custom_fields_id_seq', 1, false);


--
-- Name: custom_values_id_seq; Type: SEQUENCE SET; Schema: public; Owner: redmine_user
--

SELECT pg_catalog.setval('public.custom_values_id_seq', 1, false);


--
-- Name: documents_id_seq; Type: SEQUENCE SET; Schema: public; Owner: redmine_user
--

SELECT pg_catalog.setval('public.documents_id_seq', 1, false);


--
-- Name: email_addresses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: redmine_user
--

SELECT pg_catalog.setval('public.email_addresses_id_seq', 2, true);


--
-- Name: enabled_modules_id_seq; Type: SEQUENCE SET; Schema: public; Owner: redmine_user
--

SELECT pg_catalog.setval('public.enabled_modules_id_seq', 1, false);


--
-- Name: enumerations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: redmine_user
--

SELECT pg_catalog.setval('public.enumerations_id_seq', 1, false);


--
-- Name: import_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: redmine_user
--

SELECT pg_catalog.setval('public.import_items_id_seq', 1, false);


--
-- Name: imports_id_seq; Type: SEQUENCE SET; Schema: public; Owner: redmine_user
--

SELECT pg_catalog.setval('public.imports_id_seq', 1, false);


--
-- Name: issue_categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: redmine_user
--

SELECT pg_catalog.setval('public.issue_categories_id_seq', 1, false);


--
-- Name: issue_relations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: redmine_user
--

SELECT pg_catalog.setval('public.issue_relations_id_seq', 1, false);


--
-- Name: issue_statuses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: redmine_user
--

SELECT pg_catalog.setval('public.issue_statuses_id_seq', 1, false);


--
-- Name: issues_id_seq; Type: SEQUENCE SET; Schema: public; Owner: redmine_user
--

SELECT pg_catalog.setval('public.issues_id_seq', 1, false);


--
-- Name: journal_details_id_seq; Type: SEQUENCE SET; Schema: public; Owner: redmine_user
--

SELECT pg_catalog.setval('public.journal_details_id_seq', 1, false);


--
-- Name: journals_id_seq; Type: SEQUENCE SET; Schema: public; Owner: redmine_user
--

SELECT pg_catalog.setval('public.journals_id_seq', 1, false);


--
-- Name: member_roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: redmine_user
--

SELECT pg_catalog.setval('public.member_roles_id_seq', 1, false);


--
-- Name: members_id_seq; Type: SEQUENCE SET; Schema: public; Owner: redmine_user
--

SELECT pg_catalog.setval('public.members_id_seq', 1, false);


--
-- Name: messages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: redmine_user
--

SELECT pg_catalog.setval('public.messages_id_seq', 1, false);


--
-- Name: news_id_seq; Type: SEQUENCE SET; Schema: public; Owner: redmine_user
--

SELECT pg_catalog.setval('public.news_id_seq', 1, false);


--
-- Name: open_id_authentication_associations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: redmine_user
--

SELECT pg_catalog.setval('public.open_id_authentication_associations_id_seq', 1, false);


--
-- Name: open_id_authentication_nonces_id_seq; Type: SEQUENCE SET; Schema: public; Owner: redmine_user
--

SELECT pg_catalog.setval('public.open_id_authentication_nonces_id_seq', 1, false);


--
-- Name: projects_id_seq; Type: SEQUENCE SET; Schema: public; Owner: redmine_user
--

SELECT pg_catalog.setval('public.projects_id_seq', 1, false);


--
-- Name: queries_id_seq; Type: SEQUENCE SET; Schema: public; Owner: redmine_user
--

SELECT pg_catalog.setval('public.queries_id_seq', 1, false);


--
-- Name: repositories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: redmine_user
--

SELECT pg_catalog.setval('public.repositories_id_seq', 1, false);


--
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: redmine_user
--

SELECT pg_catalog.setval('public.roles_id_seq', 2, true);


--
-- Name: settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: redmine_user
--

SELECT pg_catalog.setval('public.settings_id_seq', 1, false);


--
-- Name: time_entries_id_seq; Type: SEQUENCE SET; Schema: public; Owner: redmine_user
--

SELECT pg_catalog.setval('public.time_entries_id_seq', 1, false);


--
-- Name: tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: redmine_user
--

SELECT pg_catalog.setval('public.tokens_id_seq', 10, true);


--
-- Name: trackers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: redmine_user
--

SELECT pg_catalog.setval('public.trackers_id_seq', 1, false);


--
-- Name: user_preferences_id_seq; Type: SEQUENCE SET; Schema: public; Owner: redmine_user
--

SELECT pg_catalog.setval('public.user_preferences_id_seq', 2, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: redmine_user
--

SELECT pg_catalog.setval('public.users_id_seq', 5, true);


--
-- Name: versions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: redmine_user
--

SELECT pg_catalog.setval('public.versions_id_seq', 1, false);


--
-- Name: watchers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: redmine_user
--

SELECT pg_catalog.setval('public.watchers_id_seq', 1, false);


--
-- Name: wiki_content_versions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: redmine_user
--

SELECT pg_catalog.setval('public.wiki_content_versions_id_seq', 1, false);


--
-- Name: wiki_contents_id_seq; Type: SEQUENCE SET; Schema: public; Owner: redmine_user
--

SELECT pg_catalog.setval('public.wiki_contents_id_seq', 1, false);


--
-- Name: wiki_pages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: redmine_user
--

SELECT pg_catalog.setval('public.wiki_pages_id_seq', 1, false);


--
-- Name: wiki_redirects_id_seq; Type: SEQUENCE SET; Schema: public; Owner: redmine_user
--

SELECT pg_catalog.setval('public.wiki_redirects_id_seq', 1, false);


--
-- Name: wikis_id_seq; Type: SEQUENCE SET; Schema: public; Owner: redmine_user
--

SELECT pg_catalog.setval('public.wikis_id_seq', 1, false);


--
-- Name: workflows_id_seq; Type: SEQUENCE SET; Schema: public; Owner: redmine_user
--

SELECT pg_catalog.setval('public.workflows_id_seq', 1, false);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: redmine_user
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: attachments attachments_pkey; Type: CONSTRAINT; Schema: public; Owner: redmine_user
--

ALTER TABLE ONLY public.attachments
    ADD CONSTRAINT attachments_pkey PRIMARY KEY (id);


--
-- Name: auth_sources auth_sources_pkey; Type: CONSTRAINT; Schema: public; Owner: redmine_user
--

ALTER TABLE ONLY public.auth_sources
    ADD CONSTRAINT auth_sources_pkey PRIMARY KEY (id);


--
-- Name: boards boards_pkey; Type: CONSTRAINT; Schema: public; Owner: redmine_user
--

ALTER TABLE ONLY public.boards
    ADD CONSTRAINT boards_pkey PRIMARY KEY (id);


--
-- Name: changes changes_pkey; Type: CONSTRAINT; Schema: public; Owner: redmine_user
--

ALTER TABLE ONLY public.changes
    ADD CONSTRAINT changes_pkey PRIMARY KEY (id);


--
-- Name: changesets changesets_pkey; Type: CONSTRAINT; Schema: public; Owner: redmine_user
--

ALTER TABLE ONLY public.changesets
    ADD CONSTRAINT changesets_pkey PRIMARY KEY (id);


--
-- Name: comments comments_pkey; Type: CONSTRAINT; Schema: public; Owner: redmine_user
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (id);


--
-- Name: custom_field_enumerations custom_field_enumerations_pkey; Type: CONSTRAINT; Schema: public; Owner: redmine_user
--

ALTER TABLE ONLY public.custom_field_enumerations
    ADD CONSTRAINT custom_field_enumerations_pkey PRIMARY KEY (id);


--
-- Name: custom_fields custom_fields_pkey; Type: CONSTRAINT; Schema: public; Owner: redmine_user
--

ALTER TABLE ONLY public.custom_fields
    ADD CONSTRAINT custom_fields_pkey PRIMARY KEY (id);


--
-- Name: custom_values custom_values_pkey; Type: CONSTRAINT; Schema: public; Owner: redmine_user
--

ALTER TABLE ONLY public.custom_values
    ADD CONSTRAINT custom_values_pkey PRIMARY KEY (id);


--
-- Name: documents documents_pkey; Type: CONSTRAINT; Schema: public; Owner: redmine_user
--

ALTER TABLE ONLY public.documents
    ADD CONSTRAINT documents_pkey PRIMARY KEY (id);


--
-- Name: email_addresses email_addresses_pkey; Type: CONSTRAINT; Schema: public; Owner: redmine_user
--

ALTER TABLE ONLY public.email_addresses
    ADD CONSTRAINT email_addresses_pkey PRIMARY KEY (id);


--
-- Name: enabled_modules enabled_modules_pkey; Type: CONSTRAINT; Schema: public; Owner: redmine_user
--

ALTER TABLE ONLY public.enabled_modules
    ADD CONSTRAINT enabled_modules_pkey PRIMARY KEY (id);


--
-- Name: enumerations enumerations_pkey; Type: CONSTRAINT; Schema: public; Owner: redmine_user
--

ALTER TABLE ONLY public.enumerations
    ADD CONSTRAINT enumerations_pkey PRIMARY KEY (id);


--
-- Name: import_items import_items_pkey; Type: CONSTRAINT; Schema: public; Owner: redmine_user
--

ALTER TABLE ONLY public.import_items
    ADD CONSTRAINT import_items_pkey PRIMARY KEY (id);


--
-- Name: imports imports_pkey; Type: CONSTRAINT; Schema: public; Owner: redmine_user
--

ALTER TABLE ONLY public.imports
    ADD CONSTRAINT imports_pkey PRIMARY KEY (id);


--
-- Name: issue_categories issue_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: redmine_user
--

ALTER TABLE ONLY public.issue_categories
    ADD CONSTRAINT issue_categories_pkey PRIMARY KEY (id);


--
-- Name: issue_relations issue_relations_pkey; Type: CONSTRAINT; Schema: public; Owner: redmine_user
--

ALTER TABLE ONLY public.issue_relations
    ADD CONSTRAINT issue_relations_pkey PRIMARY KEY (id);


--
-- Name: issue_statuses issue_statuses_pkey; Type: CONSTRAINT; Schema: public; Owner: redmine_user
--

ALTER TABLE ONLY public.issue_statuses
    ADD CONSTRAINT issue_statuses_pkey PRIMARY KEY (id);


--
-- Name: issues issues_pkey; Type: CONSTRAINT; Schema: public; Owner: redmine_user
--

ALTER TABLE ONLY public.issues
    ADD CONSTRAINT issues_pkey PRIMARY KEY (id);


--
-- Name: journal_details journal_details_pkey; Type: CONSTRAINT; Schema: public; Owner: redmine_user
--

ALTER TABLE ONLY public.journal_details
    ADD CONSTRAINT journal_details_pkey PRIMARY KEY (id);


--
-- Name: journals journals_pkey; Type: CONSTRAINT; Schema: public; Owner: redmine_user
--

ALTER TABLE ONLY public.journals
    ADD CONSTRAINT journals_pkey PRIMARY KEY (id);


--
-- Name: member_roles member_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: redmine_user
--

ALTER TABLE ONLY public.member_roles
    ADD CONSTRAINT member_roles_pkey PRIMARY KEY (id);


--
-- Name: members members_pkey; Type: CONSTRAINT; Schema: public; Owner: redmine_user
--

ALTER TABLE ONLY public.members
    ADD CONSTRAINT members_pkey PRIMARY KEY (id);


--
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: public; Owner: redmine_user
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id);


--
-- Name: news news_pkey; Type: CONSTRAINT; Schema: public; Owner: redmine_user
--

ALTER TABLE ONLY public.news
    ADD CONSTRAINT news_pkey PRIMARY KEY (id);


--
-- Name: open_id_authentication_associations open_id_authentication_associations_pkey; Type: CONSTRAINT; Schema: public; Owner: redmine_user
--

ALTER TABLE ONLY public.open_id_authentication_associations
    ADD CONSTRAINT open_id_authentication_associations_pkey PRIMARY KEY (id);


--
-- Name: open_id_authentication_nonces open_id_authentication_nonces_pkey; Type: CONSTRAINT; Schema: public; Owner: redmine_user
--

ALTER TABLE ONLY public.open_id_authentication_nonces
    ADD CONSTRAINT open_id_authentication_nonces_pkey PRIMARY KEY (id);


--
-- Name: projects projects_pkey; Type: CONSTRAINT; Schema: public; Owner: redmine_user
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (id);


--
-- Name: queries queries_pkey; Type: CONSTRAINT; Schema: public; Owner: redmine_user
--

ALTER TABLE ONLY public.queries
    ADD CONSTRAINT queries_pkey PRIMARY KEY (id);


--
-- Name: repositories repositories_pkey; Type: CONSTRAINT; Schema: public; Owner: redmine_user
--

ALTER TABLE ONLY public.repositories
    ADD CONSTRAINT repositories_pkey PRIMARY KEY (id);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: redmine_user
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: redmine_user
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: settings settings_pkey; Type: CONSTRAINT; Schema: public; Owner: redmine_user
--

ALTER TABLE ONLY public.settings
    ADD CONSTRAINT settings_pkey PRIMARY KEY (id);


--
-- Name: time_entries time_entries_pkey; Type: CONSTRAINT; Schema: public; Owner: redmine_user
--

ALTER TABLE ONLY public.time_entries
    ADD CONSTRAINT time_entries_pkey PRIMARY KEY (id);


--
-- Name: tokens tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: redmine_user
--

ALTER TABLE ONLY public.tokens
    ADD CONSTRAINT tokens_pkey PRIMARY KEY (id);


--
-- Name: trackers trackers_pkey; Type: CONSTRAINT; Schema: public; Owner: redmine_user
--

ALTER TABLE ONLY public.trackers
    ADD CONSTRAINT trackers_pkey PRIMARY KEY (id);


--
-- Name: user_preferences user_preferences_pkey; Type: CONSTRAINT; Schema: public; Owner: redmine_user
--

ALTER TABLE ONLY public.user_preferences
    ADD CONSTRAINT user_preferences_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: redmine_user
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: versions versions_pkey; Type: CONSTRAINT; Schema: public; Owner: redmine_user
--

ALTER TABLE ONLY public.versions
    ADD CONSTRAINT versions_pkey PRIMARY KEY (id);


--
-- Name: watchers watchers_pkey; Type: CONSTRAINT; Schema: public; Owner: redmine_user
--

ALTER TABLE ONLY public.watchers
    ADD CONSTRAINT watchers_pkey PRIMARY KEY (id);


--
-- Name: wiki_content_versions wiki_content_versions_pkey; Type: CONSTRAINT; Schema: public; Owner: redmine_user
--

ALTER TABLE ONLY public.wiki_content_versions
    ADD CONSTRAINT wiki_content_versions_pkey PRIMARY KEY (id);


--
-- Name: wiki_contents wiki_contents_pkey; Type: CONSTRAINT; Schema: public; Owner: redmine_user
--

ALTER TABLE ONLY public.wiki_contents
    ADD CONSTRAINT wiki_contents_pkey PRIMARY KEY (id);


--
-- Name: wiki_pages wiki_pages_pkey; Type: CONSTRAINT; Schema: public; Owner: redmine_user
--

ALTER TABLE ONLY public.wiki_pages
    ADD CONSTRAINT wiki_pages_pkey PRIMARY KEY (id);


--
-- Name: wiki_redirects wiki_redirects_pkey; Type: CONSTRAINT; Schema: public; Owner: redmine_user
--

ALTER TABLE ONLY public.wiki_redirects
    ADD CONSTRAINT wiki_redirects_pkey PRIMARY KEY (id);


--
-- Name: wikis wikis_pkey; Type: CONSTRAINT; Schema: public; Owner: redmine_user
--

ALTER TABLE ONLY public.wikis
    ADD CONSTRAINT wikis_pkey PRIMARY KEY (id);


--
-- Name: workflows workflows_pkey; Type: CONSTRAINT; Schema: public; Owner: redmine_user
--

ALTER TABLE ONLY public.workflows
    ADD CONSTRAINT workflows_pkey PRIMARY KEY (id);


--
-- Name: boards_project_id; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE INDEX boards_project_id ON public.boards USING btree (project_id);


--
-- Name: changeset_parents_changeset_ids; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE INDEX changeset_parents_changeset_ids ON public.changeset_parents USING btree (changeset_id);


--
-- Name: changeset_parents_parent_ids; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE INDEX changeset_parents_parent_ids ON public.changeset_parents USING btree (parent_id);


--
-- Name: changesets_changeset_id; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE INDEX changesets_changeset_id ON public.changes USING btree (changeset_id);


--
-- Name: changesets_issues_ids; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE UNIQUE INDEX changesets_issues_ids ON public.changesets_issues USING btree (changeset_id, issue_id);


--
-- Name: changesets_repos_rev; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE UNIQUE INDEX changesets_repos_rev ON public.changesets USING btree (repository_id, revision);


--
-- Name: changesets_repos_scmid; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE INDEX changesets_repos_scmid ON public.changesets USING btree (repository_id, scmid);


--
-- Name: custom_fields_roles_ids; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE UNIQUE INDEX custom_fields_roles_ids ON public.custom_fields_roles USING btree (custom_field_id, role_id);


--
-- Name: custom_values_customized; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE INDEX custom_values_customized ON public.custom_values USING btree (customized_type, customized_id);


--
-- Name: documents_project_id; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE INDEX documents_project_id ON public.documents USING btree (project_id);


--
-- Name: enabled_modules_project_id; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE INDEX enabled_modules_project_id ON public.enabled_modules USING btree (project_id);


--
-- Name: groups_users_ids; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE UNIQUE INDEX groups_users_ids ON public.groups_users USING btree (group_id, user_id);


--
-- Name: index_attachments_on_author_id; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE INDEX index_attachments_on_author_id ON public.attachments USING btree (author_id);


--
-- Name: index_attachments_on_container_id_and_container_type; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE INDEX index_attachments_on_container_id_and_container_type ON public.attachments USING btree (container_id, container_type);


--
-- Name: index_attachments_on_created_on; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE INDEX index_attachments_on_created_on ON public.attachments USING btree (created_on);


--
-- Name: index_attachments_on_disk_filename; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE INDEX index_attachments_on_disk_filename ON public.attachments USING btree (disk_filename);


--
-- Name: index_auth_sources_on_id_and_type; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE INDEX index_auth_sources_on_id_and_type ON public.auth_sources USING btree (id, type);


--
-- Name: index_boards_on_last_message_id; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE INDEX index_boards_on_last_message_id ON public.boards USING btree (last_message_id);


--
-- Name: index_changesets_issues_on_issue_id; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE INDEX index_changesets_issues_on_issue_id ON public.changesets_issues USING btree (issue_id);


--
-- Name: index_changesets_on_committed_on; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE INDEX index_changesets_on_committed_on ON public.changesets USING btree (committed_on);


--
-- Name: index_changesets_on_repository_id; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE INDEX index_changesets_on_repository_id ON public.changesets USING btree (repository_id);


--
-- Name: index_changesets_on_user_id; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE INDEX index_changesets_on_user_id ON public.changesets USING btree (user_id);


--
-- Name: index_comments_on_author_id; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE INDEX index_comments_on_author_id ON public.comments USING btree (author_id);


--
-- Name: index_comments_on_commented_id_and_commented_type; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE INDEX index_comments_on_commented_id_and_commented_type ON public.comments USING btree (commented_id, commented_type);


--
-- Name: index_custom_fields_on_id_and_type; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE INDEX index_custom_fields_on_id_and_type ON public.custom_fields USING btree (id, type);


--
-- Name: index_custom_fields_projects_on_custom_field_id_and_project_id; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE UNIQUE INDEX index_custom_fields_projects_on_custom_field_id_and_project_id ON public.custom_fields_projects USING btree (custom_field_id, project_id);


--
-- Name: index_custom_fields_trackers_on_custom_field_id_and_tracker_id; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE UNIQUE INDEX index_custom_fields_trackers_on_custom_field_id_and_tracker_id ON public.custom_fields_trackers USING btree (custom_field_id, tracker_id);


--
-- Name: index_custom_values_on_custom_field_id; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE INDEX index_custom_values_on_custom_field_id ON public.custom_values USING btree (custom_field_id);


--
-- Name: index_documents_on_category_id; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE INDEX index_documents_on_category_id ON public.documents USING btree (category_id);


--
-- Name: index_documents_on_created_on; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE INDEX index_documents_on_created_on ON public.documents USING btree (created_on);


--
-- Name: index_email_addresses_on_user_id; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE INDEX index_email_addresses_on_user_id ON public.email_addresses USING btree (user_id);


--
-- Name: index_enumerations_on_id_and_type; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE INDEX index_enumerations_on_id_and_type ON public.enumerations USING btree (id, type);


--
-- Name: index_enumerations_on_project_id; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE INDEX index_enumerations_on_project_id ON public.enumerations USING btree (project_id);


--
-- Name: index_import_items_on_import_id_and_unique_id; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE INDEX index_import_items_on_import_id_and_unique_id ON public.import_items USING btree (import_id, unique_id);


--
-- Name: index_issue_categories_on_assigned_to_id; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE INDEX index_issue_categories_on_assigned_to_id ON public.issue_categories USING btree (assigned_to_id);


--
-- Name: index_issue_relations_on_issue_from_id; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE INDEX index_issue_relations_on_issue_from_id ON public.issue_relations USING btree (issue_from_id);


--
-- Name: index_issue_relations_on_issue_from_id_and_issue_to_id; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE UNIQUE INDEX index_issue_relations_on_issue_from_id_and_issue_to_id ON public.issue_relations USING btree (issue_from_id, issue_to_id);


--
-- Name: index_issue_relations_on_issue_to_id; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE INDEX index_issue_relations_on_issue_to_id ON public.issue_relations USING btree (issue_to_id);


--
-- Name: index_issue_statuses_on_is_closed; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE INDEX index_issue_statuses_on_is_closed ON public.issue_statuses USING btree (is_closed);


--
-- Name: index_issue_statuses_on_position; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE INDEX index_issue_statuses_on_position ON public.issue_statuses USING btree ("position");


--
-- Name: index_issues_on_assigned_to_id; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE INDEX index_issues_on_assigned_to_id ON public.issues USING btree (assigned_to_id);


--
-- Name: index_issues_on_author_id; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE INDEX index_issues_on_author_id ON public.issues USING btree (author_id);


--
-- Name: index_issues_on_category_id; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE INDEX index_issues_on_category_id ON public.issues USING btree (category_id);


--
-- Name: index_issues_on_created_on; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE INDEX index_issues_on_created_on ON public.issues USING btree (created_on);


--
-- Name: index_issues_on_fixed_version_id; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE INDEX index_issues_on_fixed_version_id ON public.issues USING btree (fixed_version_id);


--
-- Name: index_issues_on_parent_id; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE INDEX index_issues_on_parent_id ON public.issues USING btree (parent_id);


--
-- Name: index_issues_on_priority_id; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE INDEX index_issues_on_priority_id ON public.issues USING btree (priority_id);


--
-- Name: index_issues_on_root_id_and_lft_and_rgt; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE INDEX index_issues_on_root_id_and_lft_and_rgt ON public.issues USING btree (root_id, lft, rgt);


--
-- Name: index_issues_on_status_id; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE INDEX index_issues_on_status_id ON public.issues USING btree (status_id);


--
-- Name: index_issues_on_tracker_id; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE INDEX index_issues_on_tracker_id ON public.issues USING btree (tracker_id);


--
-- Name: index_journals_on_created_on; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE INDEX index_journals_on_created_on ON public.journals USING btree (created_on);


--
-- Name: index_journals_on_journalized_id; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE INDEX index_journals_on_journalized_id ON public.journals USING btree (journalized_id);


--
-- Name: index_journals_on_user_id; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE INDEX index_journals_on_user_id ON public.journals USING btree (user_id);


--
-- Name: index_member_roles_on_inherited_from; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE INDEX index_member_roles_on_inherited_from ON public.member_roles USING btree (inherited_from);


--
-- Name: index_member_roles_on_member_id; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE INDEX index_member_roles_on_member_id ON public.member_roles USING btree (member_id);


--
-- Name: index_member_roles_on_role_id; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE INDEX index_member_roles_on_role_id ON public.member_roles USING btree (role_id);


--
-- Name: index_members_on_project_id; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE INDEX index_members_on_project_id ON public.members USING btree (project_id);


--
-- Name: index_members_on_user_id; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE INDEX index_members_on_user_id ON public.members USING btree (user_id);


--
-- Name: index_members_on_user_id_and_project_id; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE UNIQUE INDEX index_members_on_user_id_and_project_id ON public.members USING btree (user_id, project_id);


--
-- Name: index_messages_on_author_id; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE INDEX index_messages_on_author_id ON public.messages USING btree (author_id);


--
-- Name: index_messages_on_created_on; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE INDEX index_messages_on_created_on ON public.messages USING btree (created_on);


--
-- Name: index_messages_on_last_reply_id; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE INDEX index_messages_on_last_reply_id ON public.messages USING btree (last_reply_id);


--
-- Name: index_news_on_author_id; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE INDEX index_news_on_author_id ON public.news USING btree (author_id);


--
-- Name: index_news_on_created_on; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE INDEX index_news_on_created_on ON public.news USING btree (created_on);


--
-- Name: index_projects_on_lft; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE INDEX index_projects_on_lft ON public.projects USING btree (lft);


--
-- Name: index_projects_on_rgt; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE INDEX index_projects_on_rgt ON public.projects USING btree (rgt);


--
-- Name: index_queries_on_project_id; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE INDEX index_queries_on_project_id ON public.queries USING btree (project_id);


--
-- Name: index_queries_on_user_id; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE INDEX index_queries_on_user_id ON public.queries USING btree (user_id);


--
-- Name: index_repositories_on_project_id; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE INDEX index_repositories_on_project_id ON public.repositories USING btree (project_id);


--
-- Name: index_roles_managed_roles_on_role_id_and_managed_role_id; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE UNIQUE INDEX index_roles_managed_roles_on_role_id_and_managed_role_id ON public.roles_managed_roles USING btree (role_id, managed_role_id);


--
-- Name: index_settings_on_name; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE INDEX index_settings_on_name ON public.settings USING btree (name);


--
-- Name: index_time_entries_on_activity_id; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE INDEX index_time_entries_on_activity_id ON public.time_entries USING btree (activity_id);


--
-- Name: index_time_entries_on_created_on; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE INDEX index_time_entries_on_created_on ON public.time_entries USING btree (created_on);


--
-- Name: index_time_entries_on_user_id; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE INDEX index_time_entries_on_user_id ON public.time_entries USING btree (user_id);


--
-- Name: index_tokens_on_user_id; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE INDEX index_tokens_on_user_id ON public.tokens USING btree (user_id);


--
-- Name: index_user_preferences_on_user_id; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE INDEX index_user_preferences_on_user_id ON public.user_preferences USING btree (user_id);


--
-- Name: index_users_on_auth_source_id; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE INDEX index_users_on_auth_source_id ON public.users USING btree (auth_source_id);


--
-- Name: index_users_on_id_and_type; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE INDEX index_users_on_id_and_type ON public.users USING btree (id, type);


--
-- Name: index_users_on_type; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE INDEX index_users_on_type ON public.users USING btree (type);


--
-- Name: index_versions_on_sharing; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE INDEX index_versions_on_sharing ON public.versions USING btree (sharing);


--
-- Name: index_watchers_on_user_id; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE INDEX index_watchers_on_user_id ON public.watchers USING btree (user_id);


--
-- Name: index_watchers_on_watchable_id_and_watchable_type; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE INDEX index_watchers_on_watchable_id_and_watchable_type ON public.watchers USING btree (watchable_id, watchable_type);


--
-- Name: index_wiki_content_versions_on_updated_on; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE INDEX index_wiki_content_versions_on_updated_on ON public.wiki_content_versions USING btree (updated_on);


--
-- Name: index_wiki_contents_on_author_id; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE INDEX index_wiki_contents_on_author_id ON public.wiki_contents USING btree (author_id);


--
-- Name: index_wiki_pages_on_parent_id; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE INDEX index_wiki_pages_on_parent_id ON public.wiki_pages USING btree (parent_id);


--
-- Name: index_wiki_pages_on_wiki_id; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE INDEX index_wiki_pages_on_wiki_id ON public.wiki_pages USING btree (wiki_id);


--
-- Name: index_wiki_redirects_on_wiki_id; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE INDEX index_wiki_redirects_on_wiki_id ON public.wiki_redirects USING btree (wiki_id);


--
-- Name: index_workflows_on_new_status_id; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE INDEX index_workflows_on_new_status_id ON public.workflows USING btree (new_status_id);


--
-- Name: index_workflows_on_old_status_id; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE INDEX index_workflows_on_old_status_id ON public.workflows USING btree (old_status_id);


--
-- Name: index_workflows_on_role_id; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE INDEX index_workflows_on_role_id ON public.workflows USING btree (role_id);


--
-- Name: index_workflows_on_tracker_id; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE INDEX index_workflows_on_tracker_id ON public.workflows USING btree (tracker_id);


--
-- Name: issue_categories_project_id; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE INDEX issue_categories_project_id ON public.issue_categories USING btree (project_id);


--
-- Name: issues_project_id; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE INDEX issues_project_id ON public.issues USING btree (project_id);


--
-- Name: journal_details_journal_id; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE INDEX journal_details_journal_id ON public.journal_details USING btree (journal_id);


--
-- Name: journals_journalized_id; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE INDEX journals_journalized_id ON public.journals USING btree (journalized_id, journalized_type);


--
-- Name: messages_board_id; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE INDEX messages_board_id ON public.messages USING btree (board_id);


--
-- Name: messages_parent_id; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE INDEX messages_parent_id ON public.messages USING btree (parent_id);


--
-- Name: news_project_id; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE INDEX news_project_id ON public.news USING btree (project_id);


--
-- Name: projects_trackers_project_id; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE INDEX projects_trackers_project_id ON public.projects_trackers USING btree (project_id);


--
-- Name: projects_trackers_unique; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE UNIQUE INDEX projects_trackers_unique ON public.projects_trackers USING btree (project_id, tracker_id);


--
-- Name: queries_roles_ids; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE UNIQUE INDEX queries_roles_ids ON public.queries_roles USING btree (query_id, role_id);


--
-- Name: time_entries_issue_id; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE INDEX time_entries_issue_id ON public.time_entries USING btree (issue_id);


--
-- Name: time_entries_project_id; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE INDEX time_entries_project_id ON public.time_entries USING btree (project_id);


--
-- Name: tokens_value; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE UNIQUE INDEX tokens_value ON public.tokens USING btree (value);


--
-- Name: versions_project_id; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE INDEX versions_project_id ON public.versions USING btree (project_id);


--
-- Name: watchers_user_id_type; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE INDEX watchers_user_id_type ON public.watchers USING btree (user_id, watchable_type);


--
-- Name: wiki_content_versions_wcid; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE INDEX wiki_content_versions_wcid ON public.wiki_content_versions USING btree (wiki_content_id);


--
-- Name: wiki_contents_page_id; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE INDEX wiki_contents_page_id ON public.wiki_contents USING btree (page_id);


--
-- Name: wiki_pages_wiki_id_title; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE INDEX wiki_pages_wiki_id_title ON public.wiki_pages USING btree (wiki_id, title);


--
-- Name: wiki_redirects_wiki_id_title; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE INDEX wiki_redirects_wiki_id_title ON public.wiki_redirects USING btree (wiki_id, title);


--
-- Name: wikis_project_id; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE INDEX wikis_project_id ON public.wikis USING btree (project_id);


--
-- Name: wkfs_role_tracker_old_status; Type: INDEX; Schema: public; Owner: redmine_user
--

CREATE INDEX wkfs_role_tracker_old_status ON public.workflows USING btree (role_id, tracker_id, old_status_id);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: redmine_user
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

