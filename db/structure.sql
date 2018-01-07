--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.6
-- Dumped by pg_dump version 9.6.3

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE users (
    id integer NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip inet,
    last_sign_in_ip inet,
    confirmation_token character varying,
    confirmed_at timestamp without time zone,
    confirmation_sent_at timestamp without time zone,
    unconfirmed_email character varying,
    failed_attempts integer DEFAULT 0 NOT NULL,
    unlock_token character varying,
    locked_at timestamp without time zone
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: video_categories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE video_categories (
    id bigint NOT NULL,
    uq_category_name character varying(255),
    delete_flag integer DEFAULT 0 NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: video_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE video_categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: video_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE video_categories_id_seq OWNED BY video_categories.id;


--
-- Name: video_groups; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE video_groups (
    id bigint NOT NULL,
    uq_group_name character varying(255) NOT NULL,
    fk_category_id bigint,
    delete_flag integer DEFAULT 0 NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    uq_group_perm character varying(255) NOT NULL
);


--
-- Name: video_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE video_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: video_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE video_groups_id_seq OWNED BY video_groups.id;


--
-- Name: videos; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE videos (
    id bigint NOT NULL,
    video_time time without time zone NOT NULL,
    uq_video_name character varying(255),
    fk_groups_id bigint NOT NULL,
    delete_flag integer DEFAULT 0 NOT NULL,
    num_play bigint DEFAULT 0 NOT NULL,
    video_file_name character varying(255),
    description character varying(255),
    procedure character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    uq_video_perm character varying(255) NOT NULL
);


--
-- Name: videos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE videos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: videos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE videos_id_seq OWNED BY videos.id;


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: video_categories id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY video_categories ALTER COLUMN id SET DEFAULT nextval('video_categories_id_seq'::regclass);


--
-- Name: video_groups id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY video_groups ALTER COLUMN id SET DEFAULT nextval('video_groups_id_seq'::regclass);


--
-- Name: videos id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY videos ALTER COLUMN id SET DEFAULT nextval('videos_id_seq'::regclass);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: video_categories video_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY video_categories
    ADD CONSTRAINT video_categories_pkey PRIMARY KEY (id);


--
-- Name: video_groups video_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY video_groups
    ADD CONSTRAINT video_groups_pkey PRIMARY KEY (id);


--
-- Name: videos videos_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY videos
    ADD CONSTRAINT videos_pkey PRIMARY KEY (id);


--
-- Name: index_users_on_confirmation_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_confirmation_token ON users USING btree (confirmation_token);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
-- Name: index_users_on_unlock_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_unlock_token ON users USING btree (unlock_token);


--
-- Name: index_video_categories_on_uq_category_name; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_video_categories_on_uq_category_name ON video_categories USING btree (uq_category_name);


--
-- Name: index_video_groups_on_uq_group_name; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_video_groups_on_uq_group_name ON video_groups USING btree (uq_group_name);


--
-- Name: index_video_groups_on_uq_group_perm; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_video_groups_on_uq_group_perm ON video_groups USING btree (uq_group_perm);


--
-- Name: index_videos_on_description; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_videos_on_description ON videos USING btree (description);


--
-- Name: index_videos_on_procedure; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_videos_on_procedure ON videos USING btree (procedure);


--
-- Name: index_videos_on_uq_video_name; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_videos_on_uq_video_name ON videos USING btree (uq_video_name);


--
-- Name: index_videos_on_uq_video_perm; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_videos_on_uq_video_perm ON videos USING btree (uq_video_perm);


--
-- Name: index_videos_on_video_file_name; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_videos_on_video_file_name ON videos USING btree (video_file_name);


--
-- Name: video_groups fk_rails_042ee9573d; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY video_groups
    ADD CONSTRAINT fk_rails_042ee9573d FOREIGN KEY (fk_category_id) REFERENCES video_categories(id);


--
-- Name: videos fk_rails_10e4da9393; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY videos
    ADD CONSTRAINT fk_rails_10e4da9393 FOREIGN KEY (fk_groups_id) REFERENCES video_groups(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20170713120118'),
('20170713120305'),
('20170723080736'),
('20170923071025'),
('20171129121425'),
('20171129124044'),
('20180107032456');


