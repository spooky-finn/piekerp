--
-- PostgreSQL database dump
--

-- Dumped from database version 12.7 (Debian 12.7-1.pgdg100+1)
-- Dumped by pg_dump version 12.7 (Debian 12.7-1.pgdg100+1)

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
-- Name: attendance; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA attendance;


ALTER SCHEMA attendance OWNER TO postgres;

--
-- Name: erp; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA erp;


ALTER SCHEMA erp OWNER TO postgres;

--
-- Name: hdb_catalog; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA hdb_catalog;


ALTER SCHEMA hdb_catalog OWNER TO postgres;

--
-- Name: traderBot; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA "traderBot";


ALTER SCHEMA "traderBot" OWNER TO postgres;

--
-- Name: gen_hasura_uuid(); Type: FUNCTION; Schema: hdb_catalog; Owner: postgres
--

CREATE FUNCTION hdb_catalog.gen_hasura_uuid() RETURNS uuid
    LANGUAGE sql
    AS $$select gen_random_uuid()$$;


ALTER FUNCTION hdb_catalog.gen_hasura_uuid() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: intervals; Type: TABLE; Schema: attendance; Owner: postgres
--

CREATE TABLE attendance.intervals (
    id integer NOT NULL,
    ent timestamp without time zone,
    ext timestamp without time zone,
    card character varying NOT NULL,
    database character varying DEFAULT 'factory'::character varying
);


ALTER TABLE attendance.intervals OWNER TO postgres;

--
-- Name: Intervals_ID_seq; Type: SEQUENCE; Schema: attendance; Owner: postgres
--

CREATE SEQUENCE attendance."Intervals_ID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE attendance."Intervals_ID_seq" OWNER TO postgres;

--
-- Name: Intervals_ID_seq; Type: SEQUENCE OWNED BY; Schema: attendance; Owner: postgres
--

ALTER SEQUENCE attendance."Intervals_ID_seq" OWNED BY attendance.intervals.id;


--
-- Name: config; Type: TABLE; Schema: attendance; Owner: postgres
--

CREATE TABLE attendance.config (
    "ID" integer NOT NULL,
    "TimeDeduction" numeric NOT NULL
);


ALTER TABLE attendance.config OWNER TO postgres;

--
-- Name: config_ID_seq; Type: SEQUENCE; Schema: attendance; Owner: postgres
--

CREATE SEQUENCE attendance."config_ID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE attendance."config_ID_seq" OWNER TO postgres;

--
-- Name: config_ID_seq; Type: SEQUENCE OWNED BY; Schema: attendance; Owner: postgres
--

ALTER SEQUENCE attendance."config_ID_seq" OWNED BY attendance.config."ID";


--
-- Name: users; Type: TABLE; Schema: attendance; Owner: postgres
--

CREATE TABLE attendance.users (
    id integer NOT NULL,
    firstname text,
    lastname text,
    card character varying
);


ALTER TABLE attendance.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: attendance; Owner: postgres
--

CREATE SEQUENCE attendance.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE attendance.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: attendance; Owner: postgres
--

ALTER SEQUENCE attendance.users_id_seq OWNED BY attendance.users.id;


--
-- Name: AccessLevels; Type: TABLE; Schema: erp; Owner: postgres
--

CREATE TABLE erp."AccessLevels" (
    "AccessLevelID" integer NOT NULL,
    "Name" character varying(100) NOT NULL
);


ALTER TABLE erp."AccessLevels" OWNER TO postgres;

--
-- Name: AccessLevels_AccessLevelID_seq; Type: SEQUENCE; Schema: erp; Owner: postgres
--

CREATE SEQUENCE erp."AccessLevels_AccessLevelID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE erp."AccessLevels_AccessLevelID_seq" OWNER TO postgres;

--
-- Name: AccessLevels_AccessLevelID_seq; Type: SEQUENCE OWNED BY; Schema: erp; Owner: postgres
--

ALTER SEQUENCE erp."AccessLevels_AccessLevelID_seq" OWNED BY erp."AccessLevels"."AccessLevelID";


--
-- Name: CheckListTPLs; Type: TABLE; Schema: erp; Owner: postgres
--

CREATE TABLE erp."CheckListTPLs" (
    "CheckListTPLID" integer NOT NULL,
    "Title" character varying(255) NOT NULL
);


ALTER TABLE erp."CheckListTPLs" OWNER TO postgres;

--
-- Name: CheckListTPLs_CheckListTPLID_seq; Type: SEQUENCE; Schema: erp; Owner: postgres
--

CREATE SEQUENCE erp."CheckListTPLs_CheckListTPLID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE erp."CheckListTPLs_CheckListTPLID_seq" OWNER TO postgres;

--
-- Name: CheckListTPLs_CheckListTPLID_seq; Type: SEQUENCE OWNED BY; Schema: erp; Owner: postgres
--

ALTER SEQUENCE erp."CheckListTPLs_CheckListTPLID_seq" OWNED BY erp."CheckListTPLs"."CheckListTPLID";


--
-- Name: CheckListUnits; Type: TABLE; Schema: erp; Owner: postgres
--

CREATE TABLE erp."CheckListUnits" (
    "CheckListUnitID" integer NOT NULL,
    "OrderID" integer NOT NULL,
    "Point" character varying(255) NOT NULL,
    "IsComplited" boolean DEFAULT false NOT NULL
);


ALTER TABLE erp."CheckListUnits" OWNER TO postgres;

--
-- Name: CheckListUnits_CheckListUnitID_seq; Type: SEQUENCE; Schema: erp; Owner: postgres
--

CREATE SEQUENCE erp."CheckListUnits_CheckListUnitID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE erp."CheckListUnits_CheckListUnitID_seq" OWNER TO postgres;

--
-- Name: CheckListUnits_CheckListUnitID_seq; Type: SEQUENCE OWNED BY; Schema: erp; Owner: postgres
--

ALTER SEQUENCE erp."CheckListUnits_CheckListUnitID_seq" OWNED BY erp."CheckListUnits"."CheckListUnitID";


--
-- Name: Comments; Type: TABLE; Schema: erp; Owner: postgres
--

CREATE TABLE erp."Comments" (
    "CommentID" integer NOT NULL,
    "OrderID" integer NOT NULL,
    "UserID" integer NOT NULL,
    "Timestamp" timestamp with time zone DEFAULT now() NOT NULL,
    "Text" text NOT NULL
);


ALTER TABLE erp."Comments" OWNER TO postgres;

--
-- Name: Comments_CommentID_seq; Type: SEQUENCE; Schema: erp; Owner: postgres
--

CREATE SEQUENCE erp."Comments_CommentID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE erp."Comments_CommentID_seq" OWNER TO postgres;

--
-- Name: Comments_CommentID_seq; Type: SEQUENCE OWNED BY; Schema: erp; Owner: postgres
--

ALTER SEQUENCE erp."Comments_CommentID_seq" OWNED BY erp."Comments"."CommentID";


--
-- Name: Docs; Type: TABLE; Schema: erp; Owner: postgres
--

CREATE TABLE erp."Docs" (
    "OrderID" integer NOT NULL,
    "Key" text NOT NULL,
    "FileName" text,
    "ID" integer NOT NULL,
    "Mimetype" character varying,
    "Size" integer
);


ALTER TABLE erp."Docs" OWNER TO postgres;

--
-- Name: Docs_ID_seq; Type: SEQUENCE; Schema: erp; Owner: postgres
--

CREATE SEQUENCE erp."Docs_ID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE erp."Docs_ID_seq" OWNER TO postgres;

--
-- Name: Docs_ID_seq; Type: SEQUENCE OWNED BY; Schema: erp; Owner: postgres
--

ALTER SEQUENCE erp."Docs_ID_seq" OWNED BY erp."Docs"."ID";


--
-- Name: Notifications; Type: TABLE; Schema: erp; Owner: postgres
--

CREATE TABLE erp."Notifications" (
    "ID" integer NOT NULL,
    "OrderID" integer,
    "CommentID" integer NOT NULL,
    "MentionedUser" integer,
    "Viewed" boolean DEFAULT false NOT NULL
);


ALTER TABLE erp."Notifications" OWNER TO postgres;

--
-- Name: Notifications_ID_seq; Type: SEQUENCE; Schema: erp; Owner: postgres
--

CREATE SEQUENCE erp."Notifications_ID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE erp."Notifications_ID_seq" OWNER TO postgres;

--
-- Name: Notifications_ID_seq; Type: SEQUENCE OWNED BY; Schema: erp; Owner: postgres
--

ALTER SEQUENCE erp."Notifications_ID_seq" OWNED BY erp."Notifications"."ID";


--
-- Name: OrderItems; Type: TABLE; Schema: erp; Owner: postgres
--

CREATE TABLE erp."OrderItems" (
    "OrderItemID" integer NOT NULL,
    "OrderID" integer NOT NULL,
    "Name" character varying(255) NOT NULL,
    "Quantity" integer NOT NULL,
    "Fitter" character varying(255),
    "FullName" text,
    "SerialStarts" character varying,
    "SerialEnds" character varying
);


ALTER TABLE erp."OrderItems" OWNER TO postgres;

--
-- Name: OrderItems_OrderItemID_seq; Type: SEQUENCE; Schema: erp; Owner: postgres
--

CREATE SEQUENCE erp."OrderItems_OrderItemID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE erp."OrderItems_OrderItemID_seq" OWNER TO postgres;

--
-- Name: OrderItems_OrderItemID_seq; Type: SEQUENCE OWNED BY; Schema: erp; Owner: postgres
--

ALTER SEQUENCE erp."OrderItems_OrderItemID_seq" OWNED BY erp."OrderItems"."OrderItemID";


--
-- Name: OrderStatus; Type: TABLE; Schema: erp; Owner: postgres
--

CREATE TABLE erp."OrderStatus" (
    "ID" integer NOT NULL,
    "Name" character varying(255) NOT NULL
);


ALTER TABLE erp."OrderStatus" OWNER TO postgres;

--
-- Name: OrderStatus_OrderStatusID_seq; Type: SEQUENCE; Schema: erp; Owner: postgres
--

CREATE SEQUENCE erp."OrderStatus_OrderStatusID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE erp."OrderStatus_OrderStatusID_seq" OWNER TO postgres;

--
-- Name: OrderStatus_OrderStatusID_seq; Type: SEQUENCE OWNED BY; Schema: erp; Owner: postgres
--

ALTER SEQUENCE erp."OrderStatus_OrderStatusID_seq" OWNED BY erp."OrderStatus"."ID";


--
-- Name: Orders; Type: TABLE; Schema: erp; Owner: postgres
--

CREATE TABLE erp."Orders" (
    "OrderID" integer NOT NULL,
    "OrderStatusID" integer NOT NULL,
    "CheckListTPLID" integer,
    "ManagerID" integer,
    "CreatingDate" timestamp with time zone DEFAULT now() NOT NULL,
    "Entity" character varying(255),
    "City" character varying(255),
    "TotalAmount" numeric,
    "PaidAmount" numeric,
    "Comment" text,
    "InvoiceNumber" character varying,
    "ShippingDate" date,
    "AwaitingDispatch" boolean DEFAULT false NOT NULL,
    "AcceptanceDate" timestamp with time zone,
    "ActualShippingDate" timestamp with time zone,
    "OrderNumber" character varying,
    "IsReclamation" boolean DEFAULT false,
    "NeedAttention" text
);


ALTER TABLE erp."Orders" OWNER TO postgres;

--
-- Name: Orders_OrderID_seq; Type: SEQUENCE; Schema: erp; Owner: postgres
--

CREATE SEQUENCE erp."Orders_OrderID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE erp."Orders_OrderID_seq" OWNER TO postgres;

--
-- Name: Orders_OrderID_seq; Type: SEQUENCE OWNED BY; Schema: erp; Owner: postgres
--

ALTER SEQUENCE erp."Orders_OrderID_seq" OWNED BY erp."Orders"."OrderID";


--
-- Name: PaymentHistory; Type: TABLE; Schema: erp; Owner: postgres
--

CREATE TABLE erp."PaymentHistory" (
    "OrderID" integer NOT NULL,
    "Date" timestamp with time zone NOT NULL,
    "PaidAmount" numeric NOT NULL,
    "ID" integer NOT NULL
);


ALTER TABLE erp."PaymentHistory" OWNER TO postgres;

--
-- Name: PaymentHistory_id_seq; Type: SEQUENCE; Schema: erp; Owner: postgres
--

CREATE SEQUENCE erp."PaymentHistory_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE erp."PaymentHistory_id_seq" OWNER TO postgres;

--
-- Name: PaymentHistory_id_seq; Type: SEQUENCE OWNED BY; Schema: erp; Owner: postgres
--

ALTER SEQUENCE erp."PaymentHistory_id_seq" OWNED BY erp."PaymentHistory"."ID";


--
-- Name: Tokens; Type: TABLE; Schema: erp; Owner: postgres
--

CREATE TABLE erp."Tokens" (
    "ID" integer NOT NULL,
    "RefreshToken" text NOT NULL,
    "UserID" integer NOT NULL
);


ALTER TABLE erp."Tokens" OWNER TO postgres;

--
-- Name: Tokrns_ID_seq; Type: SEQUENCE; Schema: erp; Owner: postgres
--

CREATE SEQUENCE erp."Tokrns_ID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE erp."Tokrns_ID_seq" OWNER TO postgres;

--
-- Name: Tokrns_ID_seq; Type: SEQUENCE OWNED BY; Schema: erp; Owner: postgres
--

ALTER SEQUENCE erp."Tokrns_ID_seq" OWNED BY erp."Tokens"."ID";


--
-- Name: Users; Type: TABLE; Schema: erp; Owner: postgres
--

CREATE TABLE erp."Users" (
    "UserID" integer NOT NULL,
    "FirstName" character varying(100),
    "LastName" character varying(100),
    "Password" character varying(100),
    "AccessLevelID" integer,
    "Email" character varying(100)
);


ALTER TABLE erp."Users" OWNER TO postgres;

--
-- Name: Users_UserID_seq; Type: SEQUENCE; Schema: erp; Owner: postgres
--

CREATE SEQUENCE erp."Users_UserID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE erp."Users_UserID_seq" OWNER TO postgres;

--
-- Name: Users_UserID_seq; Type: SEQUENCE OWNED BY; Schema: erp; Owner: postgres
--

ALTER SEQUENCE erp."Users_UserID_seq" OWNED BY erp."Users"."UserID";


--
-- Name: hdb_action_log; Type: TABLE; Schema: hdb_catalog; Owner: postgres
--

CREATE TABLE hdb_catalog.hdb_action_log (
    id uuid DEFAULT hdb_catalog.gen_hasura_uuid() NOT NULL,
    action_name text,
    input_payload jsonb NOT NULL,
    request_headers jsonb NOT NULL,
    session_variables jsonb NOT NULL,
    response_payload jsonb,
    errors jsonb,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    response_received_at timestamp with time zone,
    status text NOT NULL,
    CONSTRAINT hdb_action_log_status_check CHECK ((status = ANY (ARRAY['created'::text, 'processing'::text, 'completed'::text, 'error'::text])))
);


ALTER TABLE hdb_catalog.hdb_action_log OWNER TO postgres;

--
-- Name: hdb_cron_event_invocation_logs; Type: TABLE; Schema: hdb_catalog; Owner: postgres
--

CREATE TABLE hdb_catalog.hdb_cron_event_invocation_logs (
    id text DEFAULT hdb_catalog.gen_hasura_uuid() NOT NULL,
    event_id text,
    status integer,
    request json,
    response json,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE hdb_catalog.hdb_cron_event_invocation_logs OWNER TO postgres;

--
-- Name: hdb_cron_events; Type: TABLE; Schema: hdb_catalog; Owner: postgres
--

CREATE TABLE hdb_catalog.hdb_cron_events (
    id text DEFAULT hdb_catalog.gen_hasura_uuid() NOT NULL,
    trigger_name text NOT NULL,
    scheduled_time timestamp with time zone NOT NULL,
    status text DEFAULT 'scheduled'::text NOT NULL,
    tries integer DEFAULT 0 NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    next_retry_at timestamp with time zone,
    CONSTRAINT valid_status CHECK ((status = ANY (ARRAY['scheduled'::text, 'locked'::text, 'delivered'::text, 'error'::text, 'dead'::text])))
);


ALTER TABLE hdb_catalog.hdb_cron_events OWNER TO postgres;

--
-- Name: hdb_metadata; Type: TABLE; Schema: hdb_catalog; Owner: postgres
--

CREATE TABLE hdb_catalog.hdb_metadata (
    id integer NOT NULL,
    metadata json NOT NULL,
    resource_version integer DEFAULT 1 NOT NULL
);


ALTER TABLE hdb_catalog.hdb_metadata OWNER TO postgres;

--
-- Name: hdb_scheduled_event_invocation_logs; Type: TABLE; Schema: hdb_catalog; Owner: postgres
--

CREATE TABLE hdb_catalog.hdb_scheduled_event_invocation_logs (
    id text DEFAULT hdb_catalog.gen_hasura_uuid() NOT NULL,
    event_id text,
    status integer,
    request json,
    response json,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE hdb_catalog.hdb_scheduled_event_invocation_logs OWNER TO postgres;

--
-- Name: hdb_scheduled_events; Type: TABLE; Schema: hdb_catalog; Owner: postgres
--

CREATE TABLE hdb_catalog.hdb_scheduled_events (
    id text DEFAULT hdb_catalog.gen_hasura_uuid() NOT NULL,
    webhook_conf json NOT NULL,
    scheduled_time timestamp with time zone NOT NULL,
    retry_conf json,
    payload json,
    header_conf json,
    status text DEFAULT 'scheduled'::text NOT NULL,
    tries integer DEFAULT 0 NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    next_retry_at timestamp with time zone,
    comment text,
    CONSTRAINT valid_status CHECK ((status = ANY (ARRAY['scheduled'::text, 'locked'::text, 'delivered'::text, 'error'::text, 'dead'::text])))
);


ALTER TABLE hdb_catalog.hdb_scheduled_events OWNER TO postgres;

--
-- Name: hdb_schema_notifications; Type: TABLE; Schema: hdb_catalog; Owner: postgres
--

CREATE TABLE hdb_catalog.hdb_schema_notifications (
    id integer NOT NULL,
    notification json NOT NULL,
    resource_version integer DEFAULT 1 NOT NULL,
    instance_id uuid NOT NULL,
    updated_at timestamp with time zone DEFAULT now(),
    CONSTRAINT hdb_schema_notifications_id_check CHECK ((id = 1))
);


ALTER TABLE hdb_catalog.hdb_schema_notifications OWNER TO postgres;

--
-- Name: hdb_version; Type: TABLE; Schema: hdb_catalog; Owner: postgres
--

CREATE TABLE hdb_catalog.hdb_version (
    hasura_uuid uuid DEFAULT hdb_catalog.gen_hasura_uuid() NOT NULL,
    version text NOT NULL,
    upgraded_on timestamp with time zone NOT NULL,
    cli_state jsonb DEFAULT '{}'::jsonb NOT NULL,
    console_state jsonb DEFAULT '{}'::jsonb NOT NULL
);


ALTER TABLE hdb_catalog.hdb_version OWNER TO postgres;

--
-- Name: inpurData1; Type: TABLE; Schema: traderBot; Owner: postgres
--

CREATE TABLE "traderBot"."inpurData1" (
    id integer NOT NULL,
    "Ticker" text NOT NULL,
    "ATH" real NOT NULL
);


ALTER TABLE "traderBot"."inpurData1" OWNER TO postgres;

--
-- Name: inpurData1_id_seq; Type: SEQUENCE; Schema: traderBot; Owner: postgres
--

CREATE SEQUENCE "traderBot"."inpurData1_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "traderBot"."inpurData1_id_seq" OWNER TO postgres;

--
-- Name: inpurData1_id_seq; Type: SEQUENCE OWNED BY; Schema: traderBot; Owner: postgres
--

ALTER SEQUENCE "traderBot"."inpurData1_id_seq" OWNED BY "traderBot"."inpurData1".id;


--
-- Name: inputData; Type: TABLE; Schema: traderBot; Owner: postgres
--

CREATE TABLE "traderBot"."inputData" (
    id integer NOT NULL,
    "Ticker" text,
    "ATH" text,
    "PosFromFund" text,
    "ProfitValue" text,
    "ValFirstBuy" text,
    "ValSecBuy" text,
    "ValForcedSale" text,
    "FirstBuy" boolean DEFAULT false NOT NULL,
    "SecBuy" boolean DEFAULT false NOT NULL,
    "TPid" bigint,
    "stopLossed" boolean DEFAULT false NOT NULL,
    "SumFirstBuy" text
);


ALTER TABLE "traderBot"."inputData" OWNER TO postgres;

--
-- Name: inputData_id_seq; Type: SEQUENCE; Schema: traderBot; Owner: postgres
--

CREATE SEQUENCE "traderBot"."inputData_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "traderBot"."inputData_id_seq" OWNER TO postgres;

--
-- Name: inputData_id_seq; Type: SEQUENCE OWNED BY; Schema: traderBot; Owner: postgres
--

ALTER SEQUENCE "traderBot"."inputData_id_seq" OWNED BY "traderBot"."inputData".id;


--
-- Name: config ID; Type: DEFAULT; Schema: attendance; Owner: postgres
--

ALTER TABLE ONLY attendance.config ALTER COLUMN "ID" SET DEFAULT nextval('attendance."config_ID_seq"'::regclass);


--
-- Name: intervals id; Type: DEFAULT; Schema: attendance; Owner: postgres
--

ALTER TABLE ONLY attendance.intervals ALTER COLUMN id SET DEFAULT nextval('attendance."Intervals_ID_seq"'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: attendance; Owner: postgres
--

ALTER TABLE ONLY attendance.users ALTER COLUMN id SET DEFAULT nextval('attendance.users_id_seq'::regclass);


--
-- Name: AccessLevels AccessLevelID; Type: DEFAULT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp."AccessLevels" ALTER COLUMN "AccessLevelID" SET DEFAULT nextval('erp."AccessLevels_AccessLevelID_seq"'::regclass);


--
-- Name: CheckListTPLs CheckListTPLID; Type: DEFAULT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp."CheckListTPLs" ALTER COLUMN "CheckListTPLID" SET DEFAULT nextval('erp."CheckListTPLs_CheckListTPLID_seq"'::regclass);


--
-- Name: CheckListUnits CheckListUnitID; Type: DEFAULT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp."CheckListUnits" ALTER COLUMN "CheckListUnitID" SET DEFAULT nextval('erp."CheckListUnits_CheckListUnitID_seq"'::regclass);


--
-- Name: Comments CommentID; Type: DEFAULT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp."Comments" ALTER COLUMN "CommentID" SET DEFAULT nextval('erp."Comments_CommentID_seq"'::regclass);


--
-- Name: Docs ID; Type: DEFAULT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp."Docs" ALTER COLUMN "ID" SET DEFAULT nextval('erp."Docs_ID_seq"'::regclass);


--
-- Name: Notifications ID; Type: DEFAULT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp."Notifications" ALTER COLUMN "ID" SET DEFAULT nextval('erp."Notifications_ID_seq"'::regclass);


--
-- Name: OrderItems OrderItemID; Type: DEFAULT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp."OrderItems" ALTER COLUMN "OrderItemID" SET DEFAULT nextval('erp."OrderItems_OrderItemID_seq"'::regclass);


--
-- Name: Orders OrderID; Type: DEFAULT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp."Orders" ALTER COLUMN "OrderID" SET DEFAULT nextval('erp."Orders_OrderID_seq"'::regclass);


--
-- Name: PaymentHistory ID; Type: DEFAULT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp."PaymentHistory" ALTER COLUMN "ID" SET DEFAULT nextval('erp."PaymentHistory_id_seq"'::regclass);


--
-- Name: Tokens ID; Type: DEFAULT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp."Tokens" ALTER COLUMN "ID" SET DEFAULT nextval('erp."Tokrns_ID_seq"'::regclass);


--
-- Name: Users UserID; Type: DEFAULT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp."Users" ALTER COLUMN "UserID" SET DEFAULT nextval('erp."Users_UserID_seq"'::regclass);


--
-- Name: inpurData1 id; Type: DEFAULT; Schema: traderBot; Owner: postgres
--

ALTER TABLE ONLY "traderBot"."inpurData1" ALTER COLUMN id SET DEFAULT nextval('"traderBot"."inpurData1_id_seq"'::regclass);


--
-- Name: inputData id; Type: DEFAULT; Schema: traderBot; Owner: postgres
--

ALTER TABLE ONLY "traderBot"."inputData" ALTER COLUMN id SET DEFAULT nextval('"traderBot"."inputData_id_seq"'::regclass);


--
-- Data for Name: config; Type: TABLE DATA; Schema: attendance; Owner: postgres
--

COPY attendance.config ("ID", "TimeDeduction") FROM stdin;
1	20.0
\.


--
-- Data for Name: intervals; Type: TABLE DATA; Schema: attendance; Owner: postgres
--

COPY attendance.intervals (id, ent, ext, card, database) FROM stdin;
155311	2021-12-01 08:18:20	2021-12-01 16:20:23	9224701	factory
155312	2021-12-02 08:12:05	2021-12-02 16:16:51	9224701	factory
155313	2021-12-03 08:15:31	2021-12-03 15:54:18	9224701	factory
155314	2021-12-04 08:24:02	2021-12-04 12:59:28	9224701	factory
155315	2021-12-06 09:22:49	2021-12-06 15:59:57	9224701	factory
155316	2021-12-07 08:03:46	2021-12-07 15:40:05	9224701	factory
155317	2021-12-08 08:19:51	2021-12-08 15:52:36	9224701	factory
155318	2021-12-09 08:28:13	\N	9224701	factory
155319	2021-12-10 08:50:46	2021-12-10 16:21:04	9224701	factory
155320	2021-12-11 08:54:14	2021-12-11 12:40:18	9224701	factory
155321	2021-12-13 08:23:14	2021-12-13 17:07:00	9224701	factory
155322	2021-12-14 08:56:50	2021-12-14 16:06:56	9224701	factory
155323	2021-12-15 08:27:11	2021-12-15 16:49:52	9224701	factory
155324	2021-12-16 08:39:05	2021-12-16 16:32:40	9224701	factory
155325	2021-12-17 09:06:39	2021-12-17 16:07:35	9224701	factory
155326	2021-12-18 08:36:03	2021-12-18 12:27:46	9224701	factory
155327	2021-12-20 08:48:32	2021-12-20 16:00:29	9224701	factory
155328	2021-12-21 08:30:49	2021-12-21 16:06:51	9224701	factory
155329	2021-12-22 08:34:54	2021-12-22 16:45:17	9224701	factory
155330	2021-12-23 08:58:36	2021-12-23 16:23:39	9224701	factory
155331	2021-12-24 09:05:00	2021-12-24 16:12:16	9224701	factory
155332	2021-12-25 08:57:55	\N	9224701	factory
155333	2021-12-27 07:53:32	2021-12-27 16:08:05	9224701	factory
155334	2021-12-28 15:14:24	2021-12-28 16:10:21	9224701	factory
155335	2021-12-29 08:18:30	2021-12-29 12:37:33	9224701	factory
155336	2022-01-05 10:28:58	2022-01-05 15:17:27	9224701	factory
155337	2022-01-10 08:36:58	2022-01-10 15:45:17	9224701	factory
155338	2022-01-11 08:52:09	2022-01-11 16:46:05	9224701	factory
155339	2022-01-12 08:26:18	2022-01-12 15:43:28	9224701	factory
155340	2022-01-13 09:09:03	2022-01-13 16:27:47	9224701	factory
155341	2022-01-14 08:42:18	2022-01-14 16:09:00	9224701	factory
155342	2022-01-17 08:26:41	2022-01-17 16:20:35	9224701	factory
155343	2022-01-18 09:00:31	2022-01-18 16:18:10	9224701	factory
155344	2022-01-19 08:09:59	2022-01-19 16:19:41	9224701	factory
155345	2022-01-20 08:31:21	2022-01-20 16:34:25	9224701	factory
155346	2022-01-21 08:55:58	2022-01-21 16:14:31	9224701	factory
155347	2022-01-22 09:17:49	2022-01-22 12:56:59	9224701	factory
155348	2022-01-24 08:19:31	2022-01-24 16:18:27	9224701	factory
155349	2022-01-25 08:39:51	2022-01-25 16:13:36	9224701	factory
155350	2022-01-26 08:41:01	2022-01-26 16:24:09	9224701	factory
155351	2022-01-27 09:02:16	2022-01-27 16:19:32	9224701	factory
155352	2022-01-28 08:27:35	2022-01-28 16:17:24	9224701	factory
155353	2022-01-31 08:27:00	\N	9224701	factory
155354	2022-02-01 08:33:14	2022-02-01 15:47:52	9224701	factory
155355	2022-02-02 08:38:38	2022-02-02 16:01:37	9224701	factory
155356	2022-02-03 08:40:03	2022-02-03 17:22:26	9224701	factory
155357	2022-02-04 08:58:03	2022-02-04 16:07:37	9224701	factory
155358	2022-02-05 09:03:49	2022-02-05 13:19:00	9224701	factory
155359	2022-02-07 08:05:25	2022-02-07 16:22:08	9224701	factory
155360	2022-02-08 08:11:48	2022-02-08 16:26:59	9224701	factory
155361	2022-02-09 08:26:53	2022-02-09 16:19:33	9224701	factory
155362	2022-02-10 08:57:44	2022-02-10 16:15:34	9224701	factory
155363	2022-02-11 08:24:41	2022-02-11 16:09:44	9224701	factory
155364	2022-02-12 08:41:57	2022-02-12 13:10:08	9224701	factory
155365	2022-02-14 08:43:25	2022-02-14 17:04:25	9224701	factory
155366	2022-02-15 08:14:37	2022-02-15 16:34:51	9224701	factory
155367	2022-02-16 08:35:51	2022-02-16 16:33:49	9224701	factory
155368	2022-02-17 08:10:18	2022-02-17 16:25:34	9224701	factory
155369	2022-02-18 08:10:52	2022-02-18 16:23:20	9224701	factory
155370	2022-02-19 08:11:11	2022-02-19 12:20:12	9224701	factory
155371	2022-02-21 08:34:14	2022-02-21 16:21:12	9224701	factory
155372	2022-02-22 08:31:27	2022-02-22 16:30:48	9224701	factory
155373	2022-02-23 08:02:46	2022-02-23 15:48:54	9224701	factory
155374	2022-02-24 08:41:27	2022-02-24 18:03:28	9224701	factory
155375	2022-02-25 08:53:17	2022-02-25 16:17:50	9224701	factory
155376	2022-02-26 13:18:45	\N	9224701	factory
155377	2022-02-28 08:56:46	2022-02-28 16:40:56	9224701	factory
155378	2022-03-01 08:27:43	2022-03-01 16:29:40	9224701	factory
155379	2021-12-14 06:35:03	\N	11003802	factory
155380	2021-12-15 06:44:30	2021-12-15 15:30:53	11003802	factory
155381	2021-12-16 06:43:26	2021-12-16 15:32:21	11003802	factory
155382	2021-12-17 06:44:53	2021-12-17 15:34:36	11003802	factory
155383	2021-12-20 06:43:54	2021-12-20 15:32:04	11003802	factory
155384	2021-12-21 06:37:37	2021-12-21 15:31:20	11003802	factory
155385	2021-12-23 06:36:27	2021-12-23 15:31:57	11003802	factory
155386	2021-12-24 06:40:43	2021-12-24 15:31:54	11003802	factory
155387	2021-12-25 06:44:47	2021-12-25 14:29:34	11003802	factory
155388	2021-12-27 06:40:53	2021-12-27 15:30:28	11003802	factory
155389	2021-12-28 06:42:05	2021-12-28 15:31:45	11003802	factory
155390	2021-12-29 06:47:39	2021-12-29 11:18:05	11003802	factory
155391	2022-01-10 06:45:41	2022-01-10 15:33:58	11003802	factory
155392	2022-01-11 06:41:37	2022-01-11 15:33:14	11003802	factory
155393	2022-01-12 06:43:12	2022-01-12 15:30:13	11003802	factory
155394	2022-01-13 06:41:25	2022-01-13 15:31:21	11003802	factory
155395	2022-01-14 06:34:19	2022-01-14 15:33:16	11003802	factory
155396	2022-01-17 06:48:04	2022-01-17 15:33:43	11003802	factory
155397	2022-01-18 06:34:46	2022-01-18 15:31:19	11003802	factory
155398	2022-01-19 06:38:55	2022-01-19 15:43:11	11003802	factory
155399	2022-01-20 06:39:37	2022-01-20 15:31:15	11003802	factory
155400	2022-01-21 06:41:09	2022-01-21 15:31:21	11003802	factory
155401	2022-01-24 06:25:36	2022-01-24 15:31:23	11003802	factory
155402	2022-01-25 06:38:14	2022-01-25 15:31:42	11003802	factory
155403	2022-01-26 06:35:44	\N	11003802	factory
155404	2022-01-27 08:41:14	2022-01-27 15:32:36	11003802	factory
155405	2022-01-28 06:41:51	2022-01-28 15:27:37	11003802	factory
155406	2022-01-31 06:40:47	2022-01-31 15:31:51	11003802	factory
155407	2022-02-01 06:44:16	2022-02-01 15:31:22	11003802	factory
155408	2022-02-02 06:36:41	2022-02-02 15:31:17	11003802	factory
155409	2022-02-03 06:32:51	2022-02-03 15:39:46	11003802	factory
155410	2022-02-04 06:47:05	2022-02-04 15:31:52	11003802	factory
155411	2022-02-07 06:43:25	2022-02-07 15:32:03	11003802	factory
155412	2022-02-08 06:29:59	2022-02-08 15:32:10	11003802	factory
155413	2022-02-09 06:49:53	2022-02-09 15:32:21	11003802	factory
155414	2022-02-10 06:47:17	2022-02-10 15:31:47	11003802	factory
155415	2022-02-11 06:36:40	2022-02-11 15:30:57	11003802	factory
155416	2022-02-14 06:32:55	2022-02-14 15:37:02	11003802	factory
155417	2021-12-01 05:46:06	2021-12-01 13:30:31	9224735	factory
155418	2021-12-02 06:42:10	2021-12-02 15:33:45	9224735	factory
155419	2021-12-03 05:43:21	2021-12-03 15:32:44	9224735	factory
155420	2021-12-06 06:39:02	2021-12-06 15:33:18	9224735	factory
155421	2021-12-07 06:45:51	2021-12-07 15:33:00	9224735	factory
155422	2021-12-08 06:42:52	2021-12-08 15:33:23	9224735	factory
155423	2021-12-09 06:47:41	2021-12-09 15:30:46	9224735	factory
155424	2021-12-10 06:48:49	2021-12-10 15:30:13	9224735	factory
155425	2021-12-13 06:41:52	2021-12-13 06:55:03	9224735	factory
155426	2021-12-13 15:30:52	\N	9224735	factory
155427	2021-12-14 05:50:05	2021-12-14 15:30:42	9224735	factory
155428	2021-12-15 06:37:44	2021-12-15 15:30:59	9224735	factory
155429	2021-12-16 05:48:24	2021-12-16 15:32:17	9224735	factory
155430	2021-12-17 05:46:26	2021-12-17 14:35:28	9224735	factory
155431	2021-12-20 06:39:29	2021-12-20 15:32:09	9224735	factory
155432	2021-12-21 06:43:27	2021-12-21 15:31:35	9224735	factory
155433	2021-12-22 06:34:51	2021-12-22 15:32:18	9224735	factory
155434	2021-12-23 06:35:40	2021-12-23 15:32:21	9224735	factory
155435	2021-12-24 06:33:55	2021-12-24 15:32:20	9224735	factory
155436	2021-12-25 06:34:15	2021-12-25 13:34:31	9224735	factory
155437	2021-12-27 06:42:06	2021-12-27 15:32:26	9224735	factory
155438	2021-12-28 05:46:02	2021-12-28 15:31:49	9224735	factory
155439	2021-12-29 06:37:07	\N	9224735	factory
155440	2022-01-03 06:59:49	2022-01-03 11:02:48	9224735	factory
155441	2022-01-04 06:44:47	2022-01-04 15:05:04	9224735	factory
155442	2022-01-05 06:45:26	2022-01-05 14:31:41	9224735	factory
155443	2022-01-06 06:45:37	2022-01-06 13:41:39	9224735	factory
155444	2022-01-10 06:35:25	2022-01-10 15:31:57	9224735	factory
155445	2022-01-11 06:43:06	2022-01-11 15:33:21	9224735	factory
155446	2022-01-12 06:30:10	2022-01-12 15:32:09	9224735	factory
155447	2022-01-13 06:31:30	2022-01-13 15:32:01	9224735	factory
155448	2022-01-14 06:42:09	2022-01-14 15:31:44	9224735	factory
155449	2022-01-17 06:33:58	2022-01-17 15:31:10	9224735	factory
155450	2022-01-18 06:35:26	2022-01-18 15:31:22	9224735	factory
155451	2022-01-19 06:30:46	2022-01-19 15:32:36	9224735	factory
155452	2022-01-20 06:33:44	2022-01-20 15:31:27	9224735	factory
155453	2022-01-21 06:35:56	2022-01-21 15:32:16	9224735	factory
155454	2022-01-24 06:36:39	2022-01-24 15:31:33	9224735	factory
155455	2022-01-25 06:38:08	2022-01-25 15:37:52	9224735	factory
155456	2022-01-26 06:32:06	2022-01-26 15:31:56	9224735	factory
155457	2022-01-27 06:26:40	2022-01-27 15:31:51	9224735	factory
155458	2022-01-28 05:50:36	2022-01-28 15:30:39	9224735	factory
155459	2022-01-31 06:33:45	2022-01-31 15:32:00	9224735	factory
155460	2022-02-01 06:32:44	2022-02-01 15:31:29	9224735	factory
155461	2022-02-02 06:34:31	2022-02-02 15:31:25	9224735	factory
155462	2022-02-03 06:38:54	2022-02-03 15:32:48	9224735	factory
155463	2022-02-04 05:42:38	2022-02-04 15:33:57	9224735	factory
155464	2022-02-07 06:34:21	2022-02-07 15:39:06	9224735	factory
155465	2022-02-08 06:35:56	2022-02-08 15:42:29	9224735	factory
155466	2022-02-09 06:35:06	2022-02-09 15:32:32	9224735	factory
155467	2022-02-10 06:46:02	2022-02-10 15:32:08	9224735	factory
155468	2022-02-11 06:29:57	2022-02-11 15:31:06	9224735	factory
155469	2022-02-14 05:47:10	2022-02-14 15:33:50	9224735	factory
155470	2022-02-15 06:30:34	2022-02-15 15:32:24	9224735	factory
155471	2022-02-16 06:31:32	2022-02-16 15:32:16	9224735	factory
155472	2022-02-17 06:30:24	2022-02-17 15:31:42	9224735	factory
155473	2022-02-18 06:29:24	2022-02-18 15:33:14	9224735	factory
155474	2022-02-21 06:36:10	2022-02-21 15:32:49	9224735	factory
155475	2022-02-22 06:35:19	2022-02-22 15:33:10	9224735	factory
155476	2022-02-23 06:40:25	2022-02-23 15:31:26	9224735	factory
155477	2022-02-24 06:32:52	2022-02-24 15:31:46	9224735	factory
155478	2022-02-25 06:34:30	2022-02-25 14:33:02	9224735	factory
155479	2022-02-28 06:34:58	2022-02-28 15:32:13	9224735	factory
155480	2022-03-01 06:38:09	2022-03-01 15:32:00	9224735	factory
155481	2021-12-01 05:47:33	2021-12-01 15:31:43	9224748	factory
155482	2021-12-02 05:42:31	2021-12-02 15:30:46	9224748	factory
155483	2021-12-03 05:44:51	2021-12-03 15:30:28	9224748	factory
155484	2021-12-04 06:02:31	2021-12-04 12:01:21	9224748	factory
155485	2021-12-06 06:30:38	2021-12-06 15:31:26	9224748	factory
155486	2021-12-07 06:53:09	2021-12-07 15:31:24	9224748	factory
155487	2021-12-08 09:18:29	2021-12-08 15:30:29	9224748	factory
155488	2021-12-16 05:48:42	2021-12-16 15:32:30	9224748	factory
155489	2021-12-17 05:43:07	2021-12-17 15:50:24	9224748	factory
155490	2021-12-18 05:56:40	2021-12-18 12:01:33	9224748	factory
155491	2021-12-20 05:43:59	2021-12-20 15:30:31	9224748	factory
155492	2021-12-21 05:44:56	2021-12-21 15:31:15	9224748	factory
155493	2021-12-22 05:47:46	2021-12-22 15:30:58	9224748	factory
155494	2021-12-23 05:48:41	2021-12-23 15:30:46	9224748	factory
155495	2021-12-24 05:53:32	2021-12-24 15:32:52	9224748	factory
155496	2021-12-25 05:51:53	2021-12-25 14:41:01	9224748	factory
155497	2021-12-27 05:47:22	2021-12-27 15:30:46	9224748	factory
155498	2021-12-28 05:47:06	2021-12-28 14:39:10	9224748	factory
155499	2021-12-29 06:48:59	2021-12-29 10:04:30	9224748	factory
155500	2022-01-03 06:49:10	2022-01-03 11:00:07	9224748	factory
155501	2022-01-04 05:53:18	2022-01-04 14:31:15	9224748	factory
155502	2022-01-05 05:48:30	2022-01-05 14:42:05	9224748	factory
155503	2022-01-06 05:47:13	2022-01-06 13:33:27	9224748	factory
155504	2022-01-10 06:38:28	2022-01-10 15:37:26	9224748	factory
155505	2022-01-11 06:39:54	2022-01-11 15:32:08	9224748	factory
155506	2022-01-12 06:26:58	2022-01-12 15:31:29	9224748	factory
155507	2022-01-13 06:41:09	2022-01-13 15:32:09	9224748	factory
155508	2022-01-14 06:40:58	2022-01-14 15:30:47	9224748	factory
155509	2022-01-17 06:50:47	2022-01-17 15:32:30	9224748	factory
155510	2022-01-18 06:42:20	2022-01-18 15:32:29	9224748	factory
155511	2022-01-19 06:42:14	2022-01-19 15:31:18	9224748	factory
155512	2022-01-20 06:38:50	2022-01-20 15:30:49	9224748	factory
155513	2022-01-21 06:51:49	2022-01-21 15:35:11	9224748	factory
155514	2022-01-24 06:37:23	2022-01-24 15:30:35	9224748	factory
155515	2022-01-25 06:38:39	2022-01-25 15:34:20	9224748	factory
155516	2022-01-26 06:39:15	2022-01-26 15:30:57	9224748	factory
155517	2022-01-27 06:38:55	2022-01-27 15:31:10	9224748	factory
155518	2022-01-28 05:43:36	2022-01-28 15:30:28	9224748	factory
155519	2022-01-29 05:49:45	2022-01-29 11:06:00	9224748	factory
155520	2022-01-31 05:51:31	2022-01-31 15:31:31	9224748	factory
155521	2022-02-01 05:47:09	2022-02-01 15:30:20	9224748	factory
155522	2022-02-02 05:34:02	2022-02-02 15:31:59	9224748	factory
155523	2022-02-03 06:42:52	2022-02-03 15:30:42	9224748	factory
155524	2022-02-04 05:37:48	2022-02-04 15:36:32	9224748	factory
155525	2022-02-07 06:25:20	2022-02-07 15:40:31	9224748	factory
155526	2022-02-08 06:27:52	2022-02-08 16:05:41	9224748	factory
155527	2022-02-09 06:34:43	2022-02-09 17:55:02	9224748	factory
155528	2022-02-10 06:38:10	2022-02-10 15:30:57	9224748	factory
155529	2022-02-11 06:39:35	2022-02-11 15:31:09	9224748	factory
155530	2022-02-14 06:40:01	2022-02-14 15:32:19	9224748	factory
155531	2022-02-15 06:29:08	2022-02-15 15:26:31	9224748	factory
155532	2022-02-16 06:20:17	2022-02-16 15:31:07	9224748	factory
155533	2022-02-17 06:28:02	2022-02-17 15:31:39	9224748	factory
155534	2022-02-18 06:36:46	2022-02-18 15:30:36	9224748	factory
155535	2022-02-21 05:43:09	2022-02-21 15:32:20	9224748	factory
155536	2022-02-22 05:53:04	\N	9224748	factory
155537	2022-02-23 05:43:57	2022-02-23 14:34:21	9224748	factory
155538	2022-02-24 05:50:34	2022-02-24 15:30:17	9224748	factory
155539	2022-02-25 05:46:35	2022-02-25 14:33:58	9224748	factory
155540	2022-02-28 06:17:42	2022-02-28 15:31:24	9224748	factory
155541	2022-03-01 05:41:58	2022-03-01 15:31:17	9224748	factory
155542	2021-11-15 15:14:13	\N	9224769	factory
155543	2021-12-01 06:58:16	2021-12-01 15:32:02	9224769	factory
155544	2021-12-02 06:13:17	2021-12-02 15:32:14	9224769	factory
155545	2021-12-03 06:22:23	2021-12-03 15:33:27	9224769	factory
155546	2021-12-06 06:21:09	2021-12-06 15:31:30	9224769	factory
155547	2021-12-07 06:16:35	2021-12-07 15:32:40	9224769	factory
155548	2021-12-08 06:22:53	2021-12-08 18:24:00	9224769	factory
155549	2021-12-08 18:32:36	2021-12-09 07:04:25	9224769	factory
155550	2021-12-09 15:31:15	\N	9224769	factory
155551	2021-12-10 06:55:16	2021-12-10 15:32:22	9224769	factory
155552	2021-12-11 06:22:03	\N	9224769	factory
155553	2021-12-13 06:19:50	2021-12-13 15:31:53	9224769	factory
155554	2021-12-14 06:23:55	\N	9224769	factory
155555	2021-12-15 06:46:12	2021-12-15 15:41:29	9224769	factory
155556	2021-12-16 06:23:18	2021-12-16 15:30:56	9224769	factory
155557	2021-12-17 06:39:17	2021-12-17 15:31:18	9224769	factory
155558	2021-12-21 06:46:38	2021-12-21 15:31:10	9224769	factory
155559	2021-12-22 06:34:00	2021-12-22 15:31:02	9224769	factory
155560	2021-12-23 07:07:43	2021-12-23 15:33:40	9224769	factory
155561	2021-12-24 06:38:39	2021-12-24 15:33:15	9224769	factory
155562	2021-12-25 06:41:22	2021-12-25 15:16:06	9224769	factory
155563	2021-12-27 06:21:29	2021-12-27 16:50:37	9224769	factory
155564	2021-12-28 06:16:24	2021-12-28 15:31:09	9224769	factory
155565	2021-12-29 06:20:09	2021-12-29 10:08:27	9224769	factory
155566	2022-01-03 06:50:58	2022-01-03 11:00:11	9224769	factory
155567	2022-01-04 06:52:01	2022-01-04 14:31:18	9224769	factory
155568	2022-01-05 06:46:45	2022-01-05 15:30:08	9224769	factory
155569	2022-01-06 06:34:26	2022-01-06 13:52:43	9224769	factory
155570	2022-01-10 06:22:32	2022-01-10 16:39:49	9224769	factory
155571	2022-01-11 06:23:47	2022-01-11 16:00:02	9224769	factory
155572	2022-01-12 06:16:57	2022-01-12 15:56:31	9224769	factory
155573	2022-01-13 06:17:30	2022-01-13 15:35:30	9224769	factory
155574	2022-01-14 06:16:24	2022-01-14 15:30:55	9224769	factory
155575	2022-01-17 06:15:33	2022-01-17 17:42:10	9224769	factory
155576	2022-01-18 15:32:08	\N	9224769	factory
155577	2022-01-20 15:32:44	\N	9224769	factory
155578	2022-01-21 06:19:57	2022-01-21 15:31:17	9224769	factory
155579	2022-01-24 06:23:59	2022-01-24 17:14:49	9224769	factory
155580	2022-01-25 06:28:18	2022-01-25 14:11:12	9224769	factory
155581	2022-01-26 06:47:14	2022-01-26 15:31:46	9224769	factory
155582	2022-01-27 06:37:57	2022-01-27 15:32:00	9224769	factory
155583	2022-01-28 06:41:00	2022-01-28 15:38:07	9224769	factory
155584	2022-01-29 06:55:58	2022-01-29 11:07:32	9224769	factory
155585	2022-01-31 07:10:57	2022-01-31 15:43:39	9224769	factory
155586	2022-02-02 06:33:02	2022-02-02 15:32:21	9224769	factory
155587	2022-02-03 06:20:25	2022-02-03 15:30:33	9224769	factory
155588	2022-02-07 07:21:36	2022-02-07 15:58:49	9224769	factory
155589	2022-02-08 06:26:48	2022-02-08 16:03:29	9224769	factory
155590	2022-02-09 06:53:08	\N	9224769	factory
155591	2022-02-10 06:50:04	2022-02-10 15:30:50	9224769	factory
155592	2022-02-11 06:24:48	2022-02-11 15:31:26	9224769	factory
155593	2022-02-12 06:43:44	2022-02-12 10:54:19	9224769	factory
155594	2022-02-14 06:41:15	2022-02-14 15:30:54	9224769	factory
155595	2022-02-15 06:19:17	2022-02-15 15:32:07	9224769	factory
155596	2022-02-16 06:37:53	2022-02-16 15:31:11	9224769	factory
155597	2022-02-17 07:08:24	2022-02-17 15:35:18	9224769	factory
155598	2022-02-21 06:59:14	2022-02-21 15:30:48	9224769	factory
155599	2022-02-22 06:35:33	2022-02-22 15:31:12	9224769	factory
155600	2022-02-24 06:50:27	2022-02-24 15:30:21	9224769	factory
155601	2022-02-25 06:39:01	\N	9224769	factory
155602	2022-02-26 06:46:57	2022-02-26 11:04:33	9224769	factory
155603	2022-02-28 06:35:32	2022-02-28 15:30:58	9224769	factory
155604	2022-03-01 06:42:22	2022-03-01 15:31:04	9224769	factory
155605	2021-11-16 06:41:33	2021-11-16 15:31:15	9224782	factory
155606	2021-12-01 06:40:00	2021-12-01 15:49:22	9224782	factory
155607	2021-12-02 06:42:30	2021-12-02 15:34:12	9224782	factory
155608	2021-12-06 06:36:35	2021-12-06 15:30:53	9224782	factory
155609	2021-12-07 06:43:39	2021-12-07 15:28:59	9224782	factory
155610	2021-12-08 06:37:44	2021-12-08 15:33:07	9224782	factory
155611	2021-12-09 06:37:19	2021-12-09 15:33:38	9224782	factory
155612	2021-12-10 06:40:06	2021-12-10 11:04:44	9224782	factory
155613	2021-12-13 06:45:06	2021-12-13 15:30:32	9224782	factory
155614	2021-12-14 06:36:29	2021-12-14 15:38:27	9224782	factory
155615	2021-12-15 06:37:21	2021-12-15 15:33:10	9224782	factory
155616	2021-12-16 06:39:49	2021-12-16 16:12:16	9224782	factory
155617	2021-12-17 06:41:59	2021-12-17 15:33:26	9224782	factory
155618	2021-12-20 06:36:59	2021-12-20 15:35:31	9224782	factory
155619	2021-12-21 06:41:34	2021-12-21 15:28:11	9224782	factory
155620	2021-12-22 06:39:17	2021-12-22 15:30:54	9224782	factory
155621	2021-12-23 06:35:37	2021-12-23 15:52:51	9224782	factory
155622	2021-12-24 06:37:22	2021-12-24 15:30:50	9224782	factory
155623	2021-12-25 06:37:11	2021-12-25 14:28:04	9224782	factory
155624	2021-12-27 06:32:56	2021-12-27 15:33:57	9224782	factory
155625	2021-12-28 06:32:09	2021-12-28 15:32:35	9224782	factory
155626	2021-12-29 06:32:31	2021-12-29 10:59:12	9224782	factory
155627	2022-01-10 06:32:09	2022-01-10 15:36:35	9224782	factory
155628	2022-01-11 06:30:51	2022-01-11 15:44:35	9224782	factory
155629	2022-01-12 06:29:56	2022-01-12 15:39:37	9224782	factory
155630	2022-01-13 06:34:52	2022-01-13 16:11:05	9224782	factory
155631	2022-01-14 06:29:25	2022-01-14 16:50:41	9224782	factory
155632	2022-01-15 06:17:50	2022-01-15 11:24:20	9224782	factory
155633	2022-01-17 06:28:56	2022-01-17 15:39:19	9224782	factory
155634	2022-01-18 06:35:12	2022-01-18 15:35:09	9224782	factory
155635	2022-01-19 06:31:45	2022-01-19 15:32:43	9224782	factory
155636	2022-01-20 06:32:34	2022-01-20 15:41:28	9224782	factory
155637	2022-01-21 06:31:52	2022-01-21 15:53:58	9224782	factory
155638	2022-01-24 06:33:34	2022-01-24 15:59:06	9224782	factory
155639	2022-01-25 06:30:52	2022-01-25 15:39:38	9224782	factory
155640	2022-01-26 06:29:13	2022-01-26 15:40:22	9224782	factory
155641	2022-01-27 06:30:50	2022-01-27 15:40:12	9224782	factory
155642	2022-01-28 06:29:14	2022-01-28 15:33:01	9224782	factory
155643	2022-01-31 06:20:11	2022-01-31 13:50:52	9224782	factory
155644	2022-02-02 06:28:08	2022-02-02 07:35:44	9224782	factory
155645	2022-02-03 06:28:27	2022-02-03 15:59:31	9224782	factory
155646	2022-02-04 06:28:49	2022-02-04 15:39:55	9224782	factory
155647	2022-02-07 06:33:02	2022-02-07 15:37:50	9224782	factory
155648	2022-02-08 06:29:29	2022-02-08 15:37:09	9224782	factory
155649	2022-02-09 06:30:00	2022-02-09 15:45:33	9224782	factory
155650	2022-02-10 06:34:25	2022-02-10 15:36:58	9224782	factory
155651	2022-02-11 06:57:27	2022-02-11 12:48:17	9224782	factory
155652	2022-02-14 06:29:11	2022-02-14 15:33:46	9224782	factory
155653	2022-02-15 06:27:52	2022-02-15 16:01:19	9224782	factory
155654	2022-02-16 06:28:22	2022-02-16 15:33:36	9224782	factory
155655	2022-02-17 06:34:14	2022-02-17 15:43:19	9224782	factory
155656	2022-02-18 06:26:05	2022-02-18 15:35:21	9224782	factory
155657	2022-02-21 06:30:45	2022-02-21 15:34:59	9224782	factory
155658	2022-02-22 06:31:16	2022-02-22 15:49:52	9224782	factory
155659	2022-02-23 06:29:37	2022-02-23 15:37:39	9224782	factory
155660	2022-02-24 06:33:28	2022-02-24 15:35:18	9224782	factory
155661	2022-02-25 06:41:26	2022-02-25 15:33:08	9224782	factory
155662	2022-02-28 06:34:12	2022-02-28 15:37:52	9224782	factory
155663	2022-03-01 06:36:54	2022-03-01 15:42:38	9224782	factory
155664	2021-11-16 08:39:27	\N	9224680	factory
155665	2021-12-01 08:18:31	2021-12-01 16:20:29	9224680	factory
155666	2021-12-02 08:12:10	2021-12-02 16:16:57	9224680	factory
155667	2021-12-03 08:15:39	2021-12-03 15:54:09	9224680	factory
155668	2021-12-04 08:23:56	2021-12-04 12:59:34	9224680	factory
155669	2021-12-06 09:22:55	2021-12-06 16:00:03	9224680	factory
155670	2021-12-07 08:03:40	2021-12-07 15:40:11	9224680	factory
155671	2021-12-08 08:19:47	2021-12-08 15:52:30	9224680	factory
155672	2021-12-09 08:28:16	\N	9224680	factory
155673	2021-12-10 08:50:49	2021-12-10 16:21:01	9224680	factory
155674	2021-12-11 08:54:17	2021-12-11 12:40:12	9224680	factory
155675	2021-12-13 08:23:08	2021-12-13 17:07:03	9224680	factory
155676	2021-12-14 08:56:56	2021-12-14 16:06:50	9224680	factory
155677	2021-12-15 08:27:07	2021-12-15 16:49:48	9224680	factory
155678	2021-12-16 08:39:11	2021-12-16 16:32:46	9224680	factory
155679	2021-12-17 09:06:42	2021-12-17 16:07:41	9224680	factory
155680	2021-12-18 08:36:06	2021-12-18 12:27:40	9224680	factory
155681	2021-12-20 08:48:28	2021-12-20 16:00:26	9224680	factory
155682	2021-12-21 08:30:55	2021-12-21 16:06:57	9224680	factory
155683	2021-12-22 08:35:00	2021-12-22 16:45:26	9224680	factory
155684	2021-12-23 08:58:39	2021-12-23 16:23:47	9224680	factory
155685	2021-12-24 09:04:54	2021-12-24 16:12:10	9224680	factory
155686	2021-12-25 08:57:51	\N	9224680	factory
155687	2021-12-27 07:53:35	2021-12-27 16:07:56	9224680	factory
155688	2021-12-28 08:14:17	2021-12-28 16:10:30	9224680	factory
155689	2021-12-29 08:18:21	2021-12-29 12:37:25	9224680	factory
155690	2022-01-05 10:29:04	2022-01-05 15:17:21	9224680	factory
155691	2022-01-10 08:37:01	2022-01-10 15:45:23	9224680	factory
155692	2022-01-11 08:52:15	2022-01-11 16:45:59	9224680	factory
155693	2022-01-12 08:26:21	2022-01-12 15:43:30	9224680	factory
155694	2022-01-13 09:09:09	2022-01-13 16:27:53	9224680	factory
155695	2022-01-14 08:42:22	2022-01-14 16:08:56	9224680	factory
155696	2022-01-17 08:26:36	2022-01-17 16:20:31	9224680	factory
155697	2022-01-18 09:00:34	2022-01-18 16:18:05	9224680	factory
155698	2022-01-19 08:09:55	2022-01-19 16:19:40	9224680	factory
155699	2022-01-20 08:31:24	2022-01-20 16:34:22	9224680	factory
155700	2022-01-21 08:56:01	2022-01-21 16:14:34	9224680	factory
155701	2022-01-22 09:17:46	2022-01-22 12:57:02	9224680	factory
155702	2022-01-24 08:19:35	2022-01-24 16:18:24	9224680	factory
155703	2022-01-25 08:39:49	2022-01-25 16:13:33	9224680	factory
155704	2022-01-26 08:41:04	2022-01-26 16:24:05	9224680	factory
155705	2022-01-27 09:02:18	2022-01-27 16:19:35	9224680	factory
155706	2022-01-28 08:27:32	2022-01-28 16:17:21	9224680	factory
155707	2022-01-31 08:27:06	\N	9224680	factory
155708	2022-02-01 08:33:11	2022-02-01 15:47:55	9224680	factory
155709	2022-02-02 08:38:44	2022-02-02 16:01:26	9224680	factory
155710	2022-02-03 08:40:06	2022-02-03 17:22:20	9224680	factory
155711	2022-02-04 08:58:00	2022-02-04 16:07:40	9224680	factory
155712	2022-02-05 09:03:52	2022-02-05 13:19:04	9224680	factory
155713	2022-02-07 08:05:21	2022-02-07 16:22:05	9224680	factory
155714	2022-02-08 08:11:51	2022-02-08 16:27:01	9224680	factory
155715	2022-02-09 08:26:57	2022-02-09 16:19:30	9224680	factory
155716	2022-02-10 08:57:42	2022-02-10 16:15:37	9224680	factory
155717	2022-02-11 08:24:43	2022-02-11 16:09:46	9224680	factory
155718	2022-02-12 08:42:00	2022-02-12 13:10:10	9224680	factory
155719	2022-02-14 08:43:23	2022-02-14 17:04:28	9224680	factory
155720	2022-02-15 08:14:39	2022-02-15 16:34:49	9224680	factory
155721	2022-02-16 08:35:48	2022-02-16 16:33:46	9224680	factory
155722	2022-02-17 08:10:21	2022-02-17 16:25:32	9224680	factory
155723	2022-02-18 08:10:55	2022-02-18 16:23:17	9224680	factory
155724	2022-02-19 08:11:06	2022-02-19 12:20:15	9224680	factory
155725	2022-02-21 08:34:11	2022-02-21 16:21:09	9224680	factory
155726	2022-02-22 08:31:23	2022-02-22 16:30:45	9224680	factory
155727	2022-02-23 08:02:43	2022-02-23 15:48:57	9224680	factory
155728	2022-02-24 08:41:30	2022-02-24 18:03:26	9224680	factory
155729	2022-02-25 08:53:20	2022-02-25 16:17:52	9224680	factory
155730	2022-02-26 13:18:47	\N	9224680	factory
155731	2022-02-28 08:56:50	2022-02-28 16:40:54	9224680	factory
155732	2022-03-01 08:27:48	2022-03-01 16:29:37	9224680	factory
155733	2022-02-23 15:32:54	\N	9224683	factory
155734	2022-02-24 06:31:38	2022-02-24 15:30:10	9224683	factory
155735	2022-02-25 06:33:04	2022-02-25 14:31:48	9224683	factory
155736	2021-11-16 06:38:56	\N	1484276	factory
155737	2021-11-17 06:38:52	\N	1484276	factory
155738	2021-12-01 06:42:24	2021-12-01 15:30:35	1484276	factory
155739	2021-12-02 06:41:31	2021-12-02 15:30:24	1484276	factory
155740	2021-12-03 06:42:31	2021-12-03 15:30:18	1484276	factory
155741	2021-12-04 05:55:49	2021-12-04 12:59:22	1484276	factory
155742	2021-12-06 06:42:38	2021-12-06 15:30:17	1484276	factory
155743	2021-12-07 06:42:05	2021-12-07 15:30:23	1484276	factory
155744	2021-12-08 06:44:48	2021-12-08 15:30:17	1484276	factory
155745	2021-12-09 06:42:30	2021-12-09 15:30:45	1484276	factory
155746	2021-12-10 06:41:51	2021-12-10 15:30:18	1484276	factory
155747	2021-12-11 05:39:56	2021-12-11 12:10:39	1484276	factory
155748	2021-12-13 06:42:42	2021-12-13 15:30:25	1484276	factory
155749	2021-12-14 06:40:33	2021-12-14 15:30:17	1484276	factory
155750	2021-12-15 06:39:33	2021-12-15 15:36:24	1484276	factory
155751	2021-12-16 06:42:12	2021-12-16 15:30:35	1484276	factory
155752	2021-12-17 05:43:11	2021-12-17 14:31:34	1484276	factory
155753	2021-12-18 05:55:44	2021-12-18 12:02:19	1484276	factory
155754	2021-12-20 06:43:31	2021-12-20 15:30:17	1484276	factory
155755	2021-12-21 06:42:25	2021-12-21 15:30:24	1484276	factory
155756	2021-12-22 06:41:50	2021-12-22 15:30:20	1484276	factory
155757	2021-12-23 06:42:03	2021-12-23 15:30:21	1484276	factory
155758	2021-12-24 06:42:58	2021-12-24 15:30:06	1484276	factory
155759	2021-12-25 06:43:09	2021-12-25 14:30:17	1484276	factory
155760	2021-12-27 06:44:24	2021-12-27 15:30:37	1484276	factory
155761	2021-12-28 06:41:41	2021-12-28 15:30:07	1484276	factory
155762	2021-12-29 06:40:20	\N	1484276	factory
155763	2022-01-04 06:43:31	2022-01-04 15:37:10	1484276	factory
155764	2022-01-05 06:43:27	2022-01-05 15:32:08	1484276	factory
155765	2022-01-06 05:40:06	2022-01-06 13:30:24	1484276	factory
155766	2022-01-10 06:44:08	2022-01-10 15:30:17	1484276	factory
155767	2022-01-11 06:45:09	2022-01-11 15:30:29	1484276	factory
155768	2022-01-12 06:41:55	2022-01-12 15:30:35	1484276	factory
155769	2022-01-13 06:44:06	2022-01-13 15:30:44	1484276	factory
155770	2022-01-14 06:44:21	2022-01-14 15:30:16	1484276	factory
155771	2022-01-17 06:43:19	2022-01-17 15:30:33	1484276	factory
155772	2022-01-18 06:43:51	2022-01-18 15:30:05	1484276	factory
155773	2022-01-19 06:45:20	2022-01-19 15:30:25	1484276	factory
155774	2022-01-20 06:43:38	2022-01-20 15:30:20	1484276	factory
155775	2022-01-21 05:46:06	2022-01-21 14:30:36	1484276	factory
155776	2022-01-24 06:42:35	2022-01-24 15:30:28	1484276	factory
155777	2022-01-25 06:43:08	2022-01-25 15:30:20	1484276	factory
155778	2022-01-26 06:42:50	2022-01-26 15:30:26	1484276	factory
155779	2022-01-27 06:43:00	\N	1484276	factory
155780	2022-01-28 06:42:48	2022-01-28 15:36:02	1484276	factory
155781	2022-02-09 06:41:18	2022-02-09 15:36:32	1484276	factory
155782	2022-02-10 06:44:50	2022-02-10 15:37:01	1484276	factory
155783	2022-02-11 06:42:09	2022-02-11 15:36:34	1484276	factory
155784	2022-02-12 05:47:27	2022-02-12 12:07:00	1484276	factory
155785	2022-02-14 06:42:31	2022-02-14 15:37:18	1484276	factory
155786	2022-02-15 05:43:58	2022-02-15 14:36:33	1484276	factory
155787	2022-02-16 06:41:30	2022-02-16 16:01:16	1484276	factory
155788	2022-02-17 06:42:27	2022-02-17 15:36:13	1484276	factory
155789	2022-02-18 06:41:41	2022-02-18 15:37:14	1484276	factory
155790	2022-02-19 05:54:34	2022-02-19 12:02:25	1484276	factory
155791	2022-02-21 06:41:15	2022-02-21 15:36:15	1484276	factory
155792	2022-02-22 06:42:07	2022-02-22 15:37:47	1484276	factory
155793	2022-02-23 06:43:38	2022-02-23 15:40:58	1484276	factory
155794	2022-02-24 06:43:59	2022-02-24 15:37:31	1484276	factory
155795	2022-02-25 06:42:30	2022-02-25 14:59:35	1484276	factory
155796	2022-02-28 06:43:12	2022-02-28 15:38:18	1484276	factory
155797	2022-03-01 06:42:47	2022-03-01 15:41:52	1484276	factory
155798	2021-11-17 06:22:53	\N	8332834	factory
155799	2021-12-01 06:27:51	2021-12-01 15:31:24	8332834	factory
155800	2021-12-02 06:31:23	2021-12-02 15:33:56	8332834	factory
155801	2021-12-03 06:42:55	2021-12-03 15:33:11	8332834	factory
155802	2021-12-06 06:31:16	2021-12-06 15:33:02	8332834	factory
155803	2021-12-07 06:28:48	2021-12-07 15:31:45	8332834	factory
155804	2021-12-08 06:28:04	2021-12-08 15:32:32	8332834	factory
155805	2021-12-09 06:32:26	2021-12-09 15:33:32	8332834	factory
155806	2021-12-10 06:33:24	2021-12-10 15:01:36	8332834	factory
155807	2021-12-13 06:31:45	2021-12-13 15:33:46	8332834	factory
155808	2021-12-14 06:31:58	2021-12-14 15:31:40	8332834	factory
155809	2021-12-15 06:30:18	2021-12-15 15:33:23	8332834	factory
155810	2021-12-16 06:34:51	2021-12-16 15:34:53	8332834	factory
155811	2021-12-17 06:40:00	2021-12-17 15:32:05	8332834	factory
155812	2021-12-20 06:33:10	2021-12-20 15:33:36	8332834	factory
155813	2021-12-21 06:23:57	2021-12-21 15:36:54	8332834	factory
155814	2021-12-22 06:30:59	2021-12-22 15:33:32	8332834	factory
155815	2021-12-23 06:34:56	2021-12-23 15:34:11	8332834	factory
155816	2021-12-24 06:34:59	2021-12-24 15:33:19	8332834	factory
155817	2021-12-27 06:29:39	2021-12-27 15:33:08	8332834	factory
155818	2021-12-28 06:12:11	2021-12-28 15:36:07	8332834	factory
155819	2021-12-29 10:54:32	\N	8332834	factory
155820	2022-01-04 06:25:06	2022-01-04 14:32:13	8332834	factory
155821	2022-01-05 06:36:55	2022-01-05 14:30:01	8332834	factory
155822	2022-01-10 06:33:11	2022-01-10 15:32:56	8332834	factory
155823	2022-01-11 06:35:52	2022-01-11 15:36:01	8332834	factory
155824	2022-01-12 06:36:37	2022-01-12 15:33:53	8332834	factory
155825	2022-01-13 06:39:22	2022-01-13 15:33:26	8332834	factory
155826	2022-01-14 15:34:17	\N	8332834	factory
155827	2022-01-17 06:38:17	2022-01-17 15:34:01	8332834	factory
155828	2022-01-18 06:31:30	2022-01-18 15:33:32	8332834	factory
155829	2022-01-19 06:42:09	2022-01-19 15:36:04	8332834	factory
155830	2022-01-20 06:31:32	2022-01-20 15:33:30	8332834	factory
155831	2022-01-21 06:35:44	2022-01-21 15:34:30	8332834	factory
155832	2022-01-24 06:29:29	2022-01-24 15:33:43	8332834	factory
155833	2022-01-25 06:32:39	2022-01-25 15:35:42	8332834	factory
155834	2022-01-26 06:38:36	2022-01-26 15:33:31	8332834	factory
155835	2022-01-27 06:31:11	2022-01-27 15:31:41	8332834	factory
155836	2022-01-28 06:35:17	2022-01-28 15:04:25	8332834	factory
155837	2022-01-31 06:33:26	2022-01-31 15:33:24	8332834	factory
155838	2022-02-01 06:38:32	2022-02-01 15:31:26	8332834	factory
155839	2022-02-02 06:39:05	2022-02-02 15:31:35	8332834	factory
155840	2022-02-03 06:35:35	2022-02-03 15:33:27	8332834	factory
155841	2022-02-04 06:15:00	2022-02-04 15:34:46	8332834	factory
155842	2022-02-07 06:25:57	2022-02-07 15:32:42	8332834	factory
155843	2022-02-08 06:31:42	2022-02-08 15:33:35	8332834	factory
155844	2022-02-09 06:26:52	2022-02-09 15:35:10	8332834	factory
155845	2022-02-10 06:31:41	2022-02-10 15:35:25	8332834	factory
155846	2022-02-11 06:36:07	2022-02-11 15:07:25	8332834	factory
155847	2022-02-14 06:25:20	2022-02-14 15:34:27	8332834	factory
155848	2022-02-15 06:36:33	2022-02-15 15:35:23	8332834	factory
155849	2022-02-16 06:25:10	2022-02-16 15:34:51	8332834	factory
155850	2022-02-17 06:24:40	2022-02-17 15:34:20	8332834	factory
155851	2022-02-18 06:27:26	2022-02-18 15:34:45	8332834	factory
155852	2022-02-21 06:28:14	2022-02-21 15:31:30	8332834	factory
155853	2022-02-22 06:32:26	2022-02-22 15:37:43	8332834	factory
155854	2022-02-23 06:37:34	2022-02-23 15:32:10	8332834	factory
155855	2022-02-24 06:12:17	2022-02-24 15:35:51	8332834	factory
155856	2022-02-25 06:34:21	2022-02-25 14:35:53	8332834	factory
155857	2022-02-28 06:15:52	2022-02-28 15:34:42	8332834	factory
155858	2022-03-01 06:31:01	2022-03-01 15:34:21	8332834	factory
155859	2021-11-17 14:31:18	\N	8332864	factory
155860	2021-12-01 05:23:12	2021-12-01 14:29:14	8332864	factory
155861	2021-12-02 05:47:53	2021-12-02 14:30:36	8332864	factory
155862	2021-12-03 05:34:51	2021-12-03 14:30:48	8332864	factory
155863	2021-12-04 05:35:15	2021-12-04 12:00:20	8332864	factory
155864	2021-12-06 14:06:45	2021-12-06 21:59:34	8332864	factory
155865	2021-12-07 14:02:46	2021-12-07 20:59:56	8332864	factory
155866	2021-12-08 14:06:50	\N	8332864	factory
155867	2021-12-09 05:44:59	2021-12-09 13:51:09	8332864	factory
155868	2021-12-09 20:51:44	\N	8332864	factory
155869	2021-12-10 14:11:25	2021-12-10 20:58:56	8332864	factory
155870	2021-12-13 05:52:20	2021-12-13 14:31:29	8332864	factory
155871	2021-12-14 05:51:50	2021-12-14 14:30:11	8332864	factory
155872	2021-12-15 05:55:59	2021-12-15 14:32:03	8332864	factory
155873	2021-12-16 05:54:45	2021-12-16 14:30:11	8332864	factory
155874	2021-12-17 05:55:59	2021-12-17 14:29:37	8332864	factory
155875	2021-12-18 05:50:57	2021-12-18 11:59:33	8332864	factory
155876	2021-12-20 14:03:07	2021-12-20 20:57:00	8332864	factory
155877	2021-12-21 13:40:13	2021-12-21 21:21:44	8332864	factory
155878	2021-12-22 13:58:00	\N	8332864	factory
155879	2021-12-23 05:39:07	2021-12-23 14:00:28	8332864	factory
155880	2021-12-23 21:08:59	\N	8332864	factory
155881	2021-12-24 14:10:00	\N	8332864	factory
155882	2021-12-25 04:57:59	2021-12-25 13:09:51	8332864	factory
155883	2021-12-25 20:00:34	\N	8332864	factory
155884	2021-12-27 06:52:13	2021-12-27 14:32:28	8332864	factory
155885	2021-12-28 05:45:04	2021-12-28 14:30:51	8332864	factory
155886	2021-12-29 07:01:43	2021-12-29 11:00:09	8332864	factory
155887	2022-01-04 14:11:08	2022-01-04 21:09:01	8332864	factory
155888	2022-01-05 14:06:49	2022-01-05 22:00:14	8332864	factory
155889	2022-01-06 12:46:36	2022-01-06 19:59:06	8332864	factory
155890	2022-01-10 05:45:41	2022-01-10 14:30:37	8332864	factory
155891	2022-01-11 05:23:25	2022-01-11 14:30:37	8332864	factory
155892	2022-01-12 10:32:15	2022-01-12 14:46:04	8332864	factory
155893	2022-01-13 05:23:51	2022-01-13 14:31:49	8332864	factory
155894	2022-01-14 05:28:16	2022-01-14 14:30:22	8332864	factory
155895	2022-01-15 05:48:48	2022-01-15 12:00:52	8332864	factory
155896	2022-01-17 14:06:45	2022-01-17 21:02:00	8332864	factory
155897	2022-01-19 14:22:35	2022-01-19 21:11:58	8332864	factory
155898	2022-01-20 13:54:30	\N	8332864	factory
155899	2022-01-21 05:33:08	2022-01-21 14:03:21	8332864	factory
155900	2022-01-21 21:01:31	\N	8332864	factory
155901	2022-01-24 05:50:35	2022-01-24 14:32:56	8332864	factory
155902	2022-01-25 05:55:32	2022-01-25 14:32:53	8332864	factory
155903	2022-01-26 05:53:45	2022-01-26 14:32:23	8332864	factory
155904	2022-01-27 05:56:23	2022-01-27 14:37:34	8332864	factory
155905	2022-01-28 05:21:55	2022-01-28 14:30:48	8332864	factory
155906	2022-01-29 05:49:23	2022-01-29 12:00:06	8332864	factory
155907	2022-01-31 13:18:25	2022-01-31 23:00:12	8332864	factory
155908	2022-02-02 14:00:05	2022-02-02 20:59:53	8332864	factory
155909	2022-02-03 14:04:09	2022-02-03 20:58:52	8332864	factory
155910	2022-02-04 13:08:35	2022-02-04 20:43:51	8332864	factory
155911	2022-02-05 05:44:25	2022-02-05 12:03:41	8332864	factory
155912	2022-02-07 05:55:43	2022-02-07 14:32:06	8332864	factory
155913	2022-02-08 05:53:55	2022-02-08 18:36:54	8332864	factory
155914	2022-02-09 05:27:08	2022-02-09 17:33:49	8332864	factory
155915	2022-02-10 05:58:01	2022-02-10 15:33:14	8332864	factory
155916	2022-02-11 05:35:22	2022-02-11 15:31:06	8332864	factory
155917	2022-02-12 05:31:34	2022-02-12 11:59:48	8332864	factory
155918	2022-02-14 05:55:23	2022-02-14 17:41:53	8332864	factory
155919	2022-02-15 07:00:15	\N	8332864	factory
155920	2022-02-16 05:54:14	2022-02-16 15:35:57	8332864	factory
155921	2022-02-17 05:40:01	2022-02-17 18:24:46	8332864	factory
155922	2022-02-18 06:15:22	2022-02-18 17:53:41	8332864	factory
155923	2022-02-19 05:46:16	2022-02-19 11:50:24	8332864	factory
155924	2022-02-21 06:00:01	2022-02-21 14:39:38	8332864	factory
155925	2022-02-22 05:29:10	2022-02-22 15:38:48	8332864	factory
155926	2022-02-23 05:30:49	2022-02-23 14:14:49	8332864	factory
155927	2022-02-24 05:23:44	2022-02-24 17:37:15	8332864	factory
155928	2022-02-25 05:47:27	2022-02-25 14:31:35	8332864	factory
155929	2022-02-26 07:58:28	\N	8332864	factory
155930	2022-02-28 13:02:59	2022-02-28 21:35:20	8332864	factory
155931	2022-03-01 06:01:11	2022-03-01 15:34:27	8332864	factory
155932	2021-12-01 14:21:27	2021-12-01 23:00:47	8332889	factory
155933	2021-12-02 14:22:50	2021-12-02 23:00:16	8332889	factory
155934	2021-12-03 14:19:56	2021-12-03 23:01:40	8332889	factory
155935	2021-12-06 05:53:23	2021-12-06 14:30:30	8332889	factory
155936	2021-12-07 05:54:49	2021-12-07 14:30:55	8332889	factory
155937	2021-12-08 05:56:10	2021-12-08 14:31:08	8332889	factory
155938	2021-12-09 05:53:35	2021-12-09 14:30:03	8332889	factory
155939	2021-12-10 05:54:21	2021-12-10 14:37:21	8332889	factory
155940	2021-12-13 14:24:00	2021-12-13 23:01:24	8332889	factory
155941	2021-12-14 14:18:39	2021-12-14 23:03:05	8332889	factory
155942	2021-12-15 14:26:13	2021-12-15 23:00:34	8332889	factory
155943	2021-12-16 14:27:15	2021-12-17 01:01:01	8332889	factory
155944	2021-12-17 14:26:47	2021-12-17 23:00:20	8332889	factory
155945	2021-12-20 05:58:15	2021-12-20 14:35:24	8332889	factory
155946	2021-12-21 05:49:33	2021-12-21 14:30:07	8332889	factory
155947	2021-12-22 05:48:37	2021-12-22 14:37:13	8332889	factory
155948	2021-12-23 05:54:47	2021-12-23 14:39:13	8332889	factory
155949	2021-12-24 14:22:47	2021-12-24 23:00:06	8332889	factory
155950	2021-12-25 05:54:28	2021-12-25 13:30:09	8332889	factory
155951	2021-12-27 14:25:26	2021-12-28 01:02:28	8332889	factory
155952	2021-12-28 14:26:13	2021-12-28 22:08:36	8332889	factory
155953	2021-12-29 06:54:20	2021-12-29 10:21:15	8332889	factory
155954	2022-01-04 05:56:13	2022-01-04 14:30:16	8332889	factory
155955	2022-01-05 05:52:19	2022-01-05 14:30:13	8332889	factory
155956	2022-01-06 05:47:26	2022-01-06 13:30:54	8332889	factory
155957	2022-01-10 14:24:59	2022-01-11 01:03:50	8332889	factory
155958	2022-01-11 14:26:55	2022-01-11 23:00:40	8332889	factory
155959	2022-01-12 14:25:35	2022-01-13 01:02:11	8332889	factory
155960	2022-01-13 14:23:57	2022-01-13 23:00:50	8332889	factory
155961	2022-01-14 14:19:27	2022-01-14 23:02:45	8332889	factory
155962	2022-01-17 05:57:06	2022-01-17 14:30:18	8332889	factory
155963	2022-01-18 05:53:09	2022-01-18 14:30:18	8332889	factory
155964	2022-01-19 05:51:41	2022-01-19 14:30:19	8332889	factory
155965	2022-01-20 05:49:20	2022-01-20 14:30:21	8332889	factory
155966	2022-01-21 05:53:35	2022-01-21 14:30:50	8332889	factory
155967	2022-01-22 05:49:28	2022-01-22 12:03:48	8332889	factory
155968	2022-01-24 14:24:45	2022-01-24 23:01:48	8332889	factory
155969	2022-01-25 05:55:27	2022-01-25 14:30:21	8332889	factory
155970	2022-01-26 05:52:36	2022-01-26 14:31:12	8332889	factory
155971	2022-01-27 05:56:20	2022-01-27 14:30:43	8332889	factory
155972	2022-01-28 05:50:29	2022-01-28 14:30:45	8332889	factory
155973	2022-01-29 05:48:59	2022-01-29 12:09:28	8332889	factory
155974	2022-01-31 05:49:55	2022-01-31 14:31:13	8332889	factory
155975	2022-02-01 05:48:46	2022-02-01 14:30:40	8332889	factory
155976	2022-02-02 14:21:59	2022-02-02 23:00:10	8332889	factory
155977	2022-02-03 14:24:33	2022-02-03 23:00:08	8332889	factory
155978	2022-02-04 14:26:50	2022-02-04 23:00:22	8332889	factory
155979	2022-02-07 05:47:57	2022-02-07 14:30:25	8332889	factory
155980	2022-02-08 05:51:50	2022-02-08 14:33:10	8332889	factory
155981	2022-02-09 05:55:21	2022-02-09 14:30:24	8332889	factory
155982	2022-02-10 05:55:06	2022-02-10 14:31:09	8332889	factory
155983	2022-02-11 05:55:45	2022-02-11 14:31:33	8332889	factory
155984	2022-02-14 14:25:05	2022-02-14 23:00:59	8332889	factory
155985	2022-02-15 15:19:52	2022-02-16 00:00:20	8332889	factory
155986	2022-02-16 14:25:56	2022-02-16 23:00:15	8332889	factory
155987	2022-02-17 14:24:12	2022-02-17 23:00:36	8332889	factory
155988	2022-02-18 14:18:36	2022-02-18 23:00:48	8332889	factory
155989	2022-02-21 05:55:36	2022-02-21 14:38:27	8332889	factory
155990	2022-02-22 05:54:00	2022-02-22 14:35:23	8332889	factory
155991	2022-02-23 05:52:48	2022-02-23 14:30:40	8332889	factory
155992	2022-02-24 05:56:34	2022-02-24 14:30:11	8332889	factory
155993	2022-02-25 05:51:48	2022-02-25 13:30:14	8332889	factory
155994	2022-02-28 14:27:21	2022-02-28 23:00:12	8332889	factory
155995	2022-03-01 14:19:09	2022-03-02 01:00:26	8332889	factory
155996	2021-12-01 06:40:59	2021-12-01 15:41:20	11021242	factory
155997	2021-12-02 06:13:40	2021-12-02 17:17:01	11021242	factory
155998	2021-12-03 09:48:40	2021-12-03 17:06:41	11021242	factory
155999	2021-12-06 07:13:17	2021-12-06 17:34:32	11021242	factory
156000	2021-12-07 06:38:48	2021-12-07 16:37:45	11021242	factory
156001	2021-12-08 06:47:47	2021-12-08 16:17:34	11021242	factory
156002	2021-12-09 07:15:12	2021-12-09 15:32:40	11021242	factory
156003	2021-12-10 07:10:32	2021-12-10 15:04:50	11021242	factory
156004	2021-12-13 06:48:20	2021-12-13 15:32:12	11021242	factory
156005	2021-12-14 06:52:08	2021-12-14 15:39:29	11021242	factory
156006	2021-12-15 06:49:41	2021-12-15 15:40:24	11021242	factory
156007	2021-12-16 07:27:55	2021-12-16 15:32:15	11021242	factory
156008	2021-12-17 06:06:41	2021-12-17 15:23:24	11021242	factory
156009	2021-12-20 07:11:41	2021-12-20 15:32:35	11021242	factory
156010	2021-12-21 06:36:32	2021-12-21 15:30:35	11021242	factory
156011	2021-12-22 07:02:31	2021-12-22 15:34:08	11021242	factory
156012	2021-12-23 07:29:36	2021-12-23 15:31:50	11021242	factory
156013	2021-12-24 06:56:11	2021-12-24 15:31:40	11021242	factory
156014	2021-12-25 07:05:14	2021-12-25 14:26:33	11021242	factory
156015	2021-12-27 07:06:32	2021-12-27 15:33:25	11021242	factory
156016	2021-12-28 07:08:59	2021-12-28 15:31:34	11021242	factory
156017	2021-12-29 07:28:09	2021-12-29 10:12:58	11021242	factory
156018	2022-01-04 06:45:55	2022-01-04 12:15:21	11021242	factory
156019	2022-01-05 06:44:04	2022-01-05 14:32:02	11021242	factory
156020	2022-01-06 07:26:28	2022-01-06 13:25:23	11021242	factory
156021	2022-01-10 06:39:05	2022-01-10 17:51:32	11021242	factory
156022	2022-01-11 06:39:09	2022-01-11 15:44:08	11021242	factory
156023	2022-01-12 06:28:44	2022-01-12 17:05:05	11021242	factory
156024	2022-01-13 06:35:13	2022-01-13 15:34:12	11021242	factory
156025	2022-01-14 05:53:47	2022-01-14 18:03:10	11021242	factory
156026	2022-01-15 06:05:46	2022-01-15 12:09:21	11021242	factory
156027	2022-01-17 06:50:03	2022-01-17 15:46:35	11021242	factory
156028	2022-01-18 07:00:40	2022-01-18 16:07:52	11021242	factory
156029	2022-01-19 06:41:45	2022-01-19 15:28:35	11021242	factory
156030	2022-01-20 05:51:30	2022-01-20 16:22:33	11021242	factory
156031	2022-01-21 05:53:55	2022-01-21 15:34:41	11021242	factory
156032	2022-01-24 06:28:03	2022-01-24 15:32:18	11021242	factory
156033	2022-01-25 05:55:48	2022-01-25 17:55:56	11021242	factory
156034	2022-01-26 06:34:29	2022-01-26 17:12:49	11021242	factory
156035	2022-01-27 06:42:02	2022-01-27 17:57:04	11021242	factory
156036	2022-01-28 06:47:09	2022-01-28 16:14:48	11021242	factory
156037	2022-01-31 06:06:56	2022-01-31 15:39:01	11021242	factory
156038	2022-02-01 06:57:23	2022-02-01 15:38:11	11021242	factory
156039	2022-02-02 06:58:50	2022-02-02 15:51:10	11021242	factory
156040	2022-02-03 06:21:30	2022-02-03 16:03:05	11021242	factory
156041	2022-02-04 06:13:33	2022-02-04 12:20:55	11021242	factory
156042	2022-02-05 06:37:16	2022-02-05 11:41:58	11021242	factory
156043	2022-02-07 06:52:07	2022-02-07 17:23:45	11021242	factory
156044	2022-02-08 06:58:40	2022-02-08 17:04:23	11021242	factory
156045	2022-02-09 07:02:16	2022-02-09 17:04:25	11021242	factory
156046	2022-02-10 07:20:10	2022-02-10 17:53:05	11021242	factory
156047	2022-02-11 07:09:52	2022-02-11 18:12:24	11021242	factory
156048	2022-02-12 06:27:39	2022-02-12 12:02:34	11021242	factory
156049	2022-02-14 07:19:38	2022-02-14 17:34:03	11021242	factory
156050	2022-02-15 07:21:07	2022-02-15 17:34:17	11021242	factory
156051	2022-02-16 06:35:21	2022-02-16 16:51:26	11021242	factory
156052	2022-02-17 06:37:11	2022-02-17 15:54:27	11021242	factory
156053	2022-02-18 10:09:09	2022-02-18 18:06:38	11021242	factory
156054	2022-02-19 06:37:00	2022-02-19 11:50:33	11021242	factory
156055	2022-02-21 06:45:01	2022-02-21 18:00:46	11021242	factory
156056	2022-02-22 06:01:46	2022-02-22 16:55:30	11021242	factory
156057	2022-02-23 06:53:02	2022-02-23 15:36:51	11021242	factory
156058	2022-02-24 06:37:00	2022-02-24 18:01:01	11021242	factory
156059	2022-02-25 07:02:25	2022-02-25 19:01:18	11021242	factory
156060	2022-02-26 07:18:32	2022-02-26 12:03:51	11021242	factory
156061	2022-02-28 06:56:03	2022-02-28 16:39:59	11021242	factory
156062	2022-03-01 06:37:39	2022-03-01 16:58:37	11021242	factory
156063	2021-11-16 05:20:31	2021-11-16 14:21:47	11110579	factory
156064	2021-11-17 05:28:36	2021-11-17 14:24:30	11110579	factory
156065	2021-11-18 05:19:55	2021-11-18 14:22:27	11110579	factory
156066	2021-11-19 05:21:23	2021-11-19 14:28:33	11110579	factory
156067	2021-11-22 05:24:41	2021-11-22 14:23:18	11110579	factory
156068	2021-11-23 05:25:33	2021-11-23 14:25:18	11110579	factory
156069	2021-11-24 05:27:04	2021-11-24 14:39:54	11110579	factory
156070	2021-11-25 05:20:17	2021-11-25 14:26:24	11110579	factory
156071	2021-11-26 05:15:54	2021-11-26 14:23:46	11110579	factory
156072	2021-11-29 05:21:23	2021-11-29 14:24:36	11110579	factory
156073	2021-11-30 05:23:33	2021-11-30 14:23:52	11110579	factory
156074	2021-12-01 05:19:12	2021-12-01 14:23:32	11110579	factory
156075	2021-12-02 05:19:33	2021-12-02 14:21:05	11110579	factory
156076	2021-12-03 05:33:37	2021-12-03 14:22:22	11110579	factory
156077	2021-12-06 05:33:33	2021-12-06 14:22:36	11110579	factory
156078	2021-12-07 05:33:02	2021-12-07 14:23:31	11110579	factory
156079	2021-12-08 05:28:01	2021-12-08 14:25:07	11110579	factory
156080	2021-12-09 05:35:52	2021-12-09 14:23:05	11110579	factory
156081	2021-12-10 05:24:05	2021-12-10 14:22:39	11110579	factory
156082	2021-12-13 05:22:31	2021-12-13 14:22:15	11110579	factory
156083	2021-12-14 05:23:21	2021-12-14 14:22:21	11110579	factory
156084	2021-12-15 05:32:47	2021-12-15 14:22:55	11110579	factory
156085	2021-12-16 05:24:49	2021-12-16 14:24:53	11110579	factory
156086	2021-12-17 05:27:44	2021-12-17 14:23:31	11110579	factory
156087	2021-12-18 05:32:22	2021-12-18 11:12:15	11110579	factory
156088	2021-12-20 05:26:14	2021-12-20 14:24:26	11110579	factory
156089	2021-12-21 05:15:25	2021-12-21 14:21:54	11110579	factory
156090	2021-12-22 05:22:50	2021-12-22 14:22:52	11110579	factory
156091	2021-12-23 05:28:23	2021-12-23 14:23:56	11110579	factory
156092	2021-12-24 05:18:29	2021-12-24 14:22:12	11110579	factory
156093	2021-12-25 05:35:53	2021-12-25 14:22:12	11110579	factory
156094	2021-12-27 05:26:52	2021-12-27 14:24:42	11110579	factory
156095	2021-12-28 05:21:38	2021-12-28 14:23:50	11110579	factory
156096	2021-12-29 05:18:47	2021-12-29 10:12:41	11110579	factory
156097	2022-01-04 06:05:34	2022-01-04 13:52:49	11110579	factory
156098	2022-01-05 05:42:05	2022-01-05 13:54:07	11110579	factory
156099	2022-01-06 05:42:58	2022-01-06 11:59:53	11110579	factory
156100	2022-01-10 05:36:31	2022-01-10 14:23:35	11110579	factory
156101	2022-01-11 05:26:03	2022-01-11 14:23:03	11110579	factory
156102	2022-01-12 05:22:41	2022-01-12 14:24:29	11110579	factory
156103	2022-01-13 05:21:59	2022-01-13 14:23:00	11110579	factory
156104	2022-01-14 05:19:45	\N	11110579	factory
156105	2022-01-17 05:25:58	2022-01-17 14:23:53	11110579	factory
156106	2022-01-18 05:24:45	2022-01-18 14:21:41	11110579	factory
156107	2022-01-19 05:26:32	2022-01-19 14:23:29	11110579	factory
156108	2022-01-20 05:27:28	2022-01-20 14:22:02	11110579	factory
156109	2022-01-21 05:28:10	\N	11110579	factory
156110	2022-01-22 05:33:36	2022-01-22 11:36:32	11110579	factory
156111	2022-01-24 05:29:19	2022-01-24 14:26:41	11110579	factory
156112	2022-01-25 05:29:28	2022-01-25 14:25:15	11110579	factory
156113	2022-01-26 05:18:09	2022-01-26 14:24:07	11110579	factory
156114	2022-01-27 05:27:12	2022-01-27 14:24:15	11110579	factory
156115	2022-01-28 05:20:25	2022-01-28 14:24:21	11110579	factory
156116	2022-01-31 05:33:11	2022-01-31 14:23:26	11110579	factory
156117	2022-02-01 05:32:32	2022-02-01 14:22:45	11110579	factory
156118	2022-02-02 05:28:02	2022-02-02 14:19:48	11110579	factory
156119	2022-02-03 05:19:46	2022-02-03 14:23:46	11110579	factory
156120	2022-02-04 05:15:02	2022-02-04 14:23:28	11110579	factory
156121	2022-02-05 05:39:26	2022-02-05 11:26:40	11110579	factory
156122	2022-02-07 05:18:56	2022-02-07 14:25:01	11110579	factory
156123	2022-02-08 05:27:13	2022-02-08 14:23:10	11110579	factory
156124	2022-02-09 05:25:44	2022-02-09 14:24:13	11110579	factory
156125	2022-02-10 05:43:36	2022-02-10 14:22:16	11110579	factory
156126	2022-02-11 05:25:38	2022-02-11 14:21:11	11110579	factory
156127	2022-02-14 05:18:11	2022-02-14 14:24:59	11110579	factory
156128	2022-02-15 05:22:29	2022-02-15 14:23:44	11110579	factory
156129	2022-02-16 05:22:32	2022-02-16 14:24:03	11110579	factory
156130	2022-02-17 05:28:44	2022-02-17 14:24:41	11110579	factory
156131	2022-02-18 05:21:57	2022-02-18 14:24:55	11110579	factory
156132	2022-02-21 05:23:13	2022-02-21 14:23:37	11110579	factory
156133	2022-02-22 05:28:10	2022-02-22 14:24:24	11110579	factory
156134	2022-02-23 05:41:17	2022-02-23 14:25:49	11110579	factory
156135	2022-02-24 05:21:46	2022-02-24 14:24:21	11110579	factory
156136	2022-02-25 05:28:35	2022-02-25 13:14:24	11110579	factory
156137	2022-02-26 05:38:33	2022-02-26 12:05:19	11110579	factory
156138	2022-02-28 05:17:43	2022-02-28 14:24:10	11110579	factory
156139	2022-03-01 05:26:00	2022-03-01 14:23:37	11110579	factory
156140	2021-11-16 05:36:31	2021-11-16 05:49:18	11105690	factory
156141	2021-12-01 05:56:06	2021-12-01 15:29:53	11105690	factory
156142	2021-12-02 05:39:59	2021-12-02 15:30:07	11105690	factory
156143	2021-12-03 05:53:17	2021-12-03 15:30:21	11105690	factory
156144	2021-12-04 05:50:11	2021-12-04 12:03:29	11105690	factory
156145	2021-12-06 05:48:18	2021-12-06 15:32:48	11105690	factory
156146	2021-12-07 05:56:15	2021-12-07 15:32:15	11105690	factory
156147	2021-12-08 05:57:19	2021-12-08 15:30:08	11105690	factory
156148	2021-12-09 05:48:11	2021-12-09 05:56:43	11105690	factory
156149	2021-12-09 15:42:52	\N	11105690	factory
156150	2021-12-10 05:51:10	2021-12-10 15:30:21	11105690	factory
156151	2021-12-11 05:59:39	2021-12-11 12:00:45	11105690	factory
156152	2021-12-13 05:56:27	2021-12-13 15:30:14	11105690	factory
156153	2021-12-14 05:52:29	2021-12-14 15:29:50	11105690	factory
156154	2021-12-15 05:54:55	2021-12-15 15:30:29	11105690	factory
156155	2021-12-16 05:42:16	2021-12-16 15:30:16	11105690	factory
156156	2021-12-17 05:55:18	2021-12-17 15:32:01	11105690	factory
156157	2021-12-18 05:55:58	2021-12-18 12:01:29	11105690	factory
156158	2021-12-20 05:55:31	2021-12-20 15:30:22	11105690	factory
156159	2021-12-21 05:54:29	2021-12-21 15:30:08	11105690	factory
156160	2021-12-22 05:57:18	2021-12-22 15:30:23	11105690	factory
156161	2021-12-23 05:58:04	2021-12-23 15:30:15	11105690	factory
156162	2021-12-24 05:53:08	2021-12-24 15:30:00	11105690	factory
156163	2021-12-25 05:52:17	2021-12-25 13:30:19	11105690	factory
156164	2021-12-27 05:56:41	2021-12-27 15:30:27	11105690	factory
156165	2021-12-28 05:53:48	2021-12-28 14:30:26	11105690	factory
156166	2021-12-29 06:56:39	2021-12-29 10:08:47	11105690	factory
156167	2022-01-04 05:55:00	2022-01-04 14:30:13	11105690	factory
156168	2022-01-05 05:51:27	2022-01-05 14:32:29	11105690	factory
156169	2022-01-06 05:51:55	2022-01-06 13:30:28	11105690	factory
156170	2022-01-10 05:50:11	2022-01-10 15:30:02	11105690	factory
156171	2022-01-11 05:52:05	2022-01-11 15:30:40	11105690	factory
156172	2022-01-12 05:56:01	2022-01-12 15:30:29	11105690	factory
156173	2022-01-13 05:49:26	2022-01-13 15:30:30	11105690	factory
156174	2022-01-14 05:45:18	2022-01-14 15:30:24	11105690	factory
156175	2022-01-15 05:55:42	2022-01-15 12:01:13	11105690	factory
156176	2022-01-17 05:49:49	2022-01-17 17:27:03	11105690	factory
156177	2022-01-18 05:54:18	2022-01-18 16:26:01	11105690	factory
156178	2022-01-19 05:54:44	2022-01-19 16:34:11	11105690	factory
156179	2022-01-20 05:50:54	2022-01-20 15:30:05	11105690	factory
156180	2022-01-21 05:56:12	2022-01-21 15:30:04	11105690	factory
156181	2022-01-22 05:50:29	2022-01-22 12:04:50	11105690	factory
156182	2022-01-24 05:51:56	2022-01-24 15:30:31	11105690	factory
156183	2022-01-25 05:54:02	2022-01-25 15:30:15	11105690	factory
156184	2022-01-26 05:53:18	2022-01-26 15:30:41	11105690	factory
156185	2022-01-27 05:57:22	2022-01-27 15:30:31	11105690	factory
156186	2022-01-28 05:50:22	2022-01-28 11:35:52	11105690	factory
156187	2022-02-02 05:57:36	2022-02-02 15:34:08	11105690	factory
156188	2022-02-03 05:52:45	2022-02-03 15:34:25	11105690	factory
156189	2022-02-04 10:26:36	2022-02-04 15:30:24	11105690	factory
156190	2022-02-05 05:57:55	2022-02-05 12:01:23	11105690	factory
156191	2022-02-07 05:51:07	2022-02-07 15:35:30	11105690	factory
156192	2022-02-08 05:45:38	2022-02-08 15:40:15	11105690	factory
156193	2022-02-09 05:46:59	2022-02-09 15:37:36	11105690	factory
156194	2022-02-10 05:46:23	2022-02-10 15:37:13	11105690	factory
156195	2022-02-11 05:50:36	2022-02-11 15:36:20	11105690	factory
156196	2022-02-12 05:56:00	2022-02-12 12:03:35	11105690	factory
156197	2022-02-14 05:43:27	2022-02-14 15:36:24	11105690	factory
156198	2022-02-15 05:46:51	2022-02-15 15:36:02	11105690	factory
156199	2022-02-16 05:53:01	2022-02-16 15:30:53	11105690	factory
156200	2022-02-17 05:41:20	2022-02-17 15:34:56	11105690	factory
156201	2022-02-28 05:42:54	2022-02-28 15:35:16	11105690	factory
156202	2022-03-01 05:50:37	\N	11105690	factory
156203	2021-12-01 05:53:10	2021-12-01 19:28:03	11109430	factory
156204	2021-12-02 07:26:04	2021-12-02 18:50:28	11109430	factory
156205	2021-12-03 07:26:35	2021-12-03 18:07:55	11109430	factory
156206	2021-12-04 05:53:38	2021-12-04 10:51:34	11109430	factory
156207	2021-12-06 05:52:49	2021-12-06 15:31:03	11109430	factory
156208	2021-12-07 05:54:58	2021-12-07 15:30:15	11109430	factory
156209	2021-12-08 05:59:09	2021-12-08 15:30:14	11109430	factory
156210	2021-12-09 05:54:21	2021-12-09 15:30:27	11109430	factory
156211	2021-12-10 05:55:11	2021-12-10 15:30:04	11109430	factory
156212	2021-12-11 05:58:11	\N	11109430	factory
156213	2021-12-13 07:27:30	2021-12-13 18:50:36	11109430	factory
156214	2021-12-14 07:26:24	2021-12-14 16:03:51	11109430	factory
156215	2021-12-15 07:29:01	2021-12-15 15:30:06	11109430	factory
156216	2021-12-16 07:30:39	2021-12-16 16:10:52	11109430	factory
156217	2021-12-17 07:29:47	2021-12-17 15:30:16	11109430	factory
156218	2021-12-18 05:55:48	2021-12-18 12:00:02	11109430	factory
156219	2021-12-20 06:01:43	2021-12-20 15:30:24	11109430	factory
156220	2021-12-21 05:58:11	2021-12-21 15:30:05	11109430	factory
156221	2021-12-22 06:06:34	2021-12-22 15:30:29	11109430	factory
156222	2021-12-23 05:58:31	2021-12-23 15:30:38	11109430	factory
156223	2021-12-24 05:47:39	2021-12-24 16:33:00	11109430	factory
156224	2021-12-25 05:55:30	2021-12-25 13:30:11	11109430	factory
156225	2021-12-27 07:25:38	2021-12-27 17:46:52	11109430	factory
156226	2021-12-28 07:21:51	2021-12-28 15:29:49	11109430	factory
156227	2021-12-29 05:57:27	2021-12-29 11:00:11	11109430	factory
156228	2022-01-04 06:00:58	2022-01-04 14:44:05	11109430	factory
156229	2022-01-05 06:11:40	\N	11109430	factory
156230	2022-01-06 05:53:28	2022-01-06 13:33:50	11109430	factory
156231	2022-01-10 05:58:15	2022-01-10 15:29:56	11109430	factory
156232	2022-01-11 05:58:01	2022-01-11 15:29:59	11109430	factory
156233	2022-01-12 06:02:18	\N	11109430	factory
156234	2022-01-13 05:56:07	2022-01-13 16:30:31	11109430	factory
156235	2022-01-14 05:52:04	2022-01-14 19:35:41	11109430	factory
156236	2022-01-15 05:48:24	2022-01-15 11:54:16	11109430	factory
156237	2022-01-17 07:29:32	2022-01-17 19:29:51	11109430	factory
156238	2022-01-18 07:27:07	2022-01-18 19:30:01	11109430	factory
156239	2022-01-19 07:31:02	2022-01-19 19:27:05	11109430	factory
156240	2022-01-20 12:05:02	2022-01-20 20:04:52	11109430	factory
156241	2022-01-21 07:27:13	2022-01-21 18:00:37	11109430	factory
156242	2022-01-22 05:50:25	2022-01-22 11:18:28	11109430	factory
156243	2022-01-24 05:59:58	2022-01-24 16:27:17	11109430	factory
156244	2022-01-25 05:54:04	2022-01-25 15:31:02	11109430	factory
156245	2022-01-26 05:49:52	2022-01-26 15:30:51	11109430	factory
156246	2022-01-27 05:52:29	2022-01-27 15:33:12	11109430	factory
156247	2022-01-28 05:59:13	2022-01-28 14:32:49	11109430	factory
156248	2022-01-29 06:15:15	2022-01-29 12:00:03	11109430	factory
156249	2022-01-31 07:24:42	2022-01-31 15:29:39	11109430	factory
156250	2022-02-01 07:26:46	2022-02-01 19:48:57	11109430	factory
156251	2022-02-02 07:28:39	2022-02-02 18:32:25	11109430	factory
156252	2022-02-03 07:29:04	2022-02-03 18:31:13	11109430	factory
156253	2022-02-04 07:26:20	\N	11109430	factory
156254	2022-02-05 06:00:59	2022-02-05 12:01:46	11109430	factory
156255	2022-02-07 05:56:53	2022-02-07 15:30:57	11109430	factory
156256	2022-02-08 05:58:27	2022-02-08 16:25:45	11109430	factory
156257	2022-02-09 05:59:37	2022-02-09 18:24:53	11109430	factory
156258	2022-02-10 06:00:54	\N	11109430	factory
156259	2022-02-11 05:49:08	2022-02-11 15:31:49	11109430	factory
156260	2022-02-12 06:03:46	2022-02-12 11:58:48	11109430	factory
156261	2022-02-14 07:27:10	2022-02-14 18:14:55	11109430	factory
156262	2022-02-15 07:27:35	2022-02-15 18:27:43	11109430	factory
156263	2022-02-16 07:27:43	\N	11109430	factory
156264	2022-02-17 07:27:26	2022-02-17 18:24:42	11109430	factory
156265	2022-02-18 07:27:11	2022-02-18 17:53:34	11109430	factory
156266	2022-02-19 06:32:35	2022-02-19 11:50:23	11109430	factory
156267	2022-02-21 05:53:35	2022-02-21 15:34:51	11109430	factory
156268	2022-02-22 05:53:33	2022-02-22 14:01:35	11109430	factory
156269	2022-02-23 05:55:17	2022-02-23 14:33:34	11109430	factory
156270	2022-02-24 05:56:19	2022-02-24 15:36:22	11109430	factory
156271	2022-02-25 05:55:03	2022-02-25 18:28:52	11109430	factory
156272	2022-02-26 05:57:12	2022-02-26 11:42:29	11109430	factory
156273	2022-02-28 05:56:30	2022-02-28 18:23:04	11109430	factory
156274	2022-03-01 07:27:05	2022-03-01 18:10:05	11109430	factory
156275	2021-11-16 14:17:49	2021-11-16 23:02:15	11123939	factory
156276	2021-11-17 14:22:16	2021-11-17 23:00:15	11123939	factory
156277	2021-11-18 14:21:12	2021-11-18 23:00:19	11123939	factory
156278	2021-11-30 23:00:13	\N	11123939	factory
156279	2021-12-01 16:27:46	2021-12-01 23:00:15	11123939	factory
156280	2021-12-02 14:16:58	2021-12-02 23:00:07	11123939	factory
156281	2021-12-03 14:21:12	2021-12-03 23:01:05	11123939	factory
156282	2021-12-06 05:56:32	2021-12-06 14:30:23	11123939	factory
156283	2021-12-07 05:57:50	2021-12-07 14:30:44	11123939	factory
156284	2021-12-08 05:58:36	2021-12-08 14:31:46	11123939	factory
156285	2021-12-09 05:56:50	2021-12-09 14:31:06	11123939	factory
156286	2021-12-10 14:25:09	2021-12-10 23:00:44	11123939	factory
156287	2021-12-13 14:23:51	2021-12-14 01:01:38	11123939	factory
156288	2021-12-14 14:26:06	2021-12-15 01:00:11	11123939	factory
156289	2021-12-15 14:29:57	2021-12-16 01:01:45	11123939	factory
156290	2021-12-16 14:22:28	2021-12-17 01:00:10	11123939	factory
156291	2021-12-17 14:27:07	2021-12-17 23:00:04	11123939	factory
156292	2021-12-20 06:00:02	2021-12-20 14:30:14	11123939	factory
156293	2021-12-21 06:00:51	2021-12-21 14:30:20	11123939	factory
156294	2021-12-22 05:59:01	2021-12-22 14:32:11	11123939	factory
156295	2021-12-23 06:00:08	2021-12-23 14:30:53	11123939	factory
156296	2021-12-24 05:58:22	2021-12-24 14:31:05	11123939	factory
156297	2021-12-25 06:03:26	2021-12-25 13:30:14	11123939	factory
156298	2021-12-27 05:57:04	2021-12-27 14:30:49	11123939	factory
156299	2021-12-28 14:23:43	2021-12-28 22:13:53	11123939	factory
156300	2021-12-29 07:06:59	\N	11123939	factory
156301	2022-01-04 05:57:45	2022-01-04 14:30:10	11123939	factory
156302	2022-01-05 05:57:18	2022-01-05 14:41:59	11123939	factory
156303	2022-01-06 05:56:31	2022-01-06 13:30:13	11123939	factory
156304	2022-01-10 14:16:23	2022-01-10 23:00:44	11123939	factory
156305	2022-01-11 14:10:16	2022-01-11 23:00:03	11123939	factory
156306	2022-01-12 14:17:29	2022-01-13 01:01:22	11123939	factory
156307	2022-01-13 14:15:05	2022-01-13 23:00:55	11123939	factory
156308	2022-01-14 14:23:14	2022-01-14 23:01:08	11123939	factory
156309	2022-01-17 05:55:42	2022-01-17 14:32:28	11123939	factory
156310	2022-01-18 05:58:57	2022-01-18 14:32:35	11123939	factory
156311	2022-01-19 06:00:13	2022-01-19 14:30:08	11123939	factory
156312	2022-01-20 07:56:24	2022-01-20 14:30:13	11123939	factory
156313	2022-01-21 05:54:04	2022-01-21 14:30:44	11123939	factory
156314	2022-01-22 05:55:52	2022-01-22 12:00:12	11123939	factory
156315	2022-01-24 14:21:33	2022-01-24 23:02:16	11123939	factory
156316	2022-01-25 14:21:26	2022-01-25 23:00:58	11123939	factory
156317	2022-01-26 14:32:57	2022-01-26 23:00:49	11123939	factory
156318	2022-01-27 14:20:08	2022-01-27 23:00:15	11123939	factory
156319	2022-01-28 14:20:36	2022-01-28 23:00:09	11123939	factory
156320	2022-02-01 06:00:32	2022-02-01 14:30:28	11123939	factory
156321	2022-02-02 05:59:54	2022-02-02 14:30:15	11123939	factory
156322	2022-02-03 05:58:38	2022-02-03 14:30:30	11123939	factory
156323	2022-02-04 06:03:28	2022-02-04 14:33:54	11123939	factory
156324	2022-02-07 14:22:39	2022-02-07 23:00:45	11123939	factory
156325	2022-02-08 14:20:29	2022-02-08 23:02:05	11123939	factory
156326	2022-02-09 14:19:13	2022-02-09 23:00:31	11123939	factory
156327	2022-02-10 14:16:59	2022-02-10 23:03:43	11123939	factory
156328	2022-02-11 14:23:26	2022-02-11 23:00:34	11123939	factory
156329	2022-02-14 06:02:30	2022-02-14 14:32:58	11123939	factory
156330	2022-02-15 05:56:46	2022-02-15 14:30:12	11123939	factory
156331	2022-02-16 06:25:38	2022-02-16 14:30:35	11123939	factory
156332	2022-02-17 05:59:03	2022-02-17 14:31:41	11123939	factory
156333	2022-02-18 05:58:39	2022-02-18 14:32:22	11123939	factory
156334	2022-02-19 05:58:35	2022-02-19 12:01:08	11123939	factory
156335	2022-02-21 14:12:44	2022-02-21 23:00:10	11123939	factory
156336	2022-02-22 14:18:15	2022-02-22 23:02:46	11123939	factory
156337	2022-02-23 07:59:00	2022-02-23 16:56:21	11123939	factory
156338	2022-02-24 14:12:22	2022-02-24 23:00:21	11123939	factory
156339	2022-02-25 13:19:50	2022-02-25 22:00:04	11123939	factory
156340	2022-02-28 05:57:41	2022-02-28 14:30:24	11123939	factory
156341	2022-03-01 05:58:59	2022-03-01 14:32:41	11123939	factory
156342	2021-11-22 06:36:49	\N	11117613	factory
156343	2021-12-01 06:53:51	2021-12-01 15:28:23	11117613	factory
156344	2021-12-02 06:55:34	2021-12-02 16:28:50	11117613	factory
156345	2021-12-03 06:48:53	2021-12-03 16:39:48	11117613	factory
156346	2021-12-06 07:01:52	2021-12-06 17:51:08	11117613	factory
156347	2021-12-07 06:56:11	2021-12-07 20:21:12	11117613	factory
156348	2021-12-08 06:51:17	2021-12-08 15:40:36	11117613	factory
156349	2021-12-09 06:55:30	2021-12-09 16:30:02	11117613	factory
156350	2021-12-10 06:43:38	2021-12-10 16:32:45	11117613	factory
156351	2021-12-13 06:40:24	2021-12-13 17:14:40	11117613	factory
156352	2021-12-14 06:42:58	2021-12-14 15:47:15	11117613	factory
156353	2021-12-15 07:03:05	2021-12-15 15:53:00	11117613	factory
156354	2021-12-16 07:00:11	2021-12-16 16:25:54	11117613	factory
156355	2021-12-17 06:50:54	2021-12-17 15:57:46	11117613	factory
156356	2021-12-20 07:06:46	2021-12-20 16:09:49	11117613	factory
156357	2021-12-21 07:01:50	2021-12-21 17:07:02	11117613	factory
156358	2021-12-22 06:44:44	2021-12-22 15:11:12	11117613	factory
156359	2021-12-23 07:31:05	2021-12-23 16:00:21	11117613	factory
156360	2021-12-24 10:25:09	2021-12-24 18:35:19	11117613	factory
156361	2021-12-25 07:08:00	2021-12-25 14:32:36	11117613	factory
156362	2021-12-27 07:00:49	2021-12-27 15:29:36	11117613	factory
156363	2021-12-28 06:47:23	2021-12-28 19:12:19	11117613	factory
156364	2021-12-29 06:36:25	2021-12-29 10:22:34	11117613	factory
156365	2022-01-04 06:49:41	2022-01-04 13:50:58	11117613	factory
156366	2022-01-05 07:20:17	2022-01-05 15:29:57	11117613	factory
156367	2022-01-06 06:56:07	2022-01-06 10:51:14	11117613	factory
156368	2022-01-10 07:04:38	2022-01-10 15:42:57	11117613	factory
156369	2022-01-11 07:09:55	2022-01-11 18:27:42	11117613	factory
156370	2022-01-12 06:53:40	2022-01-12 15:36:22	11117613	factory
156371	2022-01-13 06:40:34	2022-01-13 18:04:08	11117613	factory
156372	2022-01-14 06:53:04	2022-01-14 17:11:21	11117613	factory
156373	2022-01-15 07:17:41	2022-01-15 11:36:33	11117613	factory
156374	2022-01-17 06:38:56	2022-01-17 16:36:25	11117613	factory
156375	2022-01-18 06:49:39	2022-01-18 16:48:03	11117613	factory
156376	2022-01-19 06:44:00	2022-01-19 15:32:29	11117613	factory
156377	2022-01-20 06:35:49	2022-01-20 17:57:48	11117613	factory
156378	2022-01-21 07:06:38	2022-01-21 16:23:37	11117613	factory
156379	2022-01-22 07:54:50	2022-01-22 11:56:07	11117613	factory
156380	2022-01-24 07:13:13	2022-01-24 15:58:50	11117613	factory
156381	2022-01-25 06:49:25	2022-01-25 18:27:44	11117613	factory
156382	2022-01-26 06:52:59	2022-01-26 15:32:59	11117613	factory
156383	2022-01-27 06:52:39	2022-01-27 18:13:32	11117613	factory
156384	2022-01-28 07:09:35	2022-01-28 13:20:39	11117613	factory
156385	2022-01-29 07:07:25	2022-01-29 12:15:26	11117613	factory
156386	2022-01-31 07:04:56	2022-01-31 15:55:54	11117613	factory
156387	2022-02-01 07:07:15	2022-02-01 16:24:44	11117613	factory
156388	2022-02-02 07:00:13	2022-02-02 15:49:17	11117613	factory
156389	2022-02-03 06:58:57	2022-02-03 18:36:39	11117613	factory
156390	2022-02-04 06:52:18	2022-02-04 16:25:14	11117613	factory
156391	2022-02-05 08:01:08	2022-02-05 12:19:09	11117613	factory
156392	2022-02-07 06:56:41	2022-02-07 17:17:11	11117613	factory
156393	2022-02-08 06:53:28	2022-02-08 17:36:18	11117613	factory
156394	2022-02-09 06:56:08	2022-02-09 15:34:08	11117613	factory
156395	2022-02-10 07:20:31	2022-02-10 18:28:20	11117613	factory
156396	2022-02-11 07:14:38	2022-02-11 16:36:32	11117613	factory
156397	2022-02-12 07:42:25	2022-02-12 12:08:30	11117613	factory
156398	2022-02-14 15:46:48	\N	11117613	factory
156399	2022-02-15 07:06:35	2022-02-15 18:24:49	11117613	factory
156400	2022-02-16 07:08:01	2022-02-16 16:53:33	11117613	factory
156401	2022-02-17 06:46:53	2022-02-17 17:09:38	11117613	factory
156402	2022-02-18 17:16:52	\N	11117613	factory
156403	2022-02-21 06:50:34	2022-02-21 15:44:40	11117613	factory
156404	2022-02-22 06:51:40	2022-02-22 17:08:08	11117613	factory
156405	2022-02-23 07:05:16	2022-02-23 15:29:56	11117613	factory
156406	2022-02-24 06:56:15	2022-02-24 19:26:10	11117613	factory
156407	2022-02-25 06:47:03	2022-02-25 17:20:06	11117613	factory
156408	2022-02-26 07:11:16	2022-02-26 12:40:50	11117613	factory
156409	2022-02-28 06:36:37	2022-02-28 15:55:03	11117613	factory
156410	2022-03-01 06:50:40	2022-03-01 17:47:28	11117613	factory
156411	2021-12-01 05:51:50	2021-12-01 15:56:09	11115134	factory
156412	2021-12-02 06:58:44	2021-12-02 16:08:39	11115134	factory
156413	2021-12-03 05:52:33	2021-12-03 15:43:53	11115134	factory
156414	2021-12-06 05:43:01	2021-12-06 15:24:38	11115134	factory
156415	2021-12-07 07:01:23	2021-12-07 15:37:10	11115134	factory
156416	2021-12-08 05:45:19	2021-12-08 16:27:13	11115134	factory
156417	2021-12-09 07:07:48	2021-12-09 15:56:36	11115134	factory
156418	2021-12-10 07:23:04	2021-12-10 15:38:33	11115134	factory
156419	2021-12-13 07:30:23	2021-12-13 15:43:31	11115134	factory
156420	2021-12-14 07:05:12	2021-12-14 15:49:08	11115134	factory
156421	2021-12-15 06:01:27	2021-12-15 16:21:06	11115134	factory
156422	2021-12-16 07:03:11	2021-12-16 16:04:34	11115134	factory
156423	2021-12-17 07:20:16	2021-12-17 15:51:30	11115134	factory
156424	2021-12-20 07:13:58	2021-12-20 15:47:00	11115134	factory
156425	2021-12-21 07:09:46	2021-12-21 16:10:59	11115134	factory
156426	2021-12-22 07:37:58	2021-12-22 16:08:33	11115134	factory
156427	2021-12-23 07:19:39	2021-12-23 16:11:22	11115134	factory
156428	2021-12-24 07:26:32	2021-12-24 15:38:02	11115134	factory
156429	2021-12-25 07:14:35	2021-12-25 12:57:25	11115134	factory
156430	2021-12-27 07:25:22	2021-12-27 16:39:42	11115134	factory
156431	2021-12-28 07:13:05	2021-12-28 16:01:44	11115134	factory
156432	2021-12-29 07:22:31	\N	11115134	factory
156433	2022-01-06 07:16:50	\N	11115134	factory
156434	2022-01-10 07:53:23	2022-01-10 16:00:35	11115134	factory
156435	2022-01-11 07:22:48	2022-01-11 15:52:59	11115134	factory
156436	2022-01-12 07:42:22	2022-01-12 15:43:37	11115134	factory
156437	2022-01-13 07:04:58	2022-01-13 15:46:35	11115134	factory
156438	2022-01-14 07:15:29	2022-01-14 16:06:49	11115134	factory
156439	2022-01-17 07:17:29	2022-01-17 15:57:50	11115134	factory
156440	2022-01-18 07:05:16	2022-01-18 15:47:41	11115134	factory
156441	2022-01-19 06:11:27	2022-01-19 15:58:50	11115134	factory
156442	2022-01-20 07:09:09	2022-01-20 16:26:31	11115134	factory
156443	2022-01-24 07:20:48	2022-01-24 16:01:44	11115134	factory
156444	2022-01-25 07:20:20	2022-01-25 16:17:29	11115134	factory
156445	2022-01-26 05:43:48	2022-01-26 16:14:15	11115134	factory
156446	2022-01-27 07:08:26	2022-01-27 16:06:12	11115134	factory
156447	2022-01-31 05:46:05	2022-01-31 15:35:19	11115134	factory
156448	2022-02-01 06:57:00	2022-02-01 15:35:42	11115134	factory
156449	2022-02-02 05:35:29	2022-02-02 16:39:39	11115134	factory
156450	2022-02-03 05:48:23	2022-02-03 16:50:47	11115134	factory
156451	2022-02-04 05:32:54	2022-02-04 15:52:22	11115134	factory
156452	2022-02-05 07:38:30	2022-02-05 10:56:35	11115134	factory
156453	2022-02-07 05:39:20	2022-02-07 17:08:03	11115134	factory
156454	2022-02-08 07:01:32	2022-02-08 16:32:41	11115134	factory
156455	2022-02-09 05:34:18	2022-02-09 16:43:03	11115134	factory
157322	2021-12-13 07:04:10	\N	11009300	factory
156456	2022-02-10 07:08:04	2022-02-10 17:31:24	11115134	factory
156457	2022-02-11 05:29:30	2022-02-11 12:08:12	11115134	factory
156458	2022-02-14 06:55:37	2022-02-14 17:38:41	11115134	factory
156459	2022-02-15 07:08:48	2022-02-15 14:32:59	11115134	factory
156460	2022-02-16 05:39:20	2022-02-16 16:30:52	11115134	factory
156461	2022-02-17 07:05:12	2022-02-17 15:40:08	11115134	factory
156462	2022-02-18 05:37:50	2022-02-18 16:26:01	11115134	factory
156463	2022-02-21 05:37:40	2022-02-21 16:31:39	11115134	factory
156464	2022-02-22 07:03:51	2022-02-22 15:49:22	11115134	factory
156465	2022-02-23 05:37:40	2022-02-23 15:45:33	11115134	factory
156466	2022-02-24 07:02:16	2022-02-24 16:34:43	11115134	factory
156467	2022-02-25 05:53:01	2022-02-25 16:01:17	11115134	factory
156468	2022-02-26 07:08:06	2022-02-26 11:37:09	11115134	factory
156469	2022-02-28 07:41:15	2022-02-28 16:35:02	11115134	factory
156470	2022-03-01 07:11:50	2022-03-01 16:42:53	11115134	factory
156471	2021-11-16 05:58:07	\N	11002702	factory
156472	2021-11-30 14:31:15	\N	11002702	factory
156473	2021-12-01 05:56:11	2021-12-01 14:30:08	11002702	factory
156474	2021-12-02 05:57:30	2021-12-02 14:30:32	11002702	factory
156475	2021-12-03 05:56:59	2021-12-03 14:33:19	11002702	factory
156476	2021-12-04 06:01:36	2021-12-04 12:00:34	11002702	factory
156477	2021-12-06 14:13:54	2021-12-06 23:01:34	11002702	factory
156478	2021-12-07 14:16:36	2021-12-07 23:01:58	11002702	factory
156479	2021-12-08 14:14:38	2021-12-09 01:00:11	11002702	factory
156480	2021-12-09 14:18:09	2021-12-09 23:00:18	11002702	factory
156481	2021-12-10 14:12:58	2021-12-10 23:00:18	11002702	factory
156482	2021-12-11 05:57:18	2021-12-11 12:03:03	11002702	factory
156483	2021-12-13 05:58:59	2021-12-13 14:31:32	11002702	factory
156484	2021-12-14 05:55:59	2021-12-14 14:30:08	11002702	factory
156485	2021-12-15 05:58:24	2021-12-15 14:32:21	11002702	factory
156486	2021-12-16 05:58:25	2021-12-16 14:32:17	11002702	factory
156487	2021-12-17 05:55:47	2021-12-17 14:30:05	11002702	factory
156488	2021-12-18 05:56:43	2021-12-18 12:00:05	11002702	factory
156489	2021-12-20 14:19:03	2021-12-20 23:00:20	11002702	factory
156490	2021-12-21 14:14:12	2021-12-21 23:02:02	11002702	factory
156491	2021-12-22 14:19:23	\N	11002702	factory
156492	2021-12-23 05:05:07	2021-12-23 14:15:03	11002702	factory
156493	2021-12-23 23:00:34	2021-12-24 05:55:24	11002702	factory
156494	2021-12-24 14:31:05	\N	11002702	factory
156495	2021-12-25 13:11:10	2021-12-25 20:00:31	11002702	factory
156496	2021-12-27 05:56:08	2021-12-27 14:30:55	11002702	factory
156497	2021-12-28 05:56:46	2021-12-28 14:30:16	11002702	factory
156498	2021-12-29 06:51:35	\N	11002702	factory
156499	2022-01-04 14:17:14	2022-01-04 22:00:19	11002702	factory
156500	2022-01-05 14:17:17	2022-01-05 22:00:21	11002702	factory
156501	2022-01-06 13:17:50	2022-01-06 21:00:30	11002702	factory
156502	2022-01-10 05:59:08	2022-01-10 14:33:00	11002702	factory
156503	2022-01-11 05:55:11	2022-01-11 14:30:27	11002702	factory
156504	2022-01-12 05:56:45	2022-01-12 14:30:45	11002702	factory
156505	2022-01-13 05:56:53	2022-01-13 14:30:25	11002702	factory
156506	2022-01-14 05:58:19	2022-01-14 14:30:19	11002702	factory
156507	2022-01-17 14:14:54	2022-01-17 23:00:06	11002702	factory
156508	2022-01-18 14:20:48	2022-01-18 23:00:05	11002702	factory
156509	2022-01-19 23:00:04	\N	11002702	factory
156510	2022-01-20 14:20:04	2022-01-20 23:00:05	11002702	factory
156511	2022-01-21 14:19:07	2022-01-21 21:01:29	11002702	factory
156512	2022-01-24 05:59:32	2022-01-24 14:30:49	11002702	factory
156513	2022-01-25 14:17:19	2022-01-25 23:01:15	11002702	factory
156514	2022-01-26 14:23:56	2022-01-26 23:01:04	11002702	factory
156515	2022-01-27 14:26:45	2022-01-27 23:00:19	11002702	factory
156516	2022-01-28 14:22:37	2022-01-28 23:00:12	11002702	factory
156517	2022-01-31 14:19:05	2022-01-31 23:00:12	11002702	factory
156518	2022-02-01 14:21:15	2022-02-01 22:02:20	11002702	factory
156519	2022-02-02 05:58:22	2022-02-02 14:30:20	11002702	factory
156520	2022-02-03 05:58:46	2022-02-03 14:30:25	11002702	factory
156521	2022-02-04 05:55:47	2022-02-04 14:30:13	11002702	factory
156522	2022-02-07 14:20:03	2022-02-07 23:00:35	11002702	factory
156523	2021-11-29 05:53:58	\N	11003803	factory
156524	2021-11-30 15:37:06	\N	11003803	factory
156525	2021-12-01 05:56:24	2021-12-01 14:30:32	11003803	factory
156526	2021-12-02 05:54:55	2021-12-02 14:30:49	11003803	factory
156527	2021-12-03 05:57:26	2021-12-03 14:35:50	11003803	factory
156528	2021-12-06 05:56:09	2021-12-06 15:44:26	11003803	factory
156529	2021-12-07 05:58:01	2021-12-07 15:36:41	11003803	factory
156530	2021-12-08 05:59:31	2021-12-08 15:30:38	11003803	factory
156531	2021-12-09 05:59:30	2021-12-09 15:43:35	11003803	factory
156532	2021-12-10 05:57:50	2021-12-10 15:41:56	11003803	factory
156533	2021-12-13 05:55:47	2021-12-13 14:33:41	11003803	factory
156534	2021-12-14 05:58:09	2021-12-14 15:30:59	11003803	factory
156535	2021-12-15 05:57:54	2021-12-15 14:39:54	11003803	factory
156536	2021-12-16 05:45:07	2021-12-16 14:30:24	11003803	factory
156537	2021-12-17 05:56:38	2021-12-17 14:30:12	11003803	factory
156538	2021-12-20 06:03:07	2021-12-20 14:34:41	11003803	factory
156539	2021-12-21 05:57:34	2021-12-21 14:32:16	11003803	factory
156540	2021-12-22 05:57:24	2021-12-22 14:34:16	11003803	factory
156541	2021-12-23 05:59:21	2021-12-23 14:31:27	11003803	factory
156542	2021-12-24 05:53:35	2021-12-24 14:31:17	11003803	factory
156543	2021-12-25 05:55:48	2021-12-25 13:33:13	11003803	factory
156544	2021-12-27 05:57:53	\N	11003803	factory
156545	2021-12-28 05:57:44	2021-12-28 14:30:29	11003803	factory
156546	2021-12-29 07:06:27	\N	11003803	factory
156547	2022-01-04 05:57:41	2022-01-04 14:37:01	11003803	factory
156548	2022-01-05 05:52:31	2022-01-05 14:36:40	11003803	factory
156549	2022-01-06 05:51:24	2022-01-06 13:33:53	11003803	factory
156550	2022-01-10 05:55:25	2022-01-10 14:32:06	11003803	factory
156551	2022-01-11 05:51:10	2022-01-11 14:30:31	11003803	factory
156552	2022-01-12 05:54:25	2022-01-12 14:33:59	11003803	factory
156553	2022-01-13 05:52:56	2022-01-13 14:32:48	11003803	factory
156554	2022-01-14 05:54:26	2022-01-14 14:31:38	11003803	factory
156555	2022-01-17 05:56:56	2022-01-17 14:35:10	11003803	factory
156556	2022-01-18 05:53:54	2022-01-18 14:44:22	11003803	factory
156557	2022-01-19 05:57:42	2022-01-19 14:33:34	11003803	factory
156558	2022-01-20 05:56:58	2022-01-20 14:38:33	11003803	factory
156559	2022-01-21 05:52:41	2022-01-21 14:31:53	11003803	factory
156560	2022-01-24 05:54:01	2022-01-24 14:34:01	11003803	factory
156561	2022-01-25 05:51:56	2022-01-25 14:38:54	11003803	factory
156562	2022-01-26 05:57:57	2022-01-26 14:36:55	11003803	factory
156563	2022-01-27 05:56:31	2022-01-27 14:31:14	11003803	factory
156564	2022-01-31 05:56:42	2022-01-31 14:42:00	11003803	factory
156565	2022-02-01 05:55:06	2022-02-01 14:31:34	11003803	factory
156566	2022-02-02 05:54:08	2022-02-02 14:34:59	11003803	factory
156567	2022-02-03 05:56:35	2022-02-03 14:31:41	11003803	factory
156568	2022-02-04 05:54:11	2022-02-04 14:34:02	11003803	factory
156569	2022-02-07 05:54:12	2022-02-07 14:39:22	11003803	factory
156570	2022-02-08 05:53:47	2022-02-08 14:36:23	11003803	factory
156571	2022-02-09 05:54:18	2022-02-09 15:09:00	11003803	factory
156572	2022-02-10 05:53:24	2022-02-10 14:38:54	11003803	factory
156573	2022-02-11 05:58:29	2022-02-11 14:37:00	11003803	factory
156574	2022-02-12 06:04:43	2022-02-12 11:59:16	11003803	factory
156575	2022-02-14 05:53:55	2022-02-14 14:35:33	11003803	factory
156576	2022-02-15 05:50:15	2022-02-15 14:38:26	11003803	factory
156577	2022-02-16 05:50:20	2022-02-16 15:39:10	11003803	factory
156578	2022-02-17 05:53:34	2022-02-17 14:40:14	11003803	factory
156579	2022-02-18 05:51:48	2022-02-18 14:32:36	11003803	factory
156580	2022-02-19 05:57:51	2022-02-19 11:52:22	11003803	factory
156581	2022-02-21 06:01:06	2022-02-21 14:39:41	11003803	factory
156582	2022-02-22 05:57:34	2022-02-22 14:45:20	11003803	factory
156583	2022-02-23 05:53:09	2022-02-23 14:30:45	11003803	factory
156584	2022-02-24 05:48:40	2022-02-24 14:31:55	11003803	factory
156585	2022-02-25 05:54:36	2022-02-25 13:33:03	11003803	factory
156586	2022-02-26 05:56:17	2022-02-26 12:00:28	11003803	factory
156587	2022-02-28 05:49:58	2022-02-28 14:32:06	11003803	factory
156588	2022-03-01 05:50:24	2022-03-01 14:40:12	11003803	factory
156589	2021-11-15 15:30:45	\N	10998366	factory
156590	2021-11-16 05:47:21	2021-11-16 15:30:59	10998366	factory
156591	2021-11-18 05:30:22	2021-11-18 14:30:00	10998366	factory
156592	2021-11-19 05:27:07	\N	10998366	factory
156593	2021-11-22 05:25:27	2021-11-22 15:30:05	10998366	factory
156594	2021-11-23 05:27:26	2021-11-23 15:30:02	10998366	factory
156595	2021-11-25 05:37:42	2021-11-25 15:33:50	10998366	factory
156596	2021-11-26 05:36:00	2021-11-26 15:31:28	10998366	factory
156597	2021-11-29 05:54:50	2021-11-29 15:30:50	10998366	factory
156598	2021-11-30 05:45:33	2021-11-30 14:31:05	10998366	factory
156599	2021-12-01 05:20:35	2021-12-01 15:32:29	10998366	factory
156600	2021-12-02 05:20:03	2021-12-02 15:30:04	10998366	factory
156601	2021-12-03 05:34:47	2021-12-03 15:30:43	10998366	factory
156602	2021-12-04 05:39:06	2021-12-04 12:00:31	10998366	factory
156603	2021-12-06 05:40:03	2021-12-06 15:30:37	10998366	factory
156604	2021-12-07 05:35:24	2021-12-07 15:30:46	10998366	factory
156605	2021-12-08 05:29:24	2021-12-08 15:31:33	10998366	factory
156606	2021-12-09 05:36:47	2021-12-09 14:29:33	10998366	factory
156607	2021-12-10 05:40:44	2021-12-10 15:30:52	10998366	factory
156608	2021-12-13 05:21:02	2021-12-13 15:30:07	10998366	factory
156609	2021-12-14 05:23:16	2021-12-14 15:32:00	10998366	factory
156610	2021-12-15 05:34:13	2021-12-15 15:30:08	10998366	factory
156611	2021-12-16 05:24:59	2021-12-16 15:30:17	10998366	factory
156612	2021-12-17 05:30:08	2021-12-17 15:30:40	10998366	factory
156613	2021-12-18 05:36:57	2021-12-18 11:54:26	10998366	factory
156614	2021-12-20 05:32:33	2021-12-20 15:30:24	10998366	factory
156615	2021-12-21 05:36:55	2021-12-21 15:30:05	10998366	factory
156616	2021-12-22 05:25:12	2021-12-22 15:31:28	10998366	factory
156617	2021-12-23 05:30:01	2021-12-23 15:33:36	10998366	factory
156618	2021-12-24 05:41:17	2021-12-24 15:29:46	10998366	factory
156619	2021-12-25 05:39:03	2021-12-25 13:30:12	10998366	factory
156620	2021-12-27 05:29:02	2021-12-27 15:30:31	10998366	factory
156621	2021-12-28 05:23:45	2021-12-28 15:28:07	10998366	factory
156622	2021-12-29 07:05:09	\N	10998366	factory
156623	2022-01-04 06:01:49	2022-01-04 14:43:39	10998366	factory
156624	2022-01-05 05:51:35	2022-01-05 14:36:35	10998366	factory
156625	2022-01-06 05:44:04	2022-01-06 13:30:20	10998366	factory
156626	2022-01-10 05:43:55	2022-01-10 15:29:57	10998366	factory
156627	2022-01-11 05:40:48	2022-01-11 15:29:58	10998366	factory
156628	2022-01-12 05:44:39	2022-01-12 15:30:32	10998366	factory
156629	2022-01-13 05:20:40	2022-01-13 15:30:31	10998366	factory
156630	2022-01-14 05:44:41	2022-01-14 15:30:36	10998366	factory
156631	2022-01-15 05:33:50	2022-01-15 11:53:50	10998366	factory
156632	2022-01-17 05:38:31	2022-01-17 17:28:22	10998366	factory
156633	2022-01-18 05:30:59	2022-01-18 16:25:05	10998366	factory
156634	2022-01-19 05:45:49	2022-01-19 15:29:43	10998366	factory
156635	2022-01-20 05:40:02	2022-01-20 18:30:46	10998366	factory
156636	2022-01-21 05:39:02	2022-01-21 15:30:01	10998366	factory
156637	2022-01-22 06:00:06	2022-01-22 11:18:30	10998366	factory
156638	2022-01-24 05:26:04	2022-01-24 12:28:25	10998366	factory
156639	2022-01-25 05:54:00	2022-01-25 18:18:35	10998366	factory
156640	2022-01-26 05:37:40	2022-01-26 15:33:54	10998366	factory
156641	2022-01-27 05:36:22	2022-01-27 15:30:28	10998366	factory
156642	2022-01-28 05:57:25	2022-01-28 14:32:38	10998366	factory
156643	2022-01-31 05:33:07	2022-01-31 15:29:41	10998366	factory
156644	2022-02-01 05:35:44	2022-02-01 15:29:58	10998366	factory
156645	2022-02-02 05:28:33	2022-02-02 18:32:28	10998366	factory
156646	2022-02-03 05:31:42	2022-02-03 11:57:00	10998366	factory
156647	2022-02-03 13:57:05	2022-02-03 16:55:58	10998366	factory
156648	2022-02-04 14:33:14	\N	10998366	factory
156649	2022-02-05 05:57:57	2022-02-05 12:01:05	10998366	factory
156650	2022-02-07 05:58:31	2022-02-07 15:30:37	10998366	factory
156651	2022-02-08 05:53:15	2022-02-08 15:28:39	10998366	factory
156652	2022-02-09 05:56:46	2022-02-09 15:31:05	10998366	factory
156653	2022-02-10 05:57:20	2022-02-10 15:30:36	10998366	factory
156654	2022-02-11 05:25:33	2022-02-11 14:32:43	10998366	factory
156655	2022-02-14 05:29:42	2022-02-14 15:30:19	10998366	factory
156656	2022-02-15 05:31:28	2022-02-15 15:30:26	10998366	factory
156657	2022-02-16 05:26:36	\N	10998366	factory
156658	2022-02-17 05:28:13	2022-02-17 17:28:50	10998366	factory
156659	2022-02-18 05:32:33	2022-02-18 16:23:27	10998366	factory
156660	2022-02-19 05:45:47	2022-02-19 11:50:29	10998366	factory
156661	2022-02-21 05:51:17	2022-02-21 15:31:32	10998366	factory
156662	2022-02-22 05:56:19	2022-02-22 15:28:57	10998366	factory
156663	2022-02-23 06:07:12	2022-02-23 14:40:07	10998366	factory
156664	2022-02-24 05:59:27	2022-02-24 15:29:44	10998366	factory
156665	2022-02-25 05:27:44	2022-02-25 13:31:02	10998366	factory
156666	2022-02-28 05:42:44	2022-02-28 15:30:12	10998366	factory
156667	2022-03-01 05:33:50	2022-03-01 15:28:37	10998366	factory
156668	2021-11-16 08:35:08	\N	11002701	factory
156669	2021-11-17 08:45:49	\N	11002701	factory
156670	2021-11-18 08:51:50	2021-11-18 15:57:14	11002701	factory
156671	2021-11-19 08:41:36	\N	11002701	factory
156672	2021-11-22 08:52:01	2021-11-22 14:47:00	11002701	factory
156673	2021-11-23 08:59:32	2021-11-23 15:12:07	11002701	factory
156674	2021-11-24 09:04:44	2021-11-24 15:48:07	11002701	factory
156675	2021-11-26 08:55:42	\N	11002701	factory
156676	2021-11-27 13:35:50	\N	11002701	factory
156677	2021-12-01 09:19:16	2021-12-01 14:42:58	11002701	factory
156678	2021-12-02 08:54:52	2021-12-02 15:58:33	11002701	factory
156679	2021-12-03 08:54:05	2021-12-03 14:26:13	11002701	factory
156680	2021-12-06 09:05:51	2021-12-06 13:51:15	11002701	factory
156681	2021-12-07 08:57:03	2021-12-07 15:42:58	11002701	factory
156682	2021-12-08 08:58:07	2021-12-08 16:16:08	11002701	factory
156683	2021-12-09 09:11:18	2021-12-09 15:44:10	11002701	factory
156684	2021-12-10 09:19:12	2021-12-10 14:41:34	11002701	factory
156685	2021-12-13 09:03:42	2021-12-13 15:40:58	11002701	factory
156686	2021-12-14 08:52:26	2021-12-14 14:16:55	11002701	factory
156687	2021-12-15 08:50:36	2021-12-15 14:01:50	11002701	factory
156688	2021-12-16 08:58:53	2021-12-16 17:12:48	11002701	factory
156689	2021-12-17 09:01:15	2021-12-17 16:46:52	11002701	factory
156690	2021-12-18 08:19:03	2021-12-18 11:53:29	11002701	factory
156691	2021-12-20 09:22:19	2021-12-20 16:49:35	11002701	factory
156692	2021-12-21 08:43:27	2021-12-21 16:28:33	11002701	factory
156693	2021-12-22 09:05:44	2021-12-22 16:11:44	11002701	factory
156694	2021-12-23 16:29:02	\N	11002701	factory
156695	2021-12-24 08:48:44	2021-12-24 16:25:27	11002701	factory
156696	2021-12-25 08:39:47	2021-12-25 14:34:43	11002701	factory
156697	2021-12-27 09:37:24	2021-12-27 16:44:10	11002701	factory
156698	2021-12-28 07:13:08	\N	11002701	factory
156699	2022-01-06 09:28:21	2022-01-06 13:55:43	11002701	factory
156700	2022-01-10 09:26:53	2022-01-10 16:06:46	11002701	factory
156701	2022-01-11 09:05:05	2022-01-11 15:55:28	11002701	factory
156702	2022-01-12 09:16:10	2022-01-12 16:21:46	11002701	factory
156703	2022-01-13 09:06:33	\N	11002701	factory
156704	2022-01-14 09:17:37	\N	11002701	factory
156705	2022-01-17 09:11:34	2022-01-17 16:15:31	11002701	factory
156706	2022-01-18 09:15:22	2022-01-18 15:47:25	11002701	factory
156707	2022-01-19 08:54:20	2022-01-19 15:34:02	11002701	factory
156708	2022-01-20 09:08:07	2022-01-20 17:27:13	11002701	factory
156709	2022-01-21 08:58:15	2022-01-21 09:12:33	11002701	factory
156710	2022-01-21 16:01:46	\N	11002701	factory
156711	2022-01-22 08:33:34	2022-01-22 12:04:19	11002701	factory
156712	2022-01-24 09:28:56	2022-01-24 15:57:09	11002701	factory
156713	2022-01-25 09:15:30	2022-01-25 15:55:53	11002701	factory
156714	2022-01-26 09:10:46	2022-01-26 16:19:17	11002701	factory
156715	2022-01-27 09:27:34	2022-01-27 15:52:46	11002701	factory
156716	2022-01-28 09:24:26	2022-01-28 13:24:02	11002701	factory
156717	2022-01-31 09:40:27	2022-01-31 14:51:15	11002701	factory
156718	2022-02-03 08:39:58	2022-02-03 16:58:02	11002701	factory
156719	2022-02-04 09:15:17	2022-02-04 15:54:00	11002701	factory
156720	2022-02-05 09:09:05	2022-02-05 11:56:58	11002701	factory
156721	2022-02-07 08:34:10	2022-02-07 17:36:11	11002701	factory
156722	2022-02-08 07:42:02	2022-02-08 18:11:50	11002701	factory
156723	2022-02-09 07:10:27	2022-02-09 16:50:53	11002701	factory
156724	2022-02-10 07:36:00	2022-02-10 18:00:55	11002701	factory
156725	2022-02-11 07:50:53	2022-02-11 15:53:17	11002701	factory
156726	2022-02-12 08:36:45	2022-02-12 12:07:06	11002701	factory
156727	2022-02-14 08:45:23	2022-02-14 13:54:39	11002701	factory
156728	2022-02-15 08:45:30	2022-02-15 16:51:06	11002701	factory
156729	2022-02-16 09:11:08	2022-02-16 16:41:02	11002701	factory
156730	2022-02-17 08:52:25	2022-02-17 15:44:44	11002701	factory
156731	2022-02-18 08:58:13	2022-02-18 15:55:00	11002701	factory
156732	2022-02-19 08:46:58	2022-02-19 11:54:08	11002701	factory
156733	2022-02-21 09:07:46	2022-02-21 15:47:06	11002701	factory
156734	2022-02-22 08:46:09	\N	11002701	factory
156735	2022-02-23 08:33:22	2022-02-23 16:15:23	11002701	factory
156736	2022-02-24 09:12:33	2022-02-24 16:52:44	11002701	factory
156737	2022-02-25 08:55:39	2022-02-25 16:18:40	11002701	factory
156738	2022-02-26 08:22:38	2022-02-26 11:28:17	11002701	factory
156739	2022-02-28 08:51:37	2022-02-28 16:17:44	11002701	factory
156740	2022-03-01 09:10:33	2022-03-01 15:50:35	11002701	factory
156741	2021-11-16 05:23:30	2021-11-16 15:08:37	11003511	factory
156742	2021-11-17 05:32:26	2021-11-17 13:48:04	11003511	factory
156743	2021-11-18 05:29:52	2021-11-18 14:07:48	11003511	factory
156744	2021-11-19 05:23:52	\N	11003511	factory
156745	2021-11-20 05:49:39	\N	11003511	factory
156746	2021-12-02 05:52:48	\N	11003511	factory
156747	2021-12-03 05:36:59	\N	11003511	factory
156748	2021-12-06 05:38:47	\N	11003511	factory
156749	2021-12-07 05:35:33	2021-12-07 14:12:33	11003511	factory
156750	2021-12-08 05:32:40	\N	11003511	factory
156751	2021-12-09 05:31:07	\N	11003511	factory
156752	2021-12-10 05:43:55	\N	11003511	factory
156753	2021-12-13 05:39:01	2021-12-13 13:26:33	11003511	factory
156754	2021-12-14 05:27:29	2021-12-14 13:19:44	11003511	factory
156755	2021-12-15 05:44:01	2021-12-15 14:51:39	11003511	factory
156756	2021-12-16 05:29:52	2021-12-16 13:41:24	11003511	factory
156757	2021-12-17 05:24:30	2021-12-17 13:38:16	11003511	factory
156758	2021-12-20 05:37:35	\N	11003511	factory
156759	2021-12-21 05:24:42	\N	11003511	factory
156760	2021-12-23 05:27:47	\N	11003511	factory
156761	2021-12-24 05:17:44	2021-12-24 15:16:52	11003511	factory
156762	2021-12-25 05:28:10	2021-12-25 13:21:41	11003511	factory
156763	2021-12-27 05:31:40	\N	11003511	factory
156764	2021-12-28 05:27:14	2021-12-28 13:03:40	11003511	factory
156765	2021-12-29 05:23:19	\N	11003511	factory
156766	2022-01-04 06:12:37	\N	11003511	factory
156767	2022-01-05 05:46:49	2022-01-05 13:52:17	11003511	factory
156768	2022-01-06 05:45:56	\N	11003511	factory
156769	2022-01-10 05:41:21	\N	11003511	factory
156770	2022-01-11 05:35:04	2022-01-11 14:47:35	11003511	factory
156771	2022-01-12 06:03:53	2022-01-12 13:11:59	11003511	factory
156772	2022-01-13 05:48:24	2022-01-13 13:29:54	11003511	factory
156773	2022-01-14 06:33:12	\N	11003511	factory
156774	2022-01-17 05:28:07	2022-01-17 14:47:40	11003511	factory
156775	2022-01-18 05:30:33	2022-01-18 13:56:49	11003511	factory
156776	2022-01-19 05:34:37	2022-01-19 13:00:32	11003511	factory
156777	2022-01-20 05:32:52	2022-01-20 13:58:08	11003511	factory
156778	2022-01-21 05:32:35	2022-01-21 13:10:03	11003511	factory
156779	2022-01-22 05:37:54	\N	11003511	factory
156780	2022-01-24 05:30:39	2022-01-24 13:50:36	11003511	factory
156781	2022-01-25 05:31:01	2022-01-25 14:07:23	11003511	factory
156782	2022-01-26 05:22:16	2022-01-26 14:47:22	11003511	factory
156783	2022-01-27 05:30:51	2022-01-27 13:43:13	11003511	factory
156784	2022-01-28 05:23:24	2022-01-28 13:43:04	11003511	factory
156785	2022-02-02 05:33:09	2022-02-02 13:37:03	11003511	factory
156786	2022-02-03 05:34:11	\N	11003511	factory
156787	2022-02-04 05:35:49	\N	11003511	factory
156788	2022-02-07 05:25:23	2022-02-07 14:13:10	11003511	factory
156789	2022-02-08 05:33:23	2022-02-08 14:47:17	11003511	factory
156790	2022-02-09 05:29:20	2022-02-09 14:07:19	11003511	factory
156791	2022-02-10 05:51:23	2022-02-10 16:01:41	11003511	factory
156792	2022-02-11 05:30:26	2022-02-11 13:54:59	11003511	factory
156793	2022-02-12 05:44:36	2022-02-12 12:27:46	11003511	factory
156794	2022-02-14 05:22:18	2022-02-14 14:20:51	11003511	factory
156795	2022-02-15 05:26:59	2022-02-15 15:42:21	11003511	factory
156796	2022-02-16 05:28:08	2022-02-16 14:10:46	11003511	factory
156797	2022-02-17 05:33:49	2022-02-17 15:58:35	11003511	factory
156798	2022-02-18 05:25:21	\N	11003511	factory
156799	2022-02-19 05:50:31	\N	11003511	factory
156800	2022-02-21 05:28:15	2022-02-21 14:00:10	11003511	factory
156801	2022-02-22 05:36:34	2022-02-22 15:17:30	11003511	factory
156802	2022-02-23 05:46:21	2022-02-23 13:23:09	11003511	factory
156803	2022-02-24 05:28:46	2022-02-24 14:59:10	11003511	factory
156804	2022-02-25 05:32:16	\N	11003511	factory
156805	2022-02-26 05:41:48	2022-02-26 12:11:55	11003511	factory
156806	2021-12-01 07:03:48	2021-12-01 15:30:11	10999338	factory
156807	2021-12-02 07:02:27	2021-12-02 15:30:14	10999338	factory
156808	2021-12-03 07:01:53	\N	10999338	factory
156809	2021-12-06 07:00:43	2021-12-06 15:29:46	10999338	factory
156810	2021-12-07 06:58:19	2021-12-07 15:30:12	10999338	factory
156811	2021-12-08 07:04:11	2021-12-08 15:30:32	10999338	factory
156812	2021-12-09 06:56:22	2021-12-09 15:30:04	10999338	factory
156813	2021-12-10 07:01:46	\N	10999338	factory
156814	2021-12-13 07:01:36	2021-12-13 15:30:28	10999338	factory
156815	2021-12-14 06:59:47	2021-12-14 15:30:35	10999338	factory
156816	2021-12-15 07:00:52	2021-12-15 15:30:08	10999338	factory
156817	2021-12-16 06:53:40	2021-12-16 15:30:47	10999338	factory
156818	2021-12-17 06:59:44	2021-12-17 15:30:18	10999338	factory
156819	2021-12-20 06:44:50	2021-12-20 15:30:47	10999338	factory
156820	2021-12-21 06:59:41	2021-12-21 15:30:27	10999338	factory
156821	2021-12-22 06:58:12	2021-12-22 15:30:26	10999338	factory
156822	2021-12-23 06:57:41	2021-12-23 15:30:42	10999338	factory
156823	2021-12-24 06:42:50	2021-12-24 15:30:31	10999338	factory
156824	2021-12-27 07:03:43	2021-12-27 15:30:49	10999338	factory
156825	2021-12-28 07:03:15	2021-12-28 15:29:51	10999338	factory
156826	2021-12-29 07:05:05	\N	10999338	factory
156827	2022-01-10 07:03:30	2022-01-10 15:30:53	10999338	factory
156828	2022-01-11 07:04:15	2022-01-11 15:32:58	10999338	factory
156829	2022-01-12 07:02:47	2022-01-12 15:30:22	10999338	factory
156830	2022-01-13 06:59:43	2022-01-13 15:30:09	10999338	factory
156831	2022-01-14 07:01:28	\N	10999338	factory
156832	2022-01-17 06:58:12	2022-01-17 15:30:57	10999338	factory
156833	2022-01-18 15:31:24	\N	10999338	factory
156834	2022-01-19 07:05:19	2022-01-19 15:30:21	10999338	factory
156835	2022-01-20 07:02:16	2022-01-20 15:30:16	10999338	factory
156836	2022-01-21 07:07:10	2022-01-21 15:30:15	10999338	factory
156837	2022-01-24 07:04:17	2022-01-24 15:30:38	10999338	factory
156838	2022-01-25 07:04:56	2022-01-25 15:31:10	10999338	factory
156839	2022-01-26 06:58:55	2022-01-26 15:31:11	10999338	factory
156840	2022-01-27 07:04:29	2022-01-27 15:30:20	10999338	factory
156841	2022-01-31 07:02:18	2022-01-31 15:30:35	10999338	factory
156842	2022-02-01 07:10:16	2022-02-01 15:31:44	10999338	factory
156843	2022-02-02 07:05:43	2022-02-02 15:31:16	10999338	factory
156844	2022-02-03 07:10:25	2022-02-03 15:30:57	10999338	factory
156845	2022-02-04 07:03:15	\N	10999338	factory
156846	2022-02-07 07:01:20	2022-02-07 15:30:17	10999338	factory
156847	2022-02-08 06:58:15	2022-02-08 15:30:01	10999338	factory
156848	2022-02-09 06:59:40	2022-02-09 15:30:19	10999338	factory
156849	2022-02-10 07:04:33	2022-02-10 15:30:45	10999338	factory
156850	2022-02-11 07:07:22	\N	10999338	factory
156851	2022-02-14 07:00:58	2022-02-14 15:30:16	10999338	factory
156852	2022-02-15 06:57:32	2022-02-15 15:31:19	10999338	factory
156853	2022-02-16 07:05:08	2022-02-16 15:30:16	10999338	factory
156854	2022-02-17 07:07:09	2022-02-17 15:30:25	10999338	factory
156855	2022-02-18 07:05:14	2022-02-18 15:29:56	10999338	factory
156856	2022-02-21 07:10:40	2022-02-21 15:30:28	10999338	factory
156857	2022-02-22 07:03:14	\N	10999338	factory
156858	2022-02-24 07:05:40	2022-02-24 15:30:40	10999338	factory
156859	2022-02-25 07:06:59	\N	10999338	factory
156860	2022-02-28 07:02:17	2022-02-28 15:30:16	10999338	factory
156861	2022-03-01 07:02:29	2022-03-01 15:30:43	10999338	factory
156862	2021-12-01 05:53:53	2021-12-01 14:44:35	11065173	factory
156863	2021-12-02 05:53:29	\N	11065173	factory
156864	2021-12-03 05:50:39	2021-12-03 14:31:26	11065173	factory
156865	2021-12-04 05:48:41	2021-12-04 12:03:56	11065173	factory
156866	2021-12-06 14:14:05	2021-12-06 22:03:51	11065173	factory
156867	2021-12-07 14:15:27	2021-12-08 01:07:17	11065173	factory
156868	2021-12-08 14:09:33	2021-12-09 01:15:44	11065173	factory
156869	2021-12-09 14:19:49	2021-12-10 00:58:09	11065173	factory
156870	2021-12-10 14:19:11	2021-12-10 23:00:21	11065173	factory
156871	2021-12-13 05:55:35	2021-12-13 14:36:08	11065173	factory
156872	2021-12-14 05:50:59	2021-12-14 14:29:26	11065173	factory
156873	2021-12-15 05:47:18	2021-12-15 14:33:42	11065173	factory
156874	2021-12-16 05:52:20	2021-12-16 14:31:38	11065173	factory
156875	2021-12-17 05:53:26	2021-12-17 14:39:13	11065173	factory
156876	2021-12-18 05:53:24	2021-12-18 13:01:20	11065173	factory
156877	2021-12-20 14:19:55	2021-12-21 00:01:19	11065173	factory
156878	2021-12-21 14:13:52	2021-12-22 01:02:12	11065173	factory
156879	2021-12-22 14:21:40	2021-12-23 01:15:21	11065173	factory
156880	2021-12-23 14:10:11	2021-12-23 23:05:14	11065173	factory
156881	2021-12-24 14:38:45	2021-12-24 23:00:09	11065173	factory
156882	2021-12-25 13:19:36	2021-12-25 19:08:57	11065173	factory
156883	2021-12-27 05:55:08	2021-12-27 14:30:52	11065173	factory
156884	2021-12-28 05:53:07	2021-12-28 14:28:57	11065173	factory
156885	2021-12-29 07:11:18	2021-12-29 10:32:09	11065173	factory
156886	2022-01-04 14:35:19	2022-01-04 22:00:15	11065173	factory
156887	2022-01-05 14:16:59	2022-01-05 22:00:18	11065173	factory
156888	2022-01-06 13:18:54	2022-01-06 21:02:25	11065173	factory
156889	2022-01-10 05:56:10	2022-01-10 14:32:31	11065173	factory
156890	2022-01-11 05:56:12	2022-01-11 14:33:25	11065173	factory
156891	2022-01-12 05:57:34	2022-01-12 14:33:00	11065173	factory
156892	2022-01-13 05:53:40	2022-01-13 14:34:15	11065173	factory
156893	2022-01-14 05:55:20	2022-01-14 14:31:41	11065173	factory
156894	2022-01-15 05:54:30	2022-01-15 12:01:08	11065173	factory
156895	2022-01-17 14:13:30	2022-01-17 23:00:10	11065173	factory
156896	2022-01-18 14:17:42	2022-01-18 23:00:09	11065173	factory
156897	2022-01-19 14:03:03	2022-01-19 23:00:12	11065173	factory
156898	2022-01-20 14:18:43	2022-01-20 21:00:18	11065173	factory
156899	2022-01-21 05:51:51	2022-01-21 15:30:09	11065173	factory
156900	2022-01-22 05:55:14	2022-01-22 12:02:05	11065173	factory
156901	2022-01-24 05:56:14	2022-01-24 14:43:10	11065173	factory
156902	2022-01-25 05:55:06	2022-01-25 14:30:25	11065173	factory
156903	2022-01-26 05:54:01	2022-01-26 14:34:29	11065173	factory
156904	2022-01-27 05:54:50	2022-01-27 14:30:28	11065173	factory
156905	2022-01-28 05:57:29	2022-01-28 15:28:30	11065173	factory
156906	2022-01-29 05:57:21	2022-01-29 12:00:18	11065173	factory
156907	2022-01-31 14:10:34	2022-01-31 23:00:05	11065173	factory
156908	2022-02-01 14:11:49	2022-02-01 23:00:22	11065173	factory
156909	2022-02-02 14:21:56	2022-02-02 23:00:07	11065173	factory
156910	2022-02-03 14:17:58	2022-02-03 23:00:04	11065173	factory
156911	2022-02-04 14:16:29	2022-02-04 23:00:18	11065173	factory
156912	2022-02-07 05:53:23	2022-02-07 14:35:15	11065173	factory
156913	2022-02-08 05:56:22	2022-02-08 14:32:02	11065173	factory
156914	2022-02-09 05:58:18	\N	11065173	factory
156915	2022-02-10 05:58:51	2022-02-10 14:31:55	11065173	factory
156916	2022-02-11 05:55:48	2022-02-11 14:32:30	11065173	factory
156917	2022-02-12 05:56:22	2022-02-12 12:02:14	11065173	factory
156918	2022-02-14 14:19:00	2022-02-14 23:01:40	11065173	factory
156919	2022-02-15 14:13:50	2022-02-16 00:00:13	11065173	factory
156920	2022-02-16 14:10:57	2022-02-16 23:00:08	11065173	factory
156921	2022-02-17 14:15:51	2022-02-17 23:00:05	11065173	factory
156922	2022-02-18 14:15:48	2022-02-18 23:00:18	11065173	factory
156923	2022-02-21 05:56:59	2022-02-21 14:29:51	11065173	factory
156924	2022-02-22 05:54:52	2022-02-22 14:35:27	11065173	factory
156925	2022-02-23 05:55:28	\N	11065173	factory
156926	2022-02-24 05:54:26	\N	11065173	factory
156927	2022-02-25 05:53:47	2022-02-25 13:44:12	11065173	factory
156928	2022-02-26 05:56:07	2022-02-26 13:30:55	11065173	factory
156929	2022-02-28 14:11:41	2022-02-28 22:59:50	11065173	factory
156930	2022-03-01 14:12:22	2022-03-02 01:00:22	11065173	factory
156931	2021-11-15 23:01:34	\N	11016445	factory
156932	2021-11-23 05:59:21	\N	11016445	factory
156933	2021-11-24 14:30:55	\N	11016445	factory
156934	2021-11-30 23:00:51	\N	11016445	factory
156935	2021-12-01 14:06:53	2021-12-01 14:16:19	11016445	factory
156936	2021-12-01 23:00:40	\N	11016445	factory
156937	2021-12-02 13:53:57	2021-12-02 23:00:04	11016445	factory
156938	2021-12-03 14:17:14	2021-12-03 23:00:53	11016445	factory
156939	2021-12-06 05:53:54	2021-12-06 14:32:12	11016445	factory
156940	2021-12-07 06:04:50	2021-12-07 14:44:50	11016445	factory
156941	2021-12-08 06:00:06	2021-12-08 14:31:28	11016445	factory
156942	2021-12-09 05:59:08	2021-12-09 14:32:31	11016445	factory
156943	2021-12-10 05:53:13	2021-12-10 14:30:43	11016445	factory
156944	2021-12-11 06:00:04	2021-12-11 12:00:41	11016445	factory
156945	2021-12-13 14:27:02	2021-12-13 23:02:58	11016445	factory
156946	2021-12-14 14:16:02	2021-12-15 01:00:22	11016445	factory
156947	2021-12-15 14:27:09	2021-12-16 01:01:26	11016445	factory
156948	2021-12-16 14:27:19	2021-12-17 01:00:14	11016445	factory
156949	2021-12-17 14:33:21	2021-12-17 23:00:09	11016445	factory
156950	2021-12-20 06:01:12	2021-12-20 14:56:55	11016445	factory
156951	2021-12-21 05:54:23	2021-12-21 14:30:11	11016445	factory
156952	2021-12-22 05:57:28	2021-12-22 14:32:08	11016445	factory
156953	2021-12-23 05:54:59	2021-12-23 14:31:46	11016445	factory
156954	2021-12-24 05:52:08	2021-12-24 14:32:59	11016445	factory
156955	2021-12-25 05:52:09	2021-12-25 13:30:22	11016445	factory
156956	2021-12-27 14:20:15	2021-12-27 23:03:16	11016445	factory
156957	2021-12-28 13:54:13	2021-12-28 22:12:27	11016445	factory
156958	2021-12-29 07:06:24	2021-12-29 10:31:02	11016445	factory
156959	2022-01-04 05:55:51	2022-01-04 14:42:23	11016445	factory
156960	2022-01-05 06:31:34	2022-01-05 14:32:24	11016445	factory
156961	2022-01-06 06:00:13	2022-01-06 13:30:18	11016445	factory
156962	2022-01-10 14:32:23	2022-01-10 23:00:39	11016445	factory
156963	2022-01-11 14:30:16	2022-01-11 23:00:08	11016445	factory
156964	2022-01-12 14:27:43	2022-01-13 01:01:27	11016445	factory
156965	2022-01-13 14:18:22	2022-01-13 23:00:44	11016445	factory
156966	2022-01-14 14:19:22	2022-01-14 23:30:27	11016445	factory
156967	2022-01-17 05:49:52	2022-01-17 14:33:43	11016445	factory
156968	2022-01-18 05:54:22	2022-01-18 15:30:47	11016445	factory
156969	2022-01-19 05:54:49	2022-01-19 14:30:05	11016445	factory
156970	2022-01-20 05:39:51	2022-01-20 14:30:10	11016445	factory
156971	2022-01-21 05:39:05	2022-01-21 14:33:31	11016445	factory
156972	2022-01-22 05:51:01	2022-01-22 12:04:22	11016445	factory
156973	2022-01-24 11:16:45	2022-01-24 21:12:46	11016445	factory
156974	2022-01-25 06:42:09	2022-01-25 16:03:59	11016445	factory
156975	2022-01-26 05:54:55	2022-01-26 15:58:05	11016445	factory
156976	2022-01-27 05:40:48	2022-01-27 15:56:31	11016445	factory
156977	2022-01-28 05:49:50	2022-01-28 14:57:49	11016445	factory
156978	2022-01-31 05:50:43	2022-01-31 14:46:05	11016445	factory
156979	2022-02-01 05:53:53	2022-02-01 15:36:34	11016445	factory
156980	2022-02-02 05:57:39	2022-02-02 15:30:23	11016445	factory
156981	2022-02-03 05:52:49	2022-02-03 15:46:19	11016445	factory
156982	2022-02-04 05:57:33	2022-02-04 15:31:53	11016445	factory
156983	2022-02-05 05:57:59	2022-02-05 12:15:36	11016445	factory
156984	2022-02-07 05:51:04	2022-02-07 17:05:28	11016445	factory
156985	2022-02-08 05:53:19	2022-02-08 15:31:21	11016445	factory
156986	2022-02-09 05:50:56	\N	11016445	factory
156987	2022-02-10 05:51:36	2022-02-10 15:41:16	11016445	factory
156988	2022-02-11 05:50:33	2022-02-11 16:43:34	11016445	factory
156989	2022-02-14 05:53:43	2022-02-14 15:31:43	11016445	factory
156990	2022-02-15 05:49:04	2022-02-15 15:42:29	11016445	factory
156991	2022-02-16 06:20:58	2022-02-16 15:42:52	11016445	factory
156992	2022-02-17 06:34:16	2022-02-17 15:41:30	11016445	factory
156993	2022-02-18 05:51:01	2022-02-18 15:57:19	11016445	factory
156994	2022-02-19 05:52:18	2022-02-19 12:29:52	11016445	factory
156995	2022-02-21 05:48:43	2022-02-21 16:07:59	11016445	factory
156996	2022-02-22 05:48:42	2022-02-22 15:41:09	11016445	factory
156997	2022-02-23 06:29:42	2022-02-23 15:55:11	11016445	factory
156998	2022-02-24 06:12:47	2022-02-24 16:15:23	11016445	factory
156999	2022-02-25 05:57:41	2022-02-25 16:03:45	11016445	factory
157000	2022-02-28 05:49:51	2022-02-28 15:45:28	11016445	factory
157001	2022-03-01 05:50:40	2022-03-01 15:45:34	11016445	factory
157002	2021-12-01 06:40:32	2021-12-01 15:50:27	11019089	factory
157003	2021-12-02 06:45:09	2021-12-02 15:34:39	11019089	factory
157004	2021-12-03 06:04:12	2021-12-03 16:16:26	11019089	factory
157005	2021-12-04 05:57:07	2021-12-04 11:53:42	11019089	factory
157006	2021-12-06 06:38:59	2021-12-06 15:31:17	11019089	factory
157007	2021-12-07 06:46:33	2021-12-07 15:32:29	11019089	factory
157008	2021-12-08 06:40:09	2021-12-08 15:33:14	11019089	factory
157009	2021-12-09 06:38:23	2021-12-09 16:11:21	11019089	factory
157010	2021-12-10 06:39:54	2021-12-10 15:50:00	11019089	factory
157011	2021-12-13 06:49:40	2021-12-13 15:36:33	11019089	factory
157012	2021-12-14 06:38:39	2021-12-14 15:40:40	11019089	factory
157013	2021-12-15 06:40:09	2021-12-15 15:32:52	11019089	factory
157014	2021-12-16 06:41:23	2021-12-16 16:06:43	11019089	factory
157015	2021-12-17 06:43:03	2021-12-17 15:36:39	11019089	factory
157016	2021-12-18 06:02:32	2021-12-18 12:27:59	11019089	factory
157017	2021-12-20 06:38:16	2021-12-20 15:33:16	11019089	factory
157018	2021-12-21 06:43:54	2021-12-21 15:30:22	11019089	factory
157019	2021-12-22 06:40:20	2021-12-22 15:39:29	11019089	factory
157020	2021-12-23 06:37:52	2021-12-23 16:00:13	11019089	factory
157021	2021-12-24 06:40:00	2021-12-24 15:30:46	11019089	factory
157022	2021-12-25 06:41:01	2021-12-25 14:38:39	11019089	factory
157023	2021-12-27 06:42:58	2021-12-27 15:32:58	11019089	factory
157024	2021-12-28 06:33:38	2021-12-28 15:33:55	11019089	factory
157025	2021-12-29 06:32:27	2021-12-29 11:18:24	11019089	factory
157026	2022-01-04 06:37:50	2022-01-04 15:39:45	11019089	factory
157027	2022-01-05 06:09:20	2022-01-05 14:45:09	11019089	factory
157028	2022-01-06 06:27:21	2022-01-06 14:00:33	11019089	factory
157029	2022-01-10 06:33:42	2022-01-10 15:33:59	11019089	factory
157030	2022-01-11 06:39:49	2022-01-11 15:36:55	11019089	factory
157031	2022-01-12 06:31:18	2022-01-12 15:33:45	11019089	factory
157032	2022-01-13 06:36:18	2022-01-13 15:59:39	11019089	factory
157033	2022-01-14 06:30:51	2022-01-14 16:40:57	11019089	factory
157034	2022-01-15 06:19:09	2022-01-15 11:18:40	11019089	factory
157035	2022-01-17 06:30:28	2022-01-17 15:33:11	11019089	factory
157036	2022-01-18 06:36:38	2022-01-18 15:31:06	11019089	factory
157037	2022-01-19 06:33:02	2022-01-19 15:30:13	11019089	factory
157038	2022-01-20 06:33:49	2022-01-20 15:40:28	11019089	factory
157039	2022-01-21 06:33:23	2022-01-21 15:52:42	11019089	factory
157040	2022-01-22 05:57:46	2022-01-22 12:17:34	11019089	factory
157041	2022-01-24 06:35:07	2022-01-24 15:32:59	11019089	factory
157042	2022-01-25 06:32:20	2022-01-25 15:40:14	11019089	factory
157043	2022-01-26 06:30:39	2022-01-26 15:35:31	11019089	factory
157044	2022-01-27 06:32:18	2022-01-27 15:33:09	11019089	factory
157045	2022-01-28 06:30:44	2022-01-28 15:32:52	11019089	factory
157046	2022-01-29 06:04:19	2022-01-29 12:46:07	11019089	factory
157047	2022-02-01 06:03:05	2022-02-01 15:54:42	11019089	factory
157048	2022-02-02 06:29:41	2022-02-02 15:41:25	11019089	factory
157049	2022-02-03 06:29:57	2022-02-03 15:50:18	11019089	factory
157050	2022-02-04 06:30:19	2022-02-04 15:37:18	11019089	factory
157051	2022-02-05 06:17:32	2022-02-05 13:04:26	11019089	factory
157052	2022-02-07 06:34:31	2022-02-07 15:35:30	11019089	factory
157053	2022-02-08 06:30:56	2022-02-08 15:38:23	11019089	factory
157054	2022-02-09 06:31:30	2022-02-09 15:33:12	11019089	factory
157055	2022-02-10 06:35:48	2022-02-10 15:36:47	11019089	factory
157056	2022-02-11 06:29:14	2022-02-11 15:35:58	11019089	factory
157057	2022-02-12 06:16:03	2022-02-12 13:05:44	11019089	factory
157058	2022-02-14 06:30:27	2022-02-14 15:32:00	11019089	factory
157059	2022-02-15 06:35:52	2022-02-15 15:35:42	11019089	factory
157060	2022-02-16 06:29:54	2022-02-16 15:34:39	11019089	factory
157061	2022-02-17 06:41:33	2022-02-17 15:37:50	11019089	factory
157062	2022-02-18 06:33:46	2022-02-18 15:32:14	11019089	factory
157063	2022-02-19 05:54:55	2022-02-19 12:40:53	11019089	factory
157064	2022-02-21 06:32:07	2022-02-21 15:35:34	11019089	factory
157065	2022-02-22 06:32:31	2022-02-22 15:38:14	11019089	factory
157066	2022-02-23 06:30:59	2022-02-23 15:36:32	11019089	factory
157067	2022-02-24 06:35:44	2022-02-24 15:36:05	11019089	factory
157068	2022-02-25 05:58:47	2022-02-25 15:25:48	11019089	factory
157069	2022-02-26 06:06:12	2022-02-26 13:05:49	11019089	factory
157070	2022-02-28 06:35:38	2022-02-28 15:36:07	11019089	factory
157071	2022-03-01 06:39:57	2022-03-01 15:36:18	11019089	factory
157072	2021-11-15 23:03:11	\N	11008422	factory
157073	2021-11-18 14:21:19	2021-11-18 23:01:21	11008422	factory
157074	2021-11-26 14:31:36	\N	11008422	factory
157075	2021-11-30 20:18:51	\N	11008422	factory
157076	2021-12-01 14:16:47	2021-12-01 23:01:05	11008422	factory
157077	2021-12-02 14:16:55	2021-12-02 23:00:13	11008422	factory
157078	2021-12-03 14:14:41	2021-12-03 23:02:39	11008422	factory
157079	2021-12-06 05:56:36	2021-12-06 14:30:41	11008422	factory
157080	2021-12-07 05:58:14	2021-12-07 14:31:18	11008422	factory
157081	2021-12-08 05:59:27	2021-12-08 14:32:48	11008422	factory
157082	2021-12-09 05:56:55	2021-12-09 14:31:09	11008422	factory
157083	2021-12-10 05:53:06	2021-12-10 14:37:06	11008422	factory
157084	2021-12-11 06:05:56	\N	11008422	factory
157085	2021-12-13 14:24:46	2021-12-13 23:02:53	11008422	factory
157086	2021-12-14 14:15:59	2021-12-14 23:03:14	11008422	factory
157087	2021-12-15 14:13:48	2021-12-16 01:01:42	11008422	factory
157088	2021-12-16 14:22:33	2021-12-17 01:00:57	11008422	factory
157089	2021-12-17 14:24:32	2021-12-17 23:00:13	11008422	factory
157090	2021-12-20 06:00:05	2021-12-20 14:31:33	11008422	factory
157091	2021-12-21 05:55:03	2021-12-21 14:32:13	11008422	factory
157092	2021-12-22 05:57:22	2021-12-22 14:34:58	11008422	factory
157093	2021-12-23 05:59:41	2021-12-23 14:31:39	11008422	factory
157094	2021-12-24 05:55:52	2021-12-24 15:00:29	11008422	factory
157095	2021-12-25 05:56:00	2021-12-25 13:30:34	11008422	factory
157096	2021-12-27 14:20:19	2021-12-27 23:03:23	11008422	factory
157097	2021-12-28 14:16:54	2021-12-28 22:13:35	11008422	factory
157098	2021-12-29 07:00:38	2021-12-29 10:30:33	11008422	factory
157099	2022-01-04 06:00:35	2022-01-04 14:30:05	11008422	factory
157100	2022-01-05 05:57:22	2022-01-05 14:41:44	11008422	factory
157101	2022-01-06 05:57:44	2022-01-06 13:36:09	11008422	factory
157102	2022-01-10 14:22:02	2022-01-10 23:02:33	11008422	factory
157103	2022-01-11 14:19:54	2022-01-11 23:00:43	11008422	factory
157104	2022-01-12 14:18:09	2022-01-12 23:00:23	11008422	factory
157105	2022-01-13 14:15:33	2022-01-13 23:00:47	11008422	factory
157432	2021-12-11 12:00:56	\N	11090640	factory
157106	2022-01-14 14:19:19	2022-01-14 23:02:40	11008422	factory
157107	2022-01-17 05:55:40	2022-01-17 14:32:31	11008422	factory
157108	2022-01-18 05:52:55	2022-01-18 14:33:48	11008422	factory
157109	2022-01-19 06:02:27	2022-01-19 14:30:22	11008422	factory
157110	2022-01-20 05:55:33	2022-01-20 14:30:17	11008422	factory
157111	2022-01-24 14:21:36	2022-01-24 23:03:10	11008422	factory
157112	2022-01-25 14:22:30	2022-01-25 23:02:07	11008422	factory
157113	2022-01-26 14:32:49	2022-01-26 23:01:09	11008422	factory
157114	2022-01-27 14:21:08	2022-01-27 23:00:22	11008422	factory
157115	2022-01-28 14:19:38	2022-01-28 23:00:15	11008422	factory
157116	2022-01-31 05:57:57	2022-01-31 14:31:16	11008422	factory
157117	2022-02-01 06:00:29	2022-02-01 14:31:20	11008422	factory
157118	2022-02-02 05:54:12	2022-02-02 14:32:30	11008422	factory
157119	2022-02-03 05:58:43	2022-02-03 14:31:47	11008422	factory
157120	2022-02-04 05:54:59	2022-02-04 14:30:45	11008422	factory
157121	2022-02-05 05:59:50	2022-02-05 12:16:05	11008422	factory
157122	2022-02-07 14:23:10	2022-02-07 23:00:43	11008422	factory
157123	2022-02-08 14:14:01	2022-02-08 23:03:24	11008422	factory
157124	2022-02-09 14:19:10	2022-02-09 23:00:42	11008422	factory
157125	2022-02-10 14:17:02	2022-02-10 23:03:46	11008422	factory
157126	2022-02-11 14:23:23	2022-02-11 23:00:43	11008422	factory
157127	2022-02-14 06:02:40	2022-02-14 14:33:01	11008422	factory
157128	2022-02-15 05:54:30	2022-02-15 14:30:19	11008422	factory
157129	2022-02-16 06:25:41	2022-02-16 14:31:56	11008422	factory
157130	2022-02-17 05:55:33	2022-02-17 14:32:03	11008422	factory
157131	2022-02-18 05:54:34	2022-02-18 14:32:25	11008422	factory
157132	2022-02-19 05:59:51	2022-02-19 12:01:11	11008422	factory
157133	2022-02-21 14:12:41	2022-02-21 23:00:53	11008422	factory
157134	2022-02-22 14:18:19	2022-02-22 23:03:45	11008422	factory
157135	2022-02-23 14:14:33	2022-02-23 23:05:26	11008422	factory
157136	2022-02-24 14:12:27	2022-02-24 23:00:28	11008422	factory
157137	2022-02-25 13:19:48	2022-02-25 22:00:15	11008422	factory
157138	2022-02-28 05:56:31	2022-02-28 14:32:00	11008422	factory
157139	2022-03-01 05:57:19	2022-03-01 14:32:44	11008422	factory
157140	2021-12-01 05:51:13	2021-12-01 09:56:28	11014279	factory
157141	2021-12-01 16:38:46	2021-12-02 05:51:01	11014279	factory
157142	2021-12-02 14:30:39	\N	11014279	factory
157143	2021-12-03 05:52:15	2021-12-03 14:32:03	11014279	factory
157144	2021-12-06 14:11:55	2021-12-06 23:01:31	11014279	factory
157145	2021-12-07 14:06:10	2021-12-07 23:02:01	11014279	factory
157146	2021-12-08 14:07:56	2021-12-08 23:03:08	11014279	factory
157147	2021-12-09 14:00:42	2021-12-09 20:52:33	11014279	factory
157148	2021-12-10 05:45:14	2021-12-10 14:32:20	11014279	factory
157149	2021-12-13 05:48:15	2021-12-13 14:33:03	11014279	factory
157150	2021-12-14 05:49:56	2021-12-14 14:38:24	11014279	factory
157151	2021-12-15 05:55:11	2021-12-15 14:35:20	11014279	factory
157152	2021-12-16 05:49:30	2021-12-16 14:35:02	11014279	factory
157153	2021-12-17 05:52:37	2021-12-17 14:34:19	11014279	factory
157154	2021-12-18 05:43:41	2021-12-18 12:00:08	11014279	factory
157155	2021-12-20 14:07:25	2021-12-20 23:00:17	11014279	factory
157156	2021-12-21 14:08:58	2021-12-21 23:02:05	11014279	factory
157157	2021-12-22 14:03:18	\N	11014279	factory
157158	2021-12-23 05:06:11	2021-12-23 14:10:05	11014279	factory
157159	2021-12-23 23:00:40	\N	11014279	factory
157160	2021-12-24 14:07:20	2021-12-24 23:00:02	11014279	factory
157161	2021-12-25 13:20:23	2021-12-25 20:00:38	11014279	factory
157162	2021-12-27 13:59:40	2021-12-27 23:03:07	11014279	factory
157163	2021-12-28 05:42:35	2021-12-28 14:31:09	11014279	factory
157164	2021-12-29 06:51:08	\N	11014279	factory
157165	2022-01-04 14:08:36	2022-01-04 22:01:56	11014279	factory
157166	2022-01-05 13:59:44	2022-01-05 22:00:22	11014279	factory
157167	2022-01-06 13:24:15	2022-01-06 19:59:09	11014279	factory
157168	2022-01-10 05:53:38	2022-01-10 14:30:47	11014279	factory
157169	2022-01-11 05:47:07	2022-01-11 14:30:20	11014279	factory
157170	2022-01-12 05:51:30	2022-01-12 14:31:23	11014279	factory
157171	2022-01-13 05:47:37	2022-01-13 14:30:28	11014279	factory
157172	2022-01-14 05:52:03	2022-01-14 14:31:54	11014279	factory
157173	2022-01-15 05:44:05	2022-01-15 12:00:56	11014279	factory
157174	2022-01-17 14:07:24	2022-01-17 21:00:58	11014279	factory
157175	2022-01-18 14:06:39	2022-01-18 23:00:07	11014279	factory
157176	2022-01-19 14:05:22	2022-01-19 23:00:07	11014279	factory
157177	2022-01-20 14:06:20	2022-01-20 23:00:08	11014279	factory
157178	2022-01-21 14:07:26	2022-01-21 21:01:25	11014279	factory
157179	2022-01-24 05:51:16	2022-01-24 14:31:04	11014279	factory
157180	2022-01-25 05:49:31	2022-01-25 14:34:36	11014279	factory
157181	2022-01-26 05:50:35	2022-01-26 14:32:27	11014279	factory
157182	2022-01-27 05:50:35	2022-01-27 14:35:06	11014279	factory
157183	2022-01-28 05:50:39	2022-01-28 14:30:34	11014279	factory
157184	2022-02-07 05:54:09	2022-02-07 14:31:14	11014279	factory
157185	2022-02-08 05:52:37	2022-02-08 14:30:27	11014279	factory
157186	2022-02-09 05:51:30	2022-02-09 14:32:01	11014279	factory
157187	2022-02-10 05:53:15	2022-02-10 14:32:53	11014279	factory
157188	2022-02-11 05:53:12	2022-02-11 14:31:24	11014279	factory
157189	2022-02-14 14:06:59	2022-02-14 23:00:14	11014279	factory
157190	2022-02-15 14:07:25	2022-02-15 22:56:16	11014279	factory
157191	2022-02-16 14:06:14	2022-02-16 23:00:05	11014279	factory
157192	2022-02-17 14:02:53	2022-02-17 23:00:14	11014279	factory
157193	2022-02-18 14:06:36	2022-02-18 23:00:11	11014279	factory
157194	2022-02-21 05:50:12	2022-02-21 14:31:11	11014279	factory
157195	2022-02-22 05:47:26	2022-02-22 14:32:03	11014279	factory
157196	2022-02-24 05:54:05	2022-02-24 14:30:19	11014279	factory
157197	2022-02-25 05:54:40	2022-02-25 13:30:39	11014279	factory
157198	2022-02-28 14:04:27	2022-02-28 22:59:57	11014279	factory
157199	2022-03-01 14:11:53	2022-03-01 23:00:25	11014279	factory
157200	2021-11-16 05:52:18	2021-11-16 14:39:29	11009301	factory
157201	2021-11-17 05:35:07	2021-11-17 15:22:43	11009301	factory
157202	2021-11-18 05:42:21	2021-11-18 14:54:06	11009301	factory
157203	2021-11-19 05:37:59	2021-11-19 14:39:07	11009301	factory
157204	2021-11-20 06:58:04	2021-11-20 09:36:42	11009301	factory
157205	2021-11-22 05:45:41	2021-11-22 14:38:00	11009301	factory
157206	2021-11-23 05:42:31	2021-11-23 14:39:14	11009301	factory
157207	2021-11-24 05:50:25	2021-11-24 15:02:26	11009301	factory
157208	2021-11-25 05:45:18	2021-11-25 14:48:58	11009301	factory
157209	2021-11-26 05:36:15	2021-11-26 14:45:31	11009301	factory
157210	2021-11-29 05:31:49	\N	11009301	factory
157211	2021-11-30 05:44:43	2021-11-30 14:48:20	11009301	factory
157212	2021-12-01 05:35:38	2021-12-01 14:40:01	11009301	factory
157213	2021-12-02 05:42:19	2021-12-02 14:36:39	11009301	factory
157214	2021-12-03 05:45:33	2021-12-03 14:40:34	11009301	factory
157215	2021-12-06 05:34:41	2021-12-06 14:43:30	11009301	factory
157216	2021-12-07 05:58:06	2021-12-07 14:55:19	11009301	factory
157217	2021-12-08 05:54:15	2021-12-08 17:28:47	11009301	factory
157218	2021-12-09 05:36:25	2021-12-09 14:51:18	11009301	factory
157219	2021-12-10 05:35:24	2021-12-10 14:37:27	11009301	factory
157220	2021-12-11 05:37:24	2021-12-11 12:10:31	11009301	factory
157221	2021-12-13 05:49:02	2021-12-13 15:07:12	11009301	factory
157222	2021-12-14 10:42:11	2021-12-14 20:00:45	11009301	factory
157223	2021-12-15 05:36:10	2021-12-15 15:05:35	11009301	factory
157224	2021-12-16 05:37:37	2021-12-16 15:44:46	11009301	factory
157225	2021-12-17 05:38:55	2021-12-17 06:15:24	11009301	factory
157226	2021-12-17 14:42:46	\N	11009301	factory
157227	2021-12-18 05:39:05	2021-12-18 12:15:16	11009301	factory
157228	2021-12-20 05:49:55	2021-12-20 15:01:23	11009301	factory
157229	2021-12-21 05:36:58	2021-12-21 15:21:04	11009301	factory
157230	2021-12-22 05:43:40	2021-12-22 14:35:55	11009301	factory
157231	2021-12-23 05:40:17	2021-12-23 14:33:33	11009301	factory
157232	2021-12-24 05:53:57	2021-12-24 14:37:15	11009301	factory
157233	2021-12-25 05:58:08	2021-12-25 13:44:49	11009301	factory
157234	2021-12-27 05:35:56	2021-12-27 14:31:56	11009301	factory
157235	2021-12-28 05:38:31	2021-12-28 14:35:07	11009301	factory
157236	2021-12-29 05:45:45	2021-12-29 12:21:23	11009301	factory
157237	2022-01-04 06:00:31	2022-01-04 14:51:52	11009301	factory
157238	2022-01-05 05:38:54	2022-01-05 14:50:59	11009301	factory
157239	2022-01-06 05:37:55	2022-01-06 14:47:49	11009301	factory
157240	2022-01-10 05:41:02	\N	11009301	factory
157241	2022-01-10 22:58:29	\N	11009301	factory
157242	2022-01-11 14:05:52	2022-01-11 23:03:22	11009301	factory
157243	2022-01-12 12:26:20	2022-01-12 23:00:29	11009301	factory
157244	2022-01-13 13:57:45	2022-01-13 23:03:37	11009301	factory
157245	2022-01-14 14:14:56	2022-01-14 23:07:12	11009301	factory
157246	2022-01-17 05:32:13	2022-01-17 15:06:43	11009301	factory
157247	2022-01-18 05:31:03	2022-01-18 14:32:21	11009301	factory
157248	2022-01-19 05:46:53	2022-01-19 14:55:18	11009301	factory
157249	2022-01-20 05:40:17	2022-01-20 14:35:05	11009301	factory
157250	2022-01-21 05:41:29	2022-01-21 14:38:33	11009301	factory
157251	2022-01-24 14:02:12	2022-01-24 23:04:19	11009301	factory
157252	2022-01-25 12:28:53	2022-01-25 23:04:21	11009301	factory
157253	2022-01-26 14:24:45	2022-01-26 23:02:56	11009301	factory
157254	2022-01-27 12:31:56	2022-01-27 20:21:36	11009301	factory
157255	2022-01-31 05:33:27	2022-01-31 15:09:02	11009301	factory
157256	2022-02-01 05:39:37	2022-02-01 14:52:58	11009301	factory
157257	2022-02-02 05:31:13	2022-02-02 14:39:57	11009301	factory
157258	2022-02-03 05:33:03	2022-02-03 14:43:17	11009301	factory
157259	2022-02-04 05:40:49	2022-02-04 15:40:15	11009301	factory
157260	2022-02-07 14:08:56	2022-02-07 23:04:26	11009301	factory
157261	2022-02-08 13:38:44	2022-02-08 23:09:09	11009301	factory
157262	2022-02-09 14:08:53	2022-02-09 23:05:40	11009301	factory
157263	2022-02-10 14:14:35	2022-02-10 23:09:22	11009301	factory
157264	2022-02-11 14:03:33	2022-02-12 00:06:14	11009301	factory
157265	2022-02-14 05:37:20	2022-02-14 14:44:14	11009301	factory
157266	2022-02-15 05:31:52	2022-02-15 14:55:27	11009301	factory
157267	2022-02-16 05:29:03	2022-02-16 14:41:47	11009301	factory
157268	2022-02-17 05:32:45	2022-02-17 14:48:20	11009301	factory
157269	2022-02-18 05:43:53	2022-02-18 14:53:07	11009301	factory
157270	2022-02-19 05:47:42	\N	11009301	factory
157271	2022-02-21 13:44:59	2022-02-21 23:04:04	11009301	factory
157272	2022-02-22 13:54:57	2022-02-22 23:07:20	11009301	factory
157273	2022-02-23 13:29:10	2022-02-23 23:09:13	11009301	factory
157274	2022-02-24 13:32:18	2022-02-24 23:06:11	11009301	factory
157275	2022-02-25 12:51:03	2022-02-25 22:17:20	11009301	factory
157276	2022-02-28 05:42:09	2022-02-28 14:37:24	11009301	factory
157277	2022-03-01 05:37:21	2022-03-01 14:38:28	11009301	factory
157278	2022-02-16 15:59:05	\N	11008423	factory
157279	2022-02-17 06:50:38	2022-02-17 15:39:17	11008423	factory
157280	2022-02-18 06:48:24	2022-02-18 15:41:07	11008423	factory
157281	2022-02-21 06:50:08	2022-02-21 15:43:36	11008423	factory
157282	2022-02-22 06:48:56	2022-02-22 15:42:05	11008423	factory
157283	2022-02-23 06:45:41	2022-02-23 15:47:31	11008423	factory
157284	2022-02-24 06:49:44	2022-02-24 15:42:55	11008423	factory
157285	2022-02-25 06:46:33	2022-02-25 15:12:36	11008423	factory
157286	2022-02-28 06:49:42	2022-02-28 15:41:51	11008423	factory
157287	2022-03-01 06:50:50	2022-03-01 15:41:37	11008423	factory
157288	2022-02-17 12:14:30	2022-02-17 15:37:20	11009634	factory
157289	2022-02-18 05:51:05	2022-02-18 15:25:45	11009634	factory
157290	2022-02-19 06:38:31	2022-02-19 11:51:51	11009634	factory
157291	2022-02-21 05:56:34	2022-02-21 15:27:19	11009634	factory
157292	2022-02-22 06:17:09	2022-02-22 15:28:08	11009634	factory
157293	2022-02-23 05:56:19	2022-02-23 15:15:08	11009634	factory
157294	2022-02-24 06:02:05	2022-02-24 15:25:48	11009634	factory
157295	2022-02-25 05:57:38	2022-02-25 14:30:25	11009634	factory
157296	2022-02-28 05:47:09	2022-02-28 15:04:08	11009634	factory
157297	2022-03-01 05:50:43	2022-03-01 16:27:53	11009634	factory
157298	2022-02-01 15:30:34	\N	11010518	factory
157299	2022-02-02 06:10:53	2022-02-02 15:32:25	11010518	factory
157300	2022-02-03 06:08:04	2022-02-03 15:29:58	11010518	factory
157301	2022-02-04 06:07:13	2022-02-04 15:32:30	11010518	factory
157302	2022-02-07 06:09:26	2022-02-07 15:36:12	11010518	factory
157303	2022-02-08 06:18:30	2022-02-08 15:38:44	11010518	factory
157304	2022-02-09 06:13:05	2022-02-09 15:40:02	11010518	factory
157305	2022-02-10 06:22:22	2022-02-10 15:38:00	11010518	factory
157306	2022-02-11 06:19:30	2022-02-11 15:30:43	11010518	factory
157307	2022-02-12 07:15:59	2022-02-12 12:15:18	11010518	factory
157308	2022-02-14 06:22:25	2022-02-14 15:33:05	11010518	factory
157309	2022-02-15 06:13:02	2022-02-15 15:34:33	11010518	factory
157310	2022-02-16 06:19:53	2022-02-16 15:35:37	11010518	factory
157311	2022-02-17 06:10:14	2022-02-17 15:38:22	11010518	factory
157312	2022-02-18 06:11:44	2022-02-18 15:37:37	11010518	factory
157313	2022-02-21 06:15:10	2022-02-21 15:35:55	11010518	factory
157314	2022-02-22 06:21:56	2022-02-22 15:34:33	11010518	factory
157315	2022-02-23 06:26:11	2022-02-23 15:37:09	11010518	factory
157316	2022-02-24 06:12:20	2022-02-24 15:33:03	11010518	factory
157317	2022-02-25 06:05:56	2022-02-25 15:41:35	11010518	factory
157318	2022-02-28 06:19:15	2022-02-28 15:35:12	11010518	factory
157319	2022-03-01 06:24:04	2022-03-01 15:34:00	11010518	factory
157320	2021-12-03 07:01:44	2021-12-03 08:47:17	11009300	factory
157321	2021-12-10 06:59:59	2021-12-10 14:52:54	11009300	factory
157323	2021-12-14 07:04:42	2021-12-14 14:57:29	11009300	factory
157324	2021-12-15 07:03:13	2021-12-15 15:01:42	11009300	factory
157325	2021-12-16 06:59:15	\N	11009300	factory
157326	2021-12-17 07:01:16	\N	11009300	factory
157327	2021-12-20 07:06:55	2021-12-20 14:58:38	11009300	factory
157328	2021-12-21 07:03:05	2021-12-21 14:58:47	11009300	factory
157329	2021-12-22 07:02:49	2021-12-22 14:56:32	11009300	factory
157330	2021-12-23 07:16:08	2021-12-23 15:00:18	11009300	factory
157331	2021-12-24 07:03:37	2021-12-24 14:57:58	11009300	factory
157332	2021-12-25 07:01:40	\N	11009300	factory
157333	2021-12-27 07:02:20	\N	11009300	factory
157334	2021-12-28 07:04:23	\N	11009300	factory
157335	2022-01-10 06:55:38	\N	11009300	factory
157336	2022-01-17 07:07:19	2022-01-17 14:58:06	11009300	factory
157337	2022-01-18 07:04:24	2022-01-18 14:59:36	11009300	factory
157338	2022-01-19 07:05:08	2022-01-19 15:13:58	11009300	factory
157339	2022-01-20 06:58:48	\N	11009300	factory
157340	2022-01-21 06:59:00	2022-01-21 15:03:21	11009300	factory
157341	2022-01-24 07:00:56	2022-01-24 15:02:16	11009300	factory
157342	2022-01-25 07:09:18	2022-01-25 14:55:01	11009300	factory
157343	2022-01-26 06:56:16	2022-01-26 14:51:49	11009300	factory
157344	2022-01-27 07:02:36	\N	11009300	factory
157345	2022-01-31 07:01:25	2022-01-31 15:00:45	11009300	factory
157346	2022-02-01 06:53:18	2022-02-01 15:05:48	11009300	factory
157347	2022-02-02 07:04:40	2022-02-02 14:57:08	11009300	factory
157348	2022-02-03 14:57:17	\N	11009300	factory
157349	2022-02-04 07:04:23	2022-02-04 14:56:57	11009300	factory
157350	2022-02-07 07:03:08	2022-02-07 15:02:26	11009300	factory
157351	2022-02-08 07:02:55	2022-02-08 14:56:48	11009300	factory
157352	2022-02-09 07:00:48	2022-02-09 15:13:50	11009300	factory
157353	2022-02-10 07:01:42	2022-02-10 15:00:15	11009300	factory
157354	2022-02-11 07:00:53	2022-02-11 14:48:55	11009300	factory
157355	2022-02-14 07:04:20	2022-02-14 15:03:35	11009300	factory
157356	2022-02-15 06:59:35	2022-02-15 14:56:40	11009300	factory
157357	2022-02-16 06:58:25	2022-02-16 15:05:58	11009300	factory
157358	2022-02-17 07:02:09	2022-02-17 15:23:33	11009300	factory
157359	2022-02-18 06:51:53	2022-02-18 14:53:03	11009300	factory
157360	2022-02-21 07:02:00	2022-02-21 15:01:54	11009300	factory
157361	2022-02-22 07:03:47	2022-02-22 15:01:53	11009300	factory
157362	2022-02-23 07:03:03	2022-02-23 15:05:11	11009300	factory
157363	2022-02-24 07:03:24	2022-02-24 14:59:40	11009300	factory
157364	2022-02-25 06:56:47	\N	11009300	factory
157365	2022-02-28 07:16:44	2022-02-28 14:59:36	11009300	factory
157366	2022-03-01 07:05:24	2022-03-01 14:55:20	11009300	factory
157367	2021-11-16 05:47:29	\N	11072170	factory
157368	2021-12-01 05:51:58	2021-12-01 15:31:06	11072170	factory
157369	2021-12-02 05:52:02	2021-12-02 16:06:01	11072170	factory
157370	2021-12-03 05:54:38	2021-12-03 15:33:18	11072170	factory
157371	2021-12-06 05:48:36	2021-12-06 15:32:03	11072170	factory
157372	2021-12-07 05:45:27	2021-12-07 15:32:25	11072170	factory
157373	2021-12-08 05:56:52	2021-12-08 15:31:48	11072170	factory
157374	2021-12-09 05:51:29	2021-12-09 15:32:09	11072170	factory
157375	2021-12-10 05:54:03	\N	11072170	factory
157376	2021-12-13 05:52:32	\N	11072170	factory
157377	2021-12-14 05:53:03	\N	11072170	factory
157378	2021-12-15 05:56:02	2021-12-15 15:31:28	11072170	factory
157379	2021-12-16 05:54:37	2021-12-16 15:36:13	11072170	factory
157380	2021-12-17 06:14:11	2021-12-17 14:11:42	11072170	factory
157381	2021-12-20 05:54:21	2021-12-20 15:04:44	11072170	factory
157382	2021-12-21 05:56:26	2021-12-21 15:36:45	11072170	factory
157383	2021-12-22 05:54:48	2021-12-22 15:34:09	11072170	factory
157384	2021-12-23 05:57:50	\N	11072170	factory
157385	2021-12-24 05:50:23	\N	11072170	factory
157386	2021-12-25 05:55:25	2021-12-25 13:51:52	11072170	factory
157387	2021-12-27 05:56:45	2021-12-27 15:35:11	11072170	factory
157388	2021-12-28 05:58:45	2021-12-28 15:02:09	11072170	factory
157389	2022-01-13 06:08:34	2022-01-13 15:38:34	11072170	factory
157390	2022-01-14 06:00:46	2022-01-14 15:30:51	11072170	factory
157391	2022-01-17 06:01:24	2022-01-17 15:34:42	11072170	factory
157392	2022-01-18 06:00:17	2022-01-18 15:34:54	11072170	factory
157393	2022-01-19 06:03:08	2022-01-19 15:37:10	11072170	factory
157394	2022-01-20 06:01:41	2022-01-20 15:34:17	11072170	factory
157395	2022-01-21 05:58:00	2022-01-21 15:01:03	11072170	factory
157396	2022-01-24 05:54:04	2022-01-24 15:34:33	11072170	factory
157397	2022-01-25 05:57:47	2022-01-25 14:59:09	11072170	factory
157398	2022-01-26 05:57:06	2022-01-26 15:34:14	11072170	factory
157399	2022-01-27 06:03:58	2022-01-27 15:36:39	11072170	factory
157400	2022-01-28 05:56:49	2022-01-28 14:54:56	11072170	factory
157401	2022-01-31 06:00:31	2022-01-31 15:25:04	11072170	factory
157402	2022-02-01 05:57:54	2022-02-01 15:42:32	11072170	factory
157403	2022-02-02 05:58:29	2022-02-02 15:41:32	11072170	factory
157404	2022-02-03 05:57:58	2022-02-03 15:35:00	11072170	factory
157405	2022-02-04 05:56:47	2022-02-04 15:18:33	11072170	factory
157406	2022-02-07 05:59:01	2022-02-07 15:34:49	11072170	factory
157407	2022-02-08 05:55:53	2022-02-08 15:36:34	11072170	factory
157408	2022-02-09 05:58:00	2022-02-09 15:35:45	11072170	factory
157409	2022-02-10 06:02:26	2022-02-10 15:37:42	11072170	factory
157410	2022-02-11 06:01:11	\N	11072170	factory
157411	2022-02-14 05:40:05	2022-02-14 15:38:47	11072170	factory
157412	2022-02-15 05:53:33	2022-02-15 15:39:49	11072170	factory
157413	2022-02-16 05:56:37	2022-02-16 15:35:11	11072170	factory
157414	2022-02-17 05:57:13	2022-02-17 15:47:47	11072170	factory
157415	2022-02-18 05:57:58	2022-02-18 15:56:35	11072170	factory
157416	2022-02-21 05:41:17	\N	11072170	factory
157417	2022-02-22 05:54:38	2022-02-22 15:39:14	11072170	factory
157418	2022-02-23 06:00:27	2022-02-23 15:57:52	11072170	factory
157419	2022-02-24 05:41:43	2022-02-24 15:45:54	11072170	factory
157420	2022-02-25 05:58:27	2022-02-25 14:48:22	11072170	factory
157421	2022-02-28 05:59:51	2022-02-28 15:39:33	11072170	factory
157422	2022-03-01 05:57:55	2022-03-01 15:37:27	11072170	factory
157423	2021-12-01 05:38:26	\N	11090640	factory
157424	2021-12-02 05:36:34	\N	11090640	factory
157425	2021-12-03 05:43:24	2021-12-03 16:38:08	11090640	factory
157426	2021-12-04 05:53:12	2021-12-04 12:07:19	11090640	factory
157427	2021-12-06 05:44:03	2021-12-06 15:53:54	11090640	factory
157428	2021-12-07 05:38:02	2021-12-07 15:57:55	11090640	factory
157429	2021-12-08 05:40:31	2021-12-08 15:43:37	11090640	factory
157430	2021-12-09 05:39:17	\N	11090640	factory
157431	2021-12-10 05:41:41	\N	11090640	factory
157433	2021-12-13 05:41:30	\N	11090640	factory
157434	2021-12-14 05:41:58	2021-12-14 16:01:21	11090640	factory
157435	2021-12-15 05:42:58	\N	11090640	factory
157436	2021-12-16 05:45:46	\N	11090640	factory
157437	2021-12-17 05:39:31	\N	11090640	factory
157438	2021-12-18 12:04:38	\N	11090640	factory
157439	2021-12-20 05:36:01	2021-12-20 15:49:15	11090640	factory
157440	2021-12-21 05:37:44	\N	11090640	factory
157441	2021-12-22 05:38:34	\N	11090640	factory
157442	2021-12-23 05:39:32	\N	11090640	factory
157443	2021-12-24 05:41:26	\N	11090640	factory
157444	2021-12-25 05:42:36	\N	11090640	factory
157445	2021-12-27 05:41:24	\N	11090640	factory
157446	2021-12-28 05:42:17	\N	11090640	factory
157447	2022-01-04 05:50:15	2022-01-04 14:49:49	11090640	factory
157448	2022-01-05 05:48:04	2022-01-05 14:32:14	11090640	factory
157449	2022-01-06 05:53:14	2022-01-06 13:54:11	11090640	factory
157450	2022-01-10 05:37:54	2022-01-10 15:50:29	11090640	factory
157451	2022-01-11 05:46:21	2022-01-11 16:03:49	11090640	factory
157452	2022-01-12 05:45:41	2022-01-12 15:56:02	11090640	factory
157453	2022-01-13 05:39:45	2022-01-13 16:07:00	11090640	factory
157454	2022-01-14 05:46:39	2022-01-14 16:08:09	11090640	factory
157455	2022-01-15 12:09:50	\N	11090640	factory
157456	2022-01-17 05:43:31	2022-01-17 15:57:58	11090640	factory
157457	2022-01-18 05:46:31	2022-01-18 15:59:28	11090640	factory
157458	2022-01-19 05:35:44	2022-01-19 15:48:20	11090640	factory
157459	2022-01-20 05:42:34	2022-01-20 16:22:56	11090640	factory
157460	2022-01-21 05:41:01	\N	11090640	factory
157461	2022-01-22 06:04:30	\N	11090640	factory
157462	2022-01-24 05:46:10	2022-01-24 16:11:10	11090640	factory
157463	2022-01-25 05:45:16	2022-01-25 16:00:27	11090640	factory
157464	2022-01-26 05:44:47	2022-01-26 15:54:35	11090640	factory
157465	2022-01-27 05:41:04	2022-01-27 16:02:21	11090640	factory
157466	2022-01-28 05:38:48	2022-01-28 15:36:55	11090640	factory
157467	2022-01-29 12:11:23	\N	11090640	factory
157468	2022-01-31 05:41:42	2022-01-31 15:33:15	11090640	factory
157469	2022-02-01 05:42:20	2022-02-01 16:06:36	11090640	factory
157470	2022-02-02 05:39:15	2022-02-02 15:59:16	11090640	factory
157471	2022-02-04 05:36:31	2022-02-04 15:39:05	11090640	factory
157472	2022-02-07 05:41:29	2022-02-07 15:52:39	11090640	factory
157473	2022-02-08 05:39:33	2022-02-08 15:48:31	11090640	factory
157474	2022-02-09 05:44:47	2022-02-09 15:42:08	11090640	factory
157475	2022-02-10 15:58:50	2022-02-11 05:46:16	11090640	factory
157476	2022-02-11 16:12:11	\N	11090640	factory
157477	2022-02-12 06:27:57	\N	11090640	factory
157478	2022-02-14 05:40:02	2022-02-14 15:43:28	11090640	factory
157479	2022-02-15 05:43:10	2022-02-15 15:44:30	11090640	factory
157480	2022-02-16 05:39:33	2022-02-16 15:51:42	11090640	factory
157481	2022-02-17 05:45:22	2022-02-17 15:58:26	11090640	factory
157482	2022-02-18 05:40:40	2022-02-18 15:56:41	11090640	factory
157483	2022-02-21 05:41:14	2022-02-21 15:59:14	11090640	factory
157484	2022-02-22 05:41:43	2022-02-22 15:45:16	11090640	factory
157485	2022-02-23 05:44:38	2022-02-23 15:57:55	11090640	factory
157486	2022-02-24 05:41:39	2022-02-24 16:29:56	11090640	factory
157487	2022-02-25 05:39:15	2022-02-25 14:32:36	11090640	factory
157488	2022-02-26 05:42:14	\N	11090640	factory
157489	2022-02-28 05:37:00	2022-02-28 15:53:17	11090640	factory
157490	2022-03-01 05:37:20	2022-03-01 15:54:15	11090640	factory
157491	2021-12-01 07:01:03	2021-12-01 15:30:49	11026309	factory
157492	2021-12-02 06:55:04	2021-12-02 15:31:56	11026309	factory
157493	2021-12-03 06:56:34	2021-12-03 15:30:56	11026309	factory
157494	2021-12-06 06:58:18	2021-12-06 15:34:41	11026309	factory
157495	2021-12-07 06:58:40	2021-12-07 15:30:50	11026309	factory
157496	2021-12-08 07:05:24	2021-12-08 15:30:24	11026309	factory
157497	2021-12-09 07:00:40	2021-12-09 15:30:35	11026309	factory
157498	2021-12-13 07:00:31	2021-12-13 15:30:37	11026309	factory
157499	2021-12-14 07:02:02	2021-12-14 15:30:49	11026309	factory
157500	2021-12-15 06:59:18	2021-12-15 16:30:10	11026309	factory
157501	2021-12-16 07:02:28	2021-12-16 15:33:41	11026309	factory
157502	2021-12-17 06:59:12	2021-12-17 16:29:50	11026309	factory
157503	2021-12-18 06:58:08	2021-12-18 11:56:35	11026309	factory
157504	2021-12-20 07:06:53	2021-12-20 17:29:58	11026309	factory
157505	2021-12-21 07:06:34	2021-12-21 15:32:06	11026309	factory
157506	2021-12-22 07:03:44	2021-12-22 15:31:15	11026309	factory
157507	2021-12-23 07:04:42	2021-12-23 15:33:19	11026309	factory
157508	2021-12-24 07:23:15	2021-12-24 17:33:12	11026309	factory
157509	2021-12-25 07:03:32	2021-12-25 14:38:46	11026309	factory
157510	2021-12-27 06:59:28	2021-12-27 17:27:59	11026309	factory
157511	2021-12-28 06:58:54	2021-12-28 15:30:18	11026309	factory
157512	2021-12-29 07:06:50	2021-12-29 10:16:05	11026309	factory
157513	2022-01-10 07:00:17	2022-01-10 15:30:13	11026309	factory
157514	2022-01-11 07:06:02	2022-01-11 15:30:43	11026309	factory
157515	2022-01-12 07:00:48	2022-01-12 15:30:38	11026309	factory
157516	2022-01-13 07:01:37	2022-01-13 15:39:17	11026309	factory
157517	2022-01-14 07:02:39	2022-01-14 15:30:39	11026309	factory
157518	2022-01-17 15:35:49	\N	11026309	factory
157519	2022-01-18 07:02:38	2022-01-18 15:30:21	11026309	factory
157520	2022-01-19 07:06:28	2022-01-19 15:23:14	11026309	factory
157521	2022-01-20 07:08:45	2022-01-20 15:31:30	11026309	factory
157522	2022-01-21 07:03:40	2022-01-21 15:30:28	11026309	factory
157523	2022-01-24 07:03:19	2022-01-24 15:30:46	11026309	factory
157524	2022-01-25 07:06:11	2022-01-25 15:30:31	11026309	factory
157525	2022-01-26 07:05:05	2022-01-26 15:44:40	11026309	factory
157526	2022-01-27 07:04:33	2022-01-27 15:30:50	11026309	factory
157527	2022-01-28 07:02:41	2022-01-28 15:30:35	11026309	factory
157528	2022-01-31 07:05:19	2022-01-31 15:30:32	11026309	factory
157529	2022-02-07 06:57:27	2022-02-07 15:31:11	11026309	factory
157530	2022-02-08 06:59:24	2022-02-08 15:30:32	11026309	factory
157531	2022-02-09 07:01:12	2022-02-09 15:30:58	11026309	factory
157532	2022-02-10 07:03:34	2022-02-10 15:31:51	11026309	factory
157533	2022-02-11 07:08:10	2022-02-11 15:32:26	11026309	factory
157534	2022-02-14 07:04:02	2022-02-14 15:30:58	11026309	factory
157535	2022-02-15 07:01:02	2022-02-15 15:25:29	11026309	factory
157536	2022-02-16 07:05:27	2022-02-16 15:30:29	11026309	factory
157537	2022-02-17 06:59:28	2022-02-17 15:29:14	11026309	factory
157538	2022-02-18 07:02:11	2022-02-18 15:30:00	11026309	factory
157539	2022-02-21 06:59:37	2022-02-21 15:34:08	11026309	factory
157540	2022-02-22 07:02:57	2022-02-22 15:31:22	11026309	factory
157541	2022-02-23 07:06:31	2022-02-23 15:31:35	11026309	factory
157542	2022-02-24 15:31:26	\N	11026309	factory
157543	2022-02-25 07:03:00	2022-02-25 14:28:06	11026309	factory
157544	2022-02-28 07:05:44	2022-02-28 15:31:15	11026309	factory
157545	2022-03-01 07:00:38	2022-03-01 15:29:00	11026309	factory
157546	2021-12-01 06:14:18	2021-12-01 15:56:56	11034232	factory
157547	2021-12-02 06:13:49	2021-12-02 16:05:03	11034232	factory
157548	2021-12-03 06:11:55	2021-12-03 15:51:14	11034232	factory
157549	2021-12-04 06:15:20	2021-12-04 12:23:24	11034232	factory
157550	2021-12-06 06:12:10	2021-12-06 16:01:36	11034232	factory
157551	2021-12-07 06:19:20	2021-12-07 15:58:02	11034232	factory
157552	2021-12-08 06:22:13	2021-12-08 16:01:22	11034232	factory
157553	2021-12-09 06:21:09	2021-12-09 16:06:20	11034232	factory
157554	2021-12-10 06:12:03	2021-12-10 16:09:34	11034232	factory
157555	2021-12-13 06:13:52	\N	11034232	factory
157556	2021-12-14 06:19:16	\N	11034232	factory
157557	2021-12-15 06:21:34	\N	11034232	factory
157558	2021-12-16 06:14:24	\N	11034232	factory
157559	2021-12-17 06:12:57	2021-12-17 16:01:54	11034232	factory
157560	2021-12-18 06:16:07	2021-12-18 13:05:39	11034232	factory
157561	2021-12-20 06:14:46	2021-12-20 16:08:35	11034232	factory
157562	2021-12-21 06:13:28	2021-12-21 16:09:16	11034232	factory
157563	2021-12-22 06:11:52	2021-12-22 18:41:39	11034232	factory
157564	2021-12-23 06:20:50	\N	11034232	factory
157565	2021-12-24 06:21:13	2021-12-24 18:50:21	11034232	factory
157566	2021-12-25 06:20:17	\N	11034232	factory
157567	2021-12-27 06:13:17	\N	11034232	factory
157568	2021-12-28 06:05:04	\N	11034232	factory
157569	2022-01-04 06:21:32	2022-01-04 15:33:26	11034232	factory
157570	2022-01-05 06:15:24	2022-01-05 15:08:49	11034232	factory
157571	2022-01-06 06:12:38	2022-01-06 13:55:03	11034232	factory
157572	2022-01-10 06:20:24	2022-01-10 16:07:32	11034232	factory
157573	2022-01-11 06:25:19	2022-01-11 16:03:53	11034232	factory
157574	2022-01-12 06:17:06	2022-01-12 16:11:06	11034232	factory
157575	2022-01-13 06:21:08	2022-01-13 16:14:02	11034232	factory
157576	2022-01-14 06:19:21	2022-01-14 16:08:33	11034232	factory
157577	2022-01-15 06:26:18	2022-01-15 12:57:22	11034232	factory
157578	2022-01-17 06:26:17	2022-01-17 16:09:00	11034232	factory
157579	2022-01-18 06:23:47	2022-01-18 16:00:04	11034232	factory
157580	2022-01-19 06:05:12	2022-01-19 16:05:58	11034232	factory
157581	2022-01-20 06:20:42	2022-01-20 16:05:50	11034232	factory
157582	2022-01-21 06:24:43	2022-01-21 16:02:11	11034232	factory
157583	2022-01-22 06:35:59	2022-01-22 12:22:00	11034232	factory
157584	2022-01-24 06:18:29	2022-01-24 16:11:07	11034232	factory
157585	2022-01-25 06:31:16	2022-01-25 16:15:57	11034232	factory
157586	2022-01-26 06:35:52	2022-01-26 16:13:05	11034232	factory
157587	2022-01-27 06:23:25	2022-01-27 16:02:25	11034232	factory
157588	2022-01-28 06:20:35	2022-01-28 09:05:12	11034232	factory
157589	2022-01-31 06:18:34	2022-01-31 16:14:03	11034232	factory
157590	2022-02-01 06:40:06	2022-02-01 16:06:31	11034232	factory
157591	2022-02-02 06:15:59	2022-02-02 16:05:46	11034232	factory
157592	2022-02-03 06:24:43	2022-02-03 15:59:05	11034232	factory
157593	2022-02-04 06:20:13	2022-02-04 16:02:23	11034232	factory
157594	2022-02-07 06:33:15	2022-02-07 15:52:18	11034232	factory
157595	2022-02-08 06:07:01	2022-02-08 16:02:33	11034232	factory
157596	2022-02-09 06:21:06	2022-02-09 16:17:50	11034232	factory
157597	2022-02-10 06:13:47	2022-02-10 15:58:53	11034232	factory
157598	2022-02-11 06:06:40	2022-02-11 16:11:38	11034232	factory
157599	2022-02-14 06:31:15	2022-02-14 16:03:51	11034232	factory
157600	2022-02-15 06:09:51	2022-02-15 16:10:21	11034232	factory
157601	2022-02-16 06:20:25	2022-02-16 15:53:01	11034232	factory
157602	2022-02-17 06:19:00	2022-02-17 15:58:28	11034232	factory
157603	2022-02-18 06:21:16	2022-02-18 16:11:51	11034232	factory
157604	2022-02-21 06:21:30	2022-02-21 16:10:48	11034232	factory
157605	2022-02-22 06:22:11	2022-02-22 16:13:59	11034232	factory
157606	2022-02-23 06:37:41	2022-02-23 15:48:09	11034232	factory
157607	2022-02-24 06:23:01	2022-02-24 16:01:16	11034232	factory
157608	2022-02-25 06:27:32	2022-02-25 15:08:10	11034232	factory
157609	2022-02-26 06:21:41	2022-02-26 12:51:33	11034232	factory
157610	2022-02-28 06:23:30	2022-02-28 16:18:35	11034232	factory
157611	2022-03-01 06:16:50	2022-03-01 16:03:34	11034232	factory
157612	2021-12-02 05:40:07	2021-12-02 14:29:12	11051237	factory
157613	2021-12-03 05:40:20	2021-12-03 14:27:28	11051237	factory
157614	2021-12-06 05:45:34	2021-12-06 14:39:44	11051237	factory
157615	2021-12-07 05:44:59	2021-12-07 14:37:32	11051237	factory
157616	2021-12-08 05:46:09	2021-12-08 14:31:23	11051237	factory
157617	2021-12-09 05:49:15	2021-12-09 14:33:56	11051237	factory
157618	2021-12-10 05:41:33	2021-12-10 13:22:38	11051237	factory
157619	2021-12-13 05:37:48	2021-12-13 14:38:52	11051237	factory
157620	2021-12-14 05:53:03	2021-12-14 14:35:57	11051237	factory
157621	2021-12-15 05:44:19	2021-12-15 14:33:05	11051237	factory
157622	2021-12-16 05:43:40	2021-12-16 14:27:07	11051237	factory
157623	2021-12-17 05:46:20	2021-12-17 13:59:15	11051237	factory
157624	2021-12-20 05:47:01	2021-12-20 14:31:38	11051237	factory
157625	2021-12-21 05:52:38	2021-12-21 14:40:43	11051237	factory
157626	2021-12-22 05:43:04	2021-12-22 14:38:06	11051237	factory
157627	2021-12-23 05:44:25	2021-12-23 14:32:59	11051237	factory
157628	2021-12-24 05:48:04	2021-12-24 14:27:42	11051237	factory
157629	2021-12-25 05:45:30	2021-12-25 11:38:25	11051237	factory
157630	2021-12-27 05:43:41	2021-12-27 14:30:39	11051237	factory
157631	2021-12-28 06:24:25	2021-12-28 14:18:29	11051237	factory
157632	2022-01-04 06:06:26	2022-01-04 14:45:48	11051237	factory
157633	2022-01-05 05:50:08	2022-01-05 13:45:01	11051237	factory
157634	2022-01-06 05:53:33	2022-01-06 11:54:50	11051237	factory
157635	2022-01-10 05:50:39	2022-01-10 14:40:29	11051237	factory
157636	2022-01-11 05:50:50	2022-01-11 14:47:22	11051237	factory
157637	2022-01-12 05:52:10	2022-01-12 14:38:33	11051237	factory
157638	2022-01-13 05:51:12	2022-01-13 14:33:45	11051237	factory
157639	2022-01-14 05:43:25	2022-01-14 15:00:35	11051237	factory
157640	2022-01-17 05:44:05	2022-01-17 14:33:27	11051237	factory
157641	2022-01-18 05:34:28	2022-01-18 14:42:29	11051237	factory
157642	2022-01-19 05:55:20	2022-01-19 14:34:12	11051237	factory
157643	2022-01-20 05:38:39	2022-01-20 12:57:39	11051237	factory
157644	2022-01-21 05:43:32	2022-01-21 13:43:13	11051237	factory
157645	2022-01-24 05:44:54	2022-01-24 14:40:50	11051237	factory
157646	2022-01-25 05:39:23	2022-01-25 14:36:16	11051237	factory
157647	2022-01-26 06:00:20	2022-01-26 14:46:53	11051237	factory
157648	2022-01-27 05:38:32	2022-01-27 15:05:06	11051237	factory
157649	2022-02-09 05:34:27	2022-02-09 14:34:30	11051237	factory
157650	2022-02-10 05:36:50	2022-02-10 15:04:54	11051237	factory
157651	2022-02-11 05:40:57	2022-02-11 13:34:50	11051237	factory
157652	2022-02-14 05:43:13	2022-02-14 14:36:05	11051237	factory
157653	2022-02-15 05:43:45	2022-02-15 14:45:32	11051237	factory
157654	2022-02-16 05:40:55	2022-02-16 14:51:24	11051237	factory
157655	2022-02-17 05:37:35	2022-02-17 14:44:54	11051237	factory
157656	2022-02-18 05:32:35	2022-02-18 15:30:02	11051237	factory
157657	2022-02-19 05:42:40	2022-02-19 11:35:54	11051237	factory
157658	2022-02-21 05:43:41	2022-02-21 15:22:08	11051237	factory
157659	2022-02-22 05:40:01	2022-02-22 15:32:13	11051237	factory
157660	2022-02-24 05:43:39	2022-02-24 15:07:08	11051237	factory
157661	2022-02-25 05:39:30	2022-02-25 13:49:50	11051237	factory
157662	2022-02-28 05:33:37	2022-02-28 15:01:58	11051237	factory
157663	2022-03-01 05:36:41	2022-03-01 14:39:57	11051237	factory
157664	2022-03-02 05:38:03	\N	11051237	factory
157665	2021-12-01 06:00:27	\N	11039913	factory
157666	2021-12-02 05:40:15	2021-12-02 16:01:50	11039913	factory
157667	2021-12-03 05:35:03	2021-12-03 14:49:47	11039913	factory
157668	2021-12-04 06:01:46	2021-12-04 11:18:12	11039913	factory
157669	2021-12-06 05:45:44	2021-12-06 15:40:34	11039913	factory
157670	2021-12-07 05:45:11	2021-12-07 15:20:30	11039913	factory
157671	2021-12-08 05:42:28	2021-12-08 15:31:54	11039913	factory
157672	2021-12-09 05:45:43	2021-12-09 14:34:14	11039913	factory
157673	2021-12-10 05:41:37	2021-12-10 15:37:22	11039913	factory
157674	2021-12-11 06:07:41	2021-12-11 12:05:18	11039913	factory
157675	2021-12-13 05:46:36	\N	11039913	factory
157676	2021-12-14 05:44:30	\N	11039913	factory
157677	2021-12-15 08:39:21	2021-12-15 14:36:17	11039913	factory
157678	2021-12-16 05:44:11	2021-12-16 14:30:07	11039913	factory
157679	2021-12-17 05:42:24	2021-12-17 16:32:00	11039913	factory
157680	2021-12-18 05:45:57	2021-12-18 11:19:15	11039913	factory
157681	2021-12-20 05:42:08	2021-12-20 14:30:07	11039913	factory
157682	2021-12-21 05:42:26	2021-12-21 15:31:27	11039913	factory
157683	2021-12-22 05:38:54	2021-12-22 18:10:45	11039913	factory
157684	2021-12-23 05:40:38	2021-12-23 18:10:10	11039913	factory
157685	2021-12-24 05:37:44	2021-12-24 15:33:35	11039913	factory
157686	2021-12-25 05:46:06	2021-12-25 13:29:02	11039913	factory
157687	2021-12-27 05:35:23	2021-12-27 14:37:23	11039913	factory
157688	2021-12-28 05:43:34	\N	11039913	factory
157689	2022-01-04 05:48:00	2022-01-04 14:33:42	11039913	factory
157690	2022-01-05 05:44:45	2022-01-05 14:32:50	11039913	factory
157691	2022-01-06 05:47:30	2022-01-06 12:09:38	11039913	factory
157692	2022-01-10 05:55:30	2022-01-10 16:25:20	11039913	factory
157693	2022-01-11 05:44:11	2022-01-11 16:16:29	11039913	factory
157694	2022-01-12 05:41:21	2022-01-12 15:30:07	11039913	factory
157695	2022-01-13 05:48:28	2022-01-13 16:20:31	11039913	factory
157696	2022-01-14 05:44:17	2022-01-14 14:31:58	11039913	factory
157697	2022-01-17 05:44:30	2022-01-17 18:20:49	11039913	factory
157698	2022-01-18 05:45:37	2022-01-18 18:18:33	11039913	factory
157699	2022-01-19 05:46:35	\N	11039913	factory
157700	2022-01-20 05:49:07	2022-01-20 14:36:32	11039913	factory
157701	2022-01-21 05:48:28	2022-01-21 15:31:08	11039913	factory
157702	2022-01-22 06:41:07	\N	11039913	factory
157703	2022-01-24 15:03:19	\N	11039913	factory
157704	2022-01-25 05:53:23	2022-01-25 14:26:50	11039913	factory
157705	2022-01-26 05:52:22	2022-01-26 14:30:57	11039913	factory
157706	2022-01-27 05:48:52	2022-01-27 14:10:30	11039913	factory
157707	2022-01-31 05:53:11	2022-01-31 16:22:55	11039913	factory
157708	2022-02-01 05:53:58	2022-02-01 16:25:01	11039913	factory
157709	2022-02-02 05:53:05	2022-02-02 16:21:29	11039913	factory
157710	2022-02-03 16:25:07	2022-02-04 05:52:29	11039913	factory
157711	2022-02-04 16:25:11	\N	11039913	factory
157712	2022-02-07 05:52:40	2022-02-07 18:30:58	11039913	factory
157713	2022-02-08 05:57:42	2022-02-08 16:24:34	11039913	factory
157714	2022-02-09 05:53:12	2022-02-09 15:30:22	11039913	factory
157715	2022-02-10 05:52:11	2022-02-10 16:00:08	11039913	factory
157716	2022-02-11 05:48:52	2022-02-11 15:25:20	11039913	factory
157717	2022-02-14 05:52:55	2022-02-14 14:49:58	11039913	factory
157718	2022-02-15 05:48:10	2022-02-15 16:27:37	11039913	factory
157719	2022-02-16 05:51:29	2022-02-16 14:51:34	11039913	factory
157720	2022-02-17 05:51:32	2022-02-17 16:18:00	11039913	factory
157721	2022-02-18 05:49:04	2022-02-18 15:35:01	11039913	factory
157722	2022-02-19 05:43:58	2022-02-19 10:13:33	11039913	factory
157723	2022-02-21 05:50:58	2022-02-21 15:30:31	11039913	factory
157724	2022-02-22 05:50:44	2022-02-22 14:32:52	11039913	factory
157725	2022-02-25 05:49:05	2022-02-25 15:34:09	11039913	factory
157726	2022-02-28 05:47:12	2022-02-28 14:34:50	11039913	factory
157727	2022-03-01 05:49:39	2022-03-01 16:28:04	11039913	factory
157728	2021-12-03 06:33:14	2021-12-03 15:28:41	11041310	factory
157729	2021-12-06 06:40:53	2021-12-06 15:28:48	11041310	factory
157730	2021-12-07 06:41:14	2021-12-07 15:28:47	11041310	factory
157731	2021-12-08 06:36:28	2021-12-08 15:28:50	11041310	factory
157732	2021-12-09 06:39:24	2021-12-09 15:28:46	11041310	factory
157733	2021-12-10 06:35:26	2021-12-10 15:28:45	11041310	factory
157734	2021-12-13 06:34:02	2021-12-13 15:28:44	11041310	factory
157735	2021-12-14 06:33:24	2021-12-14 15:28:45	11041310	factory
157736	2021-12-15 06:37:02	2021-12-15 15:28:43	11041310	factory
157737	2021-12-16 06:43:18	2021-12-16 15:28:41	11041310	factory
157738	2021-12-17 06:36:49	2021-12-17 15:28:41	11041310	factory
157739	2021-12-20 06:32:02	2021-12-20 15:29:57	11041310	factory
157740	2021-12-21 06:37:56	2021-12-21 15:29:59	11041310	factory
157741	2021-12-22 06:37:02	2021-12-22 15:30:03	11041310	factory
157742	2021-12-23 06:30:13	2021-12-23 15:30:03	11041310	factory
157743	2021-12-24 06:38:40	2021-12-24 15:30:04	11041310	factory
157744	2021-12-25 06:36:19	2021-12-25 14:29:51	11041310	factory
157745	2021-12-27 06:36:00	2021-12-27 15:30:04	11041310	factory
157746	2021-12-28 06:33:36	2021-12-28 15:29:07	11041310	factory
157747	2021-12-29 06:48:57	2021-12-29 11:43:49	11041310	factory
157748	2022-01-10 06:29:57	2022-01-10 15:30:17	11041310	factory
157749	2022-01-11 06:33:11	2022-01-11 15:30:01	11041310	factory
157750	2022-01-12 06:37:14	2022-01-12 15:30:22	11041310	factory
157751	2022-01-13 06:31:02	2022-01-13 15:30:05	11041310	factory
157752	2022-01-14 06:29:46	2022-01-14 15:30:04	11041310	factory
157753	2022-01-17 06:27:54	2022-01-17 15:30:33	11041310	factory
157754	2022-01-18 06:38:40	2022-01-18 15:32:03	11041310	factory
157755	2022-01-19 06:37:13	2022-01-19 15:30:03	11041310	factory
157756	2022-01-20 06:37:48	2022-01-20 15:30:09	11041310	factory
157757	2022-01-21 06:34:47	2022-01-21 15:31:03	11041310	factory
157758	2022-01-24 06:35:48	2022-01-24 15:30:09	11041310	factory
157759	2022-01-25 06:32:42	2022-01-25 15:30:45	11041310	factory
157760	2022-01-26 06:30:20	2022-01-26 15:30:06	11041310	factory
157761	2022-01-27 06:32:50	2022-01-27 15:30:56	11041310	factory
157762	2022-01-28 06:35:47	2022-01-28 15:31:53	11041310	factory
157763	2022-01-31 06:36:12	2022-01-31 15:30:00	11041310	factory
157764	2022-02-01 06:30:45	2022-02-01 15:30:30	11041310	factory
157765	2022-02-02 06:26:57	2022-02-02 15:30:04	11041310	factory
157766	2022-02-03 06:28:15	2022-02-03 15:30:07	11041310	factory
157767	2022-02-04 06:28:31	2022-02-04 15:31:57	11041310	factory
157768	2022-02-07 06:24:34	2022-02-07 15:30:04	11041310	factory
157769	2022-02-08 06:32:09	2022-02-08 15:30:07	11041310	factory
157770	2022-02-09 06:31:38	2022-02-09 15:30:11	11041310	factory
157771	2022-02-10 06:32:20	2022-02-10 15:30:03	11041310	factory
157772	2022-02-11 06:29:19	2022-02-11 15:27:40	11041310	factory
157773	2022-02-14 06:40:08	2022-02-14 15:30:08	11041310	factory
157774	2022-02-15 06:30:31	2022-02-15 15:30:12	11041310	factory
157775	2022-02-16 06:26:26	2022-02-16 15:30:19	11041310	factory
157776	2022-02-17 06:25:52	2022-02-17 15:32:11	11041310	factory
157777	2022-02-18 06:24:51	2022-02-18 15:30:44	11041310	factory
157778	2022-02-21 06:36:07	2022-02-21 15:30:10	11041310	factory
157779	2022-02-22 06:31:50	2022-02-22 15:28:45	11041310	factory
157780	2022-02-23 06:35:02	2022-02-23 15:30:02	11041310	factory
157781	2022-02-24 06:30:43	2022-02-24 15:30:12	11041310	factory
157782	2022-02-25 06:32:50	2022-02-25 14:30:29	11041310	factory
157783	2022-02-28 06:28:46	2022-02-28 15:30:09	11041310	factory
157784	2022-03-01 06:26:07	2022-03-01 15:30:03	11041310	factory
157785	2021-11-20 13:06:54	\N	11196059	factory
157786	2021-11-23 15:47:07	\N	11196059	factory
157787	2021-12-01 15:59:24	\N	11196059	factory
157788	2021-12-02 16:07:28	\N	11196059	factory
157789	2021-12-03 16:06:04	\N	11196059	factory
157790	2021-12-06 07:06:39	2021-12-06 15:43:54	11196059	factory
157791	2021-12-07 07:12:47	2021-12-07 16:45:46	11196059	factory
157792	2021-12-08 15:53:28	\N	11196059	factory
157793	2021-12-09 07:05:55	2021-12-09 16:02:43	11196059	factory
157794	2021-12-10 07:06:30	2021-12-10 15:37:26	11196059	factory
157795	2021-12-13 15:48:36	\N	11196059	factory
157796	2021-12-14 15:55:22	\N	11196059	factory
157797	2021-12-15 15:57:20	\N	11196059	factory
157798	2021-12-16 15:46:38	\N	11196059	factory
157799	2021-12-17 16:13:34	\N	11196059	factory
157800	2021-12-20 16:09:15	\N	11196059	factory
157801	2021-12-21 07:16:09	2021-12-21 16:12:00	11196059	factory
157802	2021-12-22 15:56:13	\N	11196059	factory
157803	2021-12-23 07:04:58	2021-12-23 15:44:33	11196059	factory
157804	2021-12-24 07:15:00	2021-12-24 15:45:24	11196059	factory
157805	2021-12-25 06:59:19	2021-12-25 14:40:09	11196059	factory
157806	2021-12-27 07:16:52	2021-12-27 15:55:34	11196059	factory
157807	2021-12-28 07:12:53	2021-12-28 16:04:37	11196059	factory
157808	2021-12-29 11:54:55	\N	11196059	factory
157809	2022-01-04 07:25:24	2022-01-04 15:26:56	11196059	factory
157810	2022-01-05 07:20:30	2022-01-05 15:40:24	11196059	factory
157811	2022-01-06 14:10:26	\N	11196059	factory
157812	2022-01-10 07:11:58	2022-01-10 15:43:38	11196059	factory
157813	2022-01-11 07:07:36	2022-01-11 16:07:32	11196059	factory
157814	2022-01-12 07:19:52	2022-01-12 16:01:38	11196059	factory
157815	2022-01-13 07:08:03	2022-01-13 16:41:31	11196059	factory
157816	2022-01-14 07:11:50	2022-01-14 16:22:04	11196059	factory
157817	2022-01-17 07:14:08	2022-01-17 15:59:18	11196059	factory
157818	2022-01-18 07:15:12	2022-01-18 15:51:41	11196059	factory
157819	2022-01-19 07:17:40	2022-01-19 15:56:09	11196059	factory
157820	2022-01-20 07:24:27	2022-01-20 16:56:08	11196059	factory
157821	2022-01-21 07:22:47	2022-01-21 15:59:26	11196059	factory
157822	2022-01-24 16:10:01	\N	11196059	factory
157823	2022-01-25 07:09:38	2022-01-25 16:48:08	11196059	factory
157824	2022-01-26 16:17:53	\N	11196059	factory
157825	2022-02-16 06:58:12	2022-02-16 16:48:39	11196059	factory
157826	2022-02-17 07:09:19	2022-02-17 16:06:34	11196059	factory
157827	2022-02-18 07:10:58	2022-02-18 16:13:42	11196059	factory
157828	2022-02-19 14:57:43	\N	11196059	factory
157829	2022-02-21 15:59:28	\N	11196059	factory
157830	2022-02-22 07:15:07	2022-02-22 16:45:10	11196059	factory
157831	2022-02-23 06:20:59	2022-02-23 15:37:01	11196059	factory
157832	2022-02-24 07:03:20	2022-02-24 16:55:48	11196059	factory
157833	2022-02-25 07:15:44	2022-02-25 15:00:00	11196059	factory
157834	2022-02-28 07:06:24	2022-02-28 16:37:50	11196059	factory
157835	2022-03-01 07:14:27	2022-03-01 16:14:04	11196059	factory
157836	2021-12-01 05:49:13	2021-12-01 14:28:56	11196060	factory
157837	2021-12-02 06:05:58	2021-12-02 14:40:49	11196060	factory
157838	2021-12-03 05:35:10	2021-12-03 15:08:38	11196060	factory
157839	2021-12-06 05:37:22	2021-12-06 15:15:50	11196060	factory
157840	2021-12-07 05:33:52	2021-12-07 15:06:39	11196060	factory
157841	2021-12-08 05:40:29	2021-12-08 14:41:34	11196060	factory
157842	2021-12-09 05:35:23	2021-12-09 15:20:15	11196060	factory
157843	2021-12-10 05:41:50	2021-12-10 15:14:41	11196060	factory
157844	2021-12-13 05:43:11	2021-12-13 14:38:58	11196060	factory
157845	2021-12-14 05:46:40	2021-12-14 14:37:16	11196060	factory
157846	2021-12-15 05:36:03	2021-12-15 14:36:09	11196060	factory
157847	2021-12-16 05:55:25	2021-12-16 14:46:39	11196060	factory
157848	2021-12-17 05:39:43	2021-12-17 14:40:10	11196060	factory
157849	2021-12-20 05:42:14	2021-12-20 15:38:15	11196060	factory
157850	2021-12-21 05:42:21	2021-12-21 14:54:12	11196060	factory
157851	2021-12-22 05:33:51	2021-12-22 15:31:59	11196060	factory
157852	2021-12-23 05:44:36	2021-12-23 15:31:40	11196060	factory
157853	2021-12-24 05:37:32	2021-12-24 15:37:37	11196060	factory
157854	2021-12-25 05:35:32	2021-12-25 13:28:59	11196060	factory
157855	2021-12-27 05:41:42	2021-12-27 15:13:12	11196060	factory
157856	2021-12-28 05:32:01	2021-12-28 15:09:31	11196060	factory
157857	2021-12-29 06:17:54	\N	11196060	factory
157858	2022-01-10 05:43:40	2022-01-10 15:37:36	11196060	factory
157859	2022-01-11 05:44:08	2022-01-11 15:37:13	11196060	factory
157860	2022-01-12 05:41:17	2022-01-12 15:30:16	11196060	factory
157861	2022-01-13 05:38:18	2022-01-13 15:37:51	11196060	factory
157862	2022-01-14 05:43:41	2022-01-14 15:37:15	11196060	factory
157863	2022-01-17 05:39:44	2022-01-17 15:30:38	11196060	factory
157864	2022-01-18 05:42:17	2022-01-18 15:30:45	11196060	factory
157865	2022-01-19 05:43:04	2022-01-19 15:31:59	11196060	factory
157866	2022-01-20 05:42:10	2022-01-20 15:33:06	11196060	factory
157867	2022-01-21 05:26:36	2022-01-21 15:31:50	11196060	factory
157868	2022-01-24 05:39:34	2022-01-24 15:30:13	11196060	factory
157869	2022-01-25 05:36:49	2022-01-25 15:31:00	11196060	factory
157870	2022-01-26 05:40:54	2022-01-26 15:32:51	11196060	factory
157871	2022-01-27 05:43:57	2022-01-27 15:31:46	11196060	factory
157872	2022-01-28 05:37:41	2022-01-28 15:30:59	11196060	factory
157873	2022-01-31 05:40:33	2022-01-31 14:39:01	11196060	factory
157874	2022-02-01 05:38:32	2022-02-01 15:34:41	11196060	factory
157875	2022-02-02 05:41:56	2022-02-02 15:40:53	11196060	factory
157876	2022-02-03 05:35:38	2022-02-03 15:38:37	11196060	factory
157877	2022-02-04 05:40:13	2022-02-04 15:37:40	11196060	factory
157878	2022-02-07 05:42:28	2022-02-07 15:07:49	11196060	factory
157879	2022-02-08 05:40:29	2022-02-08 14:53:55	11196060	factory
157880	2022-02-09 05:29:07	2022-02-09 15:34:41	11196060	factory
157881	2022-02-10 05:39:43	2022-02-10 15:39:30	11196060	factory
157882	2022-02-11 05:44:06	2022-02-11 15:31:59	11196060	factory
157883	2022-02-14 05:33:44	2022-02-14 15:38:54	11196060	factory
157884	2022-02-15 05:30:19	2022-02-15 15:35:37	11196060	factory
157885	2022-02-16 05:33:23	2022-02-16 15:34:26	11196060	factory
157886	2022-02-17 05:32:16	2022-02-17 15:39:24	11196060	factory
157887	2022-02-18 05:32:45	2022-02-18 14:33:44	11196060	factory
157888	2022-02-19 05:59:04	2022-02-19 12:01:07	11196060	factory
157889	2022-02-21 05:32:12	2022-02-21 15:50:09	11196060	factory
157890	2022-02-22 05:45:32	2022-02-22 15:37:54	11196060	factory
157891	2022-02-23 05:44:43	2022-02-23 14:50:54	11196060	factory
157892	2022-02-24 05:37:27	2022-02-24 15:39:03	11196060	factory
157893	2022-02-25 05:39:23	2022-02-25 14:06:59	11196060	factory
157894	2022-02-28 05:37:56	2022-02-28 15:37:21	11196060	factory
157895	2022-03-01 05:31:29	2022-03-01 15:35:47	11196060	factory
157896	2021-11-17 06:44:26	\N	11046678	factory
157897	2021-11-18 06:38:24	\N	11046678	factory
157898	2021-11-15 15:34:08	\N	11045614	factory
157899	2021-12-01 06:02:28	\N	11045614	factory
157900	2021-12-02 06:03:06	\N	11045614	factory
157901	2021-12-03 05:54:12	\N	11045614	factory
157902	2021-12-08 05:57:44	2021-12-08 15:31:26	11045614	factory
157903	2021-12-09 05:53:57	2021-12-09 14:38:17	11045614	factory
157904	2021-12-10 05:54:05	2021-12-10 14:29:55	11045614	factory
157905	2021-12-11 06:04:06	2021-12-11 11:55:30	11045614	factory
157906	2021-12-13 05:58:54	2021-12-13 15:24:16	11045614	factory
157907	2021-12-14 05:53:14	2021-12-14 14:55:00	11045614	factory
157908	2021-12-15 06:04:19	2021-12-15 15:29:37	11045614	factory
157909	2021-12-16 05:55:15	\N	11045614	factory
157910	2021-12-17 06:01:29	2021-12-17 15:44:11	11045614	factory
157911	2021-12-18 05:54:09	2021-12-18 11:03:38	11045614	factory
157912	2021-12-20 06:04:14	2021-12-20 14:31:42	11045614	factory
157913	2021-12-21 05:59:39	2021-12-21 14:34:31	11045614	factory
157914	2021-12-22 06:10:09	2021-12-22 15:18:28	11045614	factory
157915	2021-12-23 08:15:56	\N	11045614	factory
157916	2021-12-24 05:48:26	2021-12-24 14:38:01	11045614	factory
157917	2021-12-25 05:55:31	2021-12-25 13:52:42	11045614	factory
157918	2021-12-27 14:33:25	\N	11045614	factory
157919	2021-12-28 07:11:51	\N	11045614	factory
157920	2022-01-04 06:01:20	2022-01-04 14:34:51	11045614	factory
157921	2022-01-05 06:14:42	2022-01-05 13:53:51	11045614	factory
157922	2022-01-06 05:53:45	2022-01-06 12:09:45	11045614	factory
157923	2022-01-10 06:53:03	\N	11045614	factory
157924	2022-01-11 06:53:11	\N	11045614	factory
157925	2022-01-12 06:03:46	2022-01-12 14:32:27	11045614	factory
157926	2022-01-14 05:53:49	2022-01-14 15:08:24	11045614	factory
157927	2022-01-15 05:49:10	2022-01-15 11:08:51	11045614	factory
157928	2022-01-17 05:54:14	2022-01-17 15:18:05	11045614	factory
157929	2022-01-18 05:58:17	2022-01-18 15:14:20	11045614	factory
157930	2022-01-19 05:56:19	2022-01-19 16:52:42	11045614	factory
157931	2022-01-20 06:52:42	\N	11045614	factory
157932	2022-01-21 05:51:54	2022-01-21 14:39:40	11045614	factory
157933	2022-01-22 05:49:49	2022-01-22 12:04:44	11045614	factory
157934	2022-01-24 06:01:32	2022-01-24 14:45:57	11045614	factory
157935	2022-01-25 05:55:20	\N	11045614	factory
157936	2022-01-26 05:52:18	2022-01-26 14:31:04	11045614	factory
157937	2022-01-27 05:54:19	2022-01-27 14:30:41	11045614	factory
157938	2022-02-01 06:53:30	\N	11045614	factory
157939	2022-02-02 06:39:45	2022-02-02 14:21:22	11045614	factory
157940	2022-02-03 06:28:37	2022-02-03 14:19:03	11045614	factory
157941	2022-02-04 06:38:57	2022-02-04 13:53:53	11045614	factory
157942	2022-02-05 06:02:00	2022-02-05 11:01:45	11045614	factory
157943	2022-02-07 05:58:30	2022-02-07 15:26:31	11045614	factory
157944	2022-02-08 05:59:45	2022-02-08 16:24:41	11045614	factory
157945	2022-02-09 06:01:11	2022-02-09 14:31:33	11045614	factory
157946	2022-02-10 06:02:18	2022-02-10 14:00:05	11045614	factory
157947	2022-02-11 05:51:25	2022-02-11 15:01:25	11045614	factory
157948	2022-02-12 06:05:45	2022-02-12 11:03:43	11045614	factory
157949	2022-02-14 06:00:33	2022-02-14 14:24:29	11045614	factory
157950	2022-02-15 06:02:40	2022-02-15 14:04:58	11045614	factory
157951	2022-02-16 06:57:13	2022-02-16 14:51:17	11045614	factory
157952	2022-02-17 06:39:15	2022-02-17 14:27:21	11045614	factory
157953	2022-02-18 06:16:56	\N	11045614	factory
157954	2022-02-21 05:54:54	2022-02-21 15:32:52	11045614	factory
157955	2022-02-22 05:55:02	2022-02-22 14:53:01	11045614	factory
157956	2022-02-23 05:56:31	\N	11045614	factory
157957	2022-02-24 05:57:31	2022-02-24 14:38:20	11045614	factory
157958	2022-02-25 05:56:29	2022-02-25 15:46:50	11045614	factory
157959	2022-02-26 05:58:41	2022-02-26 11:44:08	11045614	factory
157960	2022-02-28 05:58:13	\N	11045614	factory
157961	2022-03-01 05:59:16	2022-03-01 14:10:36	11045614	factory
157962	2021-11-16 05:36:51	\N	11001382	factory
157963	2021-12-02 05:51:57	2021-12-02 15:39:39	11001382	factory
157964	2021-12-03 05:34:58	2021-12-03 15:31:00	11001382	factory
157965	2021-12-04 05:37:34	2021-12-04 12:01:13	11001382	factory
157966	2021-12-06 05:37:08	2021-12-06 15:30:32	11001382	factory
157967	2021-12-07 05:33:44	2021-12-07 15:36:18	11001382	factory
157968	2021-12-08 05:40:23	2021-12-08 15:37:27	11001382	factory
157969	2021-12-09 05:35:12	2021-12-09 15:33:59	11001382	factory
157970	2021-12-10 05:41:18	2021-12-10 15:36:43	11001382	factory
157971	2021-12-11 05:40:10	2021-12-11 11:59:17	11001382	factory
157972	2021-12-13 05:43:21	2021-12-13 15:41:00	11001382	factory
157973	2021-12-14 05:46:35	2021-12-14 15:41:04	11001382	factory
157974	2021-12-15 05:35:58	2021-12-15 14:35:51	11001382	factory
157975	2021-12-16 05:29:26	2021-12-16 15:42:43	11001382	factory
157976	2021-12-17 05:39:39	2021-12-17 15:40:56	11001382	factory
157977	2021-12-18 05:45:54	2021-12-18 12:00:46	11001382	factory
157978	2021-12-20 05:42:10	2021-12-20 15:41:52	11001382	factory
157979	2021-12-21 05:42:02	2021-12-21 15:35:32	11001382	factory
157980	2021-12-22 05:38:34	2021-12-22 15:33:43	11001382	factory
157981	2021-12-23 05:44:31	2021-12-23 15:40:41	11001382	factory
157982	2021-12-24 05:37:27	2021-12-24 15:37:33	11001382	factory
157983	2021-12-25 05:35:28	2021-12-25 12:19:26	11001382	factory
157984	2021-12-27 05:35:14	2021-12-27 15:47:08	11001382	factory
157985	2021-12-28 05:43:29	2021-12-28 14:53:53	11001382	factory
157986	2022-01-04 05:47:57	2022-01-04 14:33:23	11001382	factory
157987	2022-01-05 05:47:27	2022-01-05 14:34:45	11001382	factory
157988	2022-01-06 05:47:34	2022-01-06 13:56:54	11001382	factory
157989	2022-01-10 05:43:34	2022-01-10 15:37:32	11001382	factory
157990	2022-01-11 05:44:03	2022-01-11 15:37:09	11001382	factory
157991	2022-01-12 05:41:13	2022-01-12 14:33:40	11001382	factory
157992	2022-01-14 05:43:35	2022-01-14 15:37:09	11001382	factory
157993	2022-01-15 05:47:57	2022-01-15 12:01:17	11001382	factory
157994	2022-01-17 05:39:50	2022-01-17 15:35:56	11001382	factory
157995	2022-01-18 05:42:11	2022-01-18 15:38:20	11001382	factory
157996	2022-01-19 05:42:55	2022-01-19 15:46:50	11001382	factory
157997	2022-01-20 05:34:01	2022-01-20 15:38:42	11001382	factory
157998	2022-01-21 05:39:04	2022-01-21 15:35:30	11001382	factory
157999	2022-01-24 05:39:27	2022-01-24 15:34:53	11001382	factory
158000	2022-01-25 05:36:43	2022-01-25 15:35:13	11001382	factory
158001	2022-01-26 05:40:47	2022-01-26 15:41:15	11001382	factory
158002	2022-01-27 05:43:54	2022-01-27 15:31:33	11001382	factory
158003	2022-01-28 05:37:35	2022-01-28 15:32:02	11001382	factory
158004	2022-01-31 05:40:58	2022-01-31 15:35:14	11001382	factory
158005	2022-02-01 05:38:27	2022-02-01 15:34:35	11001382	factory
158006	2022-02-02 05:41:53	2022-02-02 15:41:59	11001382	factory
158007	2022-02-03 05:35:33	2022-02-03 15:38:33	11001382	factory
158008	2022-02-04 05:43:36	2022-02-04 15:37:27	11001382	factory
158009	2022-02-05 05:49:26	2022-02-05 12:01:28	11001382	factory
158010	2022-02-07 05:42:34	2022-02-07 15:36:15	11001382	factory
158011	2022-02-08 05:40:22	2022-02-08 15:38:10	11001382	factory
158012	2022-02-09 05:35:00	2022-02-09 15:34:36	11001382	factory
158013	2022-02-10 05:37:13	2022-02-10 15:39:35	11001382	factory
158014	2022-02-14 05:36:11	2022-02-14 15:39:54	11001382	factory
158015	2022-02-15 05:37:29	2022-02-15 15:35:02	11001382	factory
158016	2022-02-16 05:33:04	2022-02-16 15:37:00	11001382	factory
158017	2022-02-17 05:37:55	2022-02-17 15:40:49	11001382	factory
158018	2022-02-18 05:36:02	2022-02-18 15:32:20	11001382	factory
158019	2022-02-19 05:58:59	2022-02-19 12:01:15	11001382	factory
158020	2022-02-21 05:36:27	2022-02-21 15:52:13	11001382	factory
158021	2022-02-22 05:35:33	2022-02-22 15:37:40	11001382	factory
158022	2022-02-23 05:54:03	2022-02-23 14:50:46	11001382	factory
158023	2022-02-24 05:35:23	2022-02-24 15:39:06	11001382	factory
158024	2022-02-25 05:44:35	2022-02-25 14:42:56	11001382	factory
158025	2022-02-26 05:46:43	2022-02-26 12:04:35	11001382	factory
158026	2022-02-28 05:38:00	2022-02-28 15:37:56	11001382	factory
158027	2022-03-01 05:36:47	2022-03-01 15:35:29	11001382	factory
158028	2021-12-06 07:19:09	2021-12-06 15:29:13	11002681	factory
158029	2021-12-07 07:04:24	\N	11002681	factory
158030	2021-12-09 06:05:54	\N	11002681	factory
158031	2021-12-13 05:55:54	2021-12-13 15:18:00	11002681	factory
158032	2021-12-14 07:14:02	2021-12-14 15:27:29	11002681	factory
158033	2021-12-15 06:51:37	2021-12-15 15:31:37	11002681	factory
158034	2021-12-16 15:31:05	\N	11002681	factory
158035	2021-12-21 15:29:31	\N	11002681	factory
158036	2021-12-22 07:07:00	2021-12-22 15:31:49	11002681	factory
158037	2021-12-23 05:59:47	2021-12-23 15:34:04	11002681	factory
158038	2022-01-11 07:06:00	2022-01-11 15:30:30	11002681	factory
158039	2022-01-12 06:14:27	2022-01-12 12:21:38	11002681	factory
158040	2022-01-17 14:38:24	\N	11002681	factory
158041	2022-01-18 07:07:10	2022-01-18 14:39:49	11002681	factory
158042	2022-01-24 15:21:33	\N	11002681	factory
158043	2022-01-25 07:15:24	2022-01-25 15:30:17	11002681	factory
158044	2022-01-26 06:50:54	2022-01-26 15:30:24	11002681	factory
158045	2021-11-16 07:16:25	\N	11001628	factory
158046	2021-11-19 05:56:17	\N	11001628	factory
158047	2021-12-01 06:53:06	2021-12-01 15:41:13	11001628	factory
158048	2021-12-02 08:46:44	2021-12-02 17:05:03	11001628	factory
158049	2021-12-03 07:05:52	2021-12-03 16:46:28	11001628	factory
158050	2021-12-06 07:23:57	2021-12-06 17:34:04	11001628	factory
158051	2021-12-07 07:25:00	2021-12-07 16:22:13	11001628	factory
158052	2021-12-08 07:08:57	2021-12-08 16:13:51	11001628	factory
158053	2021-12-10 07:05:06	2021-12-10 17:52:53	11001628	factory
158054	2021-12-13 07:10:41	2021-12-13 15:32:09	11001628	factory
158055	2021-12-14 06:54:00	2021-12-14 15:25:54	11001628	factory
158056	2021-12-15 06:47:48	2021-12-15 15:27:52	11001628	factory
158057	2021-12-20 07:42:52	\N	11001628	factory
158058	2021-12-23 05:40:49	\N	11001628	factory
158059	2021-12-24 07:35:19	2021-12-24 16:21:58	11001628	factory
158060	2021-12-25 07:46:43	2021-12-25 09:59:30	11001628	factory
158061	2021-12-28 06:04:40	2021-12-28 16:30:15	11001628	factory
158062	2021-12-29 07:26:38	\N	11001628	factory
158063	2022-01-10 06:57:23	2022-01-10 16:25:17	11001628	factory
158064	2022-01-11 07:20:01	2022-01-11 16:16:24	11001628	factory
158065	2022-01-12 07:10:24	2022-01-12 16:49:55	11001628	factory
158066	2022-01-13 07:17:10	2022-01-13 16:19:39	11001628	factory
158067	2022-01-14 06:47:44	\N	11001628	factory
158068	2022-01-17 07:21:29	2022-01-17 17:02:32	11001628	factory
158069	2022-01-18 07:11:38	2022-01-18 16:59:58	11001628	factory
158070	2022-01-19 07:09:07	2022-01-19 17:04:18	11001628	factory
158071	2022-01-20 07:01:09	2022-01-20 16:19:37	11001628	factory
158072	2022-01-21 07:01:24	2022-01-21 15:37:15	11001628	factory
158073	2022-01-24 06:57:14	2022-01-24 15:30:16	11001628	factory
158074	2022-01-25 04:02:34	\N	11001628	factory
158075	2022-01-27 08:33:46	2022-01-27 11:10:37	11001628	factory
158076	2022-01-31 07:05:30	2022-01-31 15:43:45	11001628	factory
158077	2022-02-01 07:19:22	\N	11001628	factory
158078	2022-02-02 06:53:49	2022-02-02 16:38:44	11001628	factory
158079	2022-02-03 07:18:39	2022-02-03 16:17:28	11001628	factory
158080	2022-02-04 07:16:38	\N	11001628	factory
158081	2022-02-07 07:10:18	2022-02-07 17:01:59	11001628	factory
158082	2022-02-08 07:11:39	2022-02-08 16:52:00	11001628	factory
158083	2022-02-09 07:06:44	2022-02-09 16:31:05	11001628	factory
158084	2022-02-10 07:18:26	2022-02-10 16:56:50	11001628	factory
158085	2022-02-11 07:11:44	2022-02-11 18:12:21	11001628	factory
158086	2022-02-14 07:03:27	2022-02-14 16:41:20	11001628	factory
158087	2022-02-15 07:00:25	2022-02-15 17:23:27	11001628	factory
158088	2022-02-16 07:05:40	2022-02-16 16:43:47	11001628	factory
158089	2022-02-17 06:59:06	2022-02-17 19:10:41	11001628	factory
158090	2022-02-18 07:07:54	2022-02-18 15:15:21	11001628	factory
158091	2022-02-21 07:09:19	2022-02-21 16:56:50	11001628	factory
158092	2022-02-22 07:04:08	2022-02-22 15:42:28	11001628	factory
158093	2022-02-23 08:19:06	\N	11001628	factory
158094	2022-02-26 08:55:46	\N	11001628	factory
158095	2022-02-28 07:04:58	2022-02-28 16:42:29	11001628	factory
158096	2022-03-01 07:24:20	2022-03-01 19:10:27	11001628	factory
158097	2021-11-03 21:48:00	2021-11-03 22:20:16	11016857	factory
158098	2021-11-15 14:55:46	2021-11-15 15:13:45	11016857	factory
158099	2021-12-01 15:15:42	2021-12-01 15:23:03	11016857	factory
158100	2021-11-15 15:32:00	\N	11015934	factory
158101	2022-01-05 06:38:03	\N	11015934	factory
158102	2022-02-01 15:30:46	\N	11015934	factory
158103	2022-02-02 06:34:27	2022-02-02 15:32:34	11015934	factory
158104	2022-02-03 06:43:22	2022-02-03 15:30:01	11015934	factory
158105	2022-02-04 06:34:50	2022-02-04 15:33:54	11015934	factory
158106	2022-02-07 06:35:01	2022-02-07 15:35:19	11015934	factory
158107	2022-02-08 06:40:41	2022-02-08 15:38:07	11015934	factory
158108	2022-02-09 06:39:02	2022-02-09 15:39:06	11015934	factory
158109	2022-02-10 06:44:14	2022-02-10 15:37:37	11015934	factory
158110	2022-02-11 06:43:09	2022-02-11 15:31:13	11015934	factory
158111	2022-02-14 06:40:39	2022-02-14 15:31:41	11015934	factory
158112	2022-02-15 06:46:36	2022-02-15 15:32:28	11015934	factory
158113	2022-02-16 06:36:29	2022-02-16 15:33:18	11015934	factory
158114	2022-02-17 06:35:58	2022-02-17 15:33:00	11015934	factory
158115	2022-02-18 06:40:04	2022-02-18 15:33:11	11015934	factory
158116	2022-02-21 06:38:33	2022-02-21 15:34:31	11015934	factory
158117	2022-02-22 06:44:39	2022-02-22 15:36:24	11015934	factory
158118	2022-02-23 06:39:02	2022-02-23 15:38:53	11015934	factory
158119	2022-02-24 06:41:01	2022-02-24 15:30:09	11015934	factory
158120	2022-02-25 06:39:51	2022-02-25 14:34:55	11015934	factory
158121	2022-02-28 06:41:56	2022-02-28 15:35:58	11015934	factory
158122	2022-03-01 06:42:09	2022-03-01 15:36:31	11015934	factory
158123	2021-11-16 07:02:48	2021-11-16 15:54:56	11027133	factory
158124	2021-11-30 17:07:21	2021-11-30 17:56:00	11027133	factory
158125	2021-11-30 18:08:51	2021-11-30 18:26:34	11027133	factory
158126	2021-12-02 07:09:59	2021-12-02 15:46:26	11027133	factory
158127	2021-12-03 07:03:27	2021-12-03 16:19:58	11027133	factory
158128	2021-12-06 07:08:30	2021-12-06 16:39:01	11027133	factory
158129	2021-12-07 07:13:09	2021-12-07 15:54:22	11027133	factory
158130	2021-12-08 07:21:24	2021-12-08 15:51:40	11027133	factory
158131	2021-12-10 17:05:07	\N	11027133	factory
158132	2021-12-13 07:20:35	2021-12-13 16:03:00	11027133	factory
158133	2021-12-14 07:15:25	2021-12-14 16:55:31	11027133	factory
158134	2021-12-15 07:19:39	2021-12-15 16:09:46	11027133	factory
158135	2021-12-16 08:37:50	2021-12-16 16:54:13	11027133	factory
158136	2021-12-17 07:19:41	2021-12-17 16:49:26	11027133	factory
158137	2021-12-20 07:25:24	2021-12-20 16:41:18	11027133	factory
158138	2021-12-21 07:17:26	2021-12-21 16:13:52	11027133	factory
158139	2021-12-22 07:18:41	2021-12-22 16:09:11	11027133	factory
158140	2021-12-23 07:17:44	2021-12-23 16:54:14	11027133	factory
158141	2021-12-24 07:20:19	2021-12-24 19:44:56	11027133	factory
158142	2021-12-25 08:12:37	\N	11027133	factory
158143	2021-12-27 08:01:55	2021-12-27 15:40:36	11027133	factory
158144	2021-12-28 07:14:30	2021-12-28 15:34:15	11027133	factory
158145	2021-12-29 07:26:29	\N	11027133	factory
158146	2022-01-10 07:15:57	2022-01-10 15:54:01	11027133	factory
158147	2022-01-11 07:17:57	2022-01-11 16:55:51	11027133	factory
158148	2022-01-12 07:11:55	2022-01-12 16:04:19	11027133	factory
158149	2022-01-13 16:55:08	\N	11027133	factory
158150	2022-01-14 07:18:50	2022-01-14 16:18:05	11027133	factory
158151	2022-01-17 07:18:33	2022-01-17 16:06:31	11027133	factory
158152	2022-01-18 07:09:06	2022-01-18 16:18:40	11027133	factory
158153	2022-01-19 07:42:29	2022-01-19 16:33:02	11027133	factory
158154	2022-01-20 07:23:59	2022-01-20 17:09:34	11027133	factory
158155	2022-01-21 07:16:24	2022-01-21 15:56:43	11027133	factory
158156	2022-01-24 07:08:28	2022-01-24 15:54:57	11027133	factory
158157	2022-01-25 08:41:43	2022-01-25 17:18:21	11027133	factory
158158	2022-01-26 07:06:57	2022-01-26 16:01:37	11027133	factory
158159	2022-01-27 07:23:47	2022-01-27 17:35:52	11027133	factory
158160	2022-01-28 07:32:07	2022-01-28 16:59:02	11027133	factory
158161	2022-01-31 09:10:43	2022-01-31 16:51:33	11027133	factory
158162	2022-02-02 09:03:32	2022-02-02 15:53:28	11027133	factory
158163	2022-02-03 07:29:09	2022-02-03 16:48:08	11027133	factory
158164	2022-02-04 07:33:05	2022-02-04 17:33:51	11027133	factory
158165	2022-02-07 07:25:06	2022-02-07 15:52:13	11027133	factory
158166	2022-02-08 07:10:09	2022-02-08 16:24:48	11027133	factory
158167	2022-02-09 07:17:18	\N	11027133	factory
158168	2022-02-10 07:28:16	2022-02-10 16:12:41	11027133	factory
158169	2022-02-11 07:19:00	2022-02-11 16:04:12	11027133	factory
158170	2022-02-14 08:45:12	2022-02-14 17:11:50	11027133	factory
158171	2022-02-15 07:22:13	2022-02-15 16:25:14	11027133	factory
158172	2022-02-16 07:20:35	2022-02-16 16:49:48	11027133	factory
158173	2022-02-17 07:20:03	2022-02-17 16:51:18	11027133	factory
158174	2022-02-18 08:22:30	2022-02-18 17:13:05	11027133	factory
158175	2022-02-21 07:16:24	2022-02-21 16:09:59	11027133	factory
158176	2022-02-22 07:13:31	2022-02-22 16:57:17	11027133	factory
158177	2022-02-23 08:19:09	2022-02-23 15:40:19	11027133	factory
158178	2022-02-24 07:23:58	2022-02-24 16:15:36	11027133	factory
158179	2022-02-25 07:32:31	2022-02-25 15:26:48	11027133	factory
158180	2022-02-28 07:18:53	2022-02-28 15:57:32	11027133	factory
158181	2022-03-01 07:40:17	\N	11027133	factory
158182	2021-11-23 06:55:02	\N	11014642	factory
158183	2021-11-24 07:22:10	\N	11014642	factory
158184	2021-12-01 07:24:51	2021-12-01 16:00:30	11014642	factory
158185	2021-12-02 07:19:32	2021-12-02 16:00:38	11014642	factory
158186	2021-12-03 07:14:22	2021-12-03 16:00:30	11014642	factory
158187	2021-12-06 07:29:19	2021-12-06 16:00:33	11014642	factory
158188	2021-12-07 07:23:37	2021-12-07 16:06:51	11014642	factory
158189	2021-12-08 07:44:38	2021-12-08 16:15:48	11014642	factory
158190	2021-12-09 07:24:46	2021-12-09 16:01:06	11014642	factory
158191	2021-12-10 07:13:50	2021-12-10 16:00:29	11014642	factory
158192	2021-12-13 07:26:29	2021-12-13 16:00:43	11014642	factory
158193	2021-12-14 07:19:39	2021-12-14 16:01:05	11014642	factory
158194	2021-12-15 07:23:40	2021-12-15 17:01:12	11014642	factory
158195	2021-12-16 07:25:07	2021-12-16 16:02:00	11014642	factory
158196	2021-12-17 07:21:33	2021-12-17 16:03:11	11014642	factory
158197	2021-12-20 07:48:22	2021-12-20 15:37:01	11014642	factory
158198	2021-12-21 07:14:16	2021-12-21 16:00:19	11014642	factory
158199	2021-12-22 07:24:21	2021-12-22 16:00:46	11014642	factory
158200	2021-12-23 07:20:09	2021-12-23 16:00:51	11014642	factory
158201	2021-12-24 07:25:06	2021-12-24 16:00:04	11014642	factory
158202	2021-12-27 06:59:07	2021-12-27 15:32:26	11014642	factory
158203	2021-12-28 07:24:27	2021-12-28 16:00:15	11014642	factory
158204	2021-12-29 06:56:30	2021-12-29 12:04:03	11014642	factory
158205	2022-01-10 07:25:39	2022-01-10 16:00:46	11014642	factory
158206	2022-01-11 07:26:09	2022-01-11 16:00:56	11014642	factory
158207	2022-01-12 07:26:55	2022-01-12 16:00:34	11014642	factory
158208	2022-01-13 07:26:18	2022-01-13 16:00:28	11014642	factory
158209	2022-01-14 07:28:02	2022-01-14 16:05:09	11014642	factory
158210	2022-01-17 06:54:51	2022-01-17 15:35:35	11014642	factory
158211	2022-01-18 07:19:51	2022-01-18 16:01:54	11014642	factory
158212	2022-01-19 07:29:43	2022-01-19 16:01:27	11014642	factory
158213	2022-01-20 07:27:20	2022-01-20 16:04:27	11014642	factory
158214	2022-01-21 07:28:11	2022-01-21 16:01:57	11014642	factory
158215	2022-01-24 07:25:40	2022-01-24 15:02:31	11014642	factory
158216	2022-01-28 07:25:36	2022-01-28 16:01:43	11014642	factory
158217	2022-01-31 07:30:22	2022-01-31 16:04:11	11014642	factory
158218	2022-02-01 07:27:07	2022-02-01 16:00:22	11014642	factory
158219	2022-02-02 07:21:11	2022-02-02 16:00:33	11014642	factory
158220	2022-02-03 07:20:17	2022-02-03 16:01:49	11014642	factory
158221	2022-02-04 07:16:24	2022-02-04 16:00:42	11014642	factory
158222	2022-02-07 07:20:04	2022-02-07 16:00:52	11014642	factory
158223	2022-02-08 07:25:38	2022-02-08 17:01:21	11014642	factory
158224	2022-02-09 07:25:39	2022-02-09 16:01:52	11014642	factory
158225	2022-02-10 07:24:11	2022-02-10 16:01:12	11014642	factory
158226	2022-02-11 07:24:40	2022-02-11 16:01:13	11014642	factory
158227	2022-02-14 06:56:05	2022-02-14 15:43:26	11014642	factory
158228	2022-02-15 07:15:50	2022-02-15 17:12:48	11014642	factory
158229	2022-02-16 07:11:07	2022-02-16 17:00:09	11014642	factory
158230	2022-02-17 07:20:17	2022-02-17 16:01:37	11014642	factory
158231	2022-02-18 07:25:21	2022-02-18 18:08:01	11014642	factory
158232	2022-02-21 07:27:45	2022-02-21 16:01:23	11014642	factory
158233	2022-02-22 07:25:51	2022-02-22 16:12:31	11014642	factory
158234	2022-02-24 07:25:28	2022-02-24 16:01:09	11014642	factory
158235	2022-02-25 07:22:28	2022-02-25 15:03:02	11014642	factory
158236	2022-02-28 07:26:22	2022-02-28 16:00:32	11014642	factory
158237	2022-03-01 07:25:34	2022-03-01 16:25:22	11014642	factory
158238	2021-11-23 16:36:59	\N	11020843	factory
158239	2021-12-01 15:41:32	\N	11020843	factory
158240	2021-12-02 06:47:09	2021-12-02 17:17:52	11020843	factory
158241	2021-12-03 06:35:44	2021-12-03 15:49:38	11020843	factory
158242	2021-12-06 07:13:36	2021-12-06 17:34:27	11020843	factory
158243	2021-12-07 06:37:07	2021-12-07 16:37:58	11020843	factory
158244	2021-12-08 06:38:02	2021-12-08 16:17:41	11020843	factory
158245	2021-12-09 06:44:36	2021-12-09 15:32:35	11020843	factory
158246	2021-12-10 06:37:08	2021-12-10 15:31:52	11020843	factory
158247	2021-12-13 06:35:05	2021-12-13 15:31:43	11020843	factory
158248	2021-12-14 06:35:15	2021-12-14 15:30:21	11020843	factory
158249	2021-12-15 06:35:43	2021-12-15 15:41:19	11020843	factory
158250	2021-12-16 06:45:12	2021-12-16 15:32:22	11020843	factory
158251	2021-12-17 06:31:51	2021-12-17 15:25:44	11020843	factory
158252	2021-12-20 07:08:03	2021-12-20 15:32:45	11020843	factory
158253	2021-12-21 06:36:12	2021-12-21 15:30:48	11020843	factory
158254	2021-12-22 06:36:04	2021-12-22 15:34:11	11020843	factory
158255	2021-12-23 06:47:23	2021-12-23 15:31:53	11020843	factory
158256	2021-12-24 06:35:10	2021-12-24 15:31:44	11020843	factory
158257	2021-12-25 06:48:37	2021-12-25 14:26:36	11020843	factory
158258	2021-12-27 06:35:51	2021-12-27 15:33:30	11020843	factory
158259	2021-12-28 06:34:06	2021-12-28 15:31:28	11020843	factory
158260	2021-12-29 06:34:50	2021-12-29 10:13:02	11020843	factory
158261	2022-01-04 06:35:39	2022-01-04 14:05:33	11020843	factory
158262	2022-01-05 06:53:22	2022-01-05 14:32:05	11020843	factory
158263	2022-01-06 06:56:16	2022-01-06 13:25:26	11020843	factory
158264	2022-01-10 06:36:05	2022-01-10 15:45:47	11020843	factory
158265	2022-01-11 06:36:56	2022-01-11 15:50:09	11020843	factory
158266	2022-01-12 06:36:23	2022-01-12 17:05:12	11020843	factory
158267	2022-01-13 06:45:36	2022-01-13 15:34:42	11020843	factory
158268	2022-01-14 06:31:17	2022-01-14 18:03:06	11020843	factory
158269	2022-01-15 06:40:40	2022-01-15 12:09:24	11020843	factory
158270	2022-01-17 06:29:30	2022-01-17 15:46:41	11020843	factory
158271	2022-01-18 06:37:38	2022-01-18 15:31:13	11020843	factory
158272	2022-01-19 06:46:44	2022-01-19 15:28:49	11020843	factory
158273	2022-01-20 06:54:19	2022-01-20 16:20:22	11020843	factory
158274	2022-01-21 05:45:52	2022-01-21 15:33:54	11020843	factory
158275	2022-01-24 06:36:23	2022-01-24 15:32:26	11020843	factory
158276	2022-01-25 06:56:18	2022-01-25 17:55:59	11020843	factory
158277	2022-01-26 06:48:41	2022-01-26 17:13:23	11020843	factory
158278	2022-01-27 06:50:35	2022-01-27 17:57:01	11020843	factory
158279	2022-01-28 06:37:00	2022-01-28 16:14:52	11020843	factory
158280	2022-01-31 05:54:30	2022-01-31 15:39:32	11020843	factory
158281	2022-02-01 06:39:55	2022-02-01 15:36:08	11020843	factory
158282	2022-02-02 06:36:14	2022-02-02 15:38:50	11020843	factory
158283	2022-02-03 06:49:05	2022-02-03 15:53:07	11020843	factory
158284	2022-02-04 06:42:37	2022-02-04 15:37:45	11020843	factory
158285	2022-02-05 06:35:29	2022-02-05 11:33:01	11020843	factory
158286	2022-02-07 16:06:38	\N	11020843	factory
158287	2022-02-08 06:17:48	2022-02-08 17:04:31	11020843	factory
158288	2022-02-09 06:31:46	2022-02-09 17:04:31	11020843	factory
158289	2022-02-10 06:30:45	2022-02-10 17:52:44	11020843	factory
158290	2022-02-11 06:35:17	2022-02-11 18:12:28	11020843	factory
158291	2022-02-12 06:22:16	2022-02-12 12:12:37	11020843	factory
158292	2022-02-14 06:26:25	2022-02-14 17:34:54	11020843	factory
158293	2022-02-15 06:11:27	2022-02-15 17:20:15	11020843	factory
158294	2022-02-16 06:11:33	2022-02-16 16:44:27	11020843	factory
158295	2022-02-17 06:09:10	2022-02-17 15:37:41	11020843	factory
158296	2022-02-18 06:29:38	2022-02-18 16:24:23	11020843	factory
158297	2022-02-21 07:18:26	2022-02-21 18:00:51	11020843	factory
158298	2022-02-22 06:19:47	2022-02-22 15:45:29	11020843	factory
158299	2022-02-23 06:38:50	2022-02-23 15:45:46	11020843	factory
158300	2022-02-24 06:28:42	2022-02-24 18:00:50	11020843	factory
158301	2022-02-25 06:25:17	2022-02-25 18:59:31	11020843	factory
158302	2022-02-26 06:28:17	2022-02-26 12:03:54	11020843	factory
158303	2022-02-28 06:29:24	2022-02-28 16:38:36	11020843	factory
158304	2022-03-01 06:44:35	2022-03-01 16:56:42	11020843	factory
158305	2021-11-30 20:04:50	2021-11-30 20:20:49	11015933	factory
158306	2021-11-03 21:47:57	2021-11-03 22:02:06	11008409	factory
158307	2021-11-03 22:07:18	2021-11-03 22:20:09	11008409	factory
158308	2021-11-15 14:55:41	2021-11-15 15:13:43	11008409	factory
158309	2021-12-01 15:15:41	2021-12-01 15:23:00	11008409	factory
158310	2021-12-02 09:20:20	2021-12-02 16:01:47	11008409	factory
158311	2021-12-03 08:33:04	2021-12-03 16:16:41	11008409	factory
158312	2021-12-06 08:12:44	2021-12-06 15:31:00	11008409	factory
158313	2021-12-07 07:36:20	\N	11008409	factory
158314	2021-12-08 08:18:03	2021-12-08 15:33:20	11008409	factory
158315	2021-12-09 08:31:08	2021-12-09 15:34:12	11008409	factory
158316	2021-12-10 08:09:23	2021-12-10 15:57:32	11008409	factory
158317	2021-12-13 08:03:25	2021-12-13 15:34:58	11008409	factory
158318	2021-12-14 08:22:52	2021-12-14 15:38:33	11008409	factory
158319	2021-12-15 08:32:32	2021-12-15 16:17:39	11008409	factory
158320	2021-12-16 08:03:34	2021-12-16 15:48:32	11008409	factory
158321	2021-12-17 08:37:32	2021-12-17 15:47:14	11008409	factory
158322	2021-12-20 07:47:21	2021-12-20 16:41:15	11008409	factory
158323	2021-12-21 07:53:36	2021-12-21 18:15:08	11008409	factory
158324	2021-12-22 07:42:01	2021-12-22 18:01:37	11008409	factory
158325	2021-12-23 07:05:18	2021-12-23 15:40:51	11008409	factory
158326	2021-12-24 07:49:21	2021-12-24 15:31:08	11008409	factory
158327	2021-12-27 07:09:41	2021-12-27 15:35:17	11008409	factory
158328	2021-12-28 07:40:47	2021-12-28 15:31:44	11008409	factory
158329	2021-12-29 07:23:32	2021-12-29 09:20:38	11008409	factory
158330	2022-01-10 07:00:04	2022-01-10 15:59:09	11008409	factory
158331	2022-01-11 07:04:06	2022-01-11 15:44:26	11008409	factory
158332	2022-01-12 07:13:09	2022-01-12 15:39:43	11008409	factory
158333	2022-01-13 07:15:13	2022-01-13 15:33:32	11008409	factory
158334	2022-01-14 07:24:25	2022-01-14 16:50:15	11008409	factory
158335	2022-01-17 07:10:31	2022-01-17 15:36:29	11008409	factory
158336	2022-01-18 07:15:59	2022-01-18 15:33:19	11008409	factory
158337	2022-01-19 07:27:27	2022-01-19 15:48:55	11008409	factory
158338	2022-01-20 07:19:36	2022-01-20 15:55:35	11008409	factory
158339	2022-01-21 07:22:55	2022-01-21 15:33:27	11008409	factory
158340	2022-01-24 07:04:34	2022-01-24 15:59:07	11008409	factory
158341	2022-01-25 07:25:26	2022-01-25 15:47:37	11008409	factory
158342	2022-01-26 07:47:37	2022-01-26 16:27:00	11008409	factory
158343	2022-01-27 07:07:35	2022-01-27 15:33:12	11008409	factory
158344	2022-01-28 15:27:10	\N	11008409	factory
158345	2022-02-01 06:49:05	2022-02-01 15:48:21	11008409	factory
158346	2022-02-02 07:00:21	2022-02-02 15:40:08	11008409	factory
158347	2022-02-03 06:52:03	2022-02-03 15:39:03	11008409	factory
158348	2022-02-04 06:59:12	2022-02-04 15:33:29	11008409	factory
158349	2022-02-07 07:38:22	2022-02-07 16:44:23	11008409	factory
158350	2022-02-08 06:59:28	2022-02-08 15:58:26	11008409	factory
158351	2022-02-09 07:06:55	2022-02-09 16:47:41	11008409	factory
158352	2022-02-10 07:20:36	2022-02-10 16:01:17	11008409	factory
158353	2022-02-11 07:19:05	2022-02-11 17:12:32	11008409	factory
158354	2022-02-14 07:29:55	2022-02-14 17:41:32	11008409	factory
158355	2022-02-15 07:17:21	2022-02-15 16:02:35	11008409	factory
158356	2022-02-16 07:08:31	2022-02-16 15:34:26	11008409	factory
158357	2022-02-17 07:21:47	2022-02-17 15:46:36	11008409	factory
158358	2022-02-18 07:18:01	2022-02-18 16:09:11	11008409	factory
158359	2022-02-21 07:12:29	2022-02-21 15:31:41	11008409	factory
158360	2022-02-22 07:08:10	2022-02-22 16:03:46	11008409	factory
158361	2022-02-23 07:13:46	2022-02-23 16:11:45	11008409	factory
158362	2022-02-24 07:23:07	2022-02-24 16:15:58	11008409	factory
158363	2022-02-25 08:02:04	2022-02-25 17:26:06	11008409	factory
158364	2022-02-28 07:10:18	2022-02-28 16:56:29	11008409	factory
158365	2022-02-28 17:05:28	\N	11008409	factory
158366	2022-03-01 07:12:35	2022-03-01 15:33:03	11008409	factory
158367	2021-11-15 15:32:29	\N	8170321	factory
158368	2022-02-01 15:30:52	\N	8170321	factory
158369	2022-02-07 06:44:27	2022-02-07 15:36:09	8170321	factory
158370	2022-02-08 06:44:50	2022-02-08 15:35:52	8170321	factory
158371	2022-02-09 06:47:13	2022-02-09 15:34:33	8170321	factory
158372	2022-02-10 06:48:22	2022-02-10 15:31:20	8170321	factory
158373	2022-02-11 06:44:50	2022-02-11 15:30:51	8170321	factory
158374	2022-02-14 06:45:53	2022-02-14 15:34:52	8170321	factory
158375	2022-02-15 06:46:39	2022-02-15 15:33:54	8170321	factory
158376	2022-02-16 06:42:40	2022-02-16 15:36:00	8170321	factory
158377	2022-02-17 06:41:49	2022-02-17 15:39:20	8170321	factory
158378	2022-02-18 06:43:56	2022-02-18 15:36:25	8170321	factory
158379	2022-02-21 06:45:35	2022-02-21 15:34:27	8170321	factory
158380	2022-02-22 06:44:32	2022-02-22 15:34:24	8170321	factory
158381	2022-02-23 06:55:49	2022-02-23 15:32:13	8170321	factory
158382	2022-02-24 06:46:01	2022-02-24 15:32:58	8170321	factory
158383	2022-02-25 06:45:23	2022-02-25 14:31:31	8170321	factory
158384	2022-02-28 06:44:59	2022-02-28 15:36:44	8170321	factory
158385	2022-03-01 06:46:56	2022-03-01 15:37:14	8170321	factory
158386	2021-11-17 07:41:15	\N	8170266	factory
158387	2021-12-01 07:54:29	2021-12-01 16:58:30	8170266	factory
158388	2021-12-02 07:45:57	2021-12-02 16:34:43	8170266	factory
158389	2021-12-03 07:34:48	2021-12-03 16:02:50	8170266	factory
158390	2021-12-06 08:11:43	2021-12-06 16:44:08	8170266	factory
158391	2021-12-07 08:02:54	2021-12-07 16:35:01	8170266	factory
158392	2021-12-08 07:43:55	2021-12-08 16:20:28	8170266	factory
158393	2021-12-09 07:16:50	2021-12-09 16:13:49	8170266	factory
158394	2021-12-10 07:44:03	2021-12-10 17:17:18	8170266	factory
158395	2021-12-13 08:22:15	2021-12-13 17:19:38	8170266	factory
158396	2021-12-14 07:55:40	2021-12-14 16:57:04	8170266	factory
158397	2021-12-15 07:57:59	2021-12-15 17:52:34	8170266	factory
158398	2021-12-16 07:22:06	2021-12-16 16:39:11	8170266	factory
158399	2021-12-17 08:10:39	2021-12-17 16:52:27	8170266	factory
158400	2021-12-20 16:51:46	\N	8170266	factory
158401	2021-12-21 07:46:05	2021-12-21 16:18:28	8170266	factory
158402	2021-12-22 07:22:41	2021-12-22 15:45:47	8170266	factory
158403	2021-12-23 07:35:32	2021-12-23 16:22:24	8170266	factory
158404	2021-12-24 07:30:53	2021-12-24 16:16:49	8170266	factory
158405	2021-12-25 08:40:41	2021-12-25 15:43:01	8170266	factory
158406	2021-12-27 07:18:13	2021-12-27 16:03:45	8170266	factory
158407	2021-12-28 07:39:16	2021-12-28 15:50:25	8170266	factory
158408	2021-12-29 07:16:09	\N	8170266	factory
158409	2022-01-05 07:48:53	2022-01-05 13:53:11	8170266	factory
158410	2022-01-06 08:07:20	2022-01-06 15:42:04	8170266	factory
158411	2022-01-10 07:16:18	2022-01-10 15:59:14	8170266	factory
158412	2022-01-11 07:37:19	2022-01-11 16:19:28	8170266	factory
158413	2022-01-12 07:38:39	2022-01-12 16:11:48	8170266	factory
158414	2022-01-13 06:35:17	2022-01-13 15:35:39	8170266	factory
158415	2022-01-14 08:00:02	2022-01-14 16:32:35	8170266	factory
158416	2022-01-17 07:46:16	2022-01-17 16:25:21	8170266	factory
158417	2022-01-18 08:10:06	2022-01-18 16:33:21	8170266	factory
158418	2022-01-19 07:44:01	2022-01-19 16:17:29	8170266	factory
158419	2022-01-20 07:42:36	2022-01-20 16:43:33	8170266	factory
158420	2022-01-21 07:09:44	2022-01-21 15:40:49	8170266	factory
158421	2022-01-24 09:38:05	2022-01-24 18:19:16	8170266	factory
158422	2022-01-25 07:25:46	2022-01-25 15:56:37	8170266	factory
158423	2022-01-26 08:10:21	2022-01-26 16:25:22	8170266	factory
158424	2022-01-27 07:25:26	2022-01-27 15:53:22	8170266	factory
158425	2022-01-28 07:35:00	2022-01-28 16:02:29	8170266	factory
158426	2022-01-31 07:39:00	2022-01-31 17:27:39	8170266	factory
158427	2022-02-01 06:51:13	2022-02-01 15:30:23	8170266	factory
158428	2022-02-02 07:41:01	2022-02-02 16:10:52	8170266	factory
158429	2022-02-03 07:18:23	2022-02-03 16:15:32	8170266	factory
158430	2022-02-04 06:37:02	2022-02-04 15:42:00	8170266	factory
158431	2022-02-07 07:44:57	2022-02-07 16:35:18	8170266	factory
158432	2022-02-08 07:44:30	2022-02-08 16:33:43	8170266	factory
158433	2022-02-09 07:50:29	2022-02-09 16:21:12	8170266	factory
158434	2022-02-10 07:26:21	2022-02-10 16:49:28	8170266	factory
158435	2022-02-11 07:29:12	2022-02-11 16:42:21	8170266	factory
158436	2022-02-14 07:50:27	2022-02-14 17:09:45	8170266	factory
158437	2022-02-15 07:53:37	2022-02-15 16:31:24	8170266	factory
158438	2022-02-16 07:35:06	2022-02-16 16:04:19	8170266	factory
158439	2022-02-17 07:31:02	\N	8170266	factory
158440	2022-02-17 21:41:48	2022-02-18 07:14:31	8170266	factory
158441	2022-02-18 17:00:21	\N	8170266	factory
158442	2022-02-19 09:38:29	2022-02-19 13:05:50	8170266	factory
158443	2022-02-21 07:23:15	2022-02-21 20:03:31	8170266	factory
158444	2022-02-22 07:08:15	2022-02-22 13:55:31	8170266	factory
158445	2022-02-23 09:09:28	2022-02-23 16:49:46	8170266	factory
158446	2022-02-24 07:48:10	2022-02-24 16:49:23	8170266	factory
158447	2022-02-25 10:20:37	2022-02-25 16:18:35	8170266	factory
158448	2022-02-28 08:59:48	2022-02-28 17:30:17	8170266	factory
158449	2022-03-01 08:40:54	2022-03-01 16:59:50	8170266	factory
158450	2021-12-01 06:42:12	2021-12-01 15:30:31	8170342	factory
158451	2021-12-02 06:40:05	2021-12-02 15:30:11	8170342	factory
158452	2021-12-03 06:49:52	2021-12-03 15:30:14	8170342	factory
158453	2021-12-06 06:49:24	2021-12-06 15:30:12	8170342	factory
158454	2021-12-07 06:46:01	2021-12-07 15:30:18	8170342	factory
158455	2021-12-08 06:57:14	2021-12-08 15:30:11	8170342	factory
158456	2021-12-09 06:49:45	2021-12-09 15:30:15	8170342	factory
158457	2021-12-10 06:45:15	2021-12-10 15:30:15	8170342	factory
158458	2021-12-11 06:53:49	2021-12-11 12:01:33	8170342	factory
158459	2021-12-13 06:59:31	2021-12-13 15:30:22	8170342	factory
158460	2021-12-14 06:47:11	2021-12-14 15:30:14	8170342	factory
158461	2021-12-15 06:44:19	2021-12-15 15:30:22	8170342	factory
158462	2021-12-16 06:45:16	2021-12-16 15:30:32	8170342	factory
158463	2021-12-17 06:55:34	2021-12-17 15:30:21	8170342	factory
158464	2021-12-18 06:58:38	2021-12-18 12:03:09	8170342	factory
158465	2021-12-20 06:56:14	2021-12-20 15:30:27	8170342	factory
158466	2021-12-21 06:47:43	2021-12-21 15:41:52	8170342	factory
158467	2021-12-22 06:49:55	2021-12-22 15:30:17	8170342	factory
158468	2021-12-24 06:46:44	2021-12-24 15:30:09	8170342	factory
158469	2021-12-25 06:51:26	2021-12-25 14:30:14	8170342	factory
158470	2021-12-27 06:55:31	2021-12-27 15:30:33	8170342	factory
158471	2021-12-28 06:44:05	2021-12-28 15:30:11	8170342	factory
158472	2022-01-04 06:53:49	2022-01-04 15:40:57	8170342	factory
158473	2022-01-05 06:51:50	2022-01-05 14:31:55	8170342	factory
158474	2022-01-06 06:57:08	2022-01-06 14:28:41	8170342	factory
158475	2022-01-10 06:48:53	2022-01-10 15:31:30	8170342	factory
158476	2022-01-11 15:30:22	\N	8170342	factory
158477	2022-01-12 06:54:52	2022-01-12 15:31:45	8170342	factory
158478	2022-01-13 06:42:19	2022-01-13 15:31:27	8170342	factory
158479	2022-01-14 06:57:57	2022-01-14 15:31:53	8170342	factory
158480	2022-01-24 06:59:16	2022-01-24 15:30:22	8170342	factory
158481	2022-01-25 06:50:31	2022-01-25 15:30:25	8170342	factory
158482	2022-01-26 06:43:03	2022-01-26 15:30:38	8170342	factory
158483	2022-01-27 06:44:24	2022-01-27 15:53:43	8170342	factory
158484	2022-01-28 06:39:24	\N	8170342	factory
158485	2022-01-31 06:51:01	2022-01-31 15:30:04	8170342	factory
158486	2022-02-01 06:45:09	2022-02-01 15:30:10	8170342	factory
158487	2022-02-02 06:46:39	2022-02-02 15:38:32	8170342	factory
158488	2022-02-03 06:41:54	2022-02-03 15:30:35	8170342	factory
158489	2022-02-04 06:40:47	2022-02-04 15:32:23	8170342	factory
158490	2022-02-07 06:45:37	2022-02-07 15:30:32	8170342	factory
158491	2022-02-09 06:53:31	2022-02-09 15:41:09	8170342	factory
158492	2022-02-10 06:47:24	2022-02-10 15:30:13	8170342	factory
158493	2022-02-11 06:46:13	2022-02-11 15:29:52	8170342	factory
158494	2022-02-12 06:51:29	2022-02-12 12:10:39	8170342	factory
158495	2022-02-14 06:40:43	2022-02-14 15:30:25	8170342	factory
158496	2022-02-15 06:48:21	2022-02-15 15:30:28	8170342	factory
158497	2022-02-16 06:43:37	2022-02-16 15:59:02	8170342	factory
158498	2022-02-17 06:48:14	2022-02-17 15:30:22	8170342	factory
158499	2022-02-18 06:41:35	2022-02-18 15:30:16	8170342	factory
158500	2022-02-19 06:43:34	2022-02-19 12:04:47	8170342	factory
158501	2022-02-21 06:41:40	2022-02-21 15:30:13	8170342	factory
158502	2022-02-22 06:41:39	2022-02-22 15:30:12	8170342	factory
158503	2022-02-23 06:56:19	2022-02-23 15:33:13	8170342	factory
158504	2022-02-24 06:49:41	2022-02-24 15:30:29	8170342	factory
158505	2022-02-25 06:47:48	2022-02-25 14:56:36	8170342	factory
158506	2022-02-28 06:49:38	2022-02-28 15:30:26	8170342	factory
158507	2022-03-01 06:45:21	2022-03-01 15:32:21	8170342	factory
158508	2021-12-01 06:37:48	2021-12-01 07:54:54	8170265	factory
158509	2021-12-13 09:56:35	2021-12-13 15:30:11	8170265	factory
158510	2021-12-14 06:58:01	2021-12-14 15:30:09	8170265	factory
158511	2021-12-15 06:57:44	2021-12-15 15:30:25	8170265	factory
158512	2021-12-16 06:51:25	2021-12-16 15:30:37	8170265	factory
158513	2021-12-17 06:50:22	2021-12-17 15:30:24	8170265	factory
158514	2021-12-20 06:46:21	2021-12-20 15:30:13	8170265	factory
158515	2021-12-21 06:48:42	2021-12-21 15:30:11	8170265	factory
158516	2021-12-22 06:50:58	2021-12-22 15:44:59	8170265	factory
158517	2021-12-23 06:51:11	2021-12-23 15:32:45	8170265	factory
158518	2021-12-24 06:51:17	2021-12-24 15:30:03	8170265	factory
158519	2021-12-25 06:49:48	2021-12-25 14:32:15	8170265	factory
158520	2021-12-27 06:52:28	2021-12-27 15:30:41	8170265	factory
158521	2021-12-28 06:53:52	2021-12-28 15:30:03	8170265	factory
158522	2022-01-19 06:54:45	2022-01-19 15:30:19	8170265	factory
158523	2022-01-20 06:53:23	2022-01-20 15:30:35	8170265	factory
158524	2022-01-21 06:54:25	2022-01-21 15:30:42	8170265	factory
158525	2022-01-24 06:36:28	2022-01-24 15:30:25	8170265	factory
158526	2022-01-25 06:49:16	2022-01-25 15:30:28	8170265	factory
158527	2022-01-26 06:53:54	2022-01-26 15:33:57	8170265	factory
158528	2022-01-27 06:51:40	2022-01-27 15:42:00	8170265	factory
158529	2022-02-02 09:48:40	2022-02-02 12:07:31	8170265	factory
158530	2022-02-08 06:53:39	2022-02-08 15:32:07	8170265	factory
158531	2022-02-09 06:50:22	2022-02-09 15:30:54	8170265	factory
158532	2022-02-10 06:50:12	2022-02-10 15:30:19	8170265	factory
158533	2022-02-11 06:52:52	2022-02-11 15:29:58	8170265	factory
158534	2022-02-14 06:46:02	2022-02-14 15:30:28	8170265	factory
158535	2022-02-15 06:31:24	2022-02-15 15:30:25	8170265	factory
158536	2022-02-16 06:35:03	2022-02-16 15:38:40	8170265	factory
158537	2022-02-17 06:36:50	2022-02-17 16:06:43	8170265	factory
158538	2022-02-18 06:40:07	2022-02-18 15:30:27	8170265	factory
158539	2022-02-21 06:36:46	2022-02-21 15:30:16	8170265	factory
158540	2022-02-22 06:32:11	2022-02-22 15:30:17	8170265	factory
158541	2022-02-23 06:35:47	2022-02-23 15:33:16	8170265	factory
158542	2022-02-24 06:38:17	2022-02-24 16:31:21	8170265	factory
158543	2022-02-25 06:37:07	2022-02-25 15:36:22	8170265	factory
158544	2022-02-28 06:36:50	2022-02-28 15:30:39	8170265	factory
158545	2022-03-01 06:35:46	2022-03-01 15:37:18	8170265	factory
158546	2022-02-01 15:30:40	\N	9224661	factory
158547	2022-02-02 06:46:28	2022-02-02 15:32:39	9224661	factory
158548	2022-02-03 06:47:03	2022-02-03 15:30:54	9224661	factory
158549	2022-02-04 06:45:35	2022-02-04 15:31:41	9224661	factory
158550	2022-02-07 06:44:23	2022-02-07 15:32:17	9224661	factory
158551	2022-02-08 06:44:54	2022-02-08 15:33:30	9224661	factory
158552	2022-02-09 06:47:17	2022-02-09 10:09:12	9224661	factory
158553	2022-02-10 06:48:27	2022-02-10 15:37:34	9224661	factory
158554	2022-02-11 06:44:53	2022-02-11 15:30:47	9224661	factory
158555	2022-02-14 06:46:08	2022-02-14 15:34:24	9224661	factory
158556	2022-02-15 06:46:41	2022-02-15 15:32:22	9224661	factory
158557	2022-02-16 06:36:19	2022-02-16 15:35:57	9224661	factory
158558	2022-02-21 06:45:39	2022-02-21 15:34:24	9224661	factory
158559	2022-02-22 06:44:36	2022-02-22 15:34:06	9224661	factory
158560	2022-02-23 06:55:32	2022-02-23 15:38:56	9224661	factory
158561	2022-02-24 06:46:04	2022-02-24 15:30:05	9224661	factory
158562	2022-02-25 06:45:20	2022-02-25 14:31:28	9224661	factory
158563	2022-02-28 06:45:02	2022-02-28 15:33:12	9224661	factory
158564	2022-03-01 06:46:59	2022-03-01 15:31:29	9224661	factory
158565	2021-11-15 15:34:47	\N	9224668	factory
158566	2021-11-16 06:38:48	2021-11-16 06:48:14	9224668	factory
158567	2021-11-16 15:34:34	\N	9224668	factory
158568	2021-11-17 06:55:02	2021-11-17 15:31:09	9224668	factory
158569	2021-11-18 06:48:48	2021-11-18 15:31:40	9224668	factory
158570	2021-11-19 05:49:07	2021-11-19 14:33:05	9224668	factory
158571	2021-11-22 06:47:27	2021-11-22 15:33:12	9224668	factory
158572	2021-11-23 06:45:24	\N	9224668	factory
158573	2021-11-24 06:47:39	\N	9224668	factory
158574	2021-11-25 06:50:20	2021-11-25 15:32:17	9224668	factory
158575	2021-11-26 06:48:32	2021-11-26 15:31:35	9224668	factory
158576	2021-11-29 06:50:50	\N	9224668	factory
158577	2021-11-30 06:50:03	\N	9224668	factory
158578	2021-12-01 06:48:11	2021-12-01 15:32:22	9224668	factory
158579	2021-12-02 06:46:50	2021-12-02 15:34:04	9224668	factory
158580	2021-12-03 06:48:06	2021-12-03 15:30:32	9224668	factory
158581	2021-12-06 06:48:08	2021-12-06 15:32:09	9224668	factory
158582	2021-12-07 06:47:09	2021-12-07 15:31:08	9224668	factory
158583	2021-12-08 06:48:40	2021-12-08 15:30:21	9224668	factory
158584	2021-12-09 06:48:29	2021-12-09 15:32:22	9224668	factory
158585	2021-12-10 06:47:11	2021-12-10 15:31:39	9224668	factory
158586	2021-12-13 06:47:54	2021-12-13 15:28:52	9224668	factory
158587	2021-12-14 06:45:50	2021-12-14 15:31:11	9224668	factory
158588	2021-12-15 06:39:43	2021-12-15 06:48:30	9224668	factory
158589	2021-12-15 15:30:49	\N	9224668	factory
158590	2021-12-16 06:49:54	2021-12-16 15:30:44	9224668	factory
158591	2021-12-17 05:40:16	2021-12-17 14:40:31	9224668	factory
158592	2021-12-20 06:48:53	2021-12-20 15:31:24	9224668	factory
158593	2021-12-21 06:54:04	2021-12-21 15:31:03	9224668	factory
158594	2021-12-22 06:48:16	2021-12-22 15:32:26	9224668	factory
158595	2021-12-23 06:49:01	2021-12-23 15:31:47	9224668	factory
158596	2021-12-24 06:48:59	2021-12-24 15:31:37	9224668	factory
158597	2021-12-25 06:49:57	2021-12-25 14:30:51	9224668	factory
158598	2021-12-27 06:49:02	2021-12-27 15:32:48	9224668	factory
158599	2021-12-28 06:48:04	2021-12-28 15:30:38	9224668	factory
158600	2021-12-29 06:45:11	\N	9224668	factory
158601	2022-01-04 06:51:57	2022-01-04 15:30:13	9224668	factory
158602	2022-01-05 06:51:19	2022-01-05 15:30:24	9224668	factory
158603	2022-01-10 06:51:11	2022-01-10 16:02:00	9224668	factory
158604	2022-01-11 06:51:05	2022-01-11 15:30:05	9224668	factory
158605	2022-01-12 06:48:40	2022-01-12 15:30:42	9224668	factory
158606	2022-01-13 06:50:19	2022-01-13 15:30:37	9224668	factory
158607	2022-01-14 06:56:41	2022-01-14 15:30:41	9224668	factory
158608	2022-01-17 06:46:10	2022-01-17 15:33:04	9224668	factory
158609	2022-01-18 06:43:56	2022-01-18 15:30:30	9224668	factory
158610	2022-01-19 06:58:58	2022-01-19 15:30:16	9224668	factory
158611	2022-01-20 06:51:35	2022-01-20 15:31:16	9224668	factory
158612	2022-01-21 05:53:05	2022-01-21 14:31:43	9224668	factory
158613	2022-01-24 06:48:40	2022-01-24 15:31:16	9224668	factory
158614	2022-01-25 06:49:05	2022-01-25 15:31:20	9224668	factory
158615	2022-01-26 06:48:56	2022-01-26 15:32:34	9224668	factory
158616	2022-01-27 15:30:34	\N	9224668	factory
158617	2022-01-28 06:42:52	2022-01-28 15:33:04	9224668	factory
158618	2022-01-31 06:38:38	2022-01-31 15:30:33	9224668	factory
158619	2022-02-01 05:43:17	2022-02-01 14:31:28	9224668	factory
158620	2022-02-02 05:41:49	2022-02-02 14:30:38	9224668	factory
158621	2022-02-03 06:36:35	2022-02-03 15:32:01	9224668	factory
158622	2022-02-04 06:45:09	2022-02-04 15:32:04	9224668	factory
158623	2022-02-07 06:39:06	2022-02-07 15:34:28	9224668	factory
158624	2022-02-08 06:34:12	2022-02-08 15:31:52	9224668	factory
158625	2022-02-09 06:41:58	2022-02-09 15:31:57	9224668	factory
158626	2022-02-10 06:44:53	2022-02-10 15:32:45	9224668	factory
158627	2022-02-11 06:42:12	2022-02-11 15:32:50	9224668	factory
158628	2022-02-14 06:42:34	2022-02-14 15:32:56	9224668	factory
158629	2022-02-15 05:44:03	2022-02-15 14:35:58	9224668	factory
158630	2022-02-16 06:41:33	2022-02-16 15:32:12	9224668	factory
158631	2022-02-17 06:42:30	2022-02-17 15:33:31	9224668	factory
158632	2022-02-18 06:41:44	2022-02-18 15:31:53	9224668	factory
158633	2022-02-21 06:41:18	2022-02-21 15:32:29	9224668	factory
158634	2022-02-22 06:42:10	2022-02-22 15:32:19	9224668	factory
158635	2022-02-23 06:43:41	2022-02-23 15:33:06	9224668	factory
158636	2022-02-24 06:43:55	2022-02-24 15:36:25	9224668	factory
158637	2022-02-25 06:42:35	\N	9224668	factory
158638	2022-02-28 06:43:15	2022-02-28 15:33:41	9224668	factory
158639	2022-03-01 06:42:50	2022-03-01 15:32:47	9224668	factory
158640	2021-12-03 06:33:11	2021-12-03 15:28:38	9224702	factory
158641	2021-12-06 06:40:56	2021-12-06 15:28:45	9224702	factory
158642	2021-12-07 06:41:12	2021-12-07 15:28:44	9224702	factory
158643	2021-12-08 06:36:31	2021-12-08 15:28:47	9224702	factory
158644	2021-12-09 06:39:22	2021-12-09 15:28:43	9224702	factory
158645	2021-12-10 06:35:28	2021-12-10 15:28:47	9224702	factory
158646	2021-12-13 06:34:04	2021-12-13 15:28:42	9224702	factory
158647	2021-12-14 06:33:25	2021-12-14 15:28:43	9224702	factory
158648	2021-12-15 06:37:00	2021-12-15 15:28:41	9224702	factory
158649	2021-12-16 06:43:16	\N	9224702	factory
158650	2021-12-17 06:36:51	2021-12-17 15:28:43	9224702	factory
158651	2021-12-20 06:32:00	2021-12-20 15:30:01	9224702	factory
158652	2021-12-21 06:37:53	2021-12-21 15:30:03	9224702	factory
158653	2021-12-22 06:36:59	2021-12-22 15:30:06	9224702	factory
158654	2021-12-23 06:30:09	2021-12-23 15:30:07	9224702	factory
158655	2021-12-24 06:38:45	2021-12-24 15:30:00	9224702	factory
158656	2021-12-25 06:36:15	2021-12-25 14:29:47	9224702	factory
158657	2021-12-27 06:36:04	2021-12-27 15:30:01	9224702	factory
158658	2021-12-28 06:33:39	2021-12-28 15:29:11	9224702	factory
158659	2021-12-29 06:49:01	2021-12-29 11:43:46	9224702	factory
158660	2022-01-10 06:29:54	2022-01-10 15:30:13	9224702	factory
158661	2022-01-11 06:33:14	2022-01-11 15:30:04	9224702	factory
158662	2022-01-12 06:37:18	2022-01-12 15:30:20	9224702	factory
158663	2022-01-13 06:31:06	2022-01-13 15:30:01	9224702	factory
158664	2022-01-14 06:29:43	2022-01-14 15:30:00	9224702	factory
158665	2022-01-17 06:27:56	2022-01-17 15:53:25	9224702	factory
158666	2022-01-18 06:38:44	2022-01-18 15:32:06	9224702	factory
158667	2022-01-19 06:37:08	2022-01-19 15:29:59	9224702	factory
158668	2022-01-20 06:37:49	2022-01-20 15:30:05	9224702	factory
158669	2022-01-21 06:34:43	2022-01-21 15:31:00	9224702	factory
158670	2022-01-24 06:35:52	2022-01-24 15:30:05	9224702	factory
158671	2022-01-25 06:32:45	2022-01-25 15:30:42	9224702	factory
158672	2022-01-26 06:30:23	2022-01-26 15:30:02	9224702	factory
158673	2022-01-27 06:32:53	2022-01-27 15:30:53	9224702	factory
158674	2022-01-28 06:35:50	2022-01-28 15:31:56	9224702	factory
158675	2022-01-31 06:36:10	2022-01-31 15:30:02	9224702	factory
158676	2022-02-01 06:30:42	2022-02-01 15:30:27	9224702	factory
158677	2022-02-02 06:27:00	2022-02-02 15:30:02	9224702	factory
158678	2022-02-03 06:28:17	2022-02-03 15:30:09	9224702	factory
158679	2022-02-04 06:28:28	2022-02-04 17:18:02	9224702	factory
158680	2022-02-07 15:30:07	\N	9224702	factory
158681	2022-02-08 06:32:13	2022-02-08 15:30:10	9224702	factory
158682	2022-02-09 06:31:39	2022-02-09 15:30:08	9224702	factory
158683	2022-02-10 06:32:17	2022-02-10 15:30:06	9224702	factory
158684	2022-02-11 06:29:21	2022-02-11 15:27:43	9224702	factory
158685	2022-02-14 06:40:05	2022-02-14 15:30:06	9224702	factory
158686	2022-02-15 06:30:29	2022-02-15 15:30:14	9224702	factory
158687	2022-02-16 06:26:28	2022-02-16 15:30:22	9224702	factory
158688	2022-02-17 06:25:56	2022-02-17 16:01:24	9224702	factory
158689	2022-02-18 06:24:47	2022-02-18 15:30:46	9224702	factory
158690	2022-02-21 06:36:04	2022-02-21 15:30:12	9224702	factory
158691	2022-02-22 06:31:47	2022-02-22 15:28:43	9224702	factory
158692	2022-02-23 06:34:59	2022-02-23 15:30:00	9224702	factory
158693	2022-02-24 06:30:41	2022-02-24 15:30:14	9224702	factory
158694	2022-02-25 06:32:52	2022-02-25 14:30:31	9224702	factory
158695	2022-02-28 06:28:43	2022-02-28 15:46:44	9224702	factory
158696	2022-03-01 06:26:05	2022-03-01 15:30:05	9224702	factory
158697	2021-11-23 06:09:32	\N	9224729	factory
158698	2021-11-25 06:18:45	\N	9224729	factory
158699	2021-12-01 06:11:20	2021-12-01 17:32:06	9224729	factory
158700	2021-12-02 06:13:35	2021-12-02 17:37:42	9224729	factory
158701	2021-12-03 06:14:39	2021-12-03 17:55:50	9224729	factory
158702	2021-12-04 06:15:23	2021-12-04 12:19:10	9224729	factory
158703	2021-12-06 06:12:14	2021-12-06 17:50:46	9224729	factory
158704	2021-12-07 06:12:03	2021-12-07 17:16:57	9224729	factory
158705	2021-12-08 06:12:23	2021-12-08 17:40:08	9224729	factory
158706	2021-12-09 06:12:11	2021-12-09 17:42:56	9224729	factory
158707	2021-12-10 06:12:06	2021-12-10 18:10:48	9224729	factory
158708	2021-12-11 06:16:02	\N	9224729	factory
158709	2021-12-13 06:13:55	2021-12-13 15:55:56	9224729	factory
158710	2021-12-14 06:11:00	2021-12-14 16:37:02	9224729	factory
158711	2021-12-15 06:09:56	2021-12-15 16:13:12	9224729	factory
158712	2021-12-16 06:14:29	2021-12-16 15:49:55	9224729	factory
158713	2021-12-17 06:13:00	2021-12-17 16:13:03	9224729	factory
158714	2021-12-20 06:14:49	2021-12-20 16:30:21	9224729	factory
158715	2021-12-21 06:13:31	2021-12-21 16:06:31	9224729	factory
158716	2021-12-22 06:11:48	2021-12-22 16:18:48	9224729	factory
158717	2021-12-23 06:20:54	2021-12-23 16:45:23	9224729	factory
158718	2021-12-24 06:09:27	2021-12-24 15:56:55	9224729	factory
158719	2021-12-25 06:20:22	2021-12-25 15:15:29	9224729	factory
158720	2021-12-27 06:13:20	2021-12-27 17:04:00	9224729	factory
158721	2021-12-28 06:10:31	2021-12-28 15:59:11	9224729	factory
158722	2021-12-29 06:10:20	2021-12-29 11:07:04	9224729	factory
158723	2022-01-03 11:04:57	\N	9224729	factory
158724	2022-01-04 06:21:37	2022-01-04 15:35:05	9224729	factory
158725	2022-01-05 06:15:20	2022-01-05 15:29:10	9224729	factory
158726	2022-01-06 06:12:45	2022-01-06 14:15:58	9224729	factory
158727	2022-01-10 06:13:40	2022-01-10 17:04:54	9224729	factory
158728	2022-01-11 06:11:32	2022-01-11 16:28:32	9224729	factory
158729	2022-01-12 06:10:55	2022-01-12 16:19:59	9224729	factory
158730	2022-01-13 06:11:37	2022-01-13 17:35:23	9224729	factory
158731	2022-01-14 06:10:21	2022-01-14 16:38:59	9224729	factory
158732	2022-01-18 06:14:16	\N	9224729	factory
158733	2022-01-19 06:18:01	2022-01-19 16:56:51	9224729	factory
158734	2022-01-20 06:16:47	2022-01-20 17:11:25	9224729	factory
158735	2022-01-21 06:09:57	2022-01-21 15:57:46	9224729	factory
158736	2022-01-24 06:12:33	2022-01-24 17:22:10	9224729	factory
158737	2022-01-25 06:13:34	2022-01-25 15:40:55	9224729	factory
158738	2022-01-26 06:11:41	2022-01-26 15:50:55	9224729	factory
158739	2022-01-27 06:12:44	2022-01-27 16:02:43	9224729	factory
158740	2022-01-28 06:12:30	2022-01-28 16:07:19	9224729	factory
158741	2022-01-29 06:16:17	2022-01-29 11:08:30	9224729	factory
158742	2022-01-31 06:11:33	2022-01-31 15:51:55	9224729	factory
158743	2022-02-01 06:12:31	2022-02-01 17:42:18	9224729	factory
158744	2022-02-02 06:12:13	2022-02-02 15:52:03	9224729	factory
158745	2022-02-03 06:09:43	2022-02-03 16:18:54	9224729	factory
158746	2022-02-04 06:13:38	2022-02-04 15:52:03	9224729	factory
158747	2022-02-07 06:11:19	2022-02-07 16:20:54	9224729	factory
158748	2022-02-08 06:11:38	2022-02-08 16:20:03	9224729	factory
158749	2022-02-09 06:26:07	2022-02-09 18:51:21	9224729	factory
158750	2022-02-10 06:30:20	2022-02-10 15:54:55	9224729	factory
158751	2022-02-11 06:13:05	2022-02-11 15:54:11	9224729	factory
158752	2022-02-12 06:33:11	2022-02-12 10:58:52	9224729	factory
158753	2022-02-14 06:11:57	2022-02-14 16:01:44	9224729	factory
158754	2022-02-15 06:11:31	2022-02-15 16:53:21	9224729	factory
158755	2022-02-16 06:13:55	2022-02-16 16:34:54	9224729	factory
158756	2022-02-17 06:09:18	2022-02-17 16:04:47	9224729	factory
158757	2022-02-18 06:25:37	\N	9224729	factory
158758	2022-02-19 06:33:03	2022-02-19 11:33:39	9224729	factory
158759	2022-02-21 06:14:43	2022-02-21 15:44:36	9224729	factory
158760	2022-02-22 06:11:38	2022-02-22 15:55:46	9224729	factory
158761	2022-02-23 06:14:24	2022-02-23 15:47:37	9224729	factory
158762	2022-02-24 06:12:57	2022-02-24 17:00:18	9224729	factory
158763	2022-02-25 06:12:59	2022-02-25 14:50:16	9224729	factory
158764	2022-02-26 06:14:47	2022-02-26 11:28:08	9224729	factory
158765	2022-02-28 06:10:31	2022-02-28 15:48:08	9224729	factory
158766	2022-03-01 06:16:46	2022-03-01 15:48:32	9224729	factory
158767	2021-11-30 06:39:44	2021-11-30 15:31:05	9224736	factory
158768	2021-12-01 06:40:04	2021-12-01 15:30:42	9224736	factory
158769	2021-12-02 06:34:54	2021-12-02 15:31:50	9224736	factory
158770	2021-12-03 06:32:31	2021-12-03 15:30:10	9224736	factory
158771	2021-12-06 06:32:22	2021-12-06 15:30:23	9224736	factory
158772	2021-12-07 06:36:19	2021-12-07 15:30:37	9224736	factory
158773	2021-12-08 06:34:28	2021-12-08 15:30:41	9224736	factory
158774	2021-12-09 06:31:13	2021-12-09 15:31:05	9224736	factory
158775	2021-12-10 06:31:31	2021-12-10 15:30:43	9224736	factory
158776	2021-12-13 06:25:18	2021-12-13 15:30:47	9224736	factory
158777	2021-12-14 06:32:57	2021-12-14 15:30:06	9224736	factory
158778	2021-12-15 06:32:11	2021-12-15 15:30:17	9224736	factory
158779	2021-12-16 06:32:20	\N	9224736	factory
158780	2021-12-17 06:35:38	2021-12-17 15:31:07	9224736	factory
158781	2021-12-20 06:30:39	2021-12-20 15:30:20	9224736	factory
158782	2021-12-21 06:32:01	2021-12-21 15:31:18	9224736	factory
158783	2021-12-22 06:31:48	2021-12-22 15:31:18	9224736	factory
158784	2021-12-23 06:33:55	2021-12-23 15:32:02	9224736	factory
158785	2021-12-24 06:31:35	2021-12-24 15:33:06	9224736	factory
158786	2021-12-25 06:27:21	2021-12-25 14:45:23	9224736	factory
158787	2021-12-27 06:42:47	2021-12-27 16:48:33	9224736	factory
158788	2021-12-28 06:30:47	2021-12-28 15:30:53	9224736	factory
158789	2021-12-29 06:30:25	\N	9224736	factory
158790	2022-01-04 06:33:49	2022-01-04 15:30:04	9224736	factory
158791	2022-01-05 06:35:55	2022-01-05 15:30:00	9224736	factory
158792	2022-01-06 06:32:44	2022-01-06 13:33:30	9224736	factory
158793	2022-01-10 06:30:50	2022-01-10 15:30:10	9224736	factory
158794	2022-01-11 06:37:02	2022-01-11 15:30:34	9224736	factory
158795	2022-01-12 06:31:43	2022-01-12 15:31:24	9224736	factory
158796	2022-01-13 06:41:12	2022-01-13 16:54:11	9224736	factory
158797	2022-01-14 06:33:03	2022-01-14 15:30:31	9224736	factory
158798	2022-01-17 06:34:47	2022-01-17 15:32:20	9224736	factory
158799	2022-01-18 06:34:54	2022-01-18 15:33:09	9224736	factory
158800	2022-01-19 06:36:39	\N	9224736	factory
158801	2021-12-01 07:39:10	2021-12-01 16:19:47	9224747	factory
158802	2021-12-02 07:33:01	2021-12-02 14:46:27	9224747	factory
158803	2021-12-03 07:34:52	2021-12-03 16:54:41	9224747	factory
158804	2021-12-06 07:45:38	2021-12-06 16:28:26	9224747	factory
158805	2021-12-07 07:32:16	2021-12-07 16:42:46	9224747	factory
158806	2021-12-08 07:53:52	2021-12-08 16:35:12	9224747	factory
158807	2021-12-09 07:27:16	2021-12-09 16:57:10	9224747	factory
158808	2021-12-10 07:34:32	2021-12-10 16:30:10	9224747	factory
158809	2021-12-13 07:45:33	2021-12-13 16:26:46	9224747	factory
158810	2021-12-14 07:39:00	2021-12-14 16:30:55	9224747	factory
158811	2021-12-15 07:38:52	2021-12-15 16:45:22	9224747	factory
158812	2021-12-16 07:37:32	2021-12-16 16:39:17	9224747	factory
158813	2021-12-17 07:42:33	2021-12-17 16:32:50	9224747	factory
158814	2021-12-20 07:46:50	2021-12-20 16:45:23	9224747	factory
158815	2021-12-21 16:26:46	\N	9224747	factory
158816	2021-12-22 07:30:11	2021-12-22 16:36:54	9224747	factory
158817	2021-12-23 07:36:46	\N	9224747	factory
158818	2021-12-24 07:35:39	2021-12-24 16:16:56	9224747	factory
158819	2021-12-25 07:30:08	2021-12-25 14:03:14	9224747	factory
158820	2021-12-27 07:38:38	2021-12-27 16:23:04	9224747	factory
158821	2021-12-28 07:37:02	2021-12-28 16:13:42	9224747	factory
158822	2021-12-29 07:38:15	2021-12-29 10:59:53	9224747	factory
158823	2022-01-05 11:09:52	2022-01-05 16:50:41	9224747	factory
158824	2022-01-06 08:22:05	2022-01-06 12:29:32	9224747	factory
158825	2022-01-10 07:39:45	2022-01-10 16:06:34	9224747	factory
158826	2022-01-11 08:00:24	2022-01-11 16:32:45	9224747	factory
158827	2022-01-12 13:31:00	2022-01-12 14:50:00	9224747	factory
158828	2022-01-13 07:47:30	2022-01-13 16:18:57	9224747	factory
158829	2022-01-14 07:52:18	2022-01-14 16:39:47	9224747	factory
158830	2022-01-15 07:42:21	2022-01-15 12:18:05	9224747	factory
158831	2022-01-17 07:42:51	2022-01-17 16:13:37	9224747	factory
158832	2022-01-18 07:36:50	2022-01-18 16:26:06	9224747	factory
158833	2022-01-19 08:00:15	2022-01-19 16:48:24	9224747	factory
158834	2022-01-20 07:59:08	2022-01-20 16:24:28	9224747	factory
158835	2022-01-22 07:59:24	2022-01-22 12:13:38	9224747	factory
158836	2022-01-24 07:36:08	2022-01-24 16:41:37	9224747	factory
158837	2022-01-25 07:35:27	2022-01-25 16:23:32	9224747	factory
158838	2022-01-27 07:31:00	2022-01-27 16:32:08	9224747	factory
158839	2022-01-28 16:50:05	\N	9224747	factory
158840	2022-02-03 07:33:11	2022-02-03 16:42:10	9224747	factory
158841	2022-02-04 07:53:23	2022-02-04 16:26:07	9224747	factory
158842	2022-02-07 07:37:51	2022-02-07 16:18:50	9224747	factory
158843	2022-02-08 07:30:15	2022-02-08 16:30:06	9224747	factory
158844	2022-02-09 07:47:57	2022-02-09 16:21:08	9224747	factory
158845	2022-02-10 07:48:47	2022-02-10 16:21:08	9224747	factory
158846	2022-02-11 07:53:55	2022-02-11 16:43:53	9224747	factory
158847	2022-02-12 07:16:26	2022-02-12 15:44:08	9224747	factory
158848	2022-02-14 07:32:50	2022-02-14 16:06:11	9224747	factory
158849	2022-02-15 07:25:41	2022-02-15 16:30:17	9224747	factory
158850	2022-02-16 07:08:57	\N	9224747	factory
158851	2022-02-17 07:29:39	2022-02-17 16:21:49	9224747	factory
158852	2022-02-18 07:26:22	2022-02-18 16:48:40	9224747	factory
158853	2022-02-21 07:34:34	2022-02-21 16:40:17	9224747	factory
158854	2022-02-22 07:28:11	2022-02-22 16:47:26	9224747	factory
158855	2022-02-24 07:10:36	2022-02-24 15:59:18	9224747	factory
158856	2022-02-25 07:19:32	2022-02-25 16:26:34	9224747	factory
158857	2022-02-28 07:32:44	2022-02-28 16:13:02	9224747	factory
158858	2022-03-01 07:31:31	2022-03-01 16:09:17	9224747	factory
158859	2021-11-30 07:06:19	\N	9224770	factory
158860	2021-12-01 06:55:45	2021-12-01 15:36:01	9224770	factory
158861	2021-12-02 06:57:33	2021-12-02 13:07:12	9224770	factory
158862	2021-12-03 06:53:11	2021-12-03 15:35:29	9224770	factory
158863	2021-12-06 06:56:40	2021-12-06 15:40:38	9224770	factory
158864	2021-12-07 06:55:49	2021-12-07 15:34:31	9224770	factory
158865	2021-12-08 06:55:10	2021-12-08 15:32:16	9224770	factory
158866	2021-12-09 06:55:04	2021-12-09 15:34:15	9224770	factory
158867	2021-12-10 06:55:22	2021-12-10 15:07:21	9224770	factory
158868	2021-12-13 09:12:06	2021-12-13 15:31:20	9224770	factory
158869	2021-12-14 06:55:49	2021-12-14 15:30:30	9224770	factory
158870	2021-12-15 06:52:35	2021-12-15 15:31:19	9224770	factory
158871	2021-12-16 06:55:46	2021-12-16 15:31:16	9224770	factory
158872	2021-12-17 07:33:15	2021-12-17 15:33:20	9224770	factory
158873	2021-12-20 06:52:25	2021-12-20 15:33:32	9224770	factory
158874	2021-12-21 06:53:07	2021-12-21 15:31:23	9224770	factory
158875	2021-12-22 06:49:36	2021-12-22 15:31:25	9224770	factory
158876	2021-12-23 06:55:28	2021-12-23 15:31:40	9224770	factory
158877	2021-12-24 06:49:29	2021-12-24 15:30:42	9224770	factory
158878	2021-12-25 06:48:52	2021-12-25 14:31:01	9224770	factory
158879	2021-12-27 06:58:02	2021-12-27 15:33:46	9224770	factory
158880	2021-12-28 06:56:15	2021-12-28 15:30:21	9224770	factory
158881	2021-12-29 06:57:11	2021-12-29 10:15:54	9224770	factory
158882	2022-01-10 06:57:39	2022-01-10 15:34:29	9224770	factory
158883	2022-01-11 06:54:56	2022-01-11 15:32:49	9224770	factory
158884	2022-01-12 06:52:50	2022-01-12 15:35:49	9224770	factory
158885	2022-01-13 06:54:32	2022-01-13 15:36:01	9224770	factory
158886	2022-01-14 06:51:05	2022-01-14 15:31:50	9224770	factory
158887	2022-01-17 06:55:26	2022-01-17 15:32:56	9224770	factory
158888	2022-01-18 06:54:44	2022-01-18 15:31:52	9224770	factory
158889	2022-01-19 06:54:30	2022-01-19 15:32:45	9224770	factory
158890	2022-01-20 06:57:42	2022-01-20 15:33:24	9224770	factory
158891	2022-01-21 06:58:47	2022-01-21 15:32:42	9224770	factory
158892	2022-01-24 07:04:47	2022-01-24 15:33:06	9224770	factory
158893	2022-01-25 06:54:58	2022-01-25 15:32:35	9224770	factory
158894	2022-01-26 06:53:25	2022-01-26 15:31:39	9224770	factory
158895	2022-01-27 06:57:24	2022-01-27 15:30:44	9224770	factory
158896	2022-01-28 06:58:51	2022-01-28 14:23:24	9224770	factory
158897	2022-01-31 06:56:12	2022-01-31 15:30:10	9224770	factory
158898	2022-02-01 06:57:54	2022-02-01 15:30:49	9224770	factory
158899	2022-02-02 06:56:14	2022-02-02 15:30:37	9224770	factory
158900	2022-02-03 07:02:50	2022-02-03 15:30:28	9224770	factory
158901	2022-02-04 06:59:53	2022-02-04 15:32:08	9224770	factory
158902	2022-02-07 06:49:06	2022-02-07 15:31:14	9224770	factory
158903	2022-02-08 06:51:42	2022-02-08 15:30:43	9224770	factory
158904	2022-02-09 06:52:19	2022-02-09 15:30:32	9224770	factory
158905	2022-02-10 06:56:14	2022-02-10 15:33:58	9224770	factory
158906	2022-02-11 06:53:40	2022-02-11 16:16:57	9224770	factory
158907	2022-02-14 15:31:21	\N	9224770	factory
158908	2022-02-15 06:49:03	2022-02-15 15:32:41	9224770	factory
158909	2022-02-16 06:50:42	2022-02-16 15:32:03	9224770	factory
158910	2022-02-17 06:49:09	2022-02-17 15:41:44	9224770	factory
158911	2022-02-18 06:49:46	2022-02-18 15:29:50	9224770	factory
158912	2022-02-21 07:01:43	2022-02-21 15:32:29	9224770	factory
158913	2022-02-22 06:52:32	2022-02-22 15:31:39	9224770	factory
158914	2022-02-23 06:55:38	2022-02-23 13:37:52	9224770	factory
158915	2022-02-24 06:48:55	2022-02-24 15:33:31	9224770	factory
158916	2022-02-25 06:50:26	2022-02-25 14:35:01	9224770	factory
158917	2022-02-28 06:56:15	2022-02-28 15:34:06	9224770	factory
158918	2022-03-01 06:50:18	2022-03-01 15:32:44	9224770	factory
158919	2021-12-03 06:47:18	2021-12-03 15:55:09	9224781	factory
158920	2021-12-06 06:50:55	\N	9224781	factory
158921	2021-12-07 06:46:50	\N	9224781	factory
158922	2021-12-08 06:52:02	2021-12-08 15:33:01	9224781	factory
158923	2021-12-09 06:50:26	2021-12-09 15:33:44	9224781	factory
158924	2021-12-10 06:47:33	\N	9224781	factory
158925	2021-12-13 07:26:59	2021-12-13 15:33:15	9224781	factory
158926	2021-12-14 06:37:09	2021-12-14 15:31:50	9224781	factory
158927	2021-12-15 06:39:15	2021-12-15 17:44:46	9224781	factory
158928	2021-12-16 06:38:50	2021-12-16 15:32:05	9224781	factory
158929	2021-12-17 06:43:10	2021-12-17 15:33:02	9224781	factory
158930	2021-12-20 06:52:31	2021-12-20 15:38:25	9224781	factory
158931	2021-12-21 06:34:54	2021-12-21 15:30:40	9224781	factory
158932	2021-12-22 15:39:02	\N	9224781	factory
158933	2021-12-23 06:40:11	2021-12-23 15:33:30	9224781	factory
158934	2021-12-24 06:32:00	2021-12-24 15:37:21	9224781	factory
158935	2021-12-27 06:54:19	2021-12-27 15:30:59	9224781	factory
158936	2021-12-28 07:04:03	2021-12-28 15:33:03	9224781	factory
158937	2022-01-10 06:52:58	2022-01-10 15:30:28	9224781	factory
158938	2022-01-11 06:45:43	2022-01-11 15:30:16	9224781	factory
158939	2022-01-12 06:51:40	2022-01-12 15:30:14	9224781	factory
158940	2022-01-13 06:51:59	2022-01-13 15:30:51	9224781	factory
158941	2022-01-14 06:56:52	2022-01-14 15:36:58	9224781	factory
158942	2022-01-17 06:40:08	2022-01-17 15:35:20	9224781	factory
158943	2022-01-18 06:45:26	2022-01-18 15:35:05	9224781	factory
158944	2022-01-19 06:51:17	2022-01-19 15:28:32	9224781	factory
158945	2022-01-20 06:42:09	2022-01-20 15:30:31	9224781	factory
158946	2022-01-21 06:53:30	2022-01-21 15:22:03	9224781	factory
158947	2022-01-24 06:55:17	2022-01-24 15:29:16	9224781	factory
158948	2022-01-25 06:50:38	2022-01-25 15:32:08	9224781	factory
158949	2022-01-26 06:43:26	2022-01-26 15:33:07	9224781	factory
158950	2022-01-27 06:59:24	2022-01-27 15:30:41	9224781	factory
158951	2022-01-28 06:47:43	2022-01-28 15:28:24	9224781	factory
158952	2022-01-31 06:32:50	2022-01-31 15:33:38	9224781	factory
158953	2022-02-01 06:49:14	2022-02-01 15:31:50	9224781	factory
158954	2022-02-02 06:45:02	2022-02-02 15:35:41	9224781	factory
158955	2022-02-03 06:43:25	2022-02-03 15:33:30	9224781	factory
158956	2022-02-04 06:44:46	2022-02-04 15:32:50	9224781	factory
158957	2022-02-07 06:42:54	2022-02-07 15:35:22	9224781	factory
158958	2022-02-08 06:29:35	2022-02-08 15:41:53	9224781	factory
158959	2022-02-09 06:46:27	2022-02-09 15:29:31	9224781	factory
158960	2022-02-10 06:50:00	2022-02-10 15:36:42	9224781	factory
158961	2022-02-11 06:36:12	2022-02-11 15:32:03	9224781	factory
158962	2022-02-14 07:41:22	2022-02-14 17:41:48	9224781	factory
158963	2022-02-15 06:38:45	2022-02-15 16:07:25	9224781	factory
158964	2022-02-16 06:43:20	2022-02-16 15:42:22	9224781	factory
158965	2022-02-17 06:36:17	2022-02-17 16:03:46	9224781	factory
158966	2022-02-18 06:44:01	2022-02-18 16:41:44	9224781	factory
158967	2022-02-21 06:44:20	2022-02-21 15:46:36	9224781	factory
158968	2022-02-22 06:42:37	2022-02-22 15:46:07	9224781	factory
158969	2022-02-24 06:47:42	2022-02-24 15:36:35	9224781	factory
158970	2022-02-25 06:34:25	2022-02-25 14:34:59	9224781	factory
158971	2022-02-28 06:38:24	2022-02-28 15:50:03	9224781	factory
158972	2021-12-01 07:03:16	2021-12-01 15:33:22	9224628	factory
158973	2021-12-02 06:58:38	2021-12-02 15:31:33	9224628	factory
158974	2021-12-03 06:58:45	2021-12-03 11:36:17	9224628	factory
158975	2021-12-04 07:17:27	2021-12-04 13:00:36	9224628	factory
158976	2021-12-06 07:00:03	2021-12-06 15:31:12	9224628	factory
158977	2021-12-07 06:58:16	2021-12-07 15:31:27	9224628	factory
158978	2021-12-08 07:02:16	2021-12-08 15:30:55	9224628	factory
158979	2021-12-09 06:57:00	2021-12-09 15:31:22	9224628	factory
158980	2021-12-10 06:56:40	2021-12-10 15:30:40	9224628	factory
158981	2021-12-13 06:58:42	2021-12-13 15:31:24	9224628	factory
158982	2021-12-14 07:01:10	2021-12-14 15:31:15	9224628	factory
158983	2021-12-15 07:00:52	2021-12-15 13:02:22	9224628	factory
158984	2021-12-21 06:57:06	2021-12-21 15:31:07	9224628	factory
158985	2021-12-22 06:56:33	2021-12-22 15:30:51	9224628	factory
158986	2021-12-23 06:56:11	2021-12-23 15:32:32	9224628	factory
158987	2021-12-25 06:59:25	2021-12-25 14:30:30	9224628	factory
158988	2021-12-27 06:59:50	2021-12-27 15:32:30	9224628	factory
158989	2021-12-28 06:59:59	2021-12-28 15:31:21	9224628	factory
158990	2021-12-29 06:58:24	\N	9224628	factory
158991	2022-01-04 07:02:05	2022-01-04 15:29:58	9224628	factory
158992	2022-01-05 07:06:10	2022-01-05 15:30:57	9224628	factory
158993	2022-01-06 07:05:37	2022-01-06 14:11:25	9224628	factory
158994	2022-01-10 15:31:09	\N	9224628	factory
158995	2022-01-11 07:00:06	2022-01-11 15:31:18	9224628	factory
158996	2022-01-12 06:57:00	2022-01-12 16:09:57	9224628	factory
158997	2022-01-13 06:57:45	2022-01-13 15:30:57	9224628	factory
158998	2022-01-14 06:57:44	2022-01-14 15:30:50	9224628	factory
158999	2022-01-17 06:55:32	2022-01-17 15:32:24	9224628	factory
159000	2022-01-18 07:00:10	2022-01-18 15:31:37	9224628	factory
159001	2022-01-19 07:01:27	2022-01-19 15:31:48	9224628	factory
159002	2022-01-20 06:54:26	2022-01-20 16:09:44	9224628	factory
159003	2022-01-21 15:31:41	\N	9224628	factory
159004	2022-01-24 07:06:59	2022-01-24 15:30:58	9224628	factory
159005	2022-01-25 06:59:47	2022-01-25 15:31:04	9224628	factory
159006	2022-01-26 06:56:11	2022-01-26 15:32:53	9224628	factory
159007	2022-01-27 07:02:17	2022-01-27 16:20:21	9224628	factory
159008	2022-01-28 07:04:31	2022-01-28 15:35:04	9224628	factory
159009	2022-01-31 07:00:48	2022-01-31 15:30:05	9224628	factory
159010	2022-02-01 07:02:41	2022-02-01 15:30:43	9224628	factory
159011	2022-02-02 07:02:46	2022-02-02 15:32:12	9224628	factory
159012	2022-02-03 07:06:23	2022-02-03 15:31:21	9224628	factory
159013	2022-02-04 06:59:43	2022-02-04 15:36:07	9224628	factory
159014	2022-02-07 07:01:58	2022-02-07 15:44:13	9224628	factory
159015	2022-02-08 06:54:19	2022-02-08 15:30:15	9224628	factory
159016	2022-02-09 15:32:50	\N	9224628	factory
159017	2022-02-10 15:31:56	\N	9224628	factory
159018	2022-02-11 07:07:26	2022-02-11 15:30:06	9224628	factory
159019	2022-02-14 06:59:26	2022-02-14 16:46:58	9224628	factory
159020	2022-02-15 06:56:34	2022-02-15 16:27:30	9224628	factory
159021	2022-02-16 07:03:05	2022-02-16 16:34:35	9224628	factory
159022	2022-02-17 07:03:20	2022-02-17 16:29:22	9224628	factory
159023	2022-02-18 07:00:37	2022-02-18 15:31:39	9224628	factory
159024	2022-02-21 07:08:23	2022-02-21 15:33:21	9224628	factory
159025	2022-02-22 07:01:44	2022-02-22 15:30:56	9224628	factory
159026	2022-02-23 07:10:08	2022-02-23 15:34:42	9224628	factory
159027	2022-02-24 07:02:34	2022-02-24 16:31:57	9224628	factory
159028	2022-02-25 07:10:57	2022-02-25 14:34:58	9224628	factory
159029	2022-02-26 07:00:09	2022-02-26 13:05:59	9224628	factory
159030	2022-02-28 07:05:52	2022-02-28 15:32:38	9224628	factory
159031	2022-03-01 07:03:10	2022-03-01 15:32:53	9224628	factory
159032	2021-11-16 14:26:36	\N	9224649	factory
159033	2021-11-17 05:56:39	2021-11-17 14:28:51	9224649	factory
159034	2021-11-18 05:49:08	2021-11-18 14:26:23	9224649	factory
159035	2021-11-19 05:47:44	2021-11-19 14:28:43	9224649	factory
159036	2021-11-22 05:47:23	2021-11-22 14:29:51	9224649	factory
159037	2021-11-23 05:47:18	2021-11-23 14:29:08	9224649	factory
159038	2021-11-24 05:45:38	2021-11-24 14:29:15	9224649	factory
159039	2021-11-25 05:52:21	\N	9224649	factory
159040	2021-11-26 05:46:35	2021-11-26 14:27:59	9224649	factory
159041	2021-11-29 05:59:59	2021-11-29 14:31:01	9224649	factory
159042	2021-11-30 05:42:52	2021-11-30 14:31:29	9224649	factory
159043	2021-12-01 05:49:01	2021-12-01 14:27:36	9224649	factory
159044	2021-12-02 05:49:06	2021-12-02 14:26:39	9224649	factory
159045	2021-12-03 05:48:14	2021-12-03 14:26:54	9224649	factory
159046	2021-12-06 05:42:12	2021-12-06 14:27:45	9224649	factory
159047	2021-12-07 05:46:54	2021-12-07 14:28:13	9224649	factory
159048	2021-12-08 05:48:10	2021-12-08 14:29:06	9224649	factory
159049	2021-12-09 05:49:06	2021-12-09 14:26:39	9224649	factory
159050	2021-12-10 05:45:27	2021-12-10 14:27:48	9224649	factory
159051	2021-12-13 05:58:29	2021-12-13 14:27:19	9224649	factory
159052	2021-12-14 05:47:44	2021-12-14 14:27:42	9224649	factory
159053	2021-12-15 05:46:45	2021-12-15 14:28:21	9224649	factory
159054	2021-12-16 05:58:50	2021-12-16 14:36:36	9224649	factory
159055	2021-12-17 05:45:02	2021-12-17 14:29:33	9224649	factory
159056	2021-12-20 05:44:48	2021-12-20 14:27:45	9224649	factory
159057	2021-12-21 05:43:33	2021-12-21 14:27:20	9224649	factory
159058	2021-12-22 05:44:25	2021-12-22 14:29:00	9224649	factory
159059	2021-12-23 05:46:36	2021-12-23 14:31:07	9224649	factory
159060	2021-12-24 05:47:42	2021-12-24 14:31:51	9224649	factory
159061	2021-12-25 14:27:11	\N	9224649	factory
159062	2021-12-27 05:55:16	2021-12-27 14:29:49	9224649	factory
159063	2021-12-28 05:54:35	2021-12-28 14:27:55	9224649	factory
159064	2022-01-10 06:04:24	2022-01-10 14:26:57	9224649	factory
159065	2022-01-11 05:45:33	2022-01-11 14:28:45	9224649	factory
159066	2022-01-12 05:48:07	2022-01-12 14:29:02	9224649	factory
159067	2022-01-13 05:49:22	2022-01-13 14:28:24	9224649	factory
159068	2022-01-14 05:51:27	2022-01-14 14:28:12	9224649	factory
159069	2022-01-17 05:56:12	2022-01-17 14:29:08	9224649	factory
159070	2022-01-18 05:58:27	2022-01-18 14:26:54	9224649	factory
159071	2022-01-19 05:56:39	2022-01-19 14:28:41	9224649	factory
159072	2022-01-20 05:50:36	2022-01-20 14:27:57	9224649	factory
159073	2022-01-21 05:46:09	2022-01-21 14:31:23	9224649	factory
159074	2022-01-24 05:49:47	2022-01-24 14:30:36	9224649	factory
159075	2022-01-25 05:55:01	2022-01-25 14:29:13	9224649	factory
159076	2022-01-26 05:51:51	\N	9224649	factory
159077	2022-01-27 05:54:14	2022-01-27 14:28:41	9224649	factory
159078	2022-01-28 05:51:59	2022-01-28 14:30:17	9224649	factory
159079	2022-01-31 05:57:33	2022-01-31 14:28:21	9224649	factory
159080	2022-02-01 05:57:24	2022-02-01 14:28:04	9224649	factory
159081	2022-02-02 05:58:04	\N	9224649	factory
159082	2022-02-03 05:48:59	2022-02-03 14:28:50	9224649	factory
159083	2022-02-04 05:44:28	2022-02-04 14:28:40	9224649	factory
159084	2022-02-07 05:51:39	2022-02-07 14:30:16	9224649	factory
159085	2022-02-08 05:51:25	2022-02-08 14:30:03	9224649	factory
159086	2022-02-09 05:51:15	2022-02-09 14:28:54	9224649	factory
159087	2022-02-10 05:52:57	2022-02-10 14:28:27	9224649	factory
159088	2022-02-11 05:50:17	2022-02-11 14:26:22	9224649	factory
159089	2022-02-14 06:01:04	2022-02-14 14:29:22	9224649	factory
159090	2022-02-15 05:44:55	2022-02-15 14:28:09	9224649	factory
159091	2022-02-16 05:53:08	2022-02-16 14:30:26	9224649	factory
159092	2022-02-17 05:59:16	\N	9224649	factory
159093	2022-02-18 05:48:44	2022-02-18 14:32:51	9224649	factory
159094	2022-02-21 05:55:10	2022-02-21 14:30:36	9224649	factory
159095	2022-02-22 05:49:55	2022-02-22 14:30:03	9224649	factory
159096	2022-02-23 05:58:32	2022-02-23 14:25:14	9224649	factory
159097	2022-02-24 05:57:12	2022-02-24 14:28:33	9224649	factory
159098	2022-02-25 05:56:09	2022-02-25 13:20:26	9224649	factory
159099	2022-02-28 05:51:54	2022-02-28 14:29:50	9224649	factory
159100	2022-03-01 05:47:31	2022-03-01 14:27:52	9224649	factory
159101	2021-12-01 06:34:09	\N	9224667	factory
159102	2021-12-02 06:34:34	2021-12-02 15:31:14	9224667	factory
159103	2021-12-03 06:39:20	2021-12-03 15:29:56	9224667	factory
159104	2021-12-06 06:27:44	2021-12-06 15:30:39	9224667	factory
159105	2021-12-07 06:37:01	2021-12-07 15:30:18	9224667	factory
159106	2021-12-08 06:29:46	2021-12-08 15:29:51	9224667	factory
159107	2021-12-09 06:28:45	2021-12-09 15:30:21	9224667	factory
159108	2021-12-10 06:29:23	\N	9224667	factory
159109	2021-12-13 06:27:16	2021-12-13 15:29:38	9224667	factory
159110	2021-12-14 06:28:52	2021-12-14 15:30:13	9224667	factory
159111	2021-12-15 06:27:10	2021-12-15 15:29:29	9224667	factory
159112	2021-12-16 06:27:04	2021-12-16 15:30:12	9224667	factory
159113	2021-12-17 06:35:51	2021-12-17 15:29:38	9224667	factory
159114	2021-12-20 06:28:28	2021-12-20 15:31:59	9224667	factory
159115	2021-12-21 06:23:06	2021-12-21 15:31:24	9224667	factory
159116	2021-12-22 06:29:13	2021-12-22 15:31:53	9224667	factory
159117	2021-12-23 06:33:53	2021-12-23 15:31:17	9224667	factory
159118	2021-12-24 06:32:05	2021-12-24 15:31:51	9224667	factory
159119	2021-12-27 06:27:59	2021-12-27 15:30:21	9224667	factory
159120	2021-12-28 06:12:11	2021-12-28 15:31:41	9224667	factory
159121	2021-12-29 06:47:43	\N	9224667	factory
159122	2022-01-04 06:23:12	2022-01-04 14:31:52	9224667	factory
159123	2022-01-05 06:34:31	2022-01-05 14:30:46	9224667	factory
159124	2022-01-10 06:31:14	2022-01-10 15:31:22	9224667	factory
159125	2022-01-11 06:33:21	2022-01-11 15:31:32	9224667	factory
159126	2022-01-12 06:34:13	2022-01-12 15:31:26	9224667	factory
159127	2022-01-13 06:36:10	2022-01-13 15:31:17	9224667	factory
159128	2022-01-14 06:34:24	2022-01-14 15:31:40	9224667	factory
159129	2022-01-17 06:35:57	2022-01-17 15:31:06	9224667	factory
159130	2022-01-18 06:27:59	2022-01-18 15:31:16	9224667	factory
159131	2022-01-19 06:39:29	2022-01-19 15:31:53	9224667	factory
159132	2022-01-20 06:29:31	2022-01-20 15:31:10	9224667	factory
159133	2022-01-21 06:34:38	2022-01-21 15:31:16	9224667	factory
159134	2022-01-24 06:25:30	2022-01-24 15:31:28	9224667	factory
159135	2022-01-25 06:30:13	2022-01-25 15:31:32	9224667	factory
159136	2022-01-26 06:35:48	2022-01-26 15:31:36	9224667	factory
159137	2022-01-27 06:29:08	2022-01-27 15:31:29	9224667	factory
159138	2022-01-28 06:32:48	2022-01-28 15:27:34	9224667	factory
159139	2022-01-31 06:40:51	2022-01-31 15:31:55	9224667	factory
159140	2022-02-01 06:35:06	2022-02-01 15:31:26	9224667	factory
159141	2022-02-02 06:36:45	2022-02-02 15:31:20	9224667	factory
159142	2022-02-03 06:32:48	2022-02-03 15:32:59	9224667	factory
159143	2022-02-04 06:13:46	2022-02-04 15:31:46	9224667	factory
159144	2022-02-07 06:16:54	2022-02-07 15:32:09	9224667	factory
159145	2022-02-08 15:32:13	\N	9224667	factory
159146	2022-02-09 06:27:12	2022-02-09 15:32:25	9224667	factory
159147	2022-02-10 06:31:50	2022-02-10 15:31:56	9224667	factory
159148	2022-02-11 06:36:37	2022-02-11 15:03:50	9224667	factory
159149	2022-02-14 06:25:30	2022-02-14 15:32:31	9224667	factory
159150	2022-02-15 06:36:37	2022-02-15 15:32:33	9224667	factory
159151	2022-02-16 06:23:30	2022-02-16 15:32:06	9224667	factory
159152	2022-02-17 06:24:44	2022-02-17 15:31:29	9224667	factory
159153	2022-02-18 06:27:32	2022-02-18 15:31:16	9224667	factory
159154	2022-02-21 06:28:18	2022-02-21 15:32:24	9224667	factory
159155	2022-02-22 06:32:29	2022-02-22 15:32:50	9224667	factory
159156	2022-02-23 06:39:43	2022-02-23 15:31:21	9224667	factory
159157	2022-02-24 06:12:24	2022-02-24 15:31:37	9224667	factory
159158	2022-02-25 06:34:18	2022-02-25 14:31:19	9224667	factory
159159	2022-02-28 06:15:56	2022-02-28 15:32:10	9224667	factory
159160	2022-03-01 06:31:03	2022-03-01 15:31:56	9224667	factory
159161	2021-12-01 06:46:29	2021-12-01 15:32:44	9224662	factory
159162	2021-12-02 06:44:02	2021-12-02 15:31:20	9224662	factory
159163	2021-12-03 06:46:05	2021-12-03 15:31:09	9224662	factory
159164	2021-12-06 06:37:06	2021-12-06 15:32:36	9224662	factory
159165	2021-12-07 06:46:19	2021-12-07 15:29:34	9224662	factory
159166	2021-12-08 06:48:35	2021-12-08 15:31:29	9224662	factory
159167	2021-12-09 06:43:20	2021-12-09 15:35:02	9224662	factory
159168	2021-12-10 06:46:40	2021-12-10 15:32:33	9224662	factory
159169	2021-12-11 06:44:10	\N	9224662	factory
159170	2021-12-13 06:38:28	2021-12-13 15:32:51	9224662	factory
159171	2021-12-14 06:49:55	2021-12-14 15:31:34	9224662	factory
159172	2021-12-15 06:47:51	2021-12-15 15:32:21	9224662	factory
159173	2021-12-16 07:55:28	2021-12-16 15:30:40	9224662	factory
159174	2021-12-17 06:46:28	2021-12-17 15:32:55	9224662	factory
159175	2021-12-18 07:08:32	2021-12-18 11:36:51	9224662	factory
159176	2021-12-20 06:49:40	2021-12-20 15:50:28	9224662	factory
159177	2021-12-21 06:43:32	2021-12-21 15:35:50	9224662	factory
159178	2021-12-22 06:45:42	2021-12-22 15:33:59	9224662	factory
159179	2021-12-23 08:57:05	2021-12-23 15:43:21	9224662	factory
159180	2021-12-24 06:51:07	2021-12-24 15:32:49	9224662	factory
159181	2021-12-25 06:47:15	2021-12-25 14:35:47	9224662	factory
159182	2021-12-27 06:47:28	2021-12-27 15:30:55	9224662	factory
159183	2021-12-28 06:52:06	2021-12-28 15:31:17	9224662	factory
159184	2021-12-29 07:23:35	\N	9224662	factory
159185	2022-01-04 06:50:12	2022-01-04 13:41:07	9224662	factory
159186	2022-01-05 07:49:22	2022-01-05 13:41:17	9224662	factory
159187	2022-01-06 07:03:20	2022-01-06 09:59:39	9224662	factory
159188	2022-01-10 06:37:08	2022-01-10 15:33:02	9224662	factory
159189	2022-01-11 06:40:16	2022-01-11 15:32:17	9224662	factory
159190	2022-01-12 06:58:48	2022-01-12 15:32:29	9224662	factory
159191	2022-01-13 06:53:15	2022-01-13 15:32:25	9224662	factory
159192	2022-01-14 06:41:52	2022-01-14 15:32:27	9224662	factory
159193	2022-01-17 06:43:21	2022-01-17 19:27:27	9224662	factory
159194	2022-01-18 06:41:19	2022-01-18 15:32:56	9224662	factory
159195	2022-01-19 06:50:51	2022-01-19 15:33:53	9224662	factory
159196	2022-01-20 06:42:25	\N	9224662	factory
159197	2022-01-20 20:44:40	\N	9224662	factory
159198	2022-02-07 06:34:50	2022-02-07 15:31:05	9224662	factory
159199	2022-02-08 06:37:49	2022-02-08 15:31:17	9224662	factory
159200	2022-02-09 06:47:39	2022-02-09 15:32:07	9224662	factory
159201	2022-02-10 06:44:55	\N	9224662	factory
159202	2022-02-11 06:47:32	2022-02-11 15:30:39	9224662	factory
159203	2022-02-14 06:45:59	2022-02-14 15:35:11	9224662	factory
159204	2022-02-15 06:52:09	2022-02-15 15:34:33	9224662	factory
159205	2022-02-16 06:50:36	2022-02-16 15:32:53	9224662	factory
159206	2022-02-17 06:56:10	2022-02-17 15:31:44	9224662	factory
159207	2022-02-18 06:46:20	2022-02-18 15:32:34	9224662	factory
159208	2022-02-21 06:39:14	2022-02-21 15:33:45	9224662	factory
159209	2022-02-22 15:31:36	\N	9224662	factory
159210	2022-02-23 06:46:08	2022-02-23 14:50:22	9224662	factory
159211	2022-02-24 06:47:33	2022-02-24 16:14:49	9224662	factory
159212	2022-02-25 06:49:00	2022-02-25 14:34:08	9224662	factory
159213	2022-02-28 06:42:45	2022-02-28 15:35:18	9224662	factory
159214	2022-03-01 06:36:24	2022-03-01 19:40:43	9224662	factory
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: attendance; Owner: postgres
--

COPY attendance.users (id, firstname, lastname, card) FROM stdin;
11604	Андрей	Николаев	9224696
11605	Владимир	Погодин	9224701
11606	Юрий	Рыбкин	11003802
11607	Владимир	Судаков	9224735
11608	Леонид	Тимофеев	9224748
11609	Александр	Федоров	9224769
11610	Виталий	Целищев	9224782
11611	Ольга	Щербакова	9224680
11612	Вячеслав	Иванов	9224683
11613	Алина	Путина	9224714
11614	С	Факеев	1484271
11615	Елена	Гордеева	1484276
11616	Л	Маркова	8332834
11617	Анна	Остапенко	8332859
11618	Петр	Александров	8332864
11619	Сергей	Андреев	8332889
11620	Александр	Григорьев	11021243
11621	Алексей	Егоров	11021242
11622	Александр	Иванов	11110579
11623	Григорий	Иванов	11105690
11624	Евгений	Иванов	11109430
11625	Сергей	Капитонов	11123939
11626	Валерий	Краснов	11109429
11627	Юрий	Митрофанов	11117613
11628	Николай	Николаев	11117612
11629	Денис	Новосельцев	11115134
11630	Николай	Осипов	11002702
11631	Юрий	Петров	11003803
11632	Дмитрий	Петров	10998366
11633	Сергей	Польков	11002701
11634	Юрий	Поторский	11003511
11635	Андрей	Смирнов	10999338
11636	Сергей	Симулин	11065173
11637	Сергей	Трофимов	11016445
11638	Елена	Федотова	11018974
11639	Сергей	Целищев	11019089
11640	Димитрий	Яковлев	11008422
11641	Андрей	Хохлов	11014279
11642	Алексей	Латышев	11009301
11643	Алена	Ерумина	11008423
11644	Александр В	Егоров	11009634
11645	Ирина	Александрова	11010518
11646	Андрей	Волокушин	11009300
11647	Юрий	Григорьев	11063336
11648	Виктор	Денисов	11072170
11649	Александр	Егоров	11090640
11650	Валерий	Иванов	11062825
11651	Вера	Иванова	11026309
11652	Андрей	Лыченков	11034232
11653	Юрий	Максимов	11034231
11654	Владислав	Начевкин	11051237
11655	Александр	Недбайлов	11039913
11656	Татьяна	Поздеева	11041310
11657	Сергей	Смирнов	11196059
11658	Владимир	Смирнов	11196060
11659	Александр	Сорокин	11046678
11660	Алексей	Скачков	11045614
11661	Станислав	Филиппов	11009315
11662	Сергей	Щукин	11001382
11663	Олег	Максимов	11002681
11664	Владимир	Сергеев	11001628
11665	Вадим	Краденов	11009620
11666	Елена	Страхова	11002682
11667	Екатерина	Ермолина	10996540
11668	Александр	Кутынкин	11005771
11669	Алина	Горшкова	11005751
11670	Андрей	Дмитриев	11016857
11671	Вячеслав	Егоров	11019090
11672	Римма	Матвеева	11015934
11673	Павел	Злобин	11027133
11674	Дмитрий	Павлов	11014642
11675	Валерий	Евсеев	11020843
11676	Вячеслав	Петров	11168173
11677	Алексей	Киселев	11015933
11678	Наталья	Ермакова	11179214
11679	Карен	Оганесян	11008409
11680	Ольга	Алексеева	8170321
11681	Андрей	Александров	8170266
11682	Лариса	Антонова	8170342
11683	Сергей	Антонов	8170322
11684	Светлана	Бахтина	8170265
11685	Галина	Васильева	9224661
11686	Валерий	Григорьев	9224668
11687	Алексей	Гришин	9224695
11688	Оксана	Глухова	9224702
11689	Николай	Иванов	9224729
11690		Нерабочая	9224736
11691	Анатолий	Ильин	9224747
11692	Николай	Козлов	9224770
11693	Анастасия	Козлова	9224781
11694	Валентина	Коплик	9224628
11695	Лидия	Лисицина	9224649
11696	Радислав	Марков	9224667
11697	Владимир	Матвеев	9224662
\.


--
-- Data for Name: AccessLevels; Type: TABLE DATA; Schema: erp; Owner: postgres
--

COPY erp."AccessLevels" ("AccessLevelID", "Name") FROM stdin;
1	Генеральный 
2	Менеджемент
3	Производство
4	Бухгалтерия
\.


--
-- Data for Name: CheckListTPLs; Type: TABLE DATA; Schema: erp; Owner: postgres
--

COPY erp."CheckListTPLs" ("CheckListTPLID", "Title") FROM stdin;
1	Типичный чек-лист
\.


--
-- Data for Name: CheckListUnits; Type: TABLE DATA; Schema: erp; Owner: postgres
--

COPY erp."CheckListUnits" ("CheckListUnitID", "OrderID", "Point", "IsComplited") FROM stdin;
259	90	Оплатить КШТВГ 16-80	t
260	94	Оплатить краны	f
288	89	Запросить доплату	t
287	89	Запросить уточнение расположения стрел	t
258	90	Комплект ответных фланцев, крепежа и прокладок на производстве	t
\.


--
-- Data for Name: Comments; Type: TABLE DATA; Schema: erp; Owner: postgres
--

COPY erp."Comments" ("CommentID", "OrderID", "UserID", "Timestamp", "Text") FROM stdin;
428	165	17	2021-11-24 07:42:13.342852+00	можно запросить доплату
528	240	16	2022-02-21 06:06:43.074598+00	<span style="color: rgba(0, 0, 0, 0.87); font-size: 14px;">Заполнить упаковочный лист по ссылке</span><div style="font-size: 14px; color: rgba(0, 0, 0, 0.87);">https://docs.google.com/document/d/1dbFcCfZ_PShLwERU3CVC7UQd5KKSeSD21ssyLo7DI7U/edit?usp=sharing</div>
413	174	15	2021-11-16 08:10:10.602454+00	<div class="Comments_checklistUnit__2rS_e Comments_checklistUnit_complited__1J6jW"><ya-tr-span data-index="179-0" data-translated="true" data-source-lang="en" data-target-lang="ru" data-value="Уточнить причину неисправности" data-translation="Уточнить причину неисправности" data-type="trSpan">Уточнить причину неисправности</ya-tr-span></div><div class="Comments_checklistUnit__2rS_e Comments_checklistUnit_complited__1J6jW"><ya-tr-span data-index="180-0" data-translated="true" data-source-lang="en" data-target-lang="ru" data-value="Написать ответное письмо на акт неисправности" data-translation="Написать ответное письмо на акт неисправности" data-type="trSpan">Написать ответное письмо на акт неисправности</ya-tr-span></div><div class="Comments_checklistUnit__2rS_e Comments_checklistUnit_complited__1J6jW"><ya-tr-span data-index="181-0" data-translated="true" data-source-lang="en" data-target-lang="ru" data-value="Запросить накладную на вывоз" data-translation="Запросить накладную на вывоз" data-type="trSpan" data-selected="false">Запросить накладную на вывоз</ya-tr-span></div><div class="Comments_checklistUnit__2rS_e Comments_checklistUnit_complited__1J6jW"><ya-tr-span data-index="182-0" data-translated="true" data-source-lang="en" data-target-lang="ru" data-value="Отправить плату блока БСПТ" data-translation="Отправить плату блока БСПТ" data-type="trSpan">Отправить плату блока БСПТ</ya-tr-span></div><div class="Comments_checklistUnit__2rS_e Comments_checklistUnit_complited__1J6jW"><ya-tr-span data-index="183-0" data-translated="true" data-source-lang="en" data-target-lang="ru" data-value="Получить неисправную плату БСПТ" data-translation="Получить неисправную плату БСПТ" data-type="trSpan" data-selected="false">Получить неисправную плату БСПТ</ya-tr-span></div><div class="Comments_checklistUnit__2rS_e"><ya-tr-span data-index="184-0" data-translated="true" data-source-lang="en" data-target-lang="ru" data-value="Написать акт дефектации неисправной платы" data-translation="Написать акт дефектации неисправной платы" data-type="trSpan">Написать акт дефектации неисправной платы</ya-tr-span></div><div class="Comments_checklistUnit__2rS_e"><ya-tr-span data-index="185-0" data-translated="true" data-source-lang="en" data-target-lang="ru" data-value="Получить оплату за расходы" data-translation="Получить оплату за расходы" data-type="trSpan">Получить оплату за расходы</ya-tr-span></div>
372	138	19	2021-11-11 09:55:39.927+00	Нетто:93:Брутто:108 ящ.ПЭМ=1шт.
507	215	16	2022-01-17 11:24:47.423646+00	<span style="color: rgba(0, 0, 0, 0.87); font-size: 14px;">Заполнить упаковочный лист по ссылке</span><div style="font-size: 14px; color: rgba(0, 0, 0, 0.87);">https://docs.google.com/document/d/1dbFcCfZ_PShLwERU3CVC7UQd5KKSeSD21ssyLo7DI7U/edit?usp=sharing</div>
449	143	15	2021-11-29 06:39:33.72636+00	<div class="Comments_checklistUnit__2rS_e Comments_checklistUnit_complited__1J6jW">Оплатить клапаны</div><div class="Comments_checklistUnit__2rS_e Comments_checklistUnit_complited__1J6jW">Оплатить затворы</div><div class="Comments_checklistUnit__2rS_e Comments_checklistUnit_complited__1J6jW">Оплатить краны</div><div class="Comments_checklistUnit__2rS_e">Оплатить комплект КОФ</div>
401	170	15	2021-11-12 14:54:29.948+00	<div class="Comments_checklistUnit__2rS_e">Оформить гарантийный талон</div><div class="Comments_checklistUnit__2rS_e Comments_checklistUnit_complited__1J6jW">Согласовать присоед. чертежи</div><div class="Comments_checklistUnit__2rS_e Comments_checklistUnit_complited__1J6jW">Оплатить редукторы</div><div class="Comments_checklistUnit__2rS_e Comments_checklistUnit_complited__1J6jW">Оплатить затворы ПРомарм</div><div class="Comments_checklistUnit__2rS_e Comments_checklistUnit_complited__1J6jW">Оплатить затвор Квант</div>
505	176	17	2022-01-17 11:24:27.30244+00	<span class="Comments_mentionedUserHiglight__MWwVB" data-mentioned-user="15" contenteditable="false">@Михаил Лосеев, </span>КРАНЫ ПРИЕХАЛИ, МОЖНО ПРОСИТЬ ДОПЛАТУ
425	176	15	2021-11-23 16:09:02.507506+00	Краны приедут ориентировочно к 22.12
471	197	18	2021-12-09 09:42:18.835504+00	<span style="color: rgba(0, 0, 0, 0.87); font-family: &quot;Times New Roman&quot;, serif; font-size: 14px;">ПЭМ-А 29У, </span>\n\n<p class="MsoNormal">Добрый\nдень , данный БСПТ был установлен на приводе ПЭМ-А 29У, настройка происходила\nсогласно ВЗИС.426449.002 РЭ, но добиться выходного сигнала 4-20мА у нас так и\nне получилось, при 100% открытие он выдает 16 мА. Для питания БСПТ мы\nиспользуем блок питания БП-20. Даже при полном нажатие на БСПТ штока и\n&nbsp;регулировке подстроечными резисторами максимальный выходной сигнал 16 мА.\nПросим проконсультировать нас в решение данной проблемы. И есть ли возможность\nзаказать у вас такой&nbsp;же новый.&nbsp;&nbsp;С</p><p class="MsoNormal">Уважением,<br>\nСпичак&nbsp;Вячеслав ВладимировичВедущий</p><p class="MsoNormal">инженер АСУ<br>\nАО "СКБК"<br>\nтел.&nbsp; &nbsp;&nbsp;324-91-26<br>\nфакс. 327-70-25<o:p></o:p></p>\n \n<p class="MsoNormal">&nbsp;<o:p></o:p></p> \n\n
276	106	16	2021-10-25 04:48:08.565+00	Отгрузка в ящиках вместе с затворами
502	206	15	2021-12-30 06:07:05.084362+00	<span class="Comments_mentionedUserHiglight__MWwVB" data-mentioned-user="17" contenteditable="false">@Денис Новосельцев, </span>Прошу согласовать чертежи
527	233	16	2022-02-21 06:06:34.788183+00	<span style="color: rgba(0, 0, 0, 0.87); font-size: 14px;">Заполнить упаковочный лист по ссылке</span><div style="font-size: 14px; color: rgba(0, 0, 0, 0.87);">https://docs.google.com/document/d/1dbFcCfZ_PShLwERU3CVC7UQd5KKSeSD21ssyLo7DI7U/edit?usp=sharing</div>
224	126	17	2021-10-18 03:07:38.899+00	запросить расположение стрел
511	187	15	2022-01-20 16:15:28.304113+00	Акт дефектации отправлен - восстановлению не подлежит.<div>Отправлено КП на новый привод.</div><div>Стоимость диагностики включить в стоимость нового привода</div>
533	241	18	2022-03-03 09:50:28.849506+00	отгрузку по копии доверенности разрешаю /Э.Н.Лосеев/
416	126	15	2021-11-18 06:08:52.054981+00	Вэлан обещает отгрузиться 19.11
419	161	15	2021-11-23 07:08:50.724077+00	Сдэк по расчету получается дешевле - 860руб. На доставку заложено 1341 руб.
283	126	15	2021-11-12 11:34:16.463+00	<div class="Comments_checklistUnit__2rS_e Comments_checklistUnit_complited__1J6jW">оплатить комплектацию</div><div class="Comments_checklistUnit__2rS_e Comments_checklistUnit_complited__1J6jW"> <span style="font-size: medium; color: var(--highContrast);" class="Comments_checklistUnit_complited__1J6jW">запросить расположение стрел</span></div><div class="Comments_checklistUnit__2rS_e Comments_checklistUnit_complited__1J6jW">запросить доплату</div><div class="Comments_checklistUnit__2rS_e Comments_checklistUnit_complited__1J6jW">Уточнить возможность досрочной отгрузки</div>
414	88	19	2021-11-16 12:28:25.857012+00	Нетто:1020.Брутто:1335 ящ.730*600*350=4ящ. ящ.630*450*350=3шт. ящ.730*600*250=16шт.
346	111	15	2021-11-03 10:39:47.734+00	<span class="order-title" style="font-family: Roboto, Helvetica, Arial; white-space: normal; box-sizing: border-box; background-image:  !important; background-position-x:  !important; background-position-y:  !important; background-size:  !important; background-repeat-x:  !important; background-repeat-y:  !important; background-attachment:  !important; background-origin:  !important; background-clip:  !important;">ЧБК-МНС-950611/21</span><span style="color: rgb(51, 51, 51); font-family: Roboto, Helvetica, Arial; font-size: 14px; white-space: normal; background-color: rgb(247, 247, 250);">&nbsp;от 03.11.2021</span>
281	137	17	2021-10-27 08:13:14.442+00	к какому МЭО(ф) нужен датчик? какое исполнение на РП10-30?<div><br></div>
421	169	17	2021-11-23 11:02:52.945024+00	можно запросить доплату!
422	162	17	2021-11-23 11:03:16.658781+00	можно запросить доплату
506	216	16	2022-01-17 11:24:36.405492+00	<span style="color: rgba(0, 0, 0, 0.87); font-size: 14px;">Заполнить упаковочный лист по ссылке</span><div style="font-size: 14px; color: rgba(0, 0, 0, 0.87);">https://docs.google.com/document/d/1dbFcCfZ_PShLwERU3CVC7UQd5KKSeSD21ssyLo7DI7U/edit?usp=sharing</div>
468	170	15	2021-12-08 11:53:29.48565+00	Сатликов Нияз сказал подписать чертежи следующим образом:<div>Согласовано с замечаниями (подпись, расшифровка, дата)</div><div>- <span style="background-color: rgb(248, 248, 248); color: rgba(0, 0, 0, 0.87); white-space: normal;">РЗА-С-1000.1-39.21.46L (под Y - поставить знак вопроса, D4 - поставить 99,7)</span></div><div><span style="background-color: rgb(248, 248, 248); color: rgba(0, 0, 0, 0.87); white-space: normal;">- РЗА-С-2000.1-56.21.203</span><span style="background-color: rgb(248, 248, 248); font-size: 14.4px; color: rgba(0, 0, 0, 0.6); white-space: normal;">&nbsp;</span><span style="background-color: rgb(248, 248, 248); color: rgba(0, 0, 0, 0.87);">F14 кв. 32П </span><span style="background-color: rgb(248, 248, 248); color: rgba(0, 0, 0, 0.87); white-space: normal;">(Y, D4, H4 -&nbsp;</span><span style="color: rgba(0, 0, 0, 0.87); white-space: normal; background-color: rgb(248, 248, 248);">зачеркнуть</span><span style="background-color: rgb(248, 248, 248); color: rgba(0, 0, 0, 0.87); white-space: normal;">)</span></div><div><span style="background-color: rgb(248, 248, 248); color: rgba(0, 0, 0, 0.87); white-space: normal;">- РЗА-С-2000.1-56.21.207</span><span style="background-color: rgb(248, 248, 248); color: rgba(0, 0, 0, 0.6); font-size: 14.4px; white-space: normal;">&nbsp;</span><span style="background-color: rgb(248, 248, 248); color: rgba(0, 0, 0, 0.87);">F14 кв. 36П </span><span style="background-color: rgb(248, 248, 248); color: rgba(0, 0, 0, 0.87); white-space: normal;">(Y, D4, H4 -&nbsp;</span><span style="background-color: rgb(248, 248, 248); color: rgba(0, 0, 0, 0.87); white-space: normal;">зачеркнуть</span><span style="background-color: rgb(248, 248, 248); color: rgba(0, 0, 0, 0.87); white-space: normal;">)</span><span style="background-color: rgb(248, 248, 248); color: rgba(0, 0, 0, 0.87); white-space: normal;"><br></span></div>
411	174	15	2021-11-16 07:35:59.072513+00	<span class="Comments_mentionedUserHiglight__MWwVB" data-mentioned-user="17" contenteditable="false">@Денис  Новосельцев</span><span> подготовить плату к отправке</span>
429	177	16	2021-11-24 11:50:36.276955+00	У кабелей приходящих с двигателя нет маркировки для соответствующих им клемм, одинаковая фазировка между приводами выставляется при ПСИ.  пожелание учтено, данное мероприятие будет усиленно контролироваться.
420	119	17	2021-11-23 11:02:10.617687+00	не должно быть проблем
423	126	17	2021-11-23 11:06:26.849209+00	овен будет на отгружать не ранее 4декабря, Т. К оплата прошла поздно и срок изготовления 15 календарных дней
436	183	17	2021-11-26 11:11:39.562051+00	<span class="Comments_mentionedUserHiglight__MWwVB" data-mentioned-user="18" contenteditable="false">@Ирина Энгельс</span><span> привод починили , лопнул диск тормозного устройства( сняли с донора)</span>
431	186	18	2021-11-26 06:13:09.668973+00	Вероятно это срабатывает механическая моментная муфта от дураков , потому что электрическую не подключили , рекомендация : почитать перед сном Р.Э.- 10 раз
426	177	18	2021-11-23 16:37:35.936494+00	Н.Д.В.  прошу разобраться
496	186	15	2021-12-23 06:01:37.187967+00	<span class="Comments_mentionedUserHiglight__MWwVB" data-mentioned-user="17" contenteditable="false">@Денис Новосельцев, </span><span></span><span style="font-size: 11pt; color: black; font-family: Calibri, sans-serif;">При детальном разбирательстве оказалось, что привод рабочий. </span><span style="font-size: 11pt; color: black; font-family: Calibri, sans-serif;">Претензия к тем кто вешал привод на задвижку… </span><span style="font-size: 11pt; color: black; font-family: Calibri, sans-serif;">Не почистили площадку и коронку от грязи..</span>
284	126	15	2021-11-12 11:34:16.914+00	Уточнить возможность досрочной отгрузки
512	119	19	2022-01-25 05:37:59.780171+00	ЯЩ.730*600*250=4шт. ящ.500*410*350=1шт.
378	109	15	2021-11-12 08:56:03.891+00	<span class="Comments_mentionedUserHiglight__MWwVB" data-mentioned-user="16" contenteditable="false">@Павел Злобин</span><span> Когда будет доплата?</span>
217	93	17	2021-10-06 04:31:34.566888+00	шестерни датчика 1:1, угол поворота указателя 120*
388	94	15	2021-11-12 09:03:53.078781+00	Оказалось, что нужен был кран нашего производства. Не подошел по строительной длине. Переварили фланцы
339	111	19	2021-11-01 11:53:07.778754+00	Нетто:66КГ.Брутто90КГ.Ящ.630*450*350=1шт.Ящ.650*500*650=1шт.
535	225	15	2022-03-04 12:35:41.582985+00	<span class="Comments_mentionedUserHiglight__AMXFd" data-mentioned-user="17" contenteditable="false">@Денис Новосельцев, </span><span></span><b style="white-space: normal; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); caret-color: rgb(68, 68, 68); color: rgb(68, 68, 68); font-family: calibri, sans-serif; font-size: 14.6667px; text-size-adjust: 100%;"><span style="background: var(--L0) !important; font-size: 14px !important; color: rgb(31, 73, 125);">Стрела слева&nbsp; -1 шт. и стрела справа – 1 шт.</span></b>
282	137	17	2021-10-27 08:13:25.681465+00	или без жгута?
486	208	15	2021-12-14 10:22:09.032883+00	<span style="color: rgba(0, 0, 0, 0.87); font-size: 14px;">Привод уже снят с объекта. Отправляют привод к нам на диагностику</span>
424	177	15	2021-11-23 12:33:03.705668+00	<span class="Comments_mentionedUserHiglight__MWwVB" data-mentioned-user="16" contenteditable="false">@Павел  Злобин</span><span></span>
415	141	19	2021-11-17 11:12:08.991405+00	Нетто:16кг,Брутто:26 кг.) Ящ.500*410*35=1шт.
389	139	15	2021-11-12 09:04:24.782641+00	Клиент отказался от привода. Можно пустить на другие заказы
371	133	19	2021-11-11 09:53:53.663+00	Нетто:235кг.Брутто280кг ящ.ПЭМ 3шт.
469	170	19	2021-12-09 06:52:39.146633+00	<span class="Comments_mentionedUserHiglight__MWwVB" data-mentioned-user="15" contenteditable="false">@Михаил Лосеев</span><span> подписал</span>
433	177	18	2021-11-26 07:19:50.529994+00	ОТв. Новосельцев Д.В
430	183	18	2021-11-25 14:44:54.303002+00	<p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Calibri Light&quot;,sans-serif">Получили\nписьмо с завода:</span><span style="color: rgb(31, 73, 125);">Сегодня увезли привод в ремонт.</span></p><p class="MsoNormal"><span style="color: rgb(31, 73, 125);">Контактное лицо - Мастер Петухов </span><span style="color: rgb(31, 73, 125);">Дмитрий Анатольевич тел.: 8 921 133-51-49.</span><span style="color: rgb(31, 73, 125);">Прошу выслать в наш адрес </span><span style="color: rgb(31, 73, 125);">документацию на данный привод – для проведения дефектовки/ремонта нашими</span></p><p class="MsoNormal"><span style="color:#1F497D">специалистами. </span></p><p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Calibri Light&quot;,sans-serif">уважением, Надежда</span></p>
434	183	18	2021-11-26 07:20:11.322714+00	Отв.Н.Д.В
497	187	15	2021-12-23 11:21:46.287518+00	<div class="Comments_checklistUnit__2rS_e Comments_checklistUnit_complited__1J6jW">Акт дефектации</div><div class="Comments_checklistUnit__2rS_e">Счет на оплату</div><div class="Comments_checklistUnit__2rS_e">Договор подряда</div>
432	178	18	2021-11-26 07:18:58.705775+00	оТВЕТСТВЕННЫЙ  Л.М
508	176	19	2022-01-18 05:01:21.022898+00	Нетто;60 Брутто;80 ящ.500*410*350=1шт. 630*450*350=1шт.
542	281	15	2022-03-15 09:38:40.616834+00	<div class="Comments_checklistUnit__3VLqy"><p class="MsoNormal">Купить кабельные вводы Феррол M20x1.5 (DK=8-12мм GL=7мм)\nКабельный ввод из нержавеющей стали SS304 с силиконовым уплотнителем</p></div>
223	118	15	2021-10-27 13:30:49.135+00	<div><span style="font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Oxygen, Ubuntu, Cantarell, &quot;Fira Sans&quot;, &quot;Droid Sans&quot;, &quot;Helvetica Neue&quot;, sans-serif;">Чебоксары - Минск</span><br></div><div>ООО «АнканПро», УНП 193434875</div><div>220053 Республика Беларусь, г.Минск, ул.Будславская, 2 пом.3 каб.28<div><div><span style="font-size: medium;">Борухова Юлия Ивановна + 375 (44) 701-20-19</span></div><div><span style="font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Oxygen, Ubuntu, Cantarell, &quot;Fira Sans&quot;, &quot;Droid Sans&quot;, &quot;Helvetica Neue&quot;, sans-serif;">Нетто: 66кг, брутто: 80кг, ящик: </span><span style="color: black; font-size: 11pt; font-family: Calibri, sans-serif;">650х500х650 </span><span style="font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Oxygen, Ubuntu, Cantarell, &quot;Fira Sans&quot;, &quot;Droid Sans&quot;, &quot;Helvetica Neue&quot;, sans-serif;">-1 шт.</span></div><div><span style="background-color: rgb(247, 247, 250); color: rgba(0, 0, 0, 0.87); font-size: 14.4px;">Отгрузить ТК Главдоставка, трек ЧБК-МНС-882082/21-Д</span></div></div></div>
487	189	15	2021-12-15 09:00:34.234487+00	<span style="font-size:8.0pt;font-family:&quot;Times New Roman&quot;,serif;\nmso-fareast-font-family:&quot;Times New Roman&quot;;mso-ansi-language:RU;mso-fareast-language:\nRU;mso-bidi-language:AR-SA">Комплектация от </span><span style="color: rgba(0, 0, 0, 0.87); font-family: &quot;Times New Roman&quot;, serif; background-color: rgb(248, 248, 248);">ООО ПП «Автоматика-Инвест» и </span><font face="Times New Roman, serif"><span style="font-size: 14.4px;">ООО «ОНИКС»</span></font><div><font face="Times New Roman, serif"><span style="font-size: 14.4px;">КШТВ 16-40нж-1ЛХ - 3шт.</span><span style="font-size: 8pt;"><br></span></font></div><div><span style="font-size:8.0pt;font-family:&quot;Times New Roman&quot;,serif;\nmso-fareast-font-family:&quot;Times New Roman&quot;;mso-ansi-language:RU;mso-fareast-language:\nRU;mso-bidi-language:AR-SA">Фланец плоский 40-16-01-1-F-СТ09Г2С-IV ГОСТ 33259 - 6шт.</span><div><span style="font-size:8.0pt;font-family:&quot;Times New Roman&quot;,serif;\nmso-fareast-font-family:&quot;Times New Roman&quot;;mso-ansi-language:RU;mso-fareast-language:\nRU;mso-bidi-language:AR-SA">Прокладка парон.А-40 Ру (10-40) ГОСТ 15180-86 - 6шь.</span><span style="font-size:8.0pt;font-family:&quot;Times New Roman&quot;,serif;\nmso-fareast-font-family:&quot;Times New Roman&quot;;mso-ansi-language:RU;mso-fareast-language:\nRU;mso-bidi-language:AR-SA"><br></span></div><div><span style="font-size:8.0pt;font-family:&quot;Times New Roman&quot;,serif;\nmso-fareast-font-family:&quot;Times New Roman&quot;;mso-ansi-language:RU;mso-fareast-language:\nRU;mso-bidi-language:AR-SA">Болт М16-6gх60.21.12Х18Н10Т (S24) ГОСТ 7798-70 - 24шт.</span><span style="font-size:8.0pt;font-family:&quot;Times New Roman&quot;,serif;\nmso-fareast-font-family:&quot;Times New Roman&quot;;mso-ansi-language:RU;mso-fareast-language:\nRU;mso-bidi-language:AR-SA"><br></span></div><div><span style="font-size:8.0pt;font-family:&quot;Times New Roman&quot;,serif;\nmso-fareast-font-family:&quot;Times New Roman&quot;;mso-ansi-language:RU;mso-fareast-language:\nRU;mso-bidi-language:AR-SA">Гайка М16-6H.21.12Х18Н10Т (S24) ГОСТ 5915-70 - 24шт.</span><span style="font-size:8.0pt;font-family:&quot;Times New Roman&quot;,serif;\nmso-fareast-font-family:&quot;Times New Roman&quot;;mso-ansi-language:RU;mso-fareast-language:\nRU;mso-bidi-language:AR-SA"><br></span></div></div>
503	217	15	2022-01-12 11:01:05.84733+00	Заполнить упаковочный лист по ссылке<div>https://docs.google.com/document/d/1dbFcCfZ_PShLwERU3CVC7UQd5KKSeSD21ssyLo7DI7U/edit?usp=sharing<br></div>
514	189	15	2022-01-26 12:11:18.510772+00	Не пришли прокладки с Оникса
470	197	18	2021-12-09 09:39:15.388597+00	 <br>
509	119	19	2022-01-19 06:52:39.142759+00	<span class="Comments_mentionedUserHiglight__MWwVB" data-mentioned-user="15" contenteditable="false">@Михаил Лосеев, </span>можно запросить 2 половину,  предварительно готовы будем в пятницу отдать
525	225	15	2022-02-16 13:04:20.584643+00	Вэлан отправил 10 февраля. Должны приехать 21-22 февраля
478	197	18	2021-12-14 06:59:12.848442+00	\n\n<p class="MsoNormal">8\n911 659 29 74</p>
536	270	15	2022-03-05 06:13:12.923293+00	Затворы приедут ориентировочно к 12 мая
495	188	15	2021-12-22 12:09:44.675727+00	Нужно подготовить 5 счетов:<div>№ 776 - общий счет оставить как есть</div><div><br></div><div>№ <span style="color: rgba(0, 0, 0, 0.87); font-size: 14.4px;">777 </span>Предварительная оплата 50% по счету 776 от 07.12.2021г. за услуги по ремонту\nМЭОФ-160/63-0,25М-IIСT4 УХЛ1, №04583, 2016г на сумму 17 015 без НДС</div><div><span style="color: rgba(0, 0, 0, 0.87); font-size: 14.4px;"><br></span></div><div><span style="color: rgba(0, 0, 0, 0.87); font-size: 14.4px;">№ </span><span style="font-size: 14.4px; color: rgba(0, 0, 0, 0.87);">778 </span><span style="color: rgba(0, 0, 0, 0.87); font-size: 14.4px;">Предварительная оплата 50% по счету 776 от 07.12.2021г. за услуги по ремонту\n</span>МЭОФ-1600/63-0,25М-IIСT4 УХЛ1, №04623, 2016г <span style="color: rgba(0, 0, 0, 0.87); font-size: 14.4px;">на сумму </span><span style="color: rgba(0, 0, 0, 0.87); font-size: 14.4px;">34 680 </span><span style="color: rgba(0, 0, 0, 0.87); font-size: 14.4px;">без НДС</span><br></div><div><span style="color: rgba(0, 0, 0, 0.87); font-size: 14.4px;"><br></span></div><div><span style="color: rgba(0, 0, 0, 0.87); font-size: 14.4px;">№ </span><span style="color: rgba(0, 0, 0, 0.87); font-size: 14.4px;">ХХХ </span><span style="color: rgba(0, 0, 0, 0.87); font-size: 14.4px;">Окончательная</span><span style="color: rgba(0, 0, 0, 0.87); font-size: 14.4px;"> оплата 50% по счету 776 от 07.12.2021г. за услуги по ремонту</span><br></div><div><div style="font-size: 14.4px; color: rgba(0, 0, 0, 0.87);">МЭОФ-160/63-0,25М-IIСT4 УХЛ1, №04583, 2016г на сумму 17 015 без НДС</div><div style="font-size: 14.4px; color: rgba(0, 0, 0, 0.87);"><span style="font-size: 14.4px; color: rgba(0, 0, 0, 0.87);"><br></span></div><div style="font-size: 14.4px; color: rgba(0, 0, 0, 0.87);"><span style="font-size: 14.4px; color: rgba(0, 0, 0, 0.87);">№ </span><span style="font-size: 14.4px; color: rgba(0, 0, 0, 0.87);">ХХХ </span><span style="font-size: 14.4px; color: rgba(0, 0, 0, 0.87);">Окончательная оплата 50% по счету 776 от 07.12.2021г. за услуги по ремонту\n</span>МЭОФ-1600/63-0,25М-IIСT4 УХЛ1, №04623, 2016г <span style="font-size: 14.4px; color: rgba(0, 0, 0, 0.87);">на сумму 34 680 без НДС</span></div></div><div style="font-size: 14.4px; color: rgba(0, 0, 0, 0.87);"><br></div><div style="font-size: 14.4px; color: rgba(0, 0, 0, 0.87);">Сделать УПД на счет 776.</div><div style="font-size: 14.4px; color: rgba(0, 0, 0, 0.87);"><br></div><div style="font-size: 14.4px; color: rgba(0, 0, 0, 0.87);">Сканы в течение дня отправить на <span style="font-family: Arial, sans-serif; font-size: 11pt;">ulyaev.af@gazprom-neft.ru</span></div><div style="font-size: 14.4px; color: rgba(0, 0, 0, 0.87);"><br></div><div style="font-size: 14.4px; color: rgba(0, 0, 0, 0.87);">Подписанные заявки-калькуляции, счета и УПД отправить экспресс почтой: <span style="background-color: rgb(251, 251, 251); color: rgb(51, 51, 51); font-family: &quot;YS Text&quot;, Arial, Helvetica, sans-serif; font-size: 13px; white-space: normal;">190121,&nbsp;</span><span style="font-family: Arial, sans-serif; font-size: 11pt;">Россия, Санкт-Петербург, Английская набережная,</span></div><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif;\nmso-fareast-font-family:&quot;Times New Roman&quot;;mso-ansi-language:RU;mso-fareast-language:\nRU;mso-bidi-language:AR-SA">д.70. В противном случае не смогут провести предоплату в понедельник.</span><div><font face="Arial, sans-serif">Окончательная оплата на основе УПД будет произведена 10 января.</font></div>
498	178	20	2021-12-24 14:23:47.116153+00	<div style="color: rgb(0, 0, 0); font-family: &quot;YS Text&quot;; font-size: 15px; white-space: normal; background-color: rgb(255, 255, 255);">Неправильное хранение ведет к образованию коррозии!</div><div style="color: rgb(0, 0, 0); font-family: &quot;YS Text&quot;; font-size: 15px; white-space: normal; background-color: rgb(255, 255, 255);">→ Складировать в хорошо проветриваемых, сухих помещениях.</div><div style="color: rgb(0, 0, 0); font-family: &quot;YS Text&quot;; font-size: 15px; white-space: normal; background-color: rgb(255, 255, 255);">→ Защищать от сырости грунта путем хранения на стеллаже или деревянном</div><div style="color: rgb(0, 0, 0); font-family: &quot;YS Text&quot;; font-size: 15px; white-space: normal; background-color: rgb(255, 255, 255);">поддоне.</div><div style="color: rgb(0, 0, 0); font-family: &quot;YS Text&quot;; font-size: 15px; white-space: normal; background-color: rgb(255, 255, 255);">→ Накрыть в целях защиты от пыли и грязи.</div><div style="color: rgb(0, 0, 0); font-family: &quot;YS Text&quot;; font-size: 15px; white-space: normal; background-color: rgb(255, 255, 255);">→ Неокрашенные поверхности обработать антикоррозионным средством.</div><div style="color: rgb(0, 0, 0); font-family: &quot;YS Text&quot;; font-size: 15px; white-space: normal; background-color: rgb(255, 255, 255);">Длительное хранение При длительном хранении (более 6 месяцев) необходимо дополнительно</div><div style="color: rgb(0, 0, 0); font-family: &quot;YS Text&quot;; font-size: 15px; white-space: normal; background-color: rgb(255, 255, 255);">обратить внимание на следующее:</div><div style="color: rgb(0, 0, 0); font-family: &quot;YS Text&quot;; font-size: 15px; white-space: normal; background-color: rgb(255, 255, 255);">1</div><div style="color: rgb(0, 0, 0); font-family: &quot;YS Text&quot;; font-size: 15px; white-space: normal; background-color: rgb(255, 255, 255);">Перед хранением:</div><div style="color: rgb(0, 0, 0); font-family: &quot;YS Text&quot;; font-size: 15px; white-space: normal; background-color: rgb(255, 255, 255);">обработать неокрашенные поверхности, особенно присоединительные</div><div style="color: rgb(0, 0, 0); font-family: &quot;YS Text&quot;; font-size: 15px; white-space: normal; background-color: rgb(255, 255, 255);">поверхности и фланцы, долгодействующим антикоррозионным средством.</div><div style="color: rgb(0, 0, 0); font-family: &quot;YS Text&quot;; font-size: 15px; white-space: normal; background-color: rgb(255, 255, 255);">2</div><div style="color: rgb(0, 0, 0); font-family: &quot;YS Text&quot;; font-size: 15px; white-space: normal; background-color: rgb(255, 255, 255);">Каждые 6 месяцев:</div><div style="color: rgb(0, 0, 0); font-family: &quot;YS Text&quot;; font-size: 15px; white-space: normal; background-color: rgb(255, 255, 255);">проверять на предмет образования коррозии. В случае появления</div><div style="color: rgb(0, 0, 0); font-family: &quot;YS Text&quot;; font-size: 15px; white-space: normal; background-color: rgb(255, 255, 255);">коррозии заново нанести антикоррозионную защиту.</div>
516	224	19	2022-01-27 06:37:41.056114+00	<div><br></div><div><span class="Comments_mentionedUserHiglight__MWwVB" data-mentioned-user="16" contenteditable="false" style="font-size: 14.4px; color: rgba(0, 0, 0, 0.87);">@Павел Злобин, </span><span style="font-size: 14.4px; color: rgba(0, 0, 0, 0.87);">планируем отгрузку на понедельник</span><br></div>
488	213	18	2021-12-16 05:33:33.595382+00	не соответствует момент настройки
510	206	15	2022-01-19 15:56:47.400159+00	<div class="Comments_checklistUnit__2rS_e Comments_checklistUnit_complited__1J6jW">Оплатить редукторы</div>
543	278	17	2022-03-18 12:01:46.443537+00	<span class="Comments_mentionedUserHiglight__AMXFd" data-mentioned-user="15" contenteditable="false">@Михаил Лосеев, </span>данный заказ не на СГМ?<div><br></div>
515	233	19	2022-01-27 06:37:29.000817+00	<span class="Comments_mentionedUserHiglight__MWwVB" data-mentioned-user="16" contenteditable="false">@Павел Злобин, </span><span>планируем отгрузку на понедельник</span>
520	250	15	2022-02-01 06:59:14.584497+00	Комплектация: <div>Фланец плоский 80-16-01-1-B-Ст 20-IV ГОСТ 33259-2015  - 2шт.</div><div>Прокладка парон.А-80 Ру (10-40) ГОСТ 15180-86 - 2 шт.<br></div><div>Болт М16-6gх70.58. 20 (S24) ГОСТ 7798-70 - 8шт.<br></div><div>Гайка М16-6H.05.20 (S24) ГОСТ 5915-70 - <span style="background-color: rgb(248, 248, 248); color: rgba(0, 0, 0, 0.87);">8 шт.</span><br></div><div><span style="color: rgba(0, 0, 0, 0.6); font-size: 14.4px; white-space: normal; background-color: rgb(248, 248, 248);">КШТВГ 16-80 Автоматика Инвест - 1шт.</span><span style="background-color: rgb(248, 248, 248); color: rgba(0, 0, 0, 0.87);"><br></span></div><div><span style="color: rgba(0, 0, 0, 0.6); font-size: 14.4px; white-space: normal; background-color: rgb(248, 248, 248);"><br></span></div><div><span style="color: rgba(0, 0, 0, 0.6); font-size: 14.4px; white-space: normal; background-color: rgb(248, 248, 248);">Срок готовности крана 8-15 Апреля</span></div>
479	208	18	2021-12-14 07:09:29.972565+00	АКт о неисправности во вложении
467	170	15	2021-12-06 06:30:49.320517+00	<span class="Comments_mentionedUserHiglight__MWwVB" data-mentioned-user="17" contenteditable="false">@Денис Новосельцев</span><span> Прошу согласовать чертежи редукторов</span>
526	250	15	2022-02-17 06:16:20.898648+00	<div class="Comments_checklistUnit__3VLqy Comments_checklistUnit_complited__UDryM"> Оплатить кран</div><div class="Comments_checklistUnit__3VLqy Comments_checklistUnit_complited__UDryM"> Оплатить фланцы</div>
517	240	19	2022-01-27 06:37:50.894262+00	<div><br></div><div><span class="Comments_mentionedUserHiglight__MWwVB" data-mentioned-user="16" contenteditable="false" style="font-size: 14.4px; color: rgba(0, 0, 0, 0.87);">@Павел Злобин, </span><span style="font-size: 14.4px; color: rgba(0, 0, 0, 0.87);">планируем отгрузку на понедельник</span><br></div>
499	194	20	2021-12-24 15:57:26.146042+00	Номера двигателей: 3-№20.19011078, 72, 62, 89, 61, 81, 73, 79, 87, 156, 70, 88, 80, <span style="color: rgba(0, 0, 0, 0.87); font-size: 14.4px;">139, </span><span style="color: rgba(0, 0, 0, 0.87); font-size: 14.4px;">148, </span><span style="color: rgba(0, 0, 0, 0.87); font-size: 14.4px;">157</span>
524	256	15	2022-02-15 14:55:29.679323+00	Аверин Сергей: 11.02.2022<div>1. Привод в работе с августа 2021.\n2. По часам управлялся редко, и до сих проблем не выявлялось.\n3. Сейчас не в работе естественно, а как ему работать))).\n4. Мэоф 2500 на этом же объекте.\n5. Сопротивление обмоток измеряли, все одинаковые, фото позже.\n6. Сопротивление изоляции тоже замеряли между обмоток и корпусом, тоже в норме.\n7. Фототчет в понедельник сделаем.\n8. Я уже прихожу к мнению, что в эл.двигателе в какойто момент пробой, который появляется после времени работы, что приводит к нагреву обмоток или еще что, потому что еслиб упирался в клин то , так бы не выгорало, а привод бы еще пытался работать до перегруза(такие моменты в работе встречались), а такое тоже впервые.</div><div><br></div><div><span style="color: rgba(0, 0, 0, 0.87); font-size: 14.4px;">Аверин Сергей: 15.02.2022</span><br></div><div>Что-то непонятное явление)), сняли покрутили без крана - не выгорает, установили на кран сутки уже не выгарает..) тестим дальше.<span style="font-size: 14.4px;"><br></span></div>
490	213	17	2021-12-16 06:46:21.472187+00	<span class="Comments_mentionedUserHiglight__MWwVB" data-mentioned-user="18" contenteditable="false">@Ирина Энгельс, </span><span>ссылаются на свой новый стенд для проверки моментов на электроприводах, запросил информацию по нему, ожидаю</span><div><span><br></span></div>
504	214	16	2022-01-13 10:31:34.808706+00	<span style="font-size: 14.4px;">https://abradox.ru/netcat_files/File/FilesForLoading/PassportKlinovojZadvizkiA40_ABRA_BS.pdf</span>
472	194	17	2021-12-09 10:41:24.89145+00	<span class="Comments_mentionedUserHiglight__MWwVB" data-mentioned-user="18" contenteditable="false">@Ирина Энгельс</span><span>. необходимо закупить электродвигателя АИР 56 В4 исполнение УХЛ1</span><div><br></div>
544	278	19	2022-03-18 12:41:10.980728+00	<span class="Comments_mentionedUserHiglight__AMXFd" data-mentioned-user="15" contenteditable="false">@Михаил Лосеев, </span>необходима высота штока арматуры<div>Н=?</div>
480	208	18	2021-12-14 07:16:29.670052+00	Сбой в работе МЭОФ.  Акт во вложении
500	213	17	2021-12-25 04:41:39.462285+00	<span class="Comments_mentionedUserHiglight__MWwVB" data-mentioned-user="15" contenteditable="false">@Михаил Лосеев, </span><span>привод к нам не присылают, делают под данный привод арматуру с меньшим моментом:)</span><div><span><br></span></div>
501	213	17	2021-12-25 04:41:58.781109+00	<span class="Comments_mentionedUserHiglight__MWwVB" data-mentioned-user="15" contenteditable="false">@Михаил Лосеев, </span><span>вопрос решен</span>
450	170	15	2021-11-30 06:41:35.488609+00	<div><span style="color: rgba(0, 0, 0, 0.87); background-color: rgb(248, 248, 248);">Получается, что состав арматуры и затворов будет следующий:</span><div style="background-color: rgb(248, 248, 248); color: rgba(0, 0, 0, 0.87);">- <span style="background-image:  !important; background-position-x:  !important; background-position-y:  !important; background-size:  !important; background-repeat-x:  !important; background-repeat-y:  !important; background-attachment:  !important; background-origin:  !important; background-clip:  !important; background-color: rgb(248, 248, 248); font-size: 14.4px; color: rgba(0, 0, 0, 0.6); white-space: normal;">РЗА-С-1000.1-39.21.46L&nbsp;</span>F14 кв. 27П H40 к <span style="background-color: rgb(248, 248, 248); color: rgba(0, 0, 0, 0.87); white-space: normal;">ПА 332.400.10-01 Ду400 PN10</span><span style="background-color: rgb(248, 248, 248); color: rgba(0, 0, 0, 0.87); white-space: normal;">&nbsp;</span><span style="background-color: rgb(248, 248, 248); color: rgba(0, 0, 0, 0.6); font-size: 14.4px; white-space: normal;">- 4шт.</span></div><div style="background-color: rgb(248, 248, 248); color: rgba(0, 0, 0, 0.87);"><span style="background-color: rgb(248, 248, 248); color: rgba(0, 0, 0, 0.87);">- </span><span style="background-color: rgb(248, 248, 248); color: rgba(0, 0, 0, 0.87); white-space: normal;">РЗА-С-2000.1-56.21.203</span><span style="background-image:  !important; background-position-x:  !important; background-position-y:  !important; background-size:  !important; background-repeat-x:  !important; background-repeat-y:  !important; background-attachment:  !important; background-origin:  !important; background-clip:  !important; background-color: rgb(248, 248, 248); font-size: 14.4px; color: rgba(0, 0, 0, 0.6); white-space: normal;">&nbsp;</span><span style="background-color: rgb(248, 248, 248); color: rgba(0, 0, 0, 0.87);">F14 кв. 32П</span><span style="background-image:  !important; background-position-x:  !important; background-position-y:  !important; background-size:  !important; background-repeat-x:  !important; background-repeat-y:  !important; background-attachment:  !important; background-origin:  !important; background-clip:  !important; background-color: rgb(248, 248, 248); font-size: 14.4px; color: rgba(0, 0, 0, 0.6); white-space: normal;">&nbsp;H51 к&nbsp;</span><span style="background-color: rgb(248, 248, 248); color: rgba(0, 0, 0, 0.87); white-space: normal;">ПА 332.500.10-01 Ду500 PN10&nbsp;</span><span style="background-color: rgb(248, 248, 248); color: rgba(0, 0, 0, 0.6); font-size: 14.4px; white-space: normal;">- 1шт.</span></div><div style="background-color: rgb(248, 248, 248); color: rgba(0, 0, 0, 0.87);"><span style="background-color: rgb(248, 248, 248); color: rgba(0, 0, 0, 0.87);">- </span><span style="background-color: rgb(248, 248, 248); color: rgba(0, 0, 0, 0.87); white-space: normal;">РЗА-С-2000.1-56.21.207L</span><span style="background-image:  !important; background-position-x:  !important; background-position-y:  !important; background-size:  !important; background-repeat-x:  !important; background-repeat-y:  !important; background-attachment:  !important; background-origin:  !important; background-clip:  !important; background-color: rgb(248, 248, 248); font-size: 14.4px; color: rgba(0, 0, 0, 0.6); white-space: normal;">&nbsp;</span><span style="background-color: rgb(248, 248, 248); color: rgba(0, 0, 0, 0.87);">F14 кв. 36П</span><span style="background-image:  !important; background-position-x:  !important; background-position-y:  !important; background-size:  !important; background-repeat-x:  !important; background-repeat-y:  !important; background-attachment:  !important; background-origin:  !important; background-clip:  !important; background-color: rgb(248, 248, 248); font-size: 14.4px; color: rgba(0, 0, 0, 0.6); white-space: normal;">&nbsp;H51 к&nbsp;</span><span style="background-color: rgb(248, 248, 248); color: rgba(0, 0, 0, 0.87); white-space: normal;">ПА 332.500.10-01 Ду500 PN10</span><span style="background-color: rgb(248, 248, 248); color: rgba(0, 0, 0, 0.6); font-size: 14.4px; white-space: normal;">- 2шт.</span></div><div style="background-color: rgb(248, 248, 248); color: rgba(0, 0, 0, 0.87);"><span style="background-color: rgb(248, 248, 248); color: rgba(0, 0, 0, 0.87);">- </span><span style="background-image:  !important; background-position-x:  !important; background-position-y:  !important; background-size:  !important; background-repeat-x:  !important; background-repeat-y:  !important; background-attachment:  !important; background-origin:  !important; background-clip:  !important; background-color: rgb(248, 248, 248); font-size: 14.4px; color: rgba(0, 0, 0, 0.6); white-space: normal;">РЗА-С-2000.1-56.21.208 F16 d41.15 b9.5 H57 к&nbsp;</span><span style="background-color: rgb(248, 248, 248); color: rgba(0, 0, 0, 0.87); white-space: normal;">Квант Ду500 PN10</span><span style="background-color: rgb(248, 248, 248); color: rgba(0, 0, 0, 0.6); font-size: 14.4px; white-space: normal;">- 1шт.</span></div></div><div><br></div>
481	186	15	2021-12-14 07:48:07.696015+00	Поскольку объект не сдан в эксплуатацию, не могут предоставить даже контакты ответственного персонала. Ждем...
538	206	15	2022-03-10 08:40:53.203415+00	<span class="Comments_mentionedUserHiglight__AMXFd" data-mentioned-user="17" contenteditable="false">@Денис Новосельцев, </span><span></span><span style="color: rgba(0, 0, 0, 0.87); font-size: 14px;">редуктор приедет 14 марта</span>
518	224	16	2022-01-27 12:03:58.713087+00	Отлично
491	214	15	2021-12-16 07:19:03.421508+00	<span style="font-size: 8pt; color: rgba(0, 0, 0, 0.87); font-family: &quot;Times New Roman&quot;, serif;">Комплектация от </span><span style="font-size: 14px; color: rgba(0, 0, 0, 0.87); font-family: &quot;Times New Roman&quot;, serif;">ООО </span>"КОМПАНИЯ АБРАДОКС"<div style="font-size: 14px; color: rgba(0, 0, 0, 0.87);"><span style="color: rgba(0, 0, 0, 0.6); font-size: 14.4px; white-space: normal;">- 30ч939р Ду150 Ру16 ABRA A4016-BS-150 - 1шт.</span><br></div>
545	275	15	2022-03-21 07:15:00.051339+00	<span style="font-size: 14.4px;">Для входа в ЛК КИТ +79871228159; Loseev1016 - создание заказа по шаблону</span>
546	275	15	2022-03-21 07:15:10.02712+00	<div style="font-size: 14px; color: rgba(0, 0, 0, 0.87);"><span style="background: var(--L0)  !important; font-size: 14px !important;">Чебоксары - Минск</span><br></div><div style="font-size: 14px; color: rgba(0, 0, 0, 0.87);">ООО «АнканПро», УНП 193434875</div><div style="font-size: 14px; color: rgba(0, 0, 0, 0.87);">220053 Республика Беларусь, г.Минск, ул.Будславская, 2 пом.3 каб.28<div style="background: var(--L0)  !important; font-size: 14px !important;"><div style="background: var(--L0)  !important; font-size: 14px !important;"><span style="font-size: medium; background: var(--L0)  !important;">Борухова Юлия Ивановна + 375 (44) 701-20-19</span></div><div style="background: var(--L0)  !important; font-size: 14px !important;"><span style="background: var(--L0)  !important; font-size: 14px !important;">Нетто: кг, брутто: кг, ящик: </span><span style="background: var(--L0)  !important; font-size: 11pt; color: black; font-family: Calibri, sans-serif;">650х500х650 </span><span style="background: var(--L0)  !important; font-size: 14px !important;">-1 шт.</span></div><div style="background: var(--L0)  !important; font-size: 14px !important;"><span style="background-image:  !important; background-position-x:  !important; background-position-y:  !important; background-size:  !important; background-repeat-x:  !important; background-repeat-y:  !important; background-attachment:  !important; background-origin:  !important; background-clip:  !important; background-color: rgb(247, 247, 250); font-size: 14.4px; color: rgba(0, 0, 0, 0.87);">Отгрузить ТК КИТ</span><span style="background-image:  !important; background-position-x:  !important; background-position-y:  !important; background-size:  !important; background-repeat-x:  !important; background-repeat-y:  !important; background-attachment:  !important; background-origin:  !important; background-clip:  !important; background-color: rgb(247, 247, 250); font-size: 14.4px; color: rgba(0, 0, 0, 0.87);">, трек </span></div></div></div>
548	266	16	2022-03-21 08:01:55.226765+00	<div style="color: rgba(0, 0, 0, 0.87); background: var(--L0)  !important; font-size: 14px !important;"><span style="background: var(--L0)  !important; font-size: 14px !important;">Нетто: 71кг, брутто: 83кг, ящик: 60</span><span style="background: var(--L0)  !important; font-size: 11pt; color: black; font-family: Calibri, sans-serif;">0х520х520 </span><span style="background: var(--L0)  !important; font-size: 14px !important;">-1 шт.</span></div><div style="color: rgba(0, 0, 0, 0.87); background: var(--L0)  !important; font-size: 14px !important;"><span style="background-image:  !important; background-position-x:  !important; background-position-y:  !important; background-size:  !important; background-repeat-x:  !important; background-repeat-y:  !important; background-attachment:  !important; background-origin:  !important; background-clip:  !important; background-color: rgb(247, 247, 250); font-size: 14.4px; color: rgba(0, 0, 0, 0.87);">Отгрузить ТК КИТ до терминала города Минск</span></div><div style="color: rgba(0, 0, 0, 0.87); background: var(--L0)  !important; font-size: 14px !important;"><span style="background-image:  !important; background-position-x:  !important; background-position-y:  !important; background-size:  !important; background-repeat-x:  !important; background-repeat-y:  !important; background-attachment:  !important; background-origin:  !important; background-clip:  !important; background-color: rgb(247, 247, 250); font-size: 14.4px; color: rgba(0, 0, 0, 0.87);">Контактное лицо: </span></div><div style="background: var(--L0)  !important;"><span style="color: rgba(0, 0, 0, 0.87); font-size: 14.4px; background-color: rgb(247, 247, 250);">Валерий Иванович +375296537050 трек: </span></div><h3 class="subtitle gotovo text-center" style="box-sizing: border-box; margin: 8.5px 0px 20px; font-family: Golos; font-weight: 500; line-height: 22px; color: rgb(19, 85, 160); font-size: 18px; text-align: center; letter-spacing: 0.16px; white-space: normal; background-color: rgb(255, 255, 255);">ЧЕБМИН0106979003</h3>
519	248	16	2022-01-28 05:37:39.18503+00	<span style="font-size: 8pt; color: rgba(0, 0, 0, 0.87); font-family: &quot;Times New Roman&quot;, serif;">Комплектация от </span><span style="font-size: 14px; color: rgba(0, 0, 0, 0.87); font-family: &quot;Times New Roman&quot;, serif;">ООО </span><span style="color: rgba(0, 0, 0, 0.87); font-size: 14px;">"КОМПАНИЯ АБРАДОКС"</span><div style="font-size: 14px; color: rgba(0, 0, 0, 0.87);"><span style="background: var(--L0) !important; font-size: 14.4px; color: rgba(0, 0, 0, 0.6); white-space: normal;">- 30ч939р Ду150 Ру16 ABRA A4016-BS-150 - 1шт.</span></div>
492	190	15	2021-12-16 07:37:40.009284+00	<div class="Comments_checklistUnit__2rS_e Comments_checklistUnit_complited__1J6jW">Оплатить редуктор</div><div class="Comments_checklistUnit__2rS_e Comments_checklistUnit_complited__1J6jW">Согласовать присоед. чертежи</div>
451	188	15	2021-11-30 07:55:05.157861+00	<span class="Comments_mentionedUserHiglight__MWwVB" data-mentioned-user="16" contenteditable="false">@Павел  Злобин</span><span> пришли фото шильдиков в телеграмм пожалуйста</span>
482	206	17	2021-12-14 09:34:21.656011+00	@        БСПМ-10  ДАТЧИК должен быть, согласно новой схеме   
474	174	15	2021-12-13 06:36:24.40204+00	610 платили в СДЭК
549	285	16	2022-03-21 10:58:15.652448+00	Требуемая высота переходника не менее 80 мм
452	107	19	2021-11-30 08:02:19.197609+00	БРУТ:135,нет:175 ЯЩ.730*600*350=2шт.,ящ.500*410*35=1шт.
531	263	15	2022-02-23 11:43:40.246254+00	<span style="font-size: 14px; color: black;">На МЭОФ-100/25-0,25Р-IICT4 УХЛ1, </span><span style="font-size: 14px; color: black;">380В, IP65, F07 оболочка датчика под </span><span style="background-color: rgb(248, 248, 248); color: rgba(0, 0, 0, 0.87);">кабельный ввод </span><span style="background: yellow; color: rgba(0, 0, 0, 0.87);">М25 </span>
475	66	15	2021-12-13 08:39:01.261178+00	БК-Арматура согласна произвести замену дефектных фланцев. Отправить ТК Деловые-Линии до терминала г. Балашиха
483	209	15	2021-12-14 09:45:19.039175+00	Отправили привод к нам на диагностику
453	66	19	2021-11-30 13:33:59.46251+00	Нетто:900кг:Брутто:1050;яш.850*650*35=2шт.,ящ.1200*650*350=4ящ. ящ.730*600*250=2ящ.
547	275	16	2022-03-21 07:22:56.388769+00	<div style="font-size: 14px; color: rgba(0, 0, 0, 0.87);"><span style="background: var(--L0)  !important; font-size: 14px !important;"><br></span></div><div style="font-size: 14px; color: rgba(0, 0, 0, 0.87);"><span style="background: var(--L0)  !important; font-size: 14px !important;">Чебоксары - Минск</span><br></div><div style="font-size: 14px; color: rgba(0, 0, 0, 0.87);">ООО «АнканПро», УНП 193434875</div><div style="font-size: 14px; color: rgba(0, 0, 0, 0.87);">220053 Республика Беларусь, г.Минск, ул.Будславская, 2 пом.3 каб.28<div style="background: var(--L0)  !important; font-size: 14px !important;"><div style="background: var(--L0)  !important; font-size: 14px !important;"><span style="font-size: medium; background: var(--L0)  !important;">Борухова Юлия Ивановна + 375 (44) 701-20-19</span></div><div style="background: var(--L0)  !important; font-size: 14px !important;"><span style="background: var(--L0)  !important; font-size: 14px !important;">Нетто: 65кг, брутто: 82кг, ящик: 7</span><span style="background: var(--L0)  !important; font-size: 11pt; color: black; font-family: Calibri, sans-serif;">50х600х750 </span><span style="background: var(--L0)  !important; font-size: 14px !important;">-1 шт.</span></div><div style="background: var(--L0)  !important; font-size: 14px !important;"><span style="background-image:  !important; background-position-x:  !important; background-position-y:  !important; background-size:  !important; background-repeat-x:  !important; background-repeat-y:  !important; background-attachment:  !important; background-origin:  !important; background-clip:  !important; background-color: rgb(247, 247, 250); font-size: 14.4px; color: rgba(0, 0, 0, 0.87);">Отгрузить ТК КИТ трек: </span></div><h3 class="subtitle gotovo text-center" style="box-sizing: border-box; margin: 8.5px 0px 20px; font-family: Golos; font-weight: 500; line-height: 22px; color: rgb(19, 85, 160); font-size: 18px; text-align: center; letter-spacing: 0.16px; white-space: normal; background-color: rgb(255, 255, 255);">ЧЕБМИН0106978420</h3></div></div>
521	190	15	2022-02-03 05:55:56.107196+00	<span class="Comments_mentionedUserHiglight__MWwVB" data-mentioned-user="17" contenteditable="false">@Денис Новосельцев, </span><span style="color: rgba(0, 0, 0, 0.87); font-size: 14.4px;">редуктор приедет 22-23 февраля</span>
532	244	19	2022-02-26 06:51:58.38489+00	<span class="Comments_mentionedUserHiglight__AMXFd" data-mentioned-user="15" contenteditable="false">@Михаил Лосеев, </span>направление стрелы?
530	263	15	2022-02-22 10:54:35.317832+00	<p class="MsoNormal"><span style="color:black">1. МЭОФ-250/25-0,25М-IICT4 УХЛ1, 380В, IP65, F10 - <span style="background:lime;mso-highlight:lime">согласовано</span><o:p></o:p></span></p><p class="MsoNormal"><span style="color: black;">2. МЭОФ-100/25-0,25Р-IICT4 УХЛ1, </span><span style="color: black;">380В, IP65, F07 </span><span style="color: black; background: yellow;">– не </span><span style="background-color: yellow;">согласовано</span></p><p class="MsoNormal"><span style="color: black;">Требуется </span></p><p class="MsoNormal"><span style="color:black">кабельный ввод М20 под кабель ВВГнг(А)-ХЛ 5х1,5 в металлорукаве 16мм 1шт.,&nbsp; <o:p></o:p></span></p><p class="MsoNormal"><span style="color:black">кабельный ввод <span style="background:yellow;mso-highlight:yellow">М25 под кабель КВВГЭнг(А)-ХЛ10х1,0</span> в металлорукаве 20мм 1шт.</span></p>\n
523	206	15	2022-02-03 05:57:30.052292+00	<span class="Comments_mentionedUserHiglight__MWwVB" data-mentioned-user="17" contenteditable="false">@Денис Новосельцев, </span><span style="color: rgba(0, 0, 0, 0.87); font-size: 14px;">редуктор приедет 28 февраля</span>
493	66	15	2021-12-20 09:31:36.528994+00	<span class="Comments_mentionedUserHiglight__MWwVB" data-mentioned-user="18" contenteditable="false">@Ирина Энгельс, </span>КПСР просит доплату
540	255	15	2022-03-10 11:15:28.391776+00	<div style="font-size: 14px; color: rgba(0, 0, 0, 0.87);"><span style="background: var(--L0)  !important; font-size: 14px !important;">Чебоксары - Минск</span><br></div><div style="font-size: 14px; color: rgba(0, 0, 0, 0.87);">ООО «АнканПро», УНП 193434875</div><div style="font-size: 14px; color: rgba(0, 0, 0, 0.87);">220053 Республика Беларусь, г.Минск, ул.Будславская, 2 пом.3 каб.28<div style="background: var(--L0)  !important; font-size: 14px !important;"><div style="background: var(--L0)  !important; font-size: 14px !important;"><span style="font-size: medium; background: var(--L0)  !important;">Борухова Юлия Ивановна + 375 (44) 701-20-19</span></div><div style="background: var(--L0)  !important; font-size: 14px !important;"><span style="background: var(--L0)  !important; font-size: 14px !important;">Нетто: 88кг, брутто: 98кг, ящик: </span><span style="background: var(--L0) !important; font-size: 11pt; color: black; font-family: Calibri, sans-serif;">650х500х650 </span><span style="background: var(--L0)  !important; font-size: 14px !important;">-1 шт.</span></div><div style="background: var(--L0)  !important; font-size: 14px !important;"><span style="background-image:  !important; background-position-x:  !important; background-position-y:  !important; background-size:  !important; background-repeat-x:  !important; background-repeat-y:  !important; background-attachment:  !important; background-origin:  !important; background-clip:  !important; background-color: rgb(247, 247, 250); font-size: 14.4px; color: rgba(0, 0, 0, 0.87);">Отгрузить ТК КИТ</span><span style="background-color: rgb(247, 247, 250); color: rgba(0, 0, 0, 0.87); font-size: 14.4px;">, трек </span></div><h3 class="subtitle gotovo text-center" style="box-sizing: border-box; margin: 8.5px 0px 20px; font-family: Golos; font-weight: 500; line-height: 22px; color: rgb(19, 85, 160); font-size: 18px; text-align: center; letter-spacing: 0.16px; white-space: normal; background-color: rgb(255, 255, 255);">ЧЕБМИН0106870101</h3></div></div>
412	174	15	2021-11-16 08:02:15.179194+00	<p class="MsoNormal"> Прошу подготовить накладную – 2экз.</p><p class="MsoNormal">1 экз отправить почтой (188660, Ленинградская обл.,</p><p class="MsoNormal">Всеволожский р-н, пос. Бугры, Гаражный проезд, 5) или с отгрузкой на Флейм</p><p class="MsoNormal">1 экз на производство для отправки платы</p><p class="MsoNormal">Покупатель: ЗАО «НПО Флейм»</p><p class="MsoNormal">Грузополучатель: Волжская ТЭЦ, г. Волжский, 7я Автодорога,\nКрестин Сергей&nbsp; тел.+7 922 140 27 56</p><p class="MsoNormal"><span style="color: var(--highContrast);">Плата блока сигнализации положения БСПТ-2 – 1шт. – цена 6</span><span style="color: var(--highContrast);">180 руб. без учета НДС</span></p>
494	164	15	2021-12-20 10:21:31.045532+00	<p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;\nmso-ascii-theme-font:minor-latin;mso-hansi-theme-font:minor-latin;mso-bidi-font-family:\n&quot;Times New Roman&quot;;mso-bidi-theme-font:minor-bidi;color:black;mso-themecolor:\ntext1;mso-fareast-language:EN-US">Стрела у шлагбаума должна быть слева.</span></p><p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;\nmso-ascii-theme-font:minor-latin;mso-hansi-theme-font:minor-latin;mso-bidi-font-family:\n&quot;Times New Roman&quot;;mso-bidi-theme-font:minor-bidi;color:black;mso-themecolor:\ntext1;mso-fareast-language:EN-US">-- </span></p><p class="MsoNormal"><span style="color: black; font-family: Calibri, sans-serif; font-size: 11pt;">С уважением,</span></p><p class="MsoNormal"><span style="color: black; font-family: Calibri, sans-serif; font-size: 11pt;">Дядюк Владислав Александрович</span></p><p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;\nmso-ascii-theme-font:minor-latin;mso-hansi-theme-font:minor-latin;mso-bidi-font-family:\n&quot;Times New Roman&quot;;mso-bidi-theme-font:minor-bidi;color:black;mso-themecolor:\ntext1;mso-fareast-language:EN-US">Начальник отдела материально-технического снабжения</span></p><p class="MsoNormal"><span style="color: black; font-family: Calibri, sans-serif; font-size: 11pt;">ООО «Камышинский опытный завод»</span></p><p class="MsoNormal"><span style="color: black; font-family: Calibri, sans-serif; font-size: 11pt;">E-mail: dyadyuk@koz.ru</span></p><p class="MsoNormal"><span style="color: black; font-family: Calibri, sans-serif; font-size: 11pt;">Тел.: +7 (8442) 96-86-93</span></p><p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;\nmso-ascii-theme-font:minor-latin;mso-hansi-theme-font:minor-latin;mso-bidi-font-family:\n&quot;Times New Roman&quot;;mso-bidi-theme-font:minor-bidi;color:black;mso-themecolor:\ntext1;mso-fareast-language:EN-US">Моб.: +7 982 593 08 42<o:p></o:p></span></p>\n\n
\.


--
-- Data for Name: Docs; Type: TABLE DATA; Schema: erp; Owner: postgres
--

COPY erp."Docs" ("OrderID", "Key", "FileName", "ID", "Mimetype", "Size") FROM stdin;
133	eba98603-4f5c-4164-8611-abe2bb9821c3	Доверенность.pdf	177	\N	\N
176	77b1039e-639e-4649-a524-c0c3dda12f52	Счет на оплату (Вес и Объем, с Факсимиле) (461).pdf	178	\N	\N
170	a85b4b28-258c-4062-9773-b5db056af900	Договор.tiff	179	\N	\N
66	03115276-039c-4d53-af61-e55c16b67d95	Чертежи клапанов.doc	86	\N	\N
66	70d7db61-1887-40c7-a5d0-b83dbadd32a4	Счет №ПА08611 от 05.08.2021.pdf	87	\N	\N
66	6b04270b-3340-4b9b-a65b-1e99d4ce2ec9	Счет на оплату  № НФ-680 от 01.09.2021 1.pdf	88	\N	\N
66	6746dc2b-21f5-4708-b19e-b0cd9258c4fb	Счет на оплату № 33861       от 30.08.2021 (2).pdf	89	\N	\N
66	0984b9c0-4162-4754-b5c2-312b7b497b54	Счет 497.pdf	37	\N	\N
76	f203dae9-31b2-4c4a-a306-b5abfb13a166	Счет 544 в срм.pdf	93	\N	\N
90	3d636359-f599-4ed8-8f67-728bcb98312c	469  10  2021 ..xls	95	\N	\N
95	2f554ea6-a1e5-4dbe-9af9-caea729cdfac	11420 запрос привод 2.docx	97	\N	\N
95	9db3f78d-53a6-4fb9-acc9-d5957800ab55	Чертеж AK BTV 02 DN250 300 400.pdf	100	\N	\N
95	280b30df-9fda-4959-b0b5-b4f589edcacd	Чертеж AK BTV 02 DN600.pdf	101	\N	\N
95	8f4189ac-353f-4459-9bb5-b30e54c386f8	Чертеж задвижка шиберная AK KGV 01  DN250 300 500.pdf	102	\N	\N
95	e1c32332-78e4-4556-900d-82cb416a255c	KOMPAS - Схема управления со шкафа ШУМ-380-13.pdf	103	\N	\N
96	3533771c-bdc1-4ce3-a286-7dc1be8ec301	Реквизиты НоК Горохов.docx	104	\N	\N
76	fbdade18-edcf-41cb-98dd-8ed7d5ddd6b9	Опросный лист для поставки арматуры (1).xlsx	106	\N	\N
99	a91f597d-a535-4947-a9d7-3fc8c483b810	поз. 27 Опросный лист Кран с шаровым затвором Ду50 Ру16 в комплекте с электроприводом 4шт..pdf	107	\N	\N
102	6ef23f28-a7a5-4363-a7f4-b27c006f42ff	Чертеж затвора ЗД2.200.pdf	113	\N	\N
104	55ea7039-af23-4047-ba01-9f184a2ff9ea	Заполненный ОЛ ООО АМТ.jpeg	114	\N	\N
96	ac50e36e-a093-4381-96de-088d08997795	print-barcodes.pdf	115	\N	\N
96	e6fe6031-7bf6-4f27-8fd7-133ec3bf230c	print-order.pdf	116	\N	\N
106	22e57d54-94ff-4188-abac-ad43bbe894b3	Размеры верхнего присоединительного фланца.pdf	120	\N	\N
105	d3b40d5f-e61e-4310-85ad-70b096a80402	Чертеж затвора к сч. 577.pdf	122	\N	\N
107	d17ae3d3-2e4a-4a83-a379-5c42ae3b1aec	Чертеж.jpg	123	\N	\N
107	5f49c8b1-a749-478e-9ac0-2622ee30d8e1	доп_запрос_.doc	124	\N	\N
107	23850e02-87f6-4f2c-b575-3076ca66feda	Приложение №1-2.docx	125	\N	\N
108	6fc81d86-dfef-4cdc-822e-4505a93debdc	Схема подключений НМ с датчиком БСП-3 (220В).pdf	126	\N	\N
91	5de37477-13b0-4bca-830f-6fdd2b879ed5	Упаковочные листы сп. 26, 27.doc	128	\N	\N
119	12a63a30-4fbc-4b87-b1c2-68889a9aea23	SM.DN50.PN16.МFL.PPR.2-00.000ГЧ.jpg	129	\N	\N
109	84108fa4-3740-46a4-805a-fa1f87124942	Опросный лист Арматурз КП_П_1049.pdf	130	\N	\N
127	426cb0f7-4979-479d-9ef4-fb003e970f38	Размеры присоединительного фланца межфланцевых затворов Квант.PNG	132	\N	\N
126	9254bcda-7499-46c2-b7eb-586d3be09b0d	Спецификация №2.pdf	133	\N	\N
127	457ebdec-7a6a-4606-b8d1-75fd526c014f	Счет на оплату № УТ-2655 от 08.10.2021.xlsx	134	\N	\N
126	bfb82445-9ffa-4c01-8138-737ef9054b13	Заказ покупателя ТВ-00000978 от 07.10.2021 153540.pdf	135	\N	\N
137	b52f3968-0194-42a9-891b-a65875922659	Счет 459.pdf	138	\N	\N
141	ccb45283-c82c-45e9-9fe8-fbae80088786	Чертеж Ду150.pdf	139	\N	\N
91	e1504ef4-82fc-4d6c-a728-3862c4757124	Счет на оплату № 32685       от 16.07.2021 (3).pdf	146	\N	\N
91	e0d4e560-2bee-47de-b30e-330bc88af36c	Счет на оплату  № НФ-289 от 20.04.2021.pdf	147	\N	\N
91	0a79548c-390f-4170-a44e-46d7450a5c1a	Счет на оплату (Вес и Объем, с Факсимиле) (470).pdf	148	\N	\N
91	c78f505d-8ef6-4c43-a9c9-fe895d82e552	Счет №ПА07585 от 08.07.2021.pdf	149	\N	\N
142	9f976eb9-924e-4528-8de6-ef2d574c74ab	Спецификация №35 02.11.2021.pdf	152	\N	\N
136	5dbcc388-c1ea-4aa0-8a88-de498a45acdb	Спецификация №34 02.11.21.pdf	153	\N	\N
94	78bf878d-f220-4639-9439-a28f3cb1c474	Счет на оплату (Вес и Объем, с Факсимиле) (1 026).pdf	154	\N	\N
157	a3a612d8-58e1-4c5d-a568-4caef94b0e6c	Спецификация №37.pdf	155	\N	\N
165	2eab4c01-4cbd-44df-b62d-058cdb9d7323	Затвор Ду100.PDF	156	\N	\N
165	4ad341fd-c14b-4d4a-8ef9-193e1e17fc5b	Затвор Ду500.PDF	157	\N	\N
108	739b232d-f9cf-4932-b2c1-a7e8dbc4ae57	Паспорта НМ.pdf	164	\N	\N
161	67a72f6c-d0c0-4b18-b8de-213ee12ad749	IMG-20211008-WA0003.jpg	166	\N	\N
161	b5c982db-7fff-4a71-8f0b-c54f20a49e91	IMG-20211022-WA0007.jpg	167	\N	\N
161	f44cf5f7-10d5-45f2-98fd-f62d418d0134	IMG-20211022-WA0012.jpg	168	\N	\N
161	4c871495-33ea-4616-9572-d611bd2cd8c5	IMG-20211022-WA0014.jpg	169	\N	\N
174	96c492d6-7ffe-4ca1-93be-606e96539ebf	Р-1825 от 12.11.2021г. О гарантийной замене оборудования. ПНО Флейм.PDF	171	\N	\N
174	c724178c-201e-46b5-b2a3-16f248fc74f1	№0801 Повожская электротехническая компания.pdf	172	\N	\N
174	afdb6d38-56b1-4909-b252-104ca38f0f18	П_11_15_Флейм.pdf	174	\N	\N
174	2ec9cb51-b538-42b7-9150-a2e5c30b3f74	П_11_15_Флейм.doc	176	\N	\N
176	0f601da2-d09b-4bfd-a856-fb46ec5d8b51	Спец 2.pdf	181	\N	\N
170	7b106cb1-2fe5-4cfd-913d-0d3c8f49de73	Счет №КС02763 от 22.11.2021.pdf	182	\N	\N
143	97293370-65df-4f39-9c95-ae66d415a443	Счет №КС02044 от 09.09.2021.pdf	183	\N	\N
143	99bea5a0-31b9-4cd0-a3c5-80a8377bce1c	Счет на оплату (Вес и Объем, с Факсимиле) (504).pdf	184	\N	\N
143	ce23f15c-7399-4ab9-9282-3c229e7e548a	Чертежи клапанов.doc	185	\N	\N
143	2512a4b5-d73f-4399-802e-778ebea65d26	Счет на оплату  № НФ-910 от 25.11.2021.pdf	186	\N	\N
186	58f2dae7-880b-49bd-acd6-b28fe2a04934	Рекламация.pdf	187	\N	\N
186	32a794dd-2f89-4cc3-8b85-d1936e70cba7	волгоснабресурс.PDF	188	\N	\N
187	c240dfe3-9c8a-431a-960c-4a67d579c9ea	Акт рекламации по МЭОФ в ПЭК.pdf	189	\N	\N
170	2ab29f3d-f31f-45f8-b536-9cbde3966768	Присоединительный фланец Ду500 Квант.jpg	190	\N	\N
170	254216fd-4251-47ed-aec3-e1d82964bde5	Счет на оплату № УТ-3309 от 26.11.2021.pdf	191	\N	\N
183	34640648-253e-421d-b4ba-f4ff5b633e95	Сломан тормоз.jpg	193	\N	\N
170	c8877bd5-6396-42ac-bd49-362c3fce8e47	ПА332.400.16-01.pdf	195	\N	\N
170	27cb0793-7b79-41e3-83ee-712d48ccd74b	ПА332.500.10-01.pdf.pdf	198	\N	\N
95	a13977d1-876a-4973-8beb-5b53a645078c	ПЭК дов 523.pdf	201	\N	\N
66	9691e582-1bf9-434f-9932-5424dda83d37	Упаковочные листы по сч. 497.doc	204	\N	\N
170	db1830af-2327-4714-8f55-28dce7c4c0f7	_РЗА-С-1000.1-39.21.46L.pdf	206	\N	\N
170	84f62d7f-f15a-4250-81b4-8be56932d335	РЗА-С-2000.1-56.21.(203, 207L, 208).pdf	207	\N	\N
170	b3720c6e-669b-42f8-b8cc-1d07325e3c76	Счет 616 спец. 15 от 12112021 ООО ПЭК.pdf	208	\N	\N
194	7ed5240f-2619-4a41-8a69-c047c6089d0f	Спецификации №38, 39.pdf	210	\N	\N
190	0ecde5c3-acd8-4270-837a-708e4f38b388	Чертеж ЗД2.600.16.38.1111 F25, 7 800Нм.pdf	211	\N	\N
170	dba9b39f-454d-4c8d-9046-9cb44d94a6d4	РЗА.JPG	212	\N	\N
170	749b8032-df56-485c-9b7a-274152fc15f3	РЗА1.jpg	213	\N	\N
206	a809604c-5aa9-4d68-b776-8cb7e9033e7c	Схема ПЭМ- А ( датчик БСПТ-10АМ разъем РП10-30).pdf	214	\N	\N
206	b453e98c-e5f4-4767-bdc3-35844d2cf388	ZD.3EX.DN400.PN25.PR.PPR.2-00.000ГЧ.jpg	215	\N	\N
206	948b14bf-2ac9-4447-89bf-b74624ccff0f	3EX.DN700.PN10.PR.PPR.2-00.000ГЧ.jpg	216	\N	\N
197	25eefb3c-6bef-43ba-b68b-12a81d120554	2.jpg	219	\N	\N
208	df9f4e30-9231-4407-84d0-69439ae5f79e	4.pdf	221	\N	\N
209	c896edf4-749b-48e4-ac27-1cdd115fedd1	3.pdf	222	\N	\N
143	f2207c92-fe90-47e9-8c76-26e16e42d1a7	Счет №КС02817 от 10.12.2021.pdf	223	\N	\N
189	ab4f3cf6-9f12-4431-b691-b325d0b64653	Счёт от 15.12.2021.pdf	224	\N	\N
213	bb8846d0-82f9-4dcc-ac6e-41f69259abda	Документ (1).jpg	225	\N	\N
214	e50cd555-4894-4e70-b69d-8139a9f834b7	Счет на задвижку 30ч939р.pdf	226	\N	\N
214	9920dfb5-2e48-4346-b94b-96638495b7da	Чертеж фланца задвижки.PNG	227	\N	\N
189	35a114a4-ee2f-44e0-80e8-79e1f7c33a40	Счет № 608 от 16 декабря 2021 г..xls	228	\N	\N
178	b9787ca3-7948-432f-b0ec-e07cba059b22	паспорт_ПЭМ-Б250_421В0333.pdf	229	\N	\N
205	4ab2eac5-455b-42fa-bb21-962275c76ebf	спец 52 к дог ПА-12_5 (2).pdf	230	\N	\N
170	a939f222-da5c-409e-8ac6-c005de789452	Спецификация 15.pdf	232	\N	\N
170	99c60cc1-c11b-42a5-9963-d53186a7d45b	Счет на оплату №ЧБС00060225.pdf	233	\N	\N
143	10ee6110-099e-4179-a52c-7dde164c48da	Спецификация 36.pdf	234	\N	\N
191	f60c16d8-a7db-4d9a-877e-c70a0527004d	Доверительное 551 ПЭК.pdf	235	\N	\N
191	f2a6b8e3-cbd2-44ce-a9df-722df53c2681	IMG-7fab721ed56f5ef1d4b69e7a30efca28-V.jpg	236	\N	\N
188	55786e67-4973-4900-aef1-ee7a795976ea	Акт дефектации №6 Газпромнефть.pdf	237	\N	\N
188	6b3ff547-3448-4be7-9ee7-8ff7ef1be301	Акт дефектации №6 Газпромнефть.docx	238	\N	\N
188	84b2fbc2-6d68-48e5-99a3-01cfc8fe7809	0-2 Приложение2 Заявка_5.doc	239	\N	\N
188	1bd3afcd-2ee1-48d1-b7d5-3ef694090155	0-2 Приложение2 Заявка_4.doc	240	\N	\N
188	61bc89e3-db7a-465e-9c0f-c2efb2fefa0f	778.pdf	241	\N	\N
188	cd10c05a-6ab2-4257-a752-7550288efbae	777.pdf	242	\N	\N
188	e504186a-a014-487e-8642-949f07049658	776.pdf	243	\N	\N
190	5be5aaf2-2b78-4b09-9199-09a2d3e6003e	Счет 732 спец. 16 от 22122021 ООО ПЭК.pdf	245	\N	\N
178	a2b3a40e-2edc-4301-a827-bdf9e94685ef	Листы из паспортов АУМА.pdf	246	\N	\N
178	8085f840-9f2f-469f-865a-9c4fb033c63a	Паспорт на ENERAL.doc	248	\N	\N
194	de256d66-28c9-4550-9de6-9b82328a8d40	Паспорт на ENERAL.doc	249	\N	\N
194	afdae419-9808-47a6-b1ea-797286ea1d9c	Новый паспорт на МЭО-1600 (Пауэрз).doc	250	\N	\N
194	02129d1f-ddc8-4fe4-896b-e8e8ff755864	Виски для Дениса.pdf	251	\N	\N
209	6d4fcad2-dd72-4388-a3c7-c1b3992fcdb0	A5.3.pdf	254	\N	\N
206	839cfc4b-dead-431f-8c8b-0606a2439d06	РЗА-С2-4000.1-120.21.192.pdf	255	\N	\N
206	3801779d-f2b9-4469-a346-9218f8420fb0	РЗА-С2-8000.1-241.21.64.pdf	256	\N	\N
206	3b23a858-222c-4c16-8917-5d1f0bab5d4d	Спецификация_17_2021.pdf	257	\N	\N
206	f27bc609-0173-40ce-90f3-57ecd8b4ff2c	Счет 751 сп17 ООО ПЭК.pdf	258	\N	\N
190	51013059-c10a-43fb-b4a2-c783c2731abe	РЗА-С2-8000.1-241.21.244V2.pdf	259	\N	\N
225	11cba9d3-e8dd-4ee0-a1de-aaf7bb257e2c	Заказ покупателя ТВ-00000004 от 10.01.2022 151044.pdf	260	\N	\N
66	dc2af16f-32c6-4e5a-88d2-24fb11789884	ПЭК.PDF	261	\N	\N
217	5e7ecab4-698c-49de-a6fd-8f2300cebec2	Упаковочные листы по сч. 795.doc	267	\N	\N
208	e52eb6fc-311b-4684-bca5-cc70ef2d6cd7	Схема подключений Северной компании.jpeg	268	\N	\N
206	cdf6aba7-ee65-4900-be87-b6b79de4568b	Согласованные чертежи к спец. 17.pdf	269	\N	\N
233	5631b2ab-4146-4922-95d8-2935b11f3b66	Спецификация №43.pdf	270	\N	\N
187	29c6ea88-88af-440b-a5ac-f7d186598510	Акмай 4.jpeg	271	\N	\N
187	08eb3e0c-2a62-4457-8cdd-680ab74fb74a	Акмай 3.jpeg	272	\N	\N
187	3dfedad1-69ec-4887-bfa9-f1168bf73c0d	Акмай 2.jpeg	273	\N	\N
187	2383632e-3322-4c0b-9189-7a30ae942457	Акмай 1.jpeg	274	\N	\N
187	7e25d6aa-9921-4d40-9516-ef2a18977497	Акт дефектации №7 Акмай.pdf	275	\N	\N
176	20121307-ec7e-4f35-9216-f82b7c62c228	ИП Пикуза 4 спецификация 2.doc	276	\N	\N
176	6a658ec6-a4b5-467d-a897-078d15f5de73	cmr Волгоснабресурс - Пикуза.xls	277	\N	\N
240	9c57fd8f-f9b4-4e27-a279-6977d7b32cf0	44 подписанная Пауэрз.pdf	278	\N	\N
241	b44314d5-f429-4538-83a1-e7f842882790	45 подписанная Пауэрз.pdf	279	\N	\N
238	eddbd929-0dd5-4333-a6d7-de055d055ca1	Чертеж МЭОФ АО АМК.pdf	281	\N	\N
238	c73621e2-6df8-43fd-8889-2963951ecc4b	Письмо пдтверждения размеров.pdf	282	\N	\N
243	49e3db96-8ecb-4aab-9f60-28f9f268cd04	Акт Рекламации №19 Промтехнологии.pdf	283	\N	\N
243	9caec285-381f-45cd-9a5b-e3918c2dedd1	Счет 59 Промтехнологии исправленный.pdf	284	\N	\N
208	538ae489-e56e-490d-97e5-baf3c35f4051	Шильдик МЭОФ-1000-92СК.jpeg	285	\N	\N
248	8e925ddd-4508-4443-bf24-60a30c35d896	Счет на задвижку АБРАДОКС.pdf	286	\N	\N
248	9121ad7c-2c7b-49e1-93a5-72417e27cc6e	Чертеж фланца задвижки.PNG	287	\N	\N
247	9ef2e2e8-5740-4a33-ad93-50c6f63921ab	192 ПЭК - просьба о запуске в производство.pdf	288	\N	\N
244	554edf98-0165-44c3-a864-5eb79557a7ef	СпецификацияТКП ТВ-00000148 от 01.02.2022 113300.pdf	290	\N	\N
192	65adff09-0b8f-4027-8b9c-8237cc82a5a0	Доверенность 54 ПЭК.pdf	291	\N	\N
192	b1f58ddd-60fc-42e4-b667-383a01c04445	Спец 11 подп.pdf	292	\N	\N
192	ca78fc4c-04a1-4c15-be59-c59a7704f3b6	Компенсатор Групп (в редакции Компенсатор групп).doc	293	\N	\N
192	38c0857c-92cc-4565-9255-f71d5ff8a4e2	cmr Волгоснабресурс - Компенсатор Групп.xls	294	\N	\N
252	4166bb7e-6261-4142-a43c-8caab5cd6524	Спецификация №2 к дог. 01_19.pdf	295	\N	\N
244	754b6766-00c5-416b-a912-3b8d91ab4e4a	Договор 01-11 Ялыкское.pdf	296	\N	\N
254	713c9812-9c14-4b40-971d-ddd6abc87a3b	Спецификация №46.pdf	297	\N	\N
255	ac063b05-ee14-4fa3-b86c-ef97c73431f2	Спецификация №2.pdf	299	\N	\N
208	9c1d27e1-199a-45ff-87a2-aba8cb30998d	Схема подключений МЭОФ-250.pdf	300	\N	\N
256	d09f7b8f-eae0-4f1f-beaa-eadfa66e8a06	Схема подключений МЭОФ-250.pdf	301	\N	\N
242	1560dc95-4dce-481c-ab72-d3e330155040	Компенсатор Групп дог. 01-19 спец. 1.pdf	302	\N	\N
242	ca4afc9a-7ece-450d-88d5-cbf080b12599	Доверенность 66 ПЭК.pdf	303	\N	\N
242	62e32438-fe4e-49ac-aa48-e85316b69f3a	cmr Волгоснабресурс - Компенсатор Групп.xls	304	\N	\N
250	efe66d4c-eeba-4d46-8406-de0017c0fc45	Счет № 75 от 17 февраля 2022 г..xls	305	\N	\N
256	0497da97-c0b9-4015-bd56-1a77d7816064	Фото шкафа и замеры напряжения.pdf	306	\N	\N
261	28998b1f-06ac-4d69-9255-4b0fb27f4a09	Спецификация 47.pdf	312	\N	\N
263	f1c875f7-4600-4bde-89b4-1da787ff7f4e	Кран ЯГТ 80ФТ.016.F.00.ХЛ.Э01.pdf	314	\N	\N
263	c45ecd68-db76-49bc-96e8-3a2be3c93d7f	Затвор Ду80 Палюр.pdf	315	\N	\N
143	bccab522-99de-4190-ad70-ba3a537e00cb	Счет №КС00364 от 22.02.2022.pdf	318	\N	\N
252	93784636-7f85-42bc-8151-d937cc41010c	Компенсатор Групп дог. 01-19 спец. 2 на подпись.pdf	337	\N	\N
252	a80e3efb-409e-4370-bb8c-2adc617fe1b0	cmr Волгоснабресурс - Компенсатор Групп.xls	339	\N	\N
266	4fe9b330-4c7a-49c8-beda-5b90e7679120	Белгидрохимресурс.doc	341	\N	\N
252	6f9b9419-d651-4160-8d45-16ecc26bebf5	Доверенность ‎2‎.‎24‎.‎2022-‎13‎.‎23‎.‎07.pdf	342	\N	\N
268	dfa94009-4357-4ccd-8fef-126800436627	Договор ЕХРО-ТЕХ.doc	343	\N	\N
241	03a580e6-8c73-4d48-ad38-70a334dbcb8b	ФормаОтгрузки.docx	351	\N	32848
241	3f684a80-db5e-46f9-8c8a-07438ad70006	Доверенность.pdf	352	\N	265661
241	86ecde06-0ea5-415a-8484-8b494ec8ff74	транспортная накладная.pdf	354	\N	1182276
241	74fdf729-f03c-421b-9421-2cb04e5a6c77	УЛ.pdf	355	\N	3623592
241	339c1284-2528-46b9-a297-0f7373031d22	Новые маркировочные.pdf	356	\N	120404
271	5cc84e7e-c676-4b58-bfb1-57c0cb0c629a	Спецификация 3 договор 1-19 компенсатор.jpg	357	\N	691867
208	518cb2c6-001b-484c-9c7c-659bfe281507	Акт Рекламации №20 Северная компания.pdf	358	\N	245648
208	757dd516-e7bb-414a-b922-16fb6d61d830	Счет 143 Северная компания.pdf	359	\N	180722
255	1836bd24-22bd-4add-900c-6936827a022f	cmr Волгоснабресурс - Анкан Про.xls	361	\N	78336
255	64a59397-cf80-4788-983e-941b8d988c4c	Анкан Про спец.11 для печати.doc	362	\N	40960
277	6ebcfce3-e75e-4251-a3aa-d16c40cc8c99	Спецификация БЭЗ-3П-1-С  IP54 (с 3мя кнопками, 3 каб. ввода РКн - без ШРов).pdf	363	\N	79174
277	2fe5f50c-fb18-4a87-a615-759c480a21e0	Белтехвес.doc	364	\N	77312
279	7900cce4-b962-4af3-b772-b557aa4e5bc5	Спец 4 подп компенсатор.pdf	365	\N	303613
268	5fea9058-7b5d-429d-9ae7-f0ad5b7a1536	cmr Волгоснабресурс - ЕХРО-ТЕХ.xls	366	\N	78336
275	6b90bb2b-2631-4d87-8597-604efcf0e2d9	Анкан Про спец 12 для печати.pdf	367	\N	119835
275	e2819114-26f0-4a0f-ba45-06353ff276c7	Спецификация 12 Анкан Про.pdf	368	\N	153681
275	a283ad3c-50e2-46ec-9eac-b77b3f7254b4	cmr Волгоснабресурс - Анкан Про.xls	369	\N	77312
266	8583f589-71d8-4552-bd29-1e44e3f3c703	Договор 02-21 (1)-ДвеПодписи.pdf	370	\N	2648543
266	3185918f-6aaf-4dd2-878d-820606ee1d9f	cmr Волгоснабресурс - Белгидрохимресурс.xls	371	\N	77312
283	7c00e6d9-64a9-40c8-9b87-04d4d6d7ff2a	3EX.DN80-150.PN16.FL.PPR.1-00.000ГЧ.jpg	372	\N	504295
285	04e51bbd-d0cb-46e5-bb35-e9352457f457	изображение_viber_2022-02-17_14-01-53-856.jpg	374	\N	214777
285	0eeb0059-83ed-409c-8ec8-8ada31f2d2ae	изображение_viber_2022-02-17_14-01-53-992.jpg	375	\N	200415
285	779487e5-cb2f-46fd-bcdd-e84383b6e6bc	изображение_viber_2021-07-26_10-11-38-366.jpg	376	\N	226638
285	31ac64d2-5b05-4db4-8225-b668fe045273	pasport_kran_sharovyj_316_200_ c чертежами.pdf	377	\N	787318
\.


--
-- Data for Name: Notifications; Type: TABLE DATA; Schema: erp; Owner: postgres
--

COPY erp."Notifications" ("ID", "OrderID", "CommentID", "MentionedUser", "Viewed") FROM stdin;
51	188	451	16	t
44	174	411	17	t
69	213	500	15	t
72	176	505	15	t
76	240	517	16	t
63	194	472	18	t
66	213	490	18	f
74	233	515	16	t
75	224	516	16	t
77	190	521	17	t
67	66	493	18	f
71	206	502	17	t
47	183	436	18	t
61	170	467	17	t
46	177	424	16	t
16	109	378	16	t
73	119	509	15	t
79	206	523	17	t
68	186	496	17	t
62	170	469	15	t
70	213	501	15	t
80	244	532	15	t
83	206	538	17	t
81	225	535	17	t
86	278	544	15	f
85	278	543	15	t
\.


--
-- Data for Name: OrderItems; Type: TABLE DATA; Schema: erp; Owner: postgres
--

COPY erp."OrderItems" ("OrderItemID", "OrderID", "Name", "Quantity", "Fitter", "FullName", "SerialStarts", "SerialEnds") FROM stdin;
252	91	МЭП-2500/30-30У-13К У2, 380В (с БСПТ-10АК) 	4	\N	Клапан регулирующий DN80 КПСР-2.42-80-25-0-СТ-1,6-1-42-У1 с комплектом ответных фланцев и крепежом с МЭП-2500/30-30У-13К У2, 380В (с БСПТ-10АК)\nНастройка: 2,7Кн, ход штока 32мм\nПлощадка: Ø65, h 100мм, М10, толщина плиты 21-22	\N	\N
321	109	МЭОФ-1600/63-0,25М-97СК У2, 380В, IP65, F14	1	\N		\N	\N
256	91	МЭОФ-12,5/25-0,25М-98К У2, 380В, IP65, F05 кв.11П	1	\N	Кран запорный 11с67п ЦФ DN25 PN16, фланцевый, сталь 20, полнопроходной, \nс комплектом ответных фланцев и крепежом с МЭОФ-12,5/25-0,25М-98К У2, 380В, IP65, F05 кв.11П\n	\N	\N
258	91	МЭП-12000/160-80У-14К У2, 380В	2	\N	Клапан регулирующий DN150 КПСР-1-150-160-0-СТ-4,0-1-260-У \nс комплектом ответных фланцев и крепежом с электроприводом \nс МЭП-12000/160-80У-14К У2, 380В\nНастройка: 9Кн, ход штока 75мм\nПлощадка: Ø65, h 80мм, М10, толщина плиты 21-22\n	\N	\N
259	91	МЭП-2500/30-30У-13К У2, 380В	2	\N	Клапан регулирующий DN65 КПСР-1-65-25-0-СТ-4,0-1-260-У \nс комплектом ответных фланцев и крепежом \nс МЭП-2500/30-30У-13К У2, 380В\nНастройка: 1,5Кн, ход штока 32мм\nПлощадка: Ø40, h 66мм, М10, \n	\N	\N
262	92	250/25-0,25У-99К У2 (без БП)	7	\N		\N	\N
265	92	630/25-0,25У-92К У2 (без БП)	1	Евсеев		\N	\N
248	89	АШК-2,5-380-БУШ-СВ-ПВК35-ПВТ4 УХЛ1	4	\N	2 правых, 2 левых	\N	\N
264	92	100/25-0,25У-99К У2 (без БП)	4	\N		\N	\N
266	93	МЭПК-6300/50-40У-IICТ4-05 У2, 380В, IP65	1	\N		\N	\N
267	94	МЭОФ-40/25-0,25М-96 У2, 220В, IP65, F07 кв.14П	2	\N	Кран шаровой цельносварной фланцевый 11с67п ЦФ.00.0 DN50 PN40 (L-230мм) с МЭОФ-40/25-0,25М-96 У2, 220В, IP65	\N	\N
244	66	МЭП-12000/100-50У-14К У2, 380В (с БСПТ-10АК)	2	\N	Клапан регулирующий DN150 КПСР-2.42-150-25-0-СТ-1,6-2-42-У1 с комплектом ответных фланцев и крепежом с МЭП-12000/100-50У-14К У2, 380В  3,5Кн, ход 25мм, площадка: Ø65, h 103 (138-35)мм, М14х1,5, толщина плиты 21-22 	\N	\N
255	91	МЭОФ-40/25-0,25У-96К У2, 380В, F05 кв.11П (с БСПТ-10АК)	1	\N	Кран регулирующий 11с67п DN25 PN16 равнопроцентный, сталь 20, фланцевый, полнопроходной, \nс комплектом ответных фланцев и крепежом с МЭОФ-40/25-0,25У-96К У2, 380В (с БСПТ-10АК)\n	\N	\N
257	91	МЭОФ-12,5/25-0,25М-98К У2, 380В, IP65, F05 кв.11П	1	\N	Кран запорный 11с67п ЦФ DN20 PN16, фланцевый, сталь 20, полнопроходной, \nс комплектом ответных фланцев и крепежом с МЭОФ-12,5/25-0,25М-98К У2, 380В, IP65, F05 кв.11П\n	\N	\N
207	66	МЭОФ-40/10-0,25М-99К У2, 380В, F05 кв.11П	8	\N	Затвор ПА 342.50.16-02 с комплектом ответных фланцев и крепежом с МЭОФ-40/10-0,25М-99К У2, 380В, F05 кв.11П\n	\N	\N
208	66	МЭОФ-100/25-0,25М-92CК У2, 380В, F07 кв.14П	1	\N	Затвор ПА 342.150.16-02 с комплектом ответных фланцев и крепежом с МЭОФ-100/25-0,25М-92CК У2, 380В, F07 кв.14П	\N	\N
243	80	Диагностика МЭОФ 1000/63-0,25-ЕД-20К зав. №061249	1	\N		\N	\N
212	67	МЭОФ-100/10-0,25М-99К У2, 380В, IP65, F07 кв.17П	1	\N	К крану КШХ80, Мкр 110Нм	\N	\N
213	67	МЭОФ-250/10-0,25М-99К У1, 380В, IP65, F10 кв. 22П	2	\N	К крану КШХ100, Мкр 250Нм	\N	\N
245	88	МЭОФ-100/25-0,25-ЕД-20К У1 F07 кв.17П	79	\N		\N	\N
246	88	МЭОФ-250/25-0,25-ЕД-20К У1 F07 кв.27П	6	\N		\N	\N
247	88	МЭОФ-650/63-0,25-ЕД-20К У1 F12 кв.27П	8	\N		\N	\N
249	90	МЭОФ-140/25-0,25М-IICT4 У2, 380В, IP65, F07 кв.14П	1	\N	Кран шаровой запорный КШТВГ 16-80 с комплектом ответных фланцев \n(80-16-01-1-В), прокладками и крепежом c МЭОФ-140/25-0,25М-IICT4 У2, 380В, IP65, F07 кв.14П	\N	\N
251	91	МЭП-2500/30-30У-13К У2, 380В (с БСПТ-10АК)	4	\N	Клапан регулирующий DN65 КПСР-2.42-65-40-0-СТ-1,6-2-42-У1 с комплектом ответных фланцев и крепежом с МЭП-2500/30-30У-13К У2, 380В (с БСПТ-10АК)\nНастройка: 2,5Кн, ход штока 25мм\nПлощадка: Ø65, h 128мм, М10, толщина плиты 21-22\n	\N	\N
300	95	МЭОФ-1000/63-0,25М-92СК F12, кв.27П, H30	4	\N		\N	\N
299	95	МЭОФ-4000/63-0,25М-96СК F16 d60, b16, H40	8	\N		\N	\N
301	95	МЭОФ-650/63-0,25М-92СК F12, кв.22П, H24	3	\N		\N	\N
302	95	МЭОФ-400/63-0,25М-99К F10, кв.22П, H24	3	\N		\N	\N
303	95	Шкаф управления приводом ШУМ-380-13 	36	\N		\N	\N
215	76	МЭОФ-64/10-0,25М-БКП380-IICТ4 У2, IP65, F05 кв.11П	7	\N	К затвору ЗПХ80, 70Нм	\N	\N
214	76	МЭОФ-40/10-0,25М-БКП380-IICТ4 У2, IP65, F05 кв.11П	4	\N	К затвору ЗПХ50, 40Нм	\N	\N
260	91	МЭОФ-40/10-0,25М-99К У2, 380В, F05 кв.11П	9	\N	Затвор поворотный дисковый межфланцевый ПА 342.50.16-02 (корпус - сталь 20Л, диск - сталь коррозионностойкая CF8, уплотнение - EPDM) без управления DN 50 мм PN 16 кгс/см2 \nс комплектом ответных фланцев и крепежом с МЭОФ-40/10-0,25М-99К У2, 380В, F05 кв.11П\n	\N	\N
322	110	МЭОФ-250/25-0,25М-99К У2, 380В, IP65, F10, кв. 17П, H38	4	\N		100	110
296	95	ПЭМ-А7М-77 с ЧПУ F10, Tr26x5LH	4	\N	К шиберной задвижке с выдвижным штоком, Мкр 52, датчик 56 оборотов, вылет штока 280мм	\N	\N
297	95	 ПЭМ-А7М-77 с ЧПУ F10, Tr26x5LH	4	\N	К шиберной задвижке с выдвижным штоком, Мкр 65, датчик 66 оборотов, вылет штока 330мм	\N	\N
275	91	МЭОФ-100/25-0,25М-92CК У2, 380В, F07 кв.14П	1	\N	Затвор поворотный дисковый межфланцевый ПА 342.150.16-02 (корпус - сталь 20Л, диск - сталь коррозионностойкая CF8, уплотнение - EPDM) без управления DN 150 мм PN 16 кгс/см2 \nс комплектом ответных фланцев и крепежом с МЭОФ-100/25-0,25М-92CК У2, 380В, F07 кв.14П\n	\N	\N
323	111	ПЭМ-А11М У2	2	\N	Настройка к 30ч906бр Ду100, 80Нм, 27об	\N	\N
325	118	ПЭМ-А11М У2	1	\N	Настройка к  30с941нж Ду 100, 96Нм, 21об	\N	\N
326	118	ПЭМ-Б7М У2	1	\N	Настройка к  30с964нж Ду 250, 280Нм, 42,5об	\N	\N
330	121	МЭОФ-40/25-0,25М-96 У2, 220В, IP65 с КШФ-16-80 ПЭК (L-140мм)	2	\N		\N	\N
329	120	МЭОФ-40/25-0,25М-96К У2, 380В, IP65, F07 кв.11П	21	\N		\N	\N
332	123	Ремонт МЭОФ 1000/63-0,25-ЕД-20К зав. №061249	1	\N		\N	\N
334	125	МЭОФ-40/25-0,25Р-96К F05 кв.14П	1	\N	К шаровому крану	\N	\N
338	127	МЭОФ-40/25-0,25У-IICT4 F07	1	\N	Затвор поворотный дисковый межфланцевый Квант (сталь + диск. Нерж, NBR) DN 100 мм PN 16 кгс/см2 с электроприводом МЭОФ-40/25-0,25У-IICT4 У2, 380В, IP65	\N	\N
327	66	МЭП-2500/30-30У-13К У2, 380В (с БСПТ-10АК)	4	\N	Клапан регулирующий DN65 КПСР-2.42-65-40-0-СТ-1,6-2-42-У1 с комплектом ответных фланцев и крепежом с МЭП-2500/30-30У-13К У2, 380В, 380В 2,5Кн, ход 25мм, площадка: Ø65,h 103 (138-35)мм , М12х1,25, толщина плиты 21-22\n	\N	\N
346	136	МЭОФ-1600/25-0,25-ЕД-20К У1	2	\N		\N	\N
374	143	МЭОФ-12,5/25-0,25М-98К У2, F05 кв.11П	1	\N	Кран запорный 11с67п ЦФ DN25 PN16 с комплектом ответных фланцев и крепежом с МЭОФ-12,5/25-0,25М-98К У2, 380В, IP65	\N	\N
348	138	МЭОФ-1000/63-0,25М-92СК У2, F12 кв.27П	1	\N	К шаровому крану	\N	\N
349	138	ПЭМ-В38М У2	1	\N	Настройка к 30с941нж Ду400, 590Нм, 50об	\N	\N
375	143	МЭОФ-12,5/25-0,25М-98К У2, F05 кв.11П	1	\N	Кран запорный 11с67п ЦФ DN20 PN16 с комплектом ответных фланцев и крепежом с МЭОФ-12,5/25-0,25М-98К У2, 380В, IP65 	\N	\N
376	143	МЭП-12000/160-80У-14К У2	2	\N	Клапан регулирующий DN150 КПСР-1-150-160-0-СТ-4,0-1-260-У с комплектом ответных фланцев и крепежом с МЭП-12000/160-80У-14К У2, 380В 9Кн, ход 75мм, площадка: Ø65, h 80мм, М10, толщина плиты 25	\N	\N
425	183	ПЭМ-Б5У	1	\N		\N	\N
379	143	МЭОФ-250/25-0,25М-99К У2, F10 кв.17П	1	\N	Затвор ПА 342.200.16-02 с комплектом ответных фланцев и крепежом с электроприводом МЭОФ-250/25-0,25М-99К У2, 380В\n	\N	\N
370	111	БЭЗ-3П-1С	2	\N		\N	\N
409	171	МЭОФ-40/25-0,25М-96К У2, 380В, IP65, F05 кв.14П	2	\N		\N	\N
413	174	ПЭМ-Б1У	1	\N		\N	\N
401	165	МЭОФ-40/25-0,25М-96К У2 F05 кв.14Д, H25	3	\N	К затвору Ду100	\N	\N
402	165	МЭОФ-2500/63-0,25М-96К У2, F14, d42 b12 H80	3	\N	К затвору Ду500	\N	\N
388	151	МЭОФ-100/25-0,25У-92С У2, 220В, F07 кв.14П	1	\N		\N	\N
387	151	МЭОФ-40/25-0,25У-96 У2, 220В, F07 кв.11П	1	\N		\N	\N
381	147	ПЭМ-В22М У2	10	\N	Настройка к 30c946нж Ду 600 Ру6, 380Нм, 75-90об	\N	\N
416	176	МЭОФ-16/10-0,25М-БК220-IICT4 У1 F07 кв.11П 	3	\N	с краном 10нж47фт ЦФ.01.0 DN25 PN40 (12Х18Н10Т), 26Нм	\N	\N
396	161	Блок датчика БСПМ-IICT4 со жгутом (без оболочки)	2		к МЭОФ-40/25-0,25М-ПСТ4 №071208 2015г	\N	\N
404	169	МЭОФ-200/63-0,25М-92СК F07 кв. 14Д	3	\N		\N	\N
405	169	МЭОФ-80/25-0,25М-99К F07 кв. 11Д	1	\N		\N	\N
406	169	МЭОФ-650/63-0,25М-92СК F10 кв. 22Д	4	\N		\N	\N
422	181	МЭОФ-40/63-0,25М-02 У2 F05 кв.9Д	1	\N		\N	\N
407	170	ПЭМ-А3М-С-1000.1-39 У2	4	\N	Затвор ПА 332.400.10-01 Ду400 PN10 с ПЭМ-А3М-С-1000.1-39 У2, 380 В, IP65, настройка 70Нм (1100Нм), 9,8об	\N	\N
377	143	МЭП-6300/40-40У-13К У2	2	\N	Клапан регулирующий DN80 КПСР-1-80-40-0-СТ-4,0-1-260-У с комплектом ответных фланцев и крепежом с МЭП-6300/40-40У-13К У2, 380В 4Кн, ход 40мм, площадка: Ø40, h66 мм, М10, толщина плиты 22мм (без гайки - бабочка)	\N	\N
378	143	МЭОФ-40/10-0,25М-99К У2, F07 кв.11П	9	\N	Затвор ПА 342.50.16-02 с комплектом ответных фланцев и крепежом с МЭОФ-40/10-0,25М-99К У2, 380В\n	\N	\N
429	188	МЭОФ-160/63-0,25М-IIСT4 УХЛ1, №04583, 2016г	1	\N	Замена:\n- датчика положения БСПМ-IICT4;\n- механического тормоза;\n- крышки датчика БСПМ-IICT4;\n- электродвигателя ДСР 118-0,5-187,5-IICT4 УХЛ1.	\N	\N
430	188	МЭОФ-1600/63-0,25М-IIСT4 УХЛ1, №04623, 2016г	1	\N	Увеличение пускового момента на МЭОФ.\nЗамена:\n - датчика положения БСПМ-IICT4;\n- механического тормоза;\n- крышки датчика БСПМ-IICT4.	\N	\N
427	186	ПЭМ-Б7М	1	\N		\N	\N
304	96	Пускатель ПБР-22, 220В на Din-рейку	1	\N		\N	\N
306	99	МЭОФ-40/25-0,25У-IICT4 УХЛ1, 380В, IP67, F07 кв.17Д	4	\N	К крану ДУ50 	\N	\N
435	192	МЭОФ-25/25-0,25М-08К У2, 380В, IP65, F05 кв.11П	11	\N		\N	\N
436	192	ПЭМ-А3М У2, 380В, IP65	1	\N	45Нм, настройка 16 об.	\N	\N
419	179	МЭОФ-4000/63-0,25М-96СК У2, 380В, IP65, F25 D63,3 b18 H80	2	\N	К затвору	\N	\N
344	135	МЭОФ-40/10-0,25М-99К У2	34		с наружным кв. 17	\N	\N
308	101	МЭОФ-250/10-0,25М-99К У1, 380В, IP65, F10 кв. 22П	3	\N	К крану КШХ100, 250Нм	\N	\N
310	103	МЭОФ-2500/63-0,25У-96К У2, 380В, IP65, F14 d42 b12 H80	3	\N	К затвору DN500 PN10  - 2460N*m с учетом запаса	\N	\N
328	119	МЭОФ-80/25-0,25М-99 У2, 220В, IP65, F07 кв.11Д	26	\N		\N	\N
309	102	МЭОФ-1000/25-0,25М-97К У2, 380В, IP65, F12 d28 b10 H80	1	\N	К затвору Ду200	\N	\N
333	124	ПЭМ-А11М У2	1	\N	Настройка к Ду100 3ч906бр, 80Нм, 27об	\N	\N
336	122	ПЭМ-А.70/24У УХЛ1, 380В (c БСПТ-10АК)	1	\N	К шиберной задвижке ПА500 Ду200 Тип А (кулачки), 40Нм, 45об, вылет (высота) штока до 225мм, Tr24*5	\N	\N
337	126	АШК-3-380-БУШ-СВ-ПВК35-IIВТ4-УХЛ1  	3	\N		\N	\N
316	105	МЭОФ-1000/25-0,25-ЕД-20СК У2, 380В, IP65, F10 	2	\N	К затвору Квант Ду300 F10 d31.6 b6.35 H35	\N	\N
313	106	МЭОФ-400/63-0,25М-99К У2, 380В, IP65, F10	2	\N	К затвору квант Ду 250 d28.45, лыска 20.62, H35	\N	\N
342	133	ПЭМ-Б6М У2	1	\N	Настройка к 30с941нж Ду 250, 250Нм, 42,5об	\N	\N
311	104	МЭОФ-40/25-0,25М-ПCТ4 У2, 380В, IP67, F08 кв.17П	2	\N		\N	\N
320	108	НМ-04МТ У2, 220В, IP65, с фланцем тип А (с БСП-3)	5	\N	К шиберной задвижке ПА500 Ду50 Тип А, 12Нм, 18об, ход штока 70мм, Tr18*4 - 3шт., к Ду80, 17Нм, 28об, ход штока 110мм, Tr20*4 - 2шт.	\N	\N
216	66	МЭП-12000/160-80У-14К У2, 380В (с БСПТ-10АК)	2	\N	Клапан регулирующий DN150 КПСР-1-150-160-0-СТ-4,0-1-260-У с комплектом ответных фланцев и крепежом с МЭП-12000/160-80У-14К У2, 380В 9Кн, ход 75мм, площадка: Ø65, h 80мм, М10, толщина плиты 25(28)\n	\N	\N
319	107	МЭОФ-500/25-0,25-ЕДМ-20К УХЛ1, F12 кв.22Д H30	5	\N		\N	\N
369	141	МЭОФ-100/25-0,25М-92СК У2 F07 кв.14Д H32	2	\N	К затвору Ду150	\N	\N
314	106	МЭОФ-630/15-0,25М-97К У2, 380В, IP65, F10	2	\N	К затвору квант Ду 300 d31.6, b6.35 H35	\N	\N
371	142	МЭО-630/25-0,25У-92К У2, 380В, IP65	1	\N		\N	\N
347	137	БСПТ-10М для МЭО(Ф)	3	\N		\N	\N
343	133	ПЭМ-В38М У2	3	\N	Настройка к 30с941нж Ду400, 590Нм, 50об	\N	\N
350	139	МЭОФ-6,3/12-0,25М-98 У2, F05 кв.14П	1	\N	К шаровому крану	\N	\N
373	143	МЭОФ-40/25-0,25У-96К У2, F05 кв.11П (с БСПТ-10АК)	1	\N	Кран регулирующий 11с67п DN25 PN16 с комплектом ответных фланцев и крепежом с МЭОФ-40/25-0,25У-96К У2, 380В (с БСПТ-10АК)	\N	\N
380	146	МЭОФ-1000/25-0,25М-97К У2, 380В, IP65, F12 d28 b10 H80	1	\N	К затвору Ду200	\N	\N
424	182	МЭОФ-250/25-0,25М-99К У2 F10 кв.22	3	\N	К крану Ду100 Ру16	\N	\N
397	162	МЭОФ-200/63-0,25У-92СК У2,  F07 кв.17П с (БСПТ-10АК)	2	\N		\N	\N
351	140	МЭОФ-80/25-0,25М-99К У2, F05 кв.11П	5	\N	К затвору ЗПХ80	\N	\N
398	162	МЭОФ-40/63-0,25У-02К У2 F05 кв.9П с (БСПТ-10АК)	5	\N		\N	\N
400	164	АШК-3-220-БУШ-ПК-УХЛ1 	1	\N	Шлагбаум общепромышленного исполнения АШК-3-220-БУШ-ПК-УХЛ1, со встроенным БУШ-220 и кнопочным постом управления	\N	\N
420	180	МЭОФ-80/25-0,25М-99К У2, IP65, F07 кв.17П 	3	\N	с БСПМ-10М на РП-10-30, к крану КШХ50	\N	\N
403	151	МЭОФ-250/25-0,25У-99К У2, 380В, F10 кв.22П 	2			\N	\N
410	172	МЭОФ-250/25-0,25М-99К У2, 380В, IP65, F10 кв.22П 	6	\N		\N	\N
411	173	МЭОФ-25/25-0,25М-08 У2, 220В, F05 кв.14Д	2	\N		\N	\N
412	173	МЭОФ-100/25-0,25М-92СК У2, 380В, F07 кв.17Д	4	\N		\N	\N
414	175	Доработка механизма МЭОФ-40/25-0,25М-96К на 220В	2	\N		\N	\N
415	175	Доработка механизма МЭОФ-200/63-0,25М-92СК на 220В	2	\N		\N	\N
417	177	МЭОФ-40	1	\N		\N	\N
418	178	Продленная гарантия	100	\N	 Все МЭОФ и ПЭМы	\N	\N
421	180	МЭОФ-100/25-0,25М-92CК У1, IP67, F07 кв.17П	1	\N	с БСПМ-10М на РП-10-30, к крану КШХ50	\N	\N
423	182	МЭОФ-140/25-0,25М-99К У2, F10 кв.17	2	\N	К крану Ду 80 Ру 16 	\N	\N
372	143	МЭП-2500/30-30У-13К У2	8	\N	Клапан регулирующий DN80 КПСР-2.42-80-25-0-СТ-1,6-1-42-У1 с комплектом ответных фланцев и крепежом с МЭП-2500/30-30У-13К У2, 380В 2,7Кн, ход 32мм, площадка: Ø65, h103мм (138-35 резьбовая часть), М12*1,25, толщина плиты 21-22мм	\N	\N
408	170	ПЭМ-А11М-С-2000.1-56 У2	4	\N	Затвор ПА 332.500.10-01 Ду500 PN10 с ПЭМ-А11М-С-2000.1-56 У2, 380В, IP65, настройка 110Нм (2100Нм), 14об	\N	\N
433	191	МЭОФ-1000/63-0,25М-92СК У2, 380В, IP65, F12 кв.27П	3	\N	К крану 	\N	\N
438	194	МЭО-1600/25-0,25М-92К УХЛ1, 380В, IP65	16	\N		\N	\N
439	195	Шкаф управления ШУМ-380-13 IP54 (для ПЭМ-А)	1	\N		\N	\N
432	190	 ПЭМ-А11М-С2-8000.1-241 УХЛ1, 380В, IP65, F25 	1	\N	настройка 74Нм (7800Нм), 60об	\N	\N
440	205	МЭОФ-850/45-0,25М-92СК У2, 380В, IP65, F12 кв.22П	3	\N		\N	\N
441	205	МЭОФ-1400/63-0,25М-97СК У2, 380В, IP65, F14 кв.27П	3	\N		\N	\N
445	207	МЭО-40/63-0,25У-01К (без блока питания)	2	\N		\N	\N
451	209	МЭОФ-40/25-0,25Р-96 №092043, 2021г	1	\N		\N	\N
434	192	МЭОФ-80/25-0,25М-99К У2, 380В, IP65, F05 кв.14П	2	\N		\N	\N
450	208	Ремонт МЭОФ-2500/63-0,25 БЦА2- 18К У1 IP65, 380В, F12 d40 b10x2	1	\N		\N	\N
307	100	МЭОФ-250/63-0,25-ЕД-20К У1, 380В, IP65, F10 d30 b8 	2	\N	К шаровому крану ALSO	\N	\N
448	197	БСПТ-10М для ПЭМ-А 29У	1	\N		\N	\N
452	213	ПЭМ-Б9У	1	\N		\N	\N
431	189	МЭОФ-40/25-0,25У-БКП380-IIСТ4 УХЛ1, F05 кв.14П	3	\N	с КШТВ 16-40нж-1ЛХ с комплектом ответных фланцев из 09Г2С, прокладками и крепежом	\N	\N
454	215	МЭО-250/25-0,25У-99К У1, 380В, IP65	10	\N		\N	\N
455	215	МЭО-630/25-0,25У-92К У1, 380В, IP65	1	\N		\N	\N
456	216	МЭО-250/25-0,25У-99К У2, 380В, IP65	4	\N		\N	\N
457	216	МЭО-100/25-0,25У-99К У2, 380В, IP65	2	\N		\N	\N
458	216	МЭО-630/25-0,25У-92К У2, 380В, IP65	1	\N		\N	\N
459	217	МЭО-250/25-0,25У-99К У1, 380В, IP65	2	\N		\N	\N
453	214	ПЭМ-А11М У2, 380В, IP65, F10 d22 b6 h40	1	\N	С задвижкой 30ч939р Ду150 Ру16 ABRA A4016-BS-150, настройка 110Нм, 15.5 об.	\N	\N
460	223	МЭОФ-40/25-0,25М-96К У2, 380В, IP65, F07 кв.17Д	4	\N		\N	\N
461	223	МЭОФ-16/30-0,25М-98К У2, 380В, IP65, F05 кв.14Д	3	\N		\N	\N
462	224	МЭОФ-250/25-0,25М-99К У1, 380В, IP65, F10 кв.22П	21	\N		\N	\N
463	225	АШК-5-380-БУШ-ПВК35-IIВТ4-У1	2	\N		\N	\N
464	187	Диагностика МЭОФ-100/25-0,25У-IIСT4 УХЛ1, №03346, 2015г	1	\N		\N	\N
443	206	ПЭМ-А11М-С2-8000.1-241 У1 (с БСПМ-10 - для БКЗ)	2	\N	настройка 86Нм (9154Нм), 60об	\N	\N
444	206	ПЭМ-А11М-С2-4000.1-120 У1 (с БСПМ-10 - для БКЗ)	2	\N	настройка 85Нм (4134Нм), 30об	\N	\N
482	243	Ремонт МЭОФ-160/63-0,25У-92СК №01043, 2020г	1	\N	Замена болта механического ограниителя	\N	\N
394	157	МЭО-1600/25-0,25У-92К У1	3	\N		\N	\N
493	251	МЭОФ-200/63-0,25М-92СК У2, 380В, IP65, F07 кв.17Д	4	\N		\N	\N
487	246	МЭОФ-250/10-0,25М-99К У1, 380В, IP65, F10 кв. 22П	4	\N	К шаровому крану	\N	\N
488	247	МЭОФ-64/10-0,25М-БКП380-IICТ4 У2, IP65, F05 кв.11П	2	\N	К затвору	\N	\N
426	185	МЭОФ-40/25-0,25М-96К У2, 380В, IP65, F07 кв.11П	4	\N		20211141	20211146
437	192	МЭОФ-25/25-0,25М-08К У2, 380В, IP65, на РП10-30, F05 кв.11П	2	\N		\N	\N
491	249	МЭОФ-100/25-0,25-БЦА1-18СК У1, 380В, IP65, F07 кв.17Д	1	\N		\N	\N
468	233	МЭО-250/25-0,25У-99К У1, 380В, IP65	2	\N		\N	\N
298	95	ПЭМ-Б8М с ЧПУ F14, Tr36x6LH	10	\N	К шиберной задвижке с выдвижным штоком, Мкр 234, датчик 90 оборотов, вылет штока 540мм	\N	\N
466	228	МЭОФ-4000/63-0,25М-96СК У2 F16 кв.36Д H75	1	\N		\N	\N
472	235	Кран КШФ-16-80 (L-140мм) ПЭК с МЭОФ-40/25-0,25М-96 У2, 220В, IP65	2	\N		\N	\N
473	236	Кран КШФ-16-50 (L-114мм) ПЭК с МЭОФ-40/25-0,25М-96 У2, 220В, IP65	1	\N		\N	\N
474	236	Конденсатор K78-99 10мкФ	3	\N		\N	\N
478	240	МЭОФ-250/25-0,25М-99К У2, 380В, IP65	6	\N		\N	\N
479	241	МЭО-250/25-0,25У-99К У2, 380В, IP65	26	\N		\N	\N
480	241	МЭО-100/25-0,25У-99К У2, 380В, IP65	8	\N		\N	\N
476	238	МЭОФ-650/63-0,25-БЦА2-18СК У2, 380В, IP65 (с фланцем 250 кв.24)	4	\N		\N	\N
489	247	МЭОФ-40/10-0,25М-БКП380-IICТ4 У2, IP65, F07 кв.14П	6	\N	К шаровому крану	\N	\N
471	234	ПЭМ-В6-630-25-216М У2, 380В, IP65	2	\N	Настройка 520Нм, 52об.	\N	\N
475	237	МЭОФ-250/25-0,25М-99К У2 F10 кв.22П	1	\N	К шаровому крану 	\N	\N
481	242	МЭОФ-250/25-0,25М-IIСТ4-01 У1 F10 кв.19П	1	\N	К шаровому крану	\N	\N
484	245	ПЭМ-Б6М У2, 380В, IP65	2	\N	Настройка 209Нм, 35об.	\N	\N
483	244	АШК-5-380-БУШ-СВ-ПВК35-IIВТ4-У1	2	\N		\N	\N
477	239	МЭОФ-25/25-0,25М-08К У2, 380В, IP67, F05 кв.11П	4	\N	К шаровому крану	\N	\N
494	252	МЭОФ-40/63-0,25У-02К У2, 380В, IP65, F05 кв.14П, h30	4	\N		\N	\N
485	245	ПЭМ-В38М У2, 380В, IP65	1	\N	Настройка 790Нм, 52об.	\N	\N
486	245	ПЭМ-А11М У2, 380В, IP65	1	\N	Настройка 107Нм, 22об.	\N	\N
490	248	ПЭМ-А11М У2, 380В, IP65, F10 d22 b6 h40	1	\N	С задвижкой 30ч939р Ду150 Ру16 ABRA A4016-BS-150, настройка 110Нм, 15.5 об.	\N	\N
492	250	МЭОФ-100/25-0,25М-IICT4-05 У1, 380В, IP65, F07 кв.14П	1	\N	Кран КШТВГ 16-80 с комплектом ответных фланцев плоских 80-16-01-1-B-Ст 20-IV, прокладками и крепежом c МЭОФ-100/25-0,25М-IICT4	\N	\N
495	253	МЭОФ-200/63-0,25У-92СК У2, 380В, IP65, F07 кв.17П с (БСПТ-10АК)	2	\N		\N	\N
496	253	МЭОФ-40/63-0,25У-02К У2, 380В, IP65, F05 кв.9П с (БСПТ-10АК)	5	\N		\N	\N
497	254	МЭО-1600/25-0,25У-92К У1, 380В, IP65	2	\N		\N	\N
498	254	МЭО-250/63-0,25У-99К У2, 380В, IP65	16	\N		\N	\N
499	255	ПЭМ-Б7М У2, 1,1кВт	2	\N	К задвижке 30с941нж Ду200 190Нм, 34об	\N	\N
501	256	 МЭОФ-250/25-0,25У-99К У2 №061279 2021г	1	\N		\N	\N
502	257	МЭОФ-40/25-0,25М-96К У2, 380В, IP65, F07 кв.14П	1	\N		\N	\N
503	257	МЭОФ-100/25-0,25М-92СК У2, 380В, IP65, F07 кв.17П	2	\N		\N	\N
504	258	МЭОФ-12,5/25-0,25М-08 У2, 220В, IP65, F05 кв.11П	5	\N		\N	\N
505	259	МЭОФ-15/30-0,25М-98К У2 F05 кв.9П (домик)	3	\N	К крану 	\N	\N
506	260	Электродвигатель ДСР-110-0,5-187 	2	\N	к МЭОФ-40/25-0,25М-96 №05816 2018	\N	\N
507	261	МЭОФ-1600/25-0,25-ЕД-20К У1, 380В, IP65	1	\N		\N	\N
510	263	МЭОФ-250/25-0,25М-IICT4 УХЛ1, 380В, IP65, F10 кв. 22Д	32	\N	К крану	\N	\N
508	262	МЭОФ-40/10-0,25М-99К УХЛ1, 380В, IP65, F07 кв.11П	4	\N		\N	\N
509	262	МЭОФ-250/10-0,25М-99К УХЛ1, 380В, IP65, F10 кв.17П	4	\N		\N	\N
514	265	МЭОФ-40/25-0,25М-96К У2, 380В, IP65, F07 кв.11П	3	\N		\N	\N
515	265	МЭОФ-250/25-0,25М-99К У2, 380В, IP65, F10 кв.22П	6	\N		\N	\N
517	267	МЭОФ-250/63-0,25У-99К У2, 380В, IP65, F10 кв.17П	5	\N		\N	\N
518	268	МЭО-100/25-0,25Р-99К У2, 380В, IP65	1	\N		\N	\N
519	269	МЭОФ-64/10-0,25М-92С У2, 220В, IP65, F07 кв.11Д	3	\N		\N	\N
467	208	Ремонт МЭОФ-1000/63-0,25-БЦА2- 18К У1 №112575 2020г	1	\N	Замена корпуса (трещина фланца)	\N	\N
516	266	МЭОФ-1200/25-0,25М-97К У2, 380В. IP65. F14 d41.15 b12 h64	1	\N		\N	\N
511	263	МЭОФ-100/25-0,25Р-IICT4 УХЛ1, 380В, IP65, F07 d16 b5 H35	8	\N	К затвору	\N	\N
522	271	МЭОФ-16/30-0,25М-98 У2, 220В, IP65, F05 кв.11П	1	\N		\N	\N
523	271	ПЭМ-А.150/24М У2, 380В, IP65 	1	\N		\N	\N
521	271	МЭОФ-40/63-0,25У-02К У2, 380В, IP65, F05 кв.14П	1	\N		\N	\N
524	272	МЭОФ-100/25-0,25М-99К У2, квадрат выходного вала - 24 мм 	10	\N		\N	\N
525	272	МЭОФ-250/25-0,25М-99К У2, квадрат выходного вала - 24 мм 	2	\N		\N	\N
520	270	МЭОФ-40/25-0,25М-IICT4 УХЛ1, 380В, IP65, F07 d14 b6 h30	37	\N	с затвором PALUR-ZD-3EX-DN50 PN10	\N	\N
529	274	МЭОФ-80/25-0,25М-99К УХЛ1, 380В, IP65, F10 кв.17П	1	\N		\N	\N
531	276	МЭОФ-250/63-0,25М-99К У2, 380В, IP65, F10 кв.17П	1	\N	К затвору	\N	\N
512	264	МЭОФ-100/25-0,25М-92СК У2, 380В, IP65, F07 кв.14П	1	\N	К затвору	\N	\N
532	264	МЭОФ-250/25-0,25М-99К У2, 380В, IP65, F10 кв.22П	1	\N	К затвору	\N	\N
533	264	МЭОФ-500/25-0,25М-92СК У2, 380В, IP65, F10 кв. 22П	3	\N	К затвору	\N	\N
534	277	БЭЗ-ЗП-1-С	3	\N		\N	\N
535	278	МЭОФ-250/63-0,25М-IIСТ4-01 У1, 380В, IP65, F10 кв.22П	5	\N		\N	\N
536	278	МЭОФ-1000/63-0,25М-IIСТ4-12 У1, 380В, IP65, F12 кв.27П	8	\N		\N	\N
537	278	МЭОФ-1600/63-0,25М-IIВТ4-12 У1, 380В, IP65, F14 кв.36П	2	\N		\N	\N
530	275	ПЭМ-В38М У2, 380В, IP65	1	\N	Кол - во оборотов 50, крутящий момент 850Нм	\N	\N
538	279	МЭОФ-16/30-0,25М-98 У2, 220В, IP65, F05 кв.11П	3	\N		\N	\N
539	281	МЭОФ-250/25-0,25У-99К У2, 380В, IP65, F10 кв. 22П 	1	\N	с каб. вводами M20x1.5 из нержавеющей стали SS304	\N	\N
513	265	МЭОФ-40/25-0,25У-96К У2, 380В, IP65, F05 кв.9П (БСПТ-10АМ)	1	\N		\N	\N
540	282	МЭО-250/25-0,25-БЦА2-18К У2, 380В, IP65	3	\N		\N	\N
544	284	ПЭМ-Б7М У2, 380В, IP65	4	\N		\N	\N
545	284	МЭОФ-1000/63-0,25М-92СК У2, 380В, IP65, F14	1	\N		\N	\N
541	283	МЭОФ-200/63-0,25М-БК220-IICT4 УХЛ1,  IP65, F10 d25 b8 H45	8	\N	К затвору	\N	\N
542	283	МЭОФ-140/30-0,25М-БК220-IICT4 УХЛ1,  IP65, F07 d18 b6 H30	1	\N	К затвору	\N	\N
543	283	МЭОФ-140/30-0,25М-БК220-IICT4 УХЛ1, IP65, F07 d16 b6 H30	1	\N	К затвору	\N	\N
546	285	МЭОФ-40/25-0,25У-96 У2, 220В, IP65 с переходником КМЧ	1	\N	Для ДУ 50	\N	\N
\.


--
-- Data for Name: OrderStatus; Type: TABLE DATA; Schema: erp; Owner: postgres
--

COPY erp."OrderStatus" ("ID", "Name") FROM stdin;
1	pre-order
2	order in production
3	order in archive
10	Рекламация Входящие
11	Рекламация Принятие решения
12	Рекламация В производстве
13	Рекламация В архиве
\.


--
-- Data for Name: Orders; Type: TABLE DATA; Schema: erp; Owner: postgres
--

COPY erp."Orders" ("OrderID", "OrderStatusID", "CheckListTPLID", "ManagerID", "CreatingDate", "Entity", "City", "TotalAmount", "PaidAmount", "Comment", "InvoiceNumber", "ShippingDate", "AwaitingDispatch", "AcceptanceDate", "ActualShippingDate", "OrderNumber", "IsReclamation", "NeedAttention") FROM stdin;
118	3	\N	15	2021-10-04 05:17:10.350779+00	Анкан Про	Минск	96450	96450	Отгрузить ТК Главдоставка, трек ЧБК-МНС-882082/21-Д	0709	2021-10-19	f	2021-10-06 10:59:05+00	2021-10-14 11:32:27.37+00	587	f	\N
99	3	\N	15	2021-09-21 10:53:34.347667+00	НПО Наука	Чебоксары	251616	251616	Гарантийный срок 24 месяца с даты ввода в эксплуатацию, но не более 36 месяцев со дня продажи	596	2021-10-11	f	2021-09-28 08:00:02+00	2021-10-20 09:11:32.484+00	564	f	\N
104	3	\N	16	2021-09-23 10:00:59.038089+00	ООО АМТ	Ставрополь	90782	90782	Отгрузить ТК Деловые Линии до терминала г. Ростов-на-Дону (Ростовская область.)\n\nПлательщик за транспортные расходы: ООО АМТ (АМТ-Нефтегазовое оборудование, ИНН 2635804840)\nГрузополучатель: ООО АМТ (АМТ-Нефтегазовое оборудование, ИНН 2635804840)\n\nКонтактное лицо: +7 918 574 00 09, Дмитрий	610	2021-10-11	f	2021-09-28 07:59:57+00	2021-10-10 13:30:08+00	\N	f	\N
111	3	\N	15	2021-09-30 06:28:43.780805+00	КентаврЭнерго	Минск	80100	80100	\N	0928	2021-10-19	f	2021-09-30 11:12:56+00	2021-11-03 13:43:33.48+00	\N	f	\N
91	3	\N	15	2021-09-15 08:01:56.616953+00	Пауэрз	Великий-Новгород	2276735	2276735	Требования по изготовлению: \n1)\tГарантия: 18 месяцев с даты ввода в эксплуатацию, но не более 24 месяцев со дня продажи.\n\nТребования по упаковке: \n1.\tОборудование будет отправляться в Казахстан и ждать монтажа в течение полугода.\n2.\tПриводы и арматура поставляются в сборе\n3.\tНа ящих необходимо указать:\n– номер Договора поставки, наименование Грузополучателя;\n– вес, брутто/нетто Оборудования;\n– место назначения Оборудования;\n– количество отгруженных мест;\n– номера мест и их общее количество;\n– адрес отправителя Оборудования;\n4.\tС каждым товарным местом Оборудования должны находиться два экземпляра упаковочного листа. Один экземпляр упаковочного листа должен находиться внутри ящика или упаковки, а другой экземпляр с сопроводительными документами.	386	2021-09-30	f	2021-09-15 11:12:33+00	\N	\N	f	\N
67	3	\N	15	2021-08-31 06:21:05.564207+00	ПП Элмон	Саратов	112140	112140	Упаковка в 1 ящик.\n\nОтгрузить ТК Байкал Сервис по шаблону.	526	2021-09-20	f	\N	\N	\N	f	\N
101	3	\N	15	2021-09-21 10:57:13.851605+00	ПП Элмон	Саратов	117396	117396	Упаковка в 2 ящика\nОтгрузка ТК Байкал Сервис по шаблону	593	2021-10-11	f	2021-09-28 07:59:48+00	2021-10-18 09:04:43.701+00	\N	f	\N
89	3	\N	15	2021-09-15 07:49:03.184865+00	Камышинский опытный завод	Камышин	890016	890016	Отгрузить ТК «Деловые линии» до терминала в г.Камышин\nГрузополучатель: ООО "Камышинский опытный завод"\nПлательщик: ООО "Камышинский опытный завод"\nКонтактное лицо: Федотов Дмитрий\nТел.:  +7 (8442) 96-86-93 (доб.46)	465	2021-10-11	f	2021-09-15 10:50:45+00	2021-10-29 12:43:42.831+00	463	f	\N
90	3	\N	15	2021-09-15 07:51:50.839553+00	АО Акмай	Альметьевск	104280	104280	Отгрузить ТК “ Деловые Линии” до терминала г. Альметьевск\nОтгрузочные документы отправить с грузом\nПлательщик:  АО "АКМАЙ"\nГрузополучатель: АО "АКМАЙ"\nКонтактное лицо: Сахуриев Сергей +7 (8553) 37-10-70	487	2021-10-22	f	2021-09-15 10:59:16+00	2021-10-28 07:18:09.13+00	\N	f	\N
96	3	\N	15	2021-09-17 10:23:32.19105+00	Новое качество	Новокуйбышевск	5640	5640	Шевелев Вячеслав\nмоб.: +7 (927) 795-19-13\nООО «Новое Качество»\n446201, РФ, Самарская область,\nг. Новокуйбышевск, ул. Карбышева, д.28, оф.18\nтел.: +7 (846)201-43-93 info@nok-samara.ru\n	585	2021-09-24	f	2021-09-17 13:30:08+00	2021-10-09 09:30:08+00	\N	f	\N
76	3	\N	15	2021-09-07 17:50:51.046163+00	ПП Элмон	Саратов	856770	856770	Упаковка в 4 ящика.\nОтгрузка ТК Байкал-сервис по шаблону	544	2021-10-21	f	2021-09-21 09:32:08+00	2021-11-01 18:53:13.388+00	\N	f	\N
105	3	\N	16	2021-09-27 05:41:36.294483+00	ООО ГК Гранд Арматура	Чебоксары	149472	149472	\N	634	2021-10-27	f	2021-09-28 08:00:11+00	2021-10-29 12:43:48.903+00	\N	f	\N
127	3	\N	15	2021-10-07 09:32:15.494155+00	Гарант Строй	Санкт-Петербург	61350	61350	Отгрузить ТК “ Деловые Линии” до терминала г. Санкт-Петербург\nОтгрузочные документы отправить ТК отдельным конвертом\nПлательщик:  ООО "Гарант Строй" \nГрузополучатель: ООО "Гарант Строй" \nКонтактное лицо: Капустина Елена 8-911-082-55-27	652	2021-10-25	f	2021-10-08 15:15:53+00	2021-10-25 15:57:20.876+00	598	f	\N
80	13	\N	15	2021-09-09 14:13:55.296298+00	Самаранефтегазпроект	Самара	4800	4800	\N	565	2021-09-20	f	2021-09-15 10:40:29+00	\N	\N	f	\N
123	13	\N	15	2021-10-06 07:46:15.541157+00	Самаранефтегазпроект	Самара	32400	32400	Отгрузить ТК Деловые Линии до терминала г. Елец (Липецкая обл.).\n\nПлательщик за транспортные расходы: ООО СНГП (САМАРАНЕФТЕГАЗПРОЕКТ, ИНН 6316134234)\nГрузополучатель: ООО СНГП (САМАРАНЕФТЕГАЗПРОЕКТ, ИНН 6316134234)\n\nКонтактное лицо: +7 (915) 668-65-25, Игорь, +79277509394 Станислав	629	2021-10-06	f	2021-10-06 10:59:06+00	\N	\N	f	\N
140	3	\N	15	2021-10-25 17:00:06.412793+00	Элмон	Саратов	99960	99960	Отгрузка ТК Байкал-Сервис по шаблону	668	2021-11-15	f	2021-11-01 08:03:35.705+00	2021-11-16 08:18:48.606+00	635	f	\N
107	3	\N	15	2021-09-28 07:25:36.792617+00	НПО Наука	Чебоксары	474420	474420	Упаковать в ящики - поедут сразу на объект.\nЗаберут самовывозом.	621	2021-11-19	f	2021-10-20 12:23:27+00	2021-12-01 09:29:27.1+00	\N	f	\N
253	3	\N	16	2022-02-09 05:29:02.878261+00	Синклит	Екатеринбург	220302	220302	Отгрузка ТК Байкал-Сервис по шаблону	92	2022-03-01	f	2022-02-09 05:33:04.579+00	2022-03-01 07:34:45.349+00	58	f	\N
268	2	\N	15	2022-02-25 06:30:33.869883+00	ЕХРО-ТЕХ	Караганда	31300	31300	Отгрузка ТК DPD по трек номеру KZ067259202\n	02181	2022-03-11	t	2022-02-25 06:32:16.494+00	\N	98	f	\N
100	2	\N	15	2021-09-21 10:55:27.090842+00	Навигатор	Самара	214872	214872	\N	158	2022-04-25	f	2022-03-04 12:10:11.664+00	\N	115	f	\N
135	2	\N	15	2021-10-19 15:22:49.712818+00	Элмон	Саратов	926232	926232	Упаковка в 3 ящика	183	2022-04-22	f	2022-03-15 07:01:43.183+00	\N	134	f	\N
284	2	\N	16	2022-03-21 07:18:24.994244+00	Анкан Про	Минск	507300	507300	\N	072015	\N	f	2022-03-21 07:36:38.599+00	\N	\N	f	\N
93	3	\N	15	2021-09-15 08:15:53.810049+00	ООО Югра-Нефтегазсервис	Нижневартовск	50364	50364	Упаковка в ящик.\n\nСогласованы присоед. размеры из РЭ исполнения МЭПК-6300/50-40У-IICТ4-05	542	2021-09-30	f	2021-09-15 11:18:06+00	\N	\N	f	\N
102	3	\N	15	2021-09-23 09:48:38.018947+00	ТД Энергомашкомплект	Саратов	56202	56202	В Ящик.\n\nОтгрузка ТК Байкал-Сервис до терминала г. Волжский\nПлательщик за доставку: ООО ТД "Энергомашкомплект", ИНН 6454085567 КПП645401001, 410017, Саратовская область, г. Саратов, ул. Шелковичная 37/45, офис 701,\nГрузополучатель: Волжский филиал АО "Гидроремонт-ВКК" в г. Волжский, ИНН 6345012488, 404130, Волгоградская обл, Волжский г, Ленина пр-кт, дом № 1А\nКонтактное лицо: Шишляников Станислав , 8 (961) 068-5843\n\nОригиналы документов просим отправить почтой по адресу: 410017, г. Саратов, ул. Шелковичная, д. 37/45 и копию на электронный адрес - semynin.a.d@emk.ru\n	599	2021-10-27	f	2021-10-11 20:59:22+00	2021-10-28 07:18:18.315+00	606	f	\N
109	3	\N	16	2021-09-29 10:11:28.630088+00	Арматурз	Великий Новгород	66175	66175	Отгрузка транспортной компанией: Деловые линии до адреса: Новгородская обл., Новгородский р-н, рп. Панковка, ул. Индустриальная, д. 18\nДокументы отправить: с грузом \nГрузополучатель: ООО Арматурз, ИНН 5321160421\nКонтактное лицо: Гаврилова Эллина +79210201360\n	463	2021-10-14	f	2021-09-30 11:13:28+00	2021-12-13 04:10:49.063+00	\N	f	\N
108	3	\N	15	2021-09-28 07:29:57.86805+00	Промарм	Пенза	142920	142920	Упаковка в 2 ящика\nСделать отметки на приводах: "К Ду50", "К Ду80"\n\nОтгрузить ТК Байкал-Сервис по шаблону	622	2021-10-20	f	2021-10-01 14:36:20+00	2021-10-29 12:43:27.135+00	\N	f	\N
124	3	\N	15	2021-10-07 06:23:14.49418+00	ТД ПремиумАрм	Нижний-Новгород	41136	41136	Отгрузить ТК «Байкал-сервис» до терминала г. Нижний-Новгород.\nПлательщик: ООО ТД «ПремиумАРМ» \nГрузополучатель: ТД «ПремиумАРМ» \nКонтактное лицо: Гилядова Дарья, +7(831)2-147-047\n\n 	648	2021-10-20	f	2021-10-07 09:50:41+00	2021-10-20 09:12:25.18+00	\N	f	\N
136	3	\N	15	2021-10-21 12:52:33.867709+00	Пауэрз	Великий-Новгород	218040	218040	Отгрузка ТК Байкал-Сервис по шаблону.\nГарантийный срок: 24 месяца со дня ввода механизма в эксплуатацию, но не более 30 месяцев с момента изготовления.	665	2021-12-08	f	2021-11-03 16:47:22+00	2021-12-28 04:29:49.174+00	639	f	\N
120	3	\N	16	2021-10-05 06:07:20.933173+00	АО Эприр	Санкт-Петербург	303240	303240	Отгрузка по шаблону ТК Байкал-Сервис.\n\nС обязательным комментарием: г. Санкт-Петербург, терминал "Софийская"\n\nОтгрузочные документы отправить с продукцией.\nПлательщик за транспортные расходы: АО «ЭПРИР», ИНН 7810434898\nГрузополучатель: АО «ЭПРИР», ИНН 7810434898\nКонтактное лицо: Александр, +7 (812) 448-47-08 Самойленко Василий	636	2021-10-25	f	2021-10-05 09:23:28+00	2021-10-18 09:04:56.495+00	\N	f	\N
239	3	\N	16	2022-01-17 10:30:29.032913+00	Химприбор-1	Тула	77616	77616	Отгрузка ТК Байкал-Сервис по шаблону	31	2022-02-11	f	2022-01-27 06:54:11.082+00	2022-02-22 04:52:11.789+00	39	f	\N
141	3	\N	15	2021-10-27 07:16:35.165772+00	Анкан Про	Минск	49160	49160	Чебоксары - Минск\nООО «АнканПро», УНП 193434875\n220053 Республика Беларусь, г.Минск, ул.Будславская, 2 пом.3 каб.28\nБорухова Юлия Ивановна + 375 (44) 701-20-19	070910	2021-11-23	f	2021-11-09 07:25:00.709+00	2021-11-20 20:19:15.111+00	610	f	\N
92	3	\N	15	2021-09-15 08:13:30.284985+00	Пауэрз	Великий-Новгород	416940	416940	Упаковка в 5 ящиков.\nОтгрузка ТК Байкал-Сервис по шаблону. 	570	2021-09-30	f	2021-09-15 11:15:30+00	\N	\N	f	\N
147	3	\N	15	2021-10-28 16:28:32.941336+00	УралКомплектЭнергоМаш	Екатеринбург	983400	983400	Отгрузить ТК Деловые линии до терминала г. Екатеринбург. \nГрузополучатель: ООО "УралКомплектЭнергоМаш"\nПлательщик : ООО "УралКомплектЭнергоМаш"\nКонтактное лицо: Петренко Иван (343) 222-79-77\n\n	702	2021-12-08	f	2021-11-18 05:13:47.986+00	2021-12-14 07:48:16.037+00	672	f	\N
142	3	\N	15	2021-10-27 14:59:33.081789+00	Пауэрз	Великий-Новгород	60480	60480	Отгрузка ТК Байкал-Сервис по шаблону.\nГарантийный срок: 24 месяца со дня ввода механизма в эксплуатацию, но не более 30 месяцев с момента изготовления.	688	2021-11-22	f	2021-11-03 16:47:19+00	2021-11-20 20:18:53.831+00	638	f	\N
246	3	\N	15	2022-01-27 08:08:00.170923+00	Элмон	Саратов	163728	163728	Упаковка в 2 ящика\n\nОтгрузка ТК Байкал-Сервис по шаблону	63	2022-02-14	f	2022-01-31 11:34:11+00	2022-02-25 11:59:19.725+00	45	f	\N
106	3	\N	16	2021-09-27 05:41:53.740146+00	ООО ГК Гранд Арматура	Чебоксары	196725	196725	\N	613	2021-10-18	f	2021-09-28 08:00:10+00	2021-11-18 16:37:44.678+00	\N	f	\N
94	3	\N	15	2021-09-15 08:28:26.751853+00	Железобетонные конструкции № 9	Чебоксары	48600	48600	Заберут самовывозом	580	2021-10-20	f	2021-09-16 10:32:13+00	2021-11-12 09:04:00.26+00	\N	f	\N
133	3	\N	15	2021-10-14 08:51:41.789888+00	Анкан Про	Минск	327070	327070	Чебоксары - Минск\nООО «АнканПро», УНП 193434875\n220053 Республика Беларусь, г.Минск, ул.Будславская, 2 пом.3 каб.28\nБорухова Юлия Ивановна + 375 (44) 701-20-19	07098	2021-11-11	f	2021-10-27 10:45:32+00	2021-11-20 20:18:23.454+00	628	f	\N
245	3	\N	16	2022-01-27 05:45:13.386533+00	НЕОТЕХ	Иркутск	311292	311292	Отгрузка ТК ПЭК, до терминала города Иркутск.\nКонтактное лицо: Жаркова Вероника\nтел. +7(904)127-42-61	56	2022-02-17	f	2022-01-28 05:40:06.874+00	2022-02-23 11:22:56.392+00	43	f	\N
157	3	\N	15	2021-11-01 09:47:44.911583+00	Пауэрз	Великий-Новгород	236844	236844	Отгрузка ТК Байкал-Сервис по шаблону.\nГарантийный срок: 24 месяца со дня ввода механизма в эксплуатацию, но не более 30 месяцев с момента изготовления.	696	2021-11-23	f	2021-11-09 07:51:08.109+00	2021-11-20 20:19:00.633+00	642	f	\N
276	2	\N	15	2022-03-10 06:52:32.044234+00	Уралресурс	Екатеринбург	52290	52290	В ящик\n	172	2022-04-04	f	2022-03-14 06:49:02.87+00	\N	130	f	\N
285	2	\N	16	2022-03-21 10:27:15.407765+00	Баел Крафт	Минск	43415	43415	\N	03151	\N	f	2022-03-21 11:19:15.951+00	\N	\N	f	\N
103	3	\N	15	2021-09-23 09:53:50.96106+00	АБО Арматура	Смоленск	232920	232920	В 3 ящика. \n\nОтгрузить ТК  «Байкал Сервис» до терминала в г.Смоленск.\nОтгрузочные документы отправить с продукцией.\nГрузополучатель: ООО "АБО Арматура",\nПлательщик за транспортные услуги: ООО "АБО Арматура"\nКонтактное лицо: Анастасия Стаселько, +7 4812 240020, staselko@aboarmatura.ru	608	2021-10-07	f	2021-09-24 08:40:29+00	\N	\N	f	\N
121	3	\N	15	2021-10-05 06:08:32.060478+00	ТД НефтекамскСтрой	Нефтекамск	57187	57187	Отгрузка ТК "Байкал-Сервис" до адреса:\nг.Нефтекамск, ул. Автозаводская, д. 1, строение 5/5.\nГрузополучатель: ООО «ТД «НефтекамскСтрой», ИНН/КПП: 0264076500/ 026401001\nКонтактное лицо: (34783) 2-66-47, Амиров Ратмир	609	2021-10-25	f	2021-10-05 09:22:57+00	2021-10-28 07:17:53.893+00	\N	f	\N
122	3	\N	15	2021-10-05 07:21:40.204951+00	Промарм	Пенза	48192	48192	Отгрузить ТК «Байкал-Сервис» до терминала г. Пенза.\nГрузополучатель: ООО "ПромАрм"\nПлательщик: ООО "ПромАрм"\nКонтактное лицо: Екатерина Куликова, +7 8412 35-07-97	644	2021-10-26	f	2021-10-07 09:50:44+00	2021-10-29 12:43:39.439+00	\N	f	\N
125	3	\N	15	2021-10-07 06:43:39.781624+00	Химприбор-1	Тула	25578	25578	Отгрузить ТК «Байкал Сервис» до терминала г. Тула.\nГрузополучатель: ЗАО "ХИМПРИБОР-1"\nПлательщик: ЗАО "ХИМПРИБОР-1"\nКонтактное лицо: +7 (495) 268-06-44, Елизавета Игоревна	633	2021-10-21	f	2021-10-07 09:50:44+00	2021-10-25 15:57:12.037+00	\N	f	\N
180	3	\N	15	2021-11-22 13:36:54.248184+00	Элмон	Саратов	129048	129048	Отгрузка ТК Байкал-Сервис по шаблону\n\nНа филиал ОАО "Квадра" - "Курская\nгенерация" необходимы приводы с датчиком БСПМ-10М, чтобы клеммы и\nконечные  выключатели были выполнены в\nсоответствии с блоком управления БМН5430-2074.\n\nДоплата по сч. 560.  с учетом предыдущих ошибок в платежах должна быть 56 106 руб.\n	560	2021-12-07	f	2021-11-22 13:49:46.115+00	2021-12-13 04:11:36.286+00	683	f	\N
95	3	\N	16	2021-09-16 10:08:19.284805+00	Компенсатор Групп	Минск	2909691	2909691	Риски по отклонениям присоединительных размеров от ISO-5211 Компенсатор Групп берет на себя.	0907	2021-11-11	f	2021-09-17 09:13:56+00	2021-12-02 06:10:36.866+00	\N	f	\N
254	2	\N	16	2022-02-10 06:40:44.905011+00	Пауэрз	Великий Новгород	759384	\N	Упаковка в 8 ящиков.\n\nОтгрузка ТК Байкал-Сервис по шаблону.\n\nПеред каждой отгрузкой необходимо направить УЛ, а также направлять копии УПД.\n\nГарантийный срок: 24 месяца со дня ввода механизма в эксплуатацию, но не более 30 месяцев с момента изготовления.	101	2022-03-31	f	2022-02-10 07:01:14.208+00	\N	\N	f	\N
207	3	\N	18	2021-12-14 05:33:34.984531+00	РКС Системы	Барнаул	41640	41640	В Ящик	462	2021-12-20	f	2021-12-14 06:25:16.067+00	2021-12-22 07:10:28.949+00	719	f	\N
151	3	\N	16	2021-10-29 11:41:10.428375+00	АО Эприр	Санкт-Петербург	142824	142824	Упаковать в 2 ящика:\n1) МЭОФ-40 и МЭОФ-100 с затворами\n2) МЭОФ-250 2шт.\n\nЯщик №1 отправить согласно письма и доверенности от АО "Эприр".\nОП ПАО "Т Плюс" ИНН 6315376946, КПП 434545004\nКонтактное лицо: +78332574688 Дарья\n\nЯщик №2 отправить ТК "Деловые Линии" до терминала г. Санкт-Петербург.\nОтгрузочные документы отправить с продукцией.\nПлательщик за транспортные расходы: АО «ЭПРИР», ИНН 7810434898\nГрузополучатель: АО «ЭПРИР», ИНН 7810434898\nКонтактное лицо: Александр, +7 (812) 448-47-08	695	2021-11-26	f	2021-11-12 06:33:34.03+00	2021-11-25 10:17:52.146+00	654	f	\N
138	3	\N	15	2021-10-25 16:53:06.120445+00	Анкан Про	Минск	132900	132900	\N	07099	2021-11-11	f	2021-10-27 10:45:33+00	2021-11-20 20:18:34.987+00	628	f	\N
110	3	\N	16	2021-09-29 10:23:57.153754+00	Арматурз	Великий Новгород	137894	137894	Отгрузка транспортной компанией\nДеловые линии до адреса: Новгородская обл., Новгородский р-н, рп. Панковка, ул. Индустриальная, д. 18.\nДокументы отправить с грузом,\nГрузополучатель: ООО Арматурз, ИНН 5321160421\nКонтактное лицо: Гаврилова Эллина +79210201360\n	616	2021-10-14	f	2021-09-30 11:13:29+00	2021-12-14 05:34:08.87+00	\N	f	\N
137	3	\N	15	2021-10-25 16:13:28.81437+00	ЭТС-НК	Челябинск	22608	22608	Отгрузить ТК Деловые Линии до терминала г. Челябинск.\nПлательщик: ООО "ЭТС-НК"\nГрузополучатель: ООО "ЭТС-НК"\nКонтактное лицо: Галимов Ленар, 8-987-232-5772	459	2021-11-03	f	2021-10-25 19:38:26+00	2021-11-08 16:18:23.538+00	622	f	\N
88	3	\N	15	2021-09-15 07:46:03.481902+00	Пауэрз	Великий-Новгород	6922080	6922080	Гарантийный срок: 24 месяца со дня ввода механизма в эксплуатацию, но не более 30 месяцев с момента изготовления.	486	2021-11-01	f	2021-09-15 10:48:37+00	2021-11-25 05:54:37.223+00	\N	f	false,2021-11-17T07:32:46.774Z,2021-11-17T07:32:56.684Z
172	3	\N	16	2021-11-15 09:37:00.991382+00	АО "Эприр"	Санкт - Петербург	201312	201312	ТК "Деловые Линии" до терминала г. Санкт-Петербург.\nОтгрузочные документы отправить с продукцией.\nПлательщик за транспортные расходы: АО «ЭПРИР», ИНН 7810434898\nГрузополучатель: АО «ЭПРИР», ИНН 7810434898\nКонтактное лицо: Александр, +7 (812) 448-47-08	722	2021-12-24	f	2021-12-14 06:27:14.185+00	2021-12-27 08:19:36.627+00	720	f	\N
247	3	\N	15	2022-01-27 09:09:22.732577+00	Элмон	Саратов	601008	601008	Упаковка в 3 ящика\n\nОтгрузка ТК Байкал-Сервис по шаблону	65	2022-02-21	f	2022-01-31 11:34:15+00	2022-03-16 06:52:49.102+00	46	f	\N
269	2	\N	15	2022-02-28 06:00:43.872844+00	АПА	Санкт-Петербург	100980	100980	Упаковка в 1 ящик\n\nОтгрузка ТК Байкал-Сервис по шаблону	134	2022-03-14	t	2022-02-28 06:02:36.959+00	\N	103	f	\N
264	2	\N	15	2022-02-22 10:42:03.976943+00	Элмон	Саратов	351112	351112	Отгрузка ТК Байкал-Сервис по шаблону.	175	2022-04-05	f	2022-03-14 05:10:08.389+00	\N	129	f	\N
277	1	\N	15	2022-03-14 07:45:34.052491+00	Белтехвес	Минск	20865	\N	\N	03141	\N	f	\N	\N		f	\N
240	3	\N	16	2022-01-17 10:34:14.64507+00	Пауэрз	Великий Новгород	230928	\N	Упаковка в 2 ящика.\n\nОтгрузка ТК Байкал-Сервис по шаблону.\n\nПеред каждой отгрузкой необходимо направить УЛ, а также направлять копии УПД.\n\nГарантийный срок: 24 месяца со дня ввода механизма в эксплуатацию, но не более 30 месяцев с момента изготовления.\n\nСПЕЦИФИКАЦИЯ №44	35	2022-02-03	f	2022-01-19 11:54:32+00	2022-02-22 04:51:48.134+00	19	f	\N
224	3	\N	16	2021-12-22 05:15:59.760664+00	ХИМПРИБОР-1	Тула	723996	723996	Отгрузка ТК Байкал-Сервис по шаблону	798	2022-01-31	f	2021-12-28 06:10:42.354+00	2022-02-03 10:58:43.656+00	743	f	\N
238	3	\N	16	2022-01-17 10:09:52.656346+00	АО АМК	Барнаул	341754	341754	До терминала города Барнаул, ТК Деловые - линии. \nКонтактное лицо: Шуклин Олег Николаевич\nтел. +7(3852) 500-387	25	2022-02-10	f	2022-01-19 08:54:26+00	2022-02-23 11:22:46.224+00	27	f	\N
143	2	\N	15	2021-10-27 15:00:38.581185+00	Пауэрз	Великий-Новгорд	2400348	1200174	Требования по изготовлению: \n1)\tГарантия: 18 месяцев с даты ввода в эксплуатацию, но не более 24 месяцев со дня продажи.\n\nПеред каждой отгрузкой необходимо направить УЛ, а также направлять копии УПД.\n\nТребования по упаковке: \n1.\tОборудование будет отправляться в Казахстан и ждать монтажа в течение полугода.\n2.\tПриводы и арматура поставляются в сборе\n3.\tС каждым товарным местом Оборудования должны находиться упаковочный лист.\n4. Все руководства, паспорта и сертификаты на оборудование вложить в один из ящиков.	691	2022-02-28	f	2021-11-26 10:49:57.053+00	\N	696	f	\N
241	3	\N	16	2022-01-17 10:39:19.600868+00	Пауэрз	Великий Новгород	1311456	\N	Упаковка в 12 ящиков.\nГруз заберет водитель, доверенность во вложении.\n\nПеред каждой отгрузкой необходимо направить УЛ, а также направлять копии УПД.\n\nГарантийный срок: 24 месяца со дня ввода механизма в эксплуатацию, но не более 30 месяцев с момента изготовления.\n\nСПЕЦИФИКАЦИЯ №45	37	2022-03-04	f	2022-01-19 11:54:37+00	2022-03-03 10:27:42.011+00	21	f	\N
248	3	\N	16	2022-01-27 12:00:55.036786+00	ТД Сектор	Москва	82254	82254	Отгрузка транспортной компанией: «Деловые линии » до терминала г Москва(на который по умолчанию от нас приходит)\nДокументы отправить: «отдельно в конверте Деловыми линиями»\nГрузополучатель: ООО ТД СЕКТОР \nИНН 5044121121\nКонтактное лицо: Скопинов Дмитрий \n8926-474-17-67 , 8 (495) 772-36-85	66	2022-02-21	f	2022-01-28 05:39:59.299+00	2022-02-18 05:07:02.526+00	42	f	\N
257	3	\N	16	2022-02-15 05:41:17.475994+00	Спецнефтемаш	Пенза	87240	87240	Отправить ТК "Деловые Линии" до терминала в г.Пенза.\nДокументы - в конверте, как отдельная услуга.\nПолучатель: ООО "НПО "Спецнефтемаш" ИНН 5834061289\nПлательщик: ООО "НПО "Спецнефтемаш" ИНН 5834061289\nКонт. лицо: Акимов Михаил\nКонт. тел.: 89276492764\n	97	2022-02-28	f	2022-02-15 05:46:08.423+00	2022-02-28 04:31:35.137+00	74	f	\N
255	3	\N	15	2022-02-10 08:01:56.585941+00	Анкан Про	Минск	143500	143500	Отгрузить ТК КИТ, трек ЧЕБМИН0106870101	072011	2022-03-04	f	2022-02-17 05:56:23.71+00	2022-03-14 12:18:47.15+00	81	f	\N
223	3	\N	16	2021-12-17 07:24:21.034129+00	ООО Спецстандарт	Саратов	115561	115561	Упаковка в 1 ящик, \nОтгрузка ТК до терминала города Саратов,       \n( Деловые линии или ПЭК ) \nКонтактное лицо: \nБукин Вячеслав\nсот. +79271254501	374	2021-12-29	f	2021-12-17 11:14:17.871+00	2021-12-29 07:44:29.186+00	728	f	\N
217	3	\N	16	2021-12-16 12:32:40.239323+00	Пауэрз	Великий Новгород	75744	75744	Упаковка в 1 ящик.\n\nОтгрузка ТК Байкал-Сервис по шаблону.\n\nПеред каждой отгрузкой необходимо направить УЛ, а также направлять копии УПД.\n\nГарантийный срок: 24 месяца со дня ввода механизма в эксплуатацию, но не более 30 месяцев с момента изготовления.\n\nСПЕЦИФИКАЦИЯ №42	795	2022-01-18	f	2021-12-17 11:15:05.629+00	2022-01-19 16:06:51.003+00	730	f	\N
208	12	\N	15	2021-12-14 07:06:06.652399+00	Северная компания	СПБ	22680	22680	DKotrobay@nordcompany.ru\n\nАверин Сергей +79213230937	143	\N	f	\N	\N	\N	f	true,2022-01-25T06:03:44.913Z,null
177	12	\N	15	2021-11-22 08:45:32.062437+00	УК ИМПУЛЬС	Волгодонск	\N	\N	У нас возникла проблема с приводами МЭОФ-40.\n\nДело в том, что у привода не всегда совпадает фазировка двигателя соответствующим им клеммам.\n\nСвязи с этим получается не комфортная работа с их подключением.\n\nХотелось бы, чтобы вы в следующий раз проконтролировали этот момент.\n\n--\nC уважением, заместитель генерального директора УК ИМПУЛЬС, Яровой Сергей Владимирович\n\nТел./Tel. +7 8639 26-21-83, 27-81-40, Моб./Mobile Tel. +7-918-540-26-38\n\nhttp://www.zaoimpuls.ru\ne-mail: yarovoy@zaoimpuls.ru\n	\N	\N	f	\N	\N	\N	f	false,2021-12-16T15:38:00.645Z,2022-01-14T10:29:31.044Z
278	2	\N	16	2022-03-14 09:28:32.803661+00	ХИМПРИБОР - 1	Тула	1970532	1970532	Упаковка в 9 ящиков. \nОтгрузка ТК Байкал-Сервис по шаблону с доставкой до адреса  ул. Болдина 94	177	2022-05-16	f	2022-03-18 04:52:22.932+00	\N	138	f	\N
270	2	\N	15	2022-03-01 08:18:09.448917+00	Гарант Строй	Санкт-Петербург	3032120	3032120	\N	149	2022-05-05	f	2022-03-05 05:41:36.175+00	\N	\N	f	\N
265	3	\N	16	2022-02-24 06:44:15.262478+00	Эприр	Санкт_Петербург	306228	306228	ТК "Деловые Линии" до терминала г. Санкт-Петербург.\nОтгрузочные документы отправить с продукцией.\nПлательщик за транспортные расходы: АО «ЭПРИР», ИНН 7810434898\nГрузополучатель: АО «ЭПРИР», ИНН 7810434898\nКонтактное лицо: Александр, +7 (812) 448-47-08	128	2022-03-10	f	2022-02-24 07:06:00.734+00	2022-03-21 04:56:08.866+00	96	f	\N
186	13	\N	15	2021-11-25 12:30:50.700948+00	Белгидрохимресурс	Минск Гродненская СПМК-70	\N	\N	При пусконаладочных работах выявлен шум (предположительно металлический хруст)\n\nalekseychik71@mail.ru\nЗАО «Белгидрохимресурс»\nВалерий Алексейчик,\n	\N	\N	f	\N	2022-01-11 13:42:52.13+00	\N	f	\N
256	10	\N	15	2022-02-11 10:06:41.982577+00	Северная компания	Санкт-Петербург	\N	\N	Привод работает в режиме регулирования на шаровом кране. Отрубает 6А автомат. Происходит выгорание в момент включения или выключения хотя могло быть и совпадением.\nОбмотки эл. двигателя на корпус проверены мегаомметром - все в норме. Сколько их перезапускал таких приводов, первый раз с такой неисправностью. А какие-то за последнее время конструктивные изменения в таких эл.приводах были у вас?\n\nАверин Сергей +79213230937\n\nИнтересное КЗ, получается….На фото выгорели дорожки на плате, похоже на межфазное короткое замыкание…\nАвтомат защиты долго срабатывал, не успел отключить… Дорожки сработали как плавкие предохранители.\n \nК схеме управления конечно большие вопросы…  Впервые такую встречаем.\nРегулирующий привод на ПМЛах, одним переключателем и выбором режима АВТОМАТ/РУЧНОЕ и на нем же ОТР/ЗАКР…\n\nНе понятно что вызвало короткое замыкание.  Как давно работает привод? Сколько часов? Сейчас работает?\n\nПорядок действий:\n1) Отключить от платы и замерить сопротивление обмоток двигателя с1-с2, с2-с3, с1-с3. \n2) Произвести замер сопротивления изоляции мегаометром С1-корпус, С2- корпус, С3- корпус двигателя. \n3) Фото шкафа управления + пускателей\n4) Фото мультиметра в режиме замера междуфазного напряжения фаз А-Б, А-С, Б-С.	\N	\N	f	\N	\N	\N	f	true,2022-02-11T10:17:27.482Z,null
216	3	\N	16	2021-12-16 12:29:57.54711+00	Пауэрз	Великий Новгород	276384	276384	Упаковка в 3 ящика.\n\nОтгрузка ТК Байкал-Сервис по шаблону.\n\nПеред каждой отгрузкой необходимо направить УЛ, а также направлять копии УПД.\n\nГарантийный срок: 24 месяца со дня ввода механизма в эксплуатацию, но не более 30 месяцев с момента изготовления.\n\nСПЕЦИФИКАЦИЯ №41	794	2022-01-19	f	2021-12-17 11:15:25.952+00	2022-01-19 16:06:55.633+00	731	f	\N
261	2	\N	16	2022-02-18 06:13:03.544577+00	Пауэрз	Великий Новгород	116628	\N	Отгрузка ТК Байкал-Сервис по шаблону.\n\nПеред каждой отгрузкой необходимо направить УЛ, а также направлять копии УПД.\n\nГарантийный срок: 24 месяца со дня ввода механизма в эксплуатацию, но не более 30 месяцев с момента изготовления	121	2022-03-31	f	2022-02-21 06:55:31.15+00	\N	\N	f	\N
228	3	\N	15	2021-12-30 09:54:11.712262+00	АПА	Санкт-Петербург	99590	99590	Отгрузка ТК Байкал-Сервис по шаблону.	814	2022-01-24	f	2021-12-30 09:56:11.043+00	2022-01-25 12:33:06.093+00	1	f	\N
242	3	\N	16	2022-01-24 13:29:45.545626+00	Компенсатор Групп	Минск	63660	63660	Груз заберет водитель 16.02.22, доверительное письмо во вложении.\nУпаковка в 1 ящик.\nВес нетто: 35кг. брутто 47кг. 1 место	01191	2022-02-15	f	2022-01-26 05:39:17.056+00	2022-02-16 11:11:31.702+00	35	f	\N
258	3	\N	16	2022-02-16 05:47:54.243821+00	Химприбор-1	Тула	79020	79020	Отгрузка ТК Байкал-Сервис по шаблону с доставкой до адреса  ул. Болдина 94	83	2022-03-09	f	2022-02-16 05:50:22.72+00	2022-03-16 06:00:18.357+00	82	f	\N
279	2	\N	16	2022-03-14 16:10:32.450883+00	Компенсатор групп	Минск	63000	63000	\N	01194	2022-04-06	f	2022-03-16 06:00:08.253+00	\N	136	f	\N
126	3	\N	15	2021-10-07 06:55:01.539984+00	ОЗНА-Инжиниринг	Уфа	650448	650448	ТК “Деловые Линии ” до терминала г. Уфа.\nПлательщик:  ООО «НПП ОЗНА-Инжиниринг»\nГрузополучатель: ООО «НПП ОЗНА-Инжиниринг»\nКонтактное лицо: Корнилаев Евгений, моб. +7 917 79 583 81	640	2021-11-30	f	2021-10-08 15:15:50+00	2022-02-03 04:20:48.064+00	\N	f	\N
271	2	\N	16	2022-03-04 07:28:33.394718+00	Компенсатор Групп	Минск	109060	109060	\N	01193	2022-03-25	f	2022-03-04 07:33:05.518+00	\N	112	f	\N
225	3	\N	15	2021-12-22 11:02:27.857283+00	Учалинский ГОК	Учалы	486394	486394	Приложить сертификат на шлагбаум\n\nОтгрузить «Байкал-Сервис» до адреса в г. Учалы, ул. Горнозаводская, д.2\nГрузополучатель: АО «Учалинский ГОК» КПП №997550001\nПлательщик : ООО "ПЭК"\nКонтактное лицо: Шакиров Ринат Рафаилевич\nТел: +7 (34791) 9-52-03\ne-mail: shakirov_rr@ugok.ru 	807	2022-02-28	f	2021-12-30 11:26:39.239+00	2022-03-15 04:49:51.442+00	3	f	\N
272	2	\N	15	2022-03-04 12:05:59.304255+00	Автоматика-Инвест	Тула	453024	453024	Упаковка в 4 ящика.\n\nОтгрузить ТК «Деловые Линии» по адресу г. Тула, ул. Марата, 81\nОтгрузочные документы отправить с продукцией.\n\nПлательщик за транспортные расходы: ООО ПП "Автоматика-Инвест" ИНН 7106029348, КПП 71050100\n\nГрузополучатель: ООО ПП "Автоматика-Инвест" ИНН 7106029348, КПП 71050100\n\nКонтактное лицо: Астапова Наталья, nел. +7 (910) 16-16-700	159	2022-04-15	f	2022-03-04 12:09:52.515+00	\N	116	f	\N
205	3	\N	16	2021-12-13 05:29:15.497269+00	ПромАрм	Пенза	328350	328350	Упаковка в 4 ящика.\n\nОтгрузка ТК Байкал-Сервис по шаблону.	784	2022-01-18	f	2021-12-21 06:27:28.336+00	2022-01-18 14:36:16.101+00	733	f	\N
266	2	\N	16	2022-02-24 07:59:07.099407+00	Белгидрохимресурс	Минск	51980	51980	\N	02211	2022-03-14	t	2022-02-25 06:20:43.576+00	\N	104	f	\N
209	13	\N	15	2021-12-14 07:38:58.590329+00	Пугачевские молочные продукты	Пугачев	\N	\N	Отправить ТК Байкал-Сервис до г. Балаково \nГрузополучатель: ООО «Пугачевские молочные продукты» \nПлательщик: ООО «Пугачевские молочные продукты» \nКонт. лицо: +7 8452754499, Александр Уткин a.utkin@pmpmilk.ru\n\nПриложить УПД и Договор	\N	\N	f	\N	2022-01-14 10:28:45.156+00	\N	f	false,2021-12-27T14:27:21.023Z,2022-01-12T12:31:55.590Z
233	3	\N	16	2022-01-13 13:15:05.0306+00	Пауэрз	Великий Новгород	80952	80952	Упаковка в 1 ящик.\n\nОтгрузка ТК Байкал-Сервис\n\nПеред каждой отгрузкой необходимо направить УЛ, а также направлять копии УПД.\n\nГарантийный срок: 24 месяца со дня ввода механизма в эксплуатацию, но не более 30 месяцев с момента изготовления.\n\nСПЕЦИФИКАЦИЯ №43	16	2022-01-29	f	2022-01-14 05:29:49.656+00	2022-03-04 15:17:06.414+00	14	f	\N
249	3	\N	15	2022-01-31 13:32:06.083675+00	АПА	Санкт-Петербург	70152	70152	Упаковка в ящик\nОтгрузка ТК Байкал-Сервис по шаблону.\n	72	2022-02-24	f	2022-02-07 06:58:51.663+00	2022-03-21 04:55:40.364+00	54	f	\N
262	2	\N	16	2022-02-22 05:25:14.575784+00	НЕОТЕХ	Иркутск	273312	273312	Отгрузка ТК ПЭК, до терминала города Иркутск. \nКонтактное лицо: Жаркова Вероника\nтел. +7(904)127-42-61	115	2022-03-14	f	2022-02-22 05:27:51.102+00	\N	95	f	\N
243	13	\N	15	2022-01-25 05:07:37.657458+00	Промтехнологии	Выкса	2640	2640	Отгрузить ТК “ПЭК” до терминала г. Выкса (Нижегородская обл.).\nОтгрузочные документы отправить с продукцией.\nПлательщик за транспортные расходы: ООО "НПО "Промтехнологии" ИНН 5247055548\nГрузополучатель: ООО "НПО "Промтехнологии" \nКонтактное лицо: +79867645750 Максим	59	\N	f	\N	2022-02-10 16:23:31.766+00	\N	f	true,2022-01-25T05:12:09.084Z,null
66	3	\N	15	2021-08-30 06:10:31.224504+00	ООО Пауэрз	Великий Новгород	1835004	1835004	Требования по изготовлению: \n1)\tГарантия: 18 месяцев с даты ввода в эксплуатацию, но не более 24 месяцев со дня продажи.\n\nТребования по упаковке: \n1.\tОборудование будет отправляться в Казахстан и ждать монтажа в течение полугода.\n2.\tПриводы и арматура поставляются в сборе\n3.\tС каждым товарным местом Оборудования должны находиться упаковочный лист.\n4. Все руководства, паспорта и сертификаты на оборудование вложить в один из ящиков.\n	497	2021-11-26	f	\N	2021-12-06 05:40:23.928+00	\N	f	\N
259	3	\N	15	2022-02-17 06:00:01.92531+00	Элмон	Саратов	49032	49032	Отгрузка ТК Байкал-Сервис по шаблону.\n\nЗаменить 1 страничку РЭ на маркировку МЭОФ-15/30-0,25М-98К	112	2022-03-04	f	2022-02-18 06:09:45.06+00	2022-03-16 06:53:03.683+00	88	f	\N
206	3	\N	15	2021-12-13 06:35:08.842138+00	АСК Палюр	Пермь	487248	487248	Отгрузить ТК «Байкал-сервис» или «Деловые Линии» до терминала г. Пермь.\nОтгрузочные документы отправить с продукцией.\nПлательщик за транспортные расходы: ООО «АСК «Палюр» ИНН 5902883152\nГрузополучатель: ООО «АСК «Палюр» ИНН 5902883152\nКонтактное лицо: +7 (342) 259-32-00 Валентина	785	2022-01-31	f	2021-12-22 15:11:18.13+00	2022-03-17 04:49:27.12+00	\N	f	\N
263	1	\N	15	2022-02-22 07:00:20.632074+00	ОЗНА-Инжиниринг	Уфа	3319392	\N	\N	\N	\N	f	\N	\N	\N	f	\N
267	2	\N	16	2022-02-24 08:07:35.750057+00	ПромАрм	Пенза	236370	236370	Отгрузка ТК Байкал-Сервис по шаблону.	124	2022-04-11	t	2022-03-05 06:06:47.634+00	\N	\N	f	\N
183	13	\N	\N	2021-11-23 16:34:10.538433+00	ПАО Северсталь	Череповец	\N	\N	У нас возникла аварийная ситуация на оборудовании на РОУ-2 смонтированного в рамках ИМ 107.1102 Увеличение вакуумного металла.\nВышел из строя регулятор давления – остановился в открытом (20%) положении Клапана регулирующего 18с-5-4Э-01 с электроприводом ПЭМ-Б5У.\nДля определения причин неисправности нами был демонтирован привод с регулирующего клапана. После демонтажа выяснилось что привод заклинен по механической части – не проворачивается от ручного привода. Данный привод был нами закуплен взамен вышедшего из строя.\n\nС уважением, Надежда\n\nНадежда Чиркова 	\N	\N	f	\N	2022-01-11 13:42:57.872+00	\N	f	false,2021-11-30T07:56:33.919Z,2021-11-30T07:56:40.657Z
235	3	\N	15	2022-01-17 08:36:41.046548+00	ТД НефтекамскСтрой	Нефтекамск	59083	59083	Отгрузка ТК Байкал-Сервис по шаблону с доставкой до адреса: Башкортостан Респ, Нефтекамск г, Автозаводская (ул), владение № 1, строение 5/1	30	2022-02-14	f	2022-01-26 06:17:06.018+00	2022-02-23 05:32:12.837+00	37	f	\N
234	3	\N	16	2022-01-13 13:27:27.018523+00	НЕОТЕХ	Иркутск	213744	213744	Отгрузка ТК ПЭК, до терминала города Иркутск. \nКонтактное лицо: Жаркова Вероника\nтел. +7(904)127-42-61	14	2022-02-12	f	2022-01-24 06:57:47.929+00	2022-02-23 11:23:15.952+00	30	f	\N
178	11	\N	18	2021-11-22 08:52:02.234591+00	БКЗ Флейм	Барнаул, СПБ	\N	\N	Плохо. Многие заказы из-за этого мимо вас проходят. Стандартная гарантия уже никого не удовлетворяет. Только если мелкие Почти во всех крупных проекта 24/36 мес минимальное требование. А бывает и дольше - 48/60 доходит.\nПроработайте этот вопрос с руководством.\nС уважением, Новокрещенов Анатолий\nменеджер отдела закупок\nООО "Барнаульский котельный завод"\nг. Барнаул, пр-т Космонавтов 6Э\nтел: 8(3852)37-96-08\nмоб: 8-913-021-2428\n	\N	\N	f	\N	\N	\N	f	\N
260	3	\N	15	2022-02-17 08:21:47.194946+00	АСЭ	Островец (РБ)	14215	14215	Оплата на карту Сбербанк\nОтгрузка DPD от частного лица	\N	2022-02-17	f	2022-02-17 08:24:33.075+00	2022-02-18 05:06:20.982+00	\N	f	\N
215	3	\N	16	2021-12-16 12:28:16.015667+00	Пауэрз	Великий Новгород	431934	431934	Упаковка в 5 ящиков.\n\nОтгрузка ТК Байкал-Сервис по шаблону.\n\nПеред каждой отгрузкой необходимо направить УЛ, а также направлять копии УПД.\n\nГарантийный срок: 24 месяца со дня ввода механизма в эксплуатацию, но не более 30 месяцев с момента изготовления.\n\nСПЕЦИФИКАЦИЯ №40\n	793	2022-01-21	f	2021-12-17 11:18:32.33+00	2022-01-19 16:06:59.237+00	732	f	\N
250	2	\N	15	2022-02-01 06:58:36.109+00	Акмай АО	Альметьевск	106080	53040	Отгрузить ТК “ Деловые Линии” до терминала г. Альметьевск\nОтгрузочные документы отправить с грузом\nПлательщик:  АО "АКМАЙ"\nГрузополучатель: АО "АКМАЙ"\nКонтактное лицо: Сахуриев Сергей +7 (8553) 37-10-70	79	2022-04-08	f	2022-02-17 05:48:48.75+00	\N	83	f	\N
281	2	\N	15	2022-03-15 06:59:07.987216+00	Элмон	Саратов	67950	67950	\N	178	2022-04-14	f	2022-03-15 07:00:17.472+00	\N	133	f	\N
185	3	\N	16	2021-11-25 06:05:54.647983+00	АО Эприр	Санкт-Петербург	70032	70032	ТК "Деловые Линии" до терминала г. Санкт-Петербург.\nОтгрузочные документы отправить с продукцией.\nПлательщик за транспортные расходы: АО «ЭПРИР», ИНН 7810434898\nГрузополучатель: АО «ЭПРИР», ИНН 7810434898\nКонтактное лицо: Александр, +7 (812) 448-47-08	637	2021-12-10	f	2021-11-25 07:32:22.108+00	2021-12-13 04:12:09.986+00	693	f	\N
171	3	\N	16	2021-11-15 09:21:56.505871+00	Химприбор-1	Тула	36822	36822	Отгрузка ТК Байкал-Сервис по шаблону	715	2021-11-29	f	2021-11-16 05:47:46.343+00	2021-11-24 06:38:44.105+00	664	f	\N
164	3	\N	15	2021-11-10 17:13:22.236979+00	Камышинский опытный завод	Камышин	102660	102660	Отгрузить ТК «Деловые линии» до терминала в г.Камышин\nГрузополучатель: ООО "Камышинский опытный завод"\nПлательщик: ООО "Камышинский опытный завод"\nКонтактное лицо: Федотов Дмитрий\nТел.:  +7 (8442) 96-86-93 (доб.46)	680	2021-11-30	f	2021-11-10 17:24:15.501+00	2021-12-29 07:43:41.673+00	646	f	false,2021-11-12T09:06:12.830Z,2021-11-12T09:06:14.080Z
161	3	\N	15	2021-11-08 16:07:57.233567+00	Мелстон-Сервис	Москва	16176	16176	Отгрузить ТК СДЭК или Деловые Линии до адреса г. Москва, Варшавское шоссе, 125 Ж стр.1 \nГрузополучатель: ООО "Мелстон-Сервис" \nПлательщик: ООО "ПЭК" \n+7 926 533-38-29 Алексей	704	2021-11-29	f	2021-11-16 05:46:56.755+00	2021-11-24 06:45:16.395+00	663	f	\N
187	12	\N	15	2021-11-26 08:51:58.759189+00	Акмай	Альметьевск	\N	\N	\N	\N	2021-12-24	f	\N	\N	\N	f	false,2021-11-30T20:02:08.541Z,2021-11-30T20:02:19.023Z
139	2	\N	15	2021-10-25 16:57:35.81354+00	ТД ПремиумАРМ	Нижний-Новгород	14916	14916	Отгрузить ТК «Байкал-сервис» до терминала г. Нижний-Новгород.\nПлательщик: ООО ТД «ПремиумАРМ» \nГрузополучатель: ООО ТД «ПремиумАРМ» \nКонтактное лицо: Гилядова Дарья, +7(831)2-147-047	678	2021-11-09	t	2021-10-27 10:45:35+00	2021-12-22 01:23:54.707+00	627	f	false,2021-12-22T01:32:02.399Z,2021-12-22T01:32:02.983Z
213	13	\N	\N	2021-12-16 05:31:42.656941+00	СОЮЗ-01	Москва	\N	\N	\N	\N	\N	f	\N	2022-01-11 13:43:04.088+00	\N	f	false,2021-12-16T05:35:26.919Z,2021-12-27T09:56:28.826Z
176	3	\N	15	2021-11-22 06:41:19.316221+00	ИП Пикуза	Минск	149580	149580	Паспорта на привод и кран положить вместе с документами.\n\nОтгрузить на Главдоставкой по треку ЧБК-МНС-11282/22 от 18.01.2022	08122	2021-12-13	f	2021-11-23 16:06:39.826+00	2022-01-19 16:08:06.647+00	687	f	\N
282	2	\N	16	2022-03-17 06:09:30.252621+00	АО Полимер-Аппарат	Санкт-Петербург	349824	349824	\N	191	2022-04-18	f	2022-03-17 06:18:59.453+00	\N	137	f	\N
251	3	\N	16	2022-02-02 06:48:45.340542+00	ООО АБО Арматура	Смоленск	123240	123240	Отгрузка ТК Байкал-Сервис по шаблону	81	2022-02-16	f	2022-02-02 06:51:38.171+00	2022-02-23 11:23:09.552+00	49	f	\N
179	2	\N	16	2021-11-22 13:12:16.14678+00	Эприр	Санкт-Петербург	360888	360888	\N	179	2022-04-04	f	2022-03-11 11:00:09.287+00	\N	128	f	\N
274	2	\N	16	2022-03-09 05:45:26.253457+00	Рутем	Москва	35670	35670	Отгрузка транспортной компанией «Деловые линии» до адреса.\nАдрес: г. Москва, Строительный проезд д.10\nКонтактное лицо: Чехонацкий Владислав +79015234987\n	162	2022-03-23	t	2022-03-09 07:39:49.11+00	\N	120	f	\N
175	3	\N	15	2021-11-19 05:12:06.035449+00	Альфа	Челябинск	7200	7200	Отгрузить ТК «Байкал-Сервис» до терминала г. Челябинск\nГрузополучатель: ООО «Альфа», ИНН 7447267712\nПлательщик: ООО «Альфа», ИНН 7447267712\nКонтактное лицо: Виталий,  +7 922-710-31-79	732	2021-11-19	f	2021-11-19 05:14:33.707+00	2021-11-20 20:18:43.153+00	\N	f	\N
182	3	\N	15	2021-11-23 06:51:18.190019+00	ВОДОУЗЕЛ СПб	Санкт-Петербург	166308	166308	Отгрузка ТК Байкал-Сервис до терминала «Парнас» г. Санкт-Петербург.\nГрузополучатель: ООО "ВОДОУЗЕЛ СПб" \nПлательщик: ООО "ВОДОУЗЕЛ СПб" \nКорягин Сергей Владимирович тел. +7(901) 970-76-06\n\n	742	2021-12-09	f	2021-11-23 16:10:09.94+00	2021-12-09 13:47:26.402+00	689	f	\N
173	3	\N	16	2021-11-15 09:39:35.002535+00	АБО Арматура	Смоленск	152322	152322	\N	714	2021-11-30	f	2021-11-16 05:52:54.829+00	2021-11-26 12:47:33.199+00	665	f	\N
162	3	\N	16	2021-11-08 17:34:08.576244+00	Синклит	Екатеринбург	208926	208926	Отгрузка ТК Байкал-Сервис по шаблону	700	2021-11-23	f	2021-11-09 07:28:35.753+00	2021-11-25 11:24:23.622+00	643	f	\N
165	3	\N	16	2021-11-11 06:50:51.504619+00	АБО Арматура	Смоленск	270288	270288	Отгрузка ТК Байкал-Сервис по шаблону	711	2021-11-25	f	2021-11-11 07:30:41.522+00	2021-11-26 12:47:23.234+00	650	f	\N
169	3	\N	15	2021-11-12 11:24:59.050129+00	АПА	Санкт-Петербург	292968	292968	Отгрузка ТК Байкал-Сервис по шаблону	725	2021-11-26	f	2021-11-15 09:22:50.596+00	2021-11-25 08:43:36.752+00		f	\N
174	12	\N	15	2021-11-16 07:28:48.752291+00	Флейм	Волжский	6180	\N	Отправить плату СДЭКом до адреса г. Волжский, 7я Автодорога, Волжская ТЭЦ Получатель: Крестин Сергей  тел.+7 922 140 27 56	\N	2021-11-16	f	\N	\N	\N	f	false,2021-11-30T20:01:57.925Z,2021-11-30T20:01:58.558Z
146	3	\N	15	2021-10-28 08:29:36.578953+00	ОМЗ Прогресс	Саратов	56202	56202	Отгрузка ТК Байкал-Сервис до терминала г. Волжский\nОтправить скан на электронный адрес - semynin.a.d@emk.ru и почтой по адресу: 410017, г. Саратов, а/я 1382 с пометкой для “ОМЗ Прогресс” \nС грузом отправить нулевую накладную.\nПлательщик: ООО "ОМЗ "Прогресс"\nПлательщик за доставку: ООО "ОМЗ "Прогресс"\nГрузополучатель: Волжский филиал АО "Гидроремонт-ВКК" в г. Волжский, ИНН 6345012488, 404130, Волгоградская обл, Волжский г, Ленина пр-кт, дом № 1А\nКонтактное лицо: Шишляников Станислав , 8 (961) 068-5843	693	2021-12-01	f	2021-11-15 12:34:28.349+00	2021-11-26 12:47:27.867+00	670	f	false,2021-11-23T20:38:43.673Z,2021-11-23T20:38:44.539Z
181	3	\N	15	2021-11-23 06:23:35.882143+00	АПА	Санкт-Петербург	19314	19314	Отгрузка ТК Байкал-Сервис по шаблону.\nУпаковка в ящик	739	2021-12-07	f	2021-11-23 06:26:20.535+00	2021-12-07 10:26:32.618+00	684	f	\N
194	3	\N	16	2021-12-08 09:55:34.037403+00	Пауэрз	Великий Новгород	1268736	1268736	Гарантийный срок: 24 месяца со дня ввода механизма в эксплуатацию, но не более 30 месяцев с момента изготовления.	772.773	2021-12-29	f	2021-12-08 10:36:55.353+00	2021-12-28 04:30:07.798+00	714	f	false,2021-12-25T07:10:33.255Z,2021-12-25T07:10:35.832Z
244	2	\N	15	2022-01-26 12:20:27.890145+00	УДС нефть - Ялыкское	Ижевск 	596929	298464	Отгрузка ТК Байкал-Сервис до адреса: г. Ижевск, ул. Пойма, 9\nГрузополучатель: ООО «Ялыкское», ИНН 1840042520, КПП 184001001\nПлательщик: ООО "ПЭК" (включено в стоимость)\n\nТел.: (3412) 998-000 доб.3216 \nе-mail: d.berestov@uds18.ru\n	47	2022-04-25	f	2022-02-25 06:09:12.355+00	\N	99	f	\N
189	3	\N	15	2021-12-01 10:17:08.104746+00	ВНИПЭ	Москва	418068	418068	ТК Деловые Линии до адреса Московская область, г. Лыткарино, потребительский садоводческий кооператив Василёк, 33\n\nОтгрузочные документы отправить с продукцией.\n\nПлательщик за транспортные расходы: ООО "ВНИПЭ" ИНН 7727712035\n\nГрузополучатель: ООО "ВНИПЭ" ИНН 7727712035\n\nКонтактное лицо: Казанов Сергей: +7-925-270-05-09\n	789	2022-02-10	f	2021-12-16 07:47:51.575+00	2022-02-18 05:06:04.804+00	726	f	\N
191	3	\N	16	2021-12-06 06:10:04.190645+00	Компенсатор Групп	Минск	133500	133500	Груз заберет водитель 22.12.21, скан паспорта и доверительное письмо во вложении.	082610	2021-12-20	f	2021-12-06 09:17:17+00	2021-12-22 11:10:35.858+00	708	f	\N
195	3	\N	15	2021-12-08 10:19:16.594863+00	Промарм	Пенза	25440	25440	Отгрузить ТК ДЛ или Байкал-Сервис до терминала в г. Пенза\n\nКонтактное лицо: Подопригора Ирина, тел. (8412) 35-07-97	770	2021-12-17	f	2021-12-08 13:22:15+00	2021-12-20 12:30:00.232+00	713	f	\N
252	3	\N	16	2022-02-08 11:11:57.450125+00	Компенсатор групп	Минск	90000	90000	Упаковка в 1 ящик.\nВес нетто: 28кг. брутто 40кг. 1 место	01192	2022-02-25	f	2022-02-11 05:31:33.969+00	2022-02-25 05:37:18.447+00	66	f	\N
119	3	\N	15	2021-10-04 11:53:07.010272+00	АСК Палюр	Пермь	544104	544104	Упаковка в 3 ящика\n\nОтгрузить ТК «Байкал-сервис» или «Деловые Линии» до терминала г. Пермь по шаблону \n\nОтгрузочные документы отправить с продукцией.\nПлательщик за транспортные расходы: ООО «АСК «Палюр» ИНН 5902883152\nГрузополучатель: ООО «АСК «Палюр» ИНН 5902883152\nКонтактное лицо: +7 (342) 259-32-00 Валентина	639	2022-01-24	f	2021-12-07 11:34:58+00	2022-01-25 12:33:12.546+00	737	f	\N
188	13	\N	15	2021-11-30 07:52:45.371612+00	Газпромнефть - Энергосервис	Челябинск Шагол	128388	128388	Отгрузить ТК Деловые Линии до адреса г. Челябинск ул. Бурденюка д.30\nПлательщик за транспортные расходы: ООО "ПЭК"\nГрузополучатель: ООО "ГАЗПРОМНЕФТЬ - ЭНЕРГОСЕРВИС"\nКонтактное лицо: +7 (912) 777-44-02, Дмитриенко А.В.\n\nДобрый день!\nВ описании дефектов указано о неверной настройке концевиков, что не совсем так!\nЗамятия выходного вала, а также пластины механического ограничителя, происходят по причине разности давлений на входе и выходе задвижки, в итоге проворачивает вокруг своей оси шток задвижки, что и влечёт за собой указанные последствия.\nВо вложении фото штока задвижки…\n\nМихаил, прошу Вас исключить из дефектного акта следующие строки: «Неверная настройка крайних положения (согласно РЭ п. 2.4.5 – не обеспечен запас 3-5 %\nДо механического упора, т.е привод выходит на упор раньше срабатывания концевого выключателя).\n\n\nС уважением,\n\nДмитриенко Александр Владимирович\nИнженер по АСУ ТП\n\nООО "ГАЗПРОМНЕФТЬ-ЭНЕРГОСЕРВИС"\nПО «Санкт-Петербург»\nРоссия, г. Челябинск,  Бурденюка 30, \nТелефон: 8(351) 216-01-00, (064)6316\nСот. телефон: 8 912 777-44-02\nDmitrienko.AVL@gazprom-neft.ru\naero-shagol@gazprom-neft.ru\n\n	\N	\N	f	\N	2022-01-27 09:46:09.787+00	\N	f	true,2021-11-30T07:56:05.692Z,null
190	3	\N	15	2021-12-01 11:04:13.409826+00	САЗ	Саратов	135792	136792	Отгрузка ТК Байкал-Сервис до терминала г. Документы с грузом\nПлательщик за доставку: ЗАО «Саратовский арматурный завод»\nГрузополучатель: ЗАО «Саратовский арматурный завод»\nКонтактное лицо: Варламов Алексей, 8 8452 45-44-33 доб.1477	768	2022-01-11	f	2021-12-08 10:19:12.656+00	2022-02-25 11:58:47.267+00	715	f	\N
275	2	\N	16	2022-03-10 06:42:55.672972+00	АнканПро	Минск	129765	129765	Отгрузка ТК Кит	072012	2022-03-30	t	2022-03-10 06:46:29.266+00	\N	121	f	\N
214	3	\N	16	2021-12-16 06:49:53.994887+00	ТД Сектор	Москва	81054	81054	Отгрузка транспортной компанией: «Деловые линии » до терминала г Москва(на который по умолчанию от нас приходит)\nДокументы отправить: «отдельно в конверте Деловыми линиями»\nГрузополучатель: ООО ТД СЕКТОР \nИНН 5044121121\nКонтактное лицо: Скопинов Дмитрий \n8926-474-17-67 , 8 (495) 772-36-85\n	786	2021-12-27	f	2021-12-16 10:46:58+00	2022-01-17 10:47:47.097+00	725	f	\N
237	3	\N	15	2022-01-17 08:38:48.888311+00	ЗАО Химприбор-1	Тула	36540	36540	Отгрузка ТК Байкал-Сервис по шаблону	21	2022-02-04	f	2022-01-24 10:05:17+00	2022-02-04 07:07:13.21+00	29	f	\N
197	10	\N	\N	2021-12-09 09:38:38.568749+00	АО "СКБК"	СПБ	\N	\N	\N	\N	\N	f	\N	\N	\N	f	false,2021-12-09T09:39:28.007Z,2021-12-09T09:39:31.446Z
192	3	\N	16	2021-12-06 06:14:12.836005+00	Компенсатор Групп	Минск	245254	245254	Груз заберет водитель 09.02.22, доверительное письмо во вложении.\nУпаковка в 2 ящика.\nВес нетто: 92кг. брутто 125кг. 2 места	082611	2022-02-03	f	2022-01-13 13:08:44.86+00	2022-02-10 07:13:18.433+00	10	f	\N
170	3	\N	15	2021-11-12 11:27:06.760424+00	Водоканал города Рязани	Рязань	1348512	1348512	Отгрузка ТК Байкал-Сервис до адреса: г. Рязань, Касимовское шоссе, д.9\nГрузополучатель: МП «Водоканал города Рязани», ИНН 6227004811   КПП 623401001\nПлательщик: ООО "ПЭК"\nТел.: 8 (4912) 45-33-20\ne-mail: vodokanal-torgi@mail.ru\n\nКонтактное лицо: 8 (4912) 45-34-40 Алексей\n\n	\N	2021-12-29	f	2021-11-22 12:03:23.85+00	2022-02-24 05:08:48.12+00	690	f	\N
236	3	\N	15	2022-01-17 08:37:54.906279+00	ЖБК №9	Чебоксары	27258	27258	\N	26	2022-02-09	f	2022-01-19 08:54:19+00	2022-02-16 08:14:06.461+00	20	f	\N
283	2	\N	15	2022-03-21 06:34:45.625741+00	Палюр	Пермь	1117164	1117164	\N	194	\N	f	2022-03-21 06:36:25.266+00	\N	\N	f	\N
\.


--
-- Data for Name: PaymentHistory; Type: TABLE DATA; Schema: erp; Owner: postgres
--

COPY erp."PaymentHistory" ("OrderID", "Date", "PaidAmount", "ID") FROM stdin;
99	2021-10-19 05:50:12.845+00	251616	20
107	2021-10-20 09:19:35.021+00	237210	21
76	2021-10-20 09:23:40.978+00	628385	22
76	2021-10-21 09:39:18.389+00	728385	23
76	2021-10-22 05:57:23.262+00	856770	24
137	2021-10-25 16:18:55.985+00	22608	25
90	2021-10-26 07:04:09.773+00	104280	26
105	2021-10-27 05:55:36.38+00	149472	27
139	2021-10-27 06:53:38.665+00	14916	28
133	2021-10-27 07:16:06.449+00	327070	29
138	2021-10-27 07:16:51.956+00	132900	30
142	2021-10-27 15:00:29.812+00	60480	31
89	2021-10-28 07:18:33.54+00	890016	32
108	2021-10-29 06:36:52.597+00	142920	35
140	2021-11-01 08:02:09.961+00	49980	36
162	2021-11-09 07:28:13.236+00	104463	37
141	2021-11-09 07:29:01.157+00	49160	38
88	2021-11-09 07:29:35.891+00	3461040	39
140	2021-11-10 16:14:02.694+00	99960	40
164	2021-11-10 17:23:18.797+00	51330	41
165	2021-11-11 06:59:34.633+00	135144	42
151	2021-11-11 10:03:51.883+00	142824	43
92	2021-11-12 06:31:17.228+00	416940	44
106	2021-11-15 09:17:45.065+00	184745	45
169	2021-11-15 09:20:38.869+00	146484	46
161	2021-11-16 05:41:41.255+00	16176	47
171	2021-11-16 05:47:32.163+00	36822	48
173	2021-11-16 05:50:44.422+00	76161	49
106	2021-11-16 06:06:41.441+00	184744	50
106	2021-11-17 04:48:02.469+00	196725	51
175	2021-11-19 05:15:06.811+00	7200	52
180	2021-11-22 13:41:35.932+00	64524	53
181	2021-11-23 06:27:09.831+00	9657	54
146	2021-11-23 07:06:07.61+00	56202	55
182	2021-11-23 12:10:26.971+00	83154	56
176	2021-11-23 12:11:20.861+00	74790	57
173	2021-11-24 07:16:20.43+00	152322	58
66	2021-11-24 07:18:13.306+00	917502	59
143	2021-11-24 07:18:50.612+00	600087	60
169	2021-11-24 10:57:23.92+00	292968	61
162	2021-11-24 11:29:19.27+00	208926	62
185	2021-11-25 06:08:04.397+00	70032	63
142	2021-11-25 08:02:11.725+00	0	64
165	2021-11-25 11:23:14.616+00	270288	65
147	2021-11-29 07:45:56.885+00	491700	66
147	2021-11-29 07:46:03.845+00	491700	67
107	2021-11-30 07:19:37.587+00	474420	68
95	2021-12-01 07:00:54.045+00	2909691	69
95	2021-12-01 07:01:12.45+00	2909691	70
191	2021-12-06 06:14:06.33+00	66750	71
181	2021-12-07 05:34:44.748+00	19314	72
194	2021-12-08 10:16:58.225+00	0	73
190	2021-12-08 10:17:16.123+00	67896	74
195	2021-12-08 10:21:50.899+00	12720	75
182	2021-12-09 03:32:29.006+00	166308	76
157	2021-12-09 11:04:14.305+00	236844	77
180	2021-12-10 05:29:45.934+00	129048	78
109	2021-12-10 05:34:01.425+00	66175	79
110	2021-12-13 04:54:11.357+00	137894	80
147	2021-12-13 06:08:36.903+00	983400	81
172	2021-12-14 05:53:34.269+00	201312	82
207	2021-12-14 06:10:44.341+00	41640	83
207	2021-12-14 06:10:55.973+00	41640	84
189	2021-12-16 06:55:49.09+00	418068	85
214	2021-12-16 07:03:49.814+00	81054	86
214	2021-12-16 07:12:46.532+00	81054	87
164	2021-12-17 06:23:50.596+00	102660	88
223	2021-12-17 07:28:49.62+00	115561	89
195	2021-12-20 13:15:30.663+00	25440	90
205	2021-12-21 06:27:24.309+00	164175	91
191	2021-12-21 08:00:21.177+00	133500	92
139	2021-12-22 01:32:39.593+00	0	93
139	2021-12-22 01:32:43.381+00	14916	94
139	2021-12-22 01:32:52.149+00	0	95
139	2021-12-22 01:32:55.512+00	14916	96
142	2021-12-22 07:10:56.692+00	60480	97
119	2021-12-22 15:08:05.284+00	272052	98
206	2021-12-22 15:11:24.408+00	243624	99
88	2021-12-23 13:31:16.192+00	6922080	100
205	2021-12-24 07:33:59.116+00	328350	101
224	2021-12-28 06:10:19.246+00	361998	102
188	2021-12-28 06:21:49.282+00	64194	103
228	2021-12-30 09:55:35.113+00	99590	104
228	2021-12-30 09:55:48.639+00	49795	105
225	2022-01-10 05:55:31.11+00	243197	106
192	2022-01-12 06:46:12.772+00	122627	107
176	2022-01-18 06:01:20.853+00	149580	108
238	2022-01-18 06:28:21.138+00	170877	109
188	2022-01-18 06:59:20.843+00	128388	110
236	2022-01-19 05:50:58.339+00	27258	111
234	2022-01-24 06:00:17.629+00	106872	112
239	2022-01-24 07:01:49.709+00	36540	113
237	2022-01-24 07:04:22.289+00	36540	114
239	2022-01-24 07:05:02.181+00	0	115
228	2022-01-24 12:12:30.525+00	99590	116
119	2022-01-24 12:12:49.637+00	544104	117
242	2022-01-24 13:31:02.063+00	63660	118
242	2022-01-24 13:31:37.767+00	0	119
242	2022-01-26 05:39:06.299+00	31830	120
235	2022-01-26 06:16:00.656+00	59083	121
239	2022-01-27 06:54:00.543+00	38808	122
243	2022-01-27 09:01:42.584+00	2640	123
245	2022-01-28 05:29:51.282+00	155646	124
248	2022-01-28 05:34:07.071+00	82254	125
126	2022-01-31 06:06:11.641+00	650448	126
251	2022-02-02 06:51:07.742+00	61200	127
246	2022-02-03 05:46:12.706+00	81864	128
192	2022-02-03 05:51:50.234+00	245254	129
66	2022-02-04 05:39:38.245+00	1835004	130
224	2022-02-04 07:08:35.151+00	723996	131
249	2022-02-07 05:54:54.97+00	35376	132
253	2022-02-09 05:32:05.963+00	110151	133
247	2022-02-09 07:38:29.58+00	100000	134
252	2022-02-11 05:30:28.883+00	45000	135
247	2022-02-11 06:16:11.518+00	200000	136
257	2022-02-15 05:46:02.191+00	43620	137
242	2022-02-16 05:21:53.295+00	63660	138
239	2022-02-16 05:44:12.509+00	77616	139
234	2022-02-16 05:45:11.972+00	213744	140
258	2022-02-16 05:50:06.143+00	79020	141
247	2022-02-16 07:12:57+00	300000	142
245	2022-02-17 05:13:21.25+00	311292	143
250	2022-02-17 05:47:45.242+00	53040	144
255	2022-02-17 05:56:18.347+00	143500	145
260	2022-02-17 08:23:47.376+00	14215	146
259	2022-02-18 06:09:48.529+00	49032	147
215	2022-02-18 06:10:40.326+00	431934	148
194	2022-02-21 06:02:15.562+00	1268736	149
216	2022-02-21 06:03:09.37+00	276384	150
246	2022-02-21 06:03:23.5+00	163728	151
217	2022-02-21 06:03:29.913+00	75744	152
136	2022-02-21 06:03:59.353+00	218040	153
238	2022-02-22 05:23:01.092+00	341754	154
251	2022-02-22 05:23:44.204+00	123240	155
262	2022-02-22 05:27:31.117+00	136656	156
252	2022-02-24 06:16:12.38+00	90000	157
190	2022-02-24 06:39:27.243+00	136792	158
265	2022-02-24 07:05:47.894+00	153114	159
244	2022-02-25 06:09:05.388+00	298464	160
143	2022-02-25 06:16:53.18+00	1200174	161
266	2022-02-25 06:20:40.427+00	51980	162
268	2022-02-25 06:32:03.074+00	31300	163
257	2022-02-25 06:35:16.58+00	87240	164
253	2022-02-25 06:54:42.15+00	220302	165
269	2022-02-28 06:01:30.233+00	50490	166
233	2022-03-02 06:24:18.382+00	80952	167
100	2022-03-04 06:33:27.525+00	107736	168
271	2022-03-04 07:32:43.914+00	109060	169
272	2022-03-04 12:08:33.5+00	450144	170
100	2022-03-05 05:35:36.437+00	214872	171
272	2022-03-05 05:37:32.581+00	453024	172
270	2022-03-05 05:43:16.767+00	3032120	173
267	2022-03-05 06:04:44.394+00	236370	174
208	2022-03-09 05:24:25.655+00	22680	176
247	2022-03-09 05:27:58.164+00	601008	177
274	2022-03-09 05:53:36.333+00	35670	178
275	2022-03-10 06:46:04.11+00	129765	179
276	2022-03-10 06:59:05.865+00	45056	180
225	2022-03-10 07:02:00.547+00	486394	181
265	2022-03-10 07:14:10.1+00	306228	182
262	2022-03-11 05:01:23.232+00	273312	183
179	2022-03-11 10:59:58.659+00	360888	185
276	2022-03-14 05:07:05.773+00	45776	186
269	2022-03-14 05:08:00.065+00	100980	187
249	2022-03-14 05:08:16.33+00	70152	188
206	2022-03-14 05:08:52.204+00	487248	189
264	2022-03-14 05:09:42.607+00	351112	190
276	2022-03-14 06:48:37.819+00	52290	191
278	2022-03-14 09:35:10.1+00	985266	192
281	2022-03-15 07:00:07.079+00	67950	193
135	2022-03-15 07:01:27.559+00	926232	194
170	2022-03-16 05:51:40.426+00	1348512	195
279	2022-03-16 05:59:49.401+00	63000	196
282	2022-03-17 06:18:49.94+00	349824	197
278	2022-03-18 04:50:36.285+00	1970532	198
283	2022-03-21 06:36:21.915+00	1117164	199
284	2022-03-21 07:20:21.159+00	507300	200
285	2022-03-21 10:29:06.883+00	43415	201
\.


--
-- Data for Name: Tokens; Type: TABLE DATA; Schema: erp; Owner: postgres
--

COPY erp."Tokens" ("ID", "RefreshToken", "UserID") FROM stdin;
1060	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwczovL2hhc3VyYS5pby9qd3QvY2xhaW1zIjp7IngtaGFzdXJhLWFsbG93ZWQtcm9sZXMiOlsiYWRtaW4iXSwieC1oYXN1cmEtZGVmYXVsdC1yb2xlIjoiYWRtaW4ifSwiVXNlcklEIjoxOSwiRmlyc3ROYW1lIjoi0JDQvdCw0YHRgtCw0YHQuNGPIiwiTGFzdE5hbWUiOiLQmtC-0LfQu9C-0LLQsCIsIkVtYWlsIjoiemF2b2RAcGllay5ydSIsIkFjY2Vzc0xldmVsSUQiOjQsImlhdCI6MTY0Nzg2MjE2MywiZXhwIjoxNjUwNDU0MTYzfQ.BdJQv8LBapDbVYC1aQWEbLs-daxGSUf3d7lJCdAhsPw	19
1096	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwczovL2hhc3VyYS5pby9qd3QvY2xhaW1zIjp7IngtaGFzdXJhLWFsbG93ZWQtcm9sZXMiOlsiYWRtaW4iXSwieC1oYXN1cmEtZGVmYXVsdC1yb2xlIjoiYWRtaW4ifSwiVXNlcklEIjoxNywiRmlyc3ROYW1lIjoi0JTQtdC90LjRgSIsIkxhc3ROYW1lIjoi0J3QvtCy0L7RgdC10LvRjNGG0LXQsiIsIkVtYWlsIjoiZC5ub3ZAcGllay5ydSIsIkFjY2Vzc0xldmVsSUQiOjMsImlhdCI6MTY0Nzg2NTMzOCwiZXhwIjoxNjUwNDU3MzM4fQ.55zyIi4XZjJLZBihe4TRS5kMYfHCvm8DUDS5y7l4DA8	17
1107	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwczovL2hhc3VyYS5pby9qd3QvY2xhaW1zIjp7IngtaGFzdXJhLWFsbG93ZWQtcm9sZXMiOlsiYWRtaW4iXSwieC1oYXN1cmEtZGVmYXVsdC1yb2xlIjoiYWRtaW4ifSwiVXNlcklEIjoxOSwiRmlyc3ROYW1lIjoi0JDQvdCw0YHRgtCw0YHQuNGPIiwiTGFzdE5hbWUiOiLQmtC-0LfQu9C-0LLQsCIsIkVtYWlsIjoiemF2b2RAcGllay5ydSIsIkFjY2Vzc0xldmVsSUQiOjQsImlhdCI6MTY0Njk4NjIzMCwiZXhwIjoxNjQ5NTc4MjMwfQ.2j5qBwtU8X-sCVEqAxv5NG84E8VBh7c4GoCAGfoqO-A	19
1098	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwczovL2hhc3VyYS5pby9qd3QvY2xhaW1zIjp7IngtaGFzdXJhLWFsbG93ZWQtcm9sZXMiOlsiYWRtaW4iXSwieC1oYXN1cmEtZGVmYXVsdC1yb2xlIjoiYWRtaW4ifSwiVXNlcklEIjoyMCwiRmlyc3ROYW1lIjoi0JDQvdGC0L7QvSIsIkxhc3ROYW1lIjoi0JvQvtGB0LXQtdCyIiwiRW1haWwiOiJwaWVrX3phdm9kQG1haWwucnUiLCJBY2Nlc3NMZXZlbElEIjozLCJpYXQiOjE2NDY0NjM1MjEsImV4cCI6MTY0OTA1NTUyMX0.Q5Lb4cU6qJo7GijijlFV48yKL9pZsP4g45_4UZLMNns	20
1101	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwczovL2hhc3VyYS5pby9qd3QvY2xhaW1zIjp7IngtaGFzdXJhLWFsbG93ZWQtcm9sZXMiOlsiYWRtaW4iXSwieC1oYXN1cmEtZGVmYXVsdC1yb2xlIjoiYWRtaW4ifSwiVXNlcklEIjoxNiwiRmlyc3ROYW1lIjoi0J_QsNCy0LXQuyIsIkxhc3ROYW1lIjoi0JfQu9C-0LHQuNC9IiwiRW1haWwiOiJ6bG9iaW5AcGllay5ydSIsIkFjY2Vzc0xldmVsSUQiOjIsImlhdCI6MTY0NjA1NjMxMiwiZXhwIjoxNjQ4NjQ4MzEyfQ.r9wVYvi-vMPHD1FmHiCaNys0vJ1NWsmzbNypOa3kKHM	16
1097	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwczovL2hhc3VyYS5pby9qd3QvY2xhaW1zIjp7IngtaGFzdXJhLWFsbG93ZWQtcm9sZXMiOlsiYWRtaW4iXSwieC1oYXN1cmEtZGVmYXVsdC1yb2xlIjoiYWRtaW4ifSwiVXNlcklEIjoxNSwiRmlyc3ROYW1lIjoi0JzQuNGF0LDQuNC7IiwiTGFzdE5hbWUiOiLQm9C-0YHQtdC10LIiLCJFbWFpbCI6Im1pc2hhdnpoaWtAZ21haWwuY29tIiwiQWNjZXNzTGV2ZWxJRCI6MiwiaWF0IjoxNjQ1NTM5MzE0LCJleHAiOjE2NDgxMzEzMTR9.OW8sqLqqvEivtUYV8Cp0YQP3iwBGhaejWuHQqcvOReo	15
1061	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwczovL2hhc3VyYS5pby9qd3QvY2xhaW1zIjp7IngtaGFzdXJhLWFsbG93ZWQtcm9sZXMiOlsiYWRtaW4iXSwieC1oYXN1cmEtZGVmYXVsdC1yb2xlIjoiYWRtaW4ifSwiVXNlcklEIjoxNSwiRmlyc3ROYW1lIjoi0JzQuNGF0LDQuNC7IiwiTGFzdE5hbWUiOiLQm9C-0YHQtdC10LIiLCJFbWFpbCI6Im1pc2hhdnpoaWtAZ21haWwuY29tIiwiQWNjZXNzTGV2ZWxJRCI6MiwiaWF0IjoxNjQ3ODc4NTg1LCJleHAiOjE2NTA0NzA1ODV9.wxZ84VxW53W9TMFkIRHR9_HJty-6bbVAgqaCGI9UNQg	15
1099	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwczovL2hhc3VyYS5pby9qd3QvY2xhaW1zIjp7IngtaGFzdXJhLWFsbG93ZWQtcm9sZXMiOlsiYWRtaW4iXSwieC1oYXN1cmEtZGVmYXVsdC1yb2xlIjoiYWRtaW4ifSwiVXNlcklEIjoxOSwiRmlyc3ROYW1lIjoi0JDQvdCw0YHRgtCw0YHQuNGPIiwiTGFzdE5hbWUiOiLQmtC-0LfQu9C-0LLQsCIsIkVtYWlsIjoiemF2b2RAcGllay5ydSIsIkFjY2Vzc0xldmVsSUQiOjQsImlhdCI6MTY0Nzg1NjQzNiwiZXhwIjoxNjUwNDQ4NDM2fQ.Jn2kXDmXXXNYag48LhEctmR2WADHmoKH8JrcQsHkCzw	19
1102	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwczovL2hhc3VyYS5pby9qd3QvY2xhaW1zIjp7IngtaGFzdXJhLWFsbG93ZWQtcm9sZXMiOlsiYWRtaW4iXSwieC1oYXN1cmEtZGVmYXVsdC1yb2xlIjoiYWRtaW4ifSwiVXNlcklEIjoxNSwiRmlyc3ROYW1lIjoi0JzQuNGF0LDQuNC7IiwiTGFzdE5hbWUiOiLQm9C-0YHQtdC10LIiLCJFbWFpbCI6Im1pc2hhdnpoaWtAZ21haWwuY29tIiwiQWNjZXNzTGV2ZWxJRCI6MiwiaWF0IjoxNjQ3NjA5MTcyLCJleHAiOjE2NTAyMDExNzJ9.OvjR57UJc3V_fVV085QTExcuuCQtPTr9Rjbc-rJ9lHI	15
1100	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwczovL2hhc3VyYS5pby9qd3QvY2xhaW1zIjp7IngtaGFzdXJhLWFsbG93ZWQtcm9sZXMiOlsiYWRtaW4iXSwieC1oYXN1cmEtZGVmYXVsdC1yb2xlIjoiYWRtaW4ifSwiVXNlcklEIjoxNSwiRmlyc3ROYW1lIjoi0JzQuNGF0LDQuNC7IiwiTGFzdE5hbWUiOiLQm9C-0YHQtdC10LIiLCJFbWFpbCI6Im1pc2hhdnpoaWtAZ21haWwuY29tIiwiQWNjZXNzTGV2ZWxJRCI6MiwiaWF0IjoxNjQ3MjU5NTk3LCJleHAiOjE2NDk4NTE1OTd9.gDErRNTg3XrKUbleYibWQbEudFJI_hK8hVlVwsdh9ak	15
1072	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwczovL2hhc3VyYS5pby9qd3QvY2xhaW1zIjp7IngtaGFzdXJhLWFsbG93ZWQtcm9sZXMiOlsiYWRtaW4iXSwieC1oYXN1cmEtZGVmYXVsdC1yb2xlIjoiYWRtaW4ifSwiVXNlcklEIjoxNSwiRmlyc3ROYW1lIjoi0JzQuNGF0LDQuNC7IiwiTGFzdE5hbWUiOiLQm9C-0YHQtdC10LIiLCJFbWFpbCI6Im1pc2hhdnpoaWtAZ21haWwuY29tIiwiQWNjZXNzTGV2ZWxJRCI6MiwiaWF0IjoxNjQ1NDQ3Mzg4LCJleHAiOjE2NDgwMzkzODh9.Q1hzFyYJ0WhhoxdHs54EtXnylv9DWDCmDVRbRUkK1NI	15
1073	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwczovL2hhc3VyYS5pby9qd3QvY2xhaW1zIjp7IngtaGFzdXJhLWFsbG93ZWQtcm9sZXMiOlsiYWRtaW4iXSwieC1oYXN1cmEtZGVmYXVsdC1yb2xlIjoiYWRtaW4ifSwiVXNlcklEIjoxNSwiRmlyc3ROYW1lIjoi0JzQuNGF0LDQuNC7IiwiTGFzdE5hbWUiOiLQm9C-0YHQtdC10LIiLCJFbWFpbCI6Im1pc2hhdnpoaWtAZ21haWwuY29tIiwiQWNjZXNzTGV2ZWxJRCI6MiwiaWF0IjoxNjQ1NDQ3NDAwLCJleHAiOjE2NDgwMzk0MDB9.zdlO8KEr5vqh6TEeodnLDJQUy6C-5WsZCwiQ22ef6Qc	15
1062	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwczovL2hhc3VyYS5pby9qd3QvY2xhaW1zIjp7IngtaGFzdXJhLWFsbG93ZWQtcm9sZXMiOlsiYWRtaW4iXSwieC1oYXN1cmEtZGVmYXVsdC1yb2xlIjoiYWRtaW4ifSwiVXNlcklEIjoxNiwiRmlyc3ROYW1lIjoi0J_QsNCy0LXQuyIsIkxhc3ROYW1lIjoi0JfQu9C-0LHQuNC9IiwiRW1haWwiOiJ6bG9iaW5AcGllay5ydSIsIkFjY2Vzc0xldmVsSUQiOjIsImlhdCI6MTY0NjQ3MjgzNCwiZXhwIjoxNjQ5MDY0ODM0fQ.KuZjcYIJ5y-0nKQpgY86M1OgNj4lAkoyC0bExIR8B0A	16
1103	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwczovL2hhc3VyYS5pby9qd3QvY2xhaW1zIjp7IngtaGFzdXJhLWFsbG93ZWQtcm9sZXMiOlsiYWRtaW4iXSwieC1oYXN1cmEtZGVmYXVsdC1yb2xlIjoiYWRtaW4ifSwiVXNlcklEIjoxNSwiRmlyc3ROYW1lIjoi0JzQuNGF0LDQuNC7IiwiTGFzdE5hbWUiOiLQm9C-0YHQtdC10LIiLCJFbWFpbCI6Im1pc2hhdnpoaWtAZ21haWwuY29tIiwiQWNjZXNzTGV2ZWxJRCI6MiwiaWF0IjoxNjQ2MTA2MDMwLCJleHAiOjE2NDg2OTgwMzB9.W_kId9uUd-l0gdri3Uw04HemaEERfAWkKvzEFkFpTUc	15
1077	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwczovL2hhc3VyYS5pby9qd3QvY2xhaW1zIjp7IngtaGFzdXJhLWFsbG93ZWQtcm9sZXMiOlsiYWRtaW4iXSwieC1oYXN1cmEtZGVmYXVsdC1yb2xlIjoiYWRtaW4ifSwiVXNlcklEIjoxNSwiRmlyc3ROYW1lIjoi0JzQuNGF0LDQuNC7IiwiTGFzdE5hbWUiOiLQm9C-0YHQtdC10LIiLCJFbWFpbCI6Im1pc2hhdnpoaWtAZ21haWwuY29tIiwiQWNjZXNzTGV2ZWxJRCI6MiwiaWF0IjoxNjQ1NDQ3NDY2LCJleHAiOjE2NDgwMzk0NjZ9.puQQqonXWLGpAcNwHkjyqn4Di7Z9VBMo_ner--OMoc0	15
1078	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwczovL2hhc3VyYS5pby9qd3QvY2xhaW1zIjp7IngtaGFzdXJhLWFsbG93ZWQtcm9sZXMiOlsiYWRtaW4iXSwieC1oYXN1cmEtZGVmYXVsdC1yb2xlIjoiYWRtaW4ifSwiVXNlcklEIjoxNSwiRmlyc3ROYW1lIjoi0JzQuNGF0LDQuNC7IiwiTGFzdE5hbWUiOiLQm9C-0YHQtdC10LIiLCJFbWFpbCI6Im1pc2hhdnpoaWtAZ21haWwuY29tIiwiQWNjZXNzTGV2ZWxJRCI6MiwiaWF0IjoxNjQ1NDQ3NDc1LCJleHAiOjE2NDgwMzk0NzV9.b6ZhwAAME0vkh93I8empdXntKA_c1CTqk-Jv1mna4GE	15
1104	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwczovL2hhc3VyYS5pby9qd3QvY2xhaW1zIjp7IngtaGFzdXJhLWFsbG93ZWQtcm9sZXMiOlsiYWRtaW4iXSwieC1oYXN1cmEtZGVmYXVsdC1yb2xlIjoiYWRtaW4ifSwiVXNlcklEIjoxNSwiRmlyc3ROYW1lIjoi0JzQuNGF0LDQuNC7IiwiTGFzdE5hbWUiOiLQm9C-0YHQtdC10LIiLCJFbWFpbCI6Im1pc2hhdnpoaWtAZ21haWwuY29tIiwiQWNjZXNzTGV2ZWxJRCI6MiwiaWF0IjoxNjQ3MjQxMDY4LCJleHAiOjE2NDk4MzMwNjh9.F2ADQ55v7oRppFTP7Qx3H5JgDNXsFshUsWXTkOh7Vgk	15
1079	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwczovL2hhc3VyYS5pby9qd3QvY2xhaW1zIjp7IngtaGFzdXJhLWFsbG93ZWQtcm9sZXMiOlsiYWRtaW4iXSwieC1oYXN1cmEtZGVmYXVsdC1yb2xlIjoiYWRtaW4ifSwiVXNlcklEIjoxNSwiRmlyc3ROYW1lIjoi0JzQuNGF0LDQuNC7IiwiTGFzdE5hbWUiOiLQm9C-0YHQtdC10LIiLCJFbWFpbCI6Im1pc2hhdnpoaWtAZ21haWwuY29tIiwiQWNjZXNzTGV2ZWxJRCI6MiwiaWF0IjoxNjQ1NDQ3NTE1LCJleHAiOjE2NDgwMzk1MTV9.sqNYqZE1FgFwlU26yH13NgTQprM12VCtkQq7F3idJkc	15
1081	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwczovL2hhc3VyYS5pby9qd3QvY2xhaW1zIjp7IngtaGFzdXJhLWFsbG93ZWQtcm9sZXMiOlsiYWRtaW4iXSwieC1oYXN1cmEtZGVmYXVsdC1yb2xlIjoiYWRtaW4ifSwiVXNlcklEIjoxNSwiRmlyc3ROYW1lIjoi0JzQuNGF0LDQuNC7IiwiTGFzdE5hbWUiOiLQm9C-0YHQtdC10LIiLCJFbWFpbCI6Im1pc2hhdnpoaWtAZ21haWwuY29tIiwiQWNjZXNzTGV2ZWxJRCI6MiwiaWF0IjoxNjQ1NDQ3NTgxLCJleHAiOjE2NDgwMzk1ODF9.z5Y2cXBJKFxZaf-2vsilpUIXWQJjsEkKnIaoBjlaO28	15
1063	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwczovL2hhc3VyYS5pby9qd3QvY2xhaW1zIjp7IngtaGFzdXJhLWFsbG93ZWQtcm9sZXMiOlsiYWRtaW4iXSwieC1oYXN1cmEtZGVmYXVsdC1yb2xlIjoiYWRtaW4ifSwiVXNlcklEIjoxNSwiRmlyc3ROYW1lIjoi0JzQuNGF0LDQuNC7IiwiTGFzdE5hbWUiOiLQm9C-0YHQtdC10LIiLCJFbWFpbCI6Im1pc2hhdnpoaWtAZ21haWwuY29tIiwiQWNjZXNzTGV2ZWxJRCI6MiwiaWF0IjoxNjQ3ODc5NjM0LCJleHAiOjE2NTA0NzE2MzR9.pp77CzIN9vpgEuxP9mmZmbfkE6DwK5wwBFvWFLQ1ByQ	15
1064	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwczovL2hhc3VyYS5pby9qd3QvY2xhaW1zIjp7IngtaGFzdXJhLWFsbG93ZWQtcm9sZXMiOlsiYWRtaW4iXSwieC1oYXN1cmEtZGVmYXVsdC1yb2xlIjoiYWRtaW4ifSwiVXNlcklEIjoxOCwiRmlyc3ROYW1lIjoi0K3QtNGD0LDRgNC0IiwiTGFzdE5hbWUiOiLQm9C-0YHQtdC10LIiLCJFbWFpbCI6ImluZm9AcGllay5ydSIsIkFjY2Vzc0xldmVsSUQiOjEsImlhdCI6MTY0NzA4OTY3MywiZXhwIjoxNjQ5NjgxNjczfQ.qzBIdwfPC0aesBizUDLl9R4dLWs2XZQ2a5m9cLL_YMc	18
1105	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwczovL2hhc3VyYS5pby9qd3QvY2xhaW1zIjp7IngtaGFzdXJhLWFsbG93ZWQtcm9sZXMiOlsiYWRtaW4iXSwieC1oYXN1cmEtZGVmYXVsdC1yb2xlIjoiYWRtaW4ifSwiVXNlcklEIjoxNSwiRmlyc3ROYW1lIjoi0JzQuNGF0LDQuNC7IiwiTGFzdE5hbWUiOiLQm9C-0YHQtdC10LIiLCJFbWFpbCI6Im1pc2hhdnpoaWtAZ21haWwuY29tIiwiQWNjZXNzTGV2ZWxJRCI6MiwiaWF0IjoxNjQ2NDA1NTQzLCJleHAiOjE2NDg5OTc1NDN9.cH1UqwIxSlpfpK4QCz6APrKiLOtcSbhG7l1KUnasBLU	15
1059	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwczovL2hhc3VyYS5pby9qd3QvY2xhaW1zIjp7IngtaGFzdXJhLWFsbG93ZWQtcm9sZXMiOlsiYWRtaW4iXSwieC1oYXN1cmEtZGVmYXVsdC1yb2xlIjoiYWRtaW4ifSwiVXNlcklEIjoxNSwiRmlyc3ROYW1lIjoi0JzQuNGF0LDQuNC7IiwiTGFzdE5hbWUiOiLQm9C-0YHQtdC10LIiLCJFbWFpbCI6Im1pc2hhdnpoaWtAZ21haWwuY29tIiwiQWNjZXNzTGV2ZWxJRCI6MiwiaWF0IjoxNjQ2MDYzMDgxLCJleHAiOjE2NDg2NTUwODF9.UmkAHTHK-N2VwSurgTSNnLK5MhPF4z_jkxbdD0BRza4	15
1065	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwczovL2hhc3VyYS5pby9qd3QvY2xhaW1zIjp7IngtaGFzdXJhLWFsbG93ZWQtcm9sZXMiOlsiYWRtaW4iXSwieC1oYXN1cmEtZGVmYXVsdC1yb2xlIjoiYWRtaW4ifSwiVXNlcklEIjoxNSwiRmlyc3ROYW1lIjoi0JzQuNGF0LDQuNC7IiwiTGFzdE5hbWUiOiLQm9C-0YHQtdC10LIiLCJFbWFpbCI6Im1pc2hhdnpoaWtAZ21haWwuY29tIiwiQWNjZXNzTGV2ZWxJRCI6MiwiaWF0IjoxNjQ1NDMyNDcxLCJleHAiOjE2NDgwMjQ0NzF9.2JcwDm3HLqo5PWvgc13NcwbrGD34DUR66gr6nO7yVXw	15
1085	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwczovL2hhc3VyYS5pby9qd3QvY2xhaW1zIjp7IngtaGFzdXJhLWFsbG93ZWQtcm9sZXMiOlsiYWRtaW4iXSwieC1oYXN1cmEtZGVmYXVsdC1yb2xlIjoiYWRtaW4ifSwiVXNlcklEIjoxNSwiRmlyc3ROYW1lIjoi0JzQuNGF0LDQuNC7IiwiTGFzdE5hbWUiOiLQm9C-0YHQtdC10LIiLCJFbWFpbCI6Im1pc2hhdnpoaWtAZ21haWwuY29tIiwiQWNjZXNzTGV2ZWxJRCI6MiwiaWF0IjoxNjQ1NDQ3Njc5LCJleHAiOjE2NDgwMzk2Nzl9.sSzfBf2CEGzMC2R0VD-rQ6Jzc5CdmG59VesviHiNvyI	15
1106	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwczovL2hhc3VyYS5pby9qd3QvY2xhaW1zIjp7IngtaGFzdXJhLWFsbG93ZWQtcm9sZXMiOlsiYWRtaW4iXSwieC1oYXN1cmEtZGVmYXVsdC1yb2xlIjoiYWRtaW4ifSwiVXNlcklEIjoxNiwiRmlyc3ROYW1lIjoi0J_QsNCy0LXQuyIsIkxhc3ROYW1lIjoi0JfQu9C-0LHQuNC9IiwiRW1haWwiOiJ6bG9iaW5AcGllay5ydSIsIkFjY2Vzc0xldmVsSUQiOjIsImlhdCI6MTY0Nzg2NTExMSwiZXhwIjoxNjUwNDU3MTExfQ.iY9vvJPKyDrCzhFPMK1vIk2Q-8M3DigT0W5tH9lK6Rw	16
1087	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwczovL2hhc3VyYS5pby9qd3QvY2xhaW1zIjp7IngtaGFzdXJhLWFsbG93ZWQtcm9sZXMiOlsiYWRtaW4iXSwieC1oYXN1cmEtZGVmYXVsdC1yb2xlIjoiYWRtaW4ifSwiVXNlcklEIjoxNSwiRmlyc3ROYW1lIjoi0JzQuNGF0LDQuNC7IiwiTGFzdE5hbWUiOiLQm9C-0YHQtdC10LIiLCJFbWFpbCI6Im1pc2hhdnpoaWtAZ21haWwuY29tIiwiQWNjZXNzTGV2ZWxJRCI6MiwiaWF0IjoxNjQ1NDQ3NzkyLCJleHAiOjE2NDgwMzk3OTJ9.C-4NdrZVvwRk24agvpPW-cDh4b8x8rwvdYchjCmHT_Y	15
1088	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwczovL2hhc3VyYS5pby9qd3QvY2xhaW1zIjp7IngtaGFzdXJhLWFsbG93ZWQtcm9sZXMiOlsiYWRtaW4iXSwieC1oYXN1cmEtZGVmYXVsdC1yb2xlIjoiYWRtaW4ifSwiVXNlcklEIjoxNSwiRmlyc3ROYW1lIjoi0JzQuNGF0LDQuNC7IiwiTGFzdE5hbWUiOiLQm9C-0YHQtdC10LIiLCJFbWFpbCI6Im1pc2hhdnpoaWtAZ21haWwuY29tIiwiQWNjZXNzTGV2ZWxJRCI6MiwiaWF0IjoxNjQ1NDQ3Nzk4LCJleHAiOjE2NDgwMzk3OTh9.4OkA3_hwMVh-r2NRPpnRcq-f_sRMWEt0eHywQ9HWYTY	15
1089	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwczovL2hhc3VyYS5pby9qd3QvY2xhaW1zIjp7IngtaGFzdXJhLWFsbG93ZWQtcm9sZXMiOlsiYWRtaW4iXSwieC1oYXN1cmEtZGVmYXVsdC1yb2xlIjoiYWRtaW4ifSwiVXNlcklEIjoxNSwiRmlyc3ROYW1lIjoi0JzQuNGF0LDQuNC7IiwiTGFzdE5hbWUiOiLQm9C-0YHQtdC10LIiLCJFbWFpbCI6Im1pc2hhdnpoaWtAZ21haWwuY29tIiwiQWNjZXNzTGV2ZWxJRCI6MiwiaWF0IjoxNjQ1NDQ3Nzk5LCJleHAiOjE2NDgwMzk3OTl9.th_5UJoXXyOH8Xsc8WSFPKOji97XR7MrTrjr-UBFvS0	15
1090	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwczovL2hhc3VyYS5pby9qd3QvY2xhaW1zIjp7IngtaGFzdXJhLWFsbG93ZWQtcm9sZXMiOlsiYWRtaW4iXSwieC1oYXN1cmEtZGVmYXVsdC1yb2xlIjoiYWRtaW4ifSwiVXNlcklEIjoxNSwiRmlyc3ROYW1lIjoi0JzQuNGF0LDQuNC7IiwiTGFzdE5hbWUiOiLQm9C-0YHQtdC10LIiLCJFbWFpbCI6Im1pc2hhdnpoaWtAZ21haWwuY29tIiwiQWNjZXNzTGV2ZWxJRCI6MiwiaWF0IjoxNjQ1NDQ3ODAyLCJleHAiOjE2NDgwMzk4MDJ9.5MpZwpI8B4G4fUmZBkMwy2V_NVzRTkuz26XYyByfivg	15
1091	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwczovL2hhc3VyYS5pby9qd3QvY2xhaW1zIjp7IngtaGFzdXJhLWFsbG93ZWQtcm9sZXMiOlsiYWRtaW4iXSwieC1oYXN1cmEtZGVmYXVsdC1yb2xlIjoiYWRtaW4ifSwiVXNlcklEIjoxNSwiRmlyc3ROYW1lIjoi0JzQuNGF0LDQuNC7IiwiTGFzdE5hbWUiOiLQm9C-0YHQtdC10LIiLCJFbWFpbCI6Im1pc2hhdnpoaWtAZ21haWwuY29tIiwiQWNjZXNzTGV2ZWxJRCI6MiwiaWF0IjoxNjQ1NDQ3ODAzLCJleHAiOjE2NDgwMzk4MDN9.AOPx1CXaMfEFEo5FuK8cR9TuLOD9lh0bSgeakS7VDaA	15
1092	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwczovL2hhc3VyYS5pby9qd3QvY2xhaW1zIjp7IngtaGFzdXJhLWFsbG93ZWQtcm9sZXMiOlsiYWRtaW4iXSwieC1oYXN1cmEtZGVmYXVsdC1yb2xlIjoiYWRtaW4ifSwiVXNlcklEIjoxNSwiRmlyc3ROYW1lIjoi0JzQuNGF0LDQuNC7IiwiTGFzdE5hbWUiOiLQm9C-0YHQtdC10LIiLCJFbWFpbCI6Im1pc2hhdnpoaWtAZ21haWwuY29tIiwiQWNjZXNzTGV2ZWxJRCI6MiwiaWF0IjoxNjQ1NDQ3ODAzLCJleHAiOjE2NDgwMzk4MDN9.AOPx1CXaMfEFEo5FuK8cR9TuLOD9lh0bSgeakS7VDaA	15
1095	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwczovL2hhc3VyYS5pby9qd3QvY2xhaW1zIjp7IngtaGFzdXJhLWFsbG93ZWQtcm9sZXMiOlsiYWRtaW4iXSwieC1oYXN1cmEtZGVmYXVsdC1yb2xlIjoiYWRtaW4ifSwiVXNlcklEIjoxNSwiRmlyc3ROYW1lIjoi0JzQuNGF0LDQuNC7IiwiTGFzdE5hbWUiOiLQm9C-0YHQtdC10LIiLCJFbWFpbCI6Im1pc2hhdnpoaWtAZ21haWwuY29tIiwiQWNjZXNzTGV2ZWxJRCI6MiwiaWF0IjoxNjQ1NTQ4Mzk4LCJleHAiOjE2NDgxNDAzOTh9.Ex0UkLTcmRRc_7YytK667rhzSL_z9-2BvJPwtr_2f8g	15
1093	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwczovL2hhc3VyYS5pby9qd3QvY2xhaW1zIjp7IngtaGFzdXJhLWFsbG93ZWQtcm9sZXMiOlsiYWRtaW4iXSwieC1oYXN1cmEtZGVmYXVsdC1yb2xlIjoiYWRtaW4ifSwiVXNlcklEIjoxNSwiRmlyc3ROYW1lIjoi0JzQuNGF0LDQuNC7IiwiTGFzdE5hbWUiOiLQm9C-0YHQtdC10LIiLCJFbWFpbCI6Im1pc2hhdnpoaWtAZ21haWwuY29tIiwiQWNjZXNzTGV2ZWxJRCI6MiwiaWF0IjoxNjQ1NDQ3ODIyLCJleHAiOjE2NDgwMzk4MjJ9.Fbd823bRWDgq3ASma56RWSmT_0fFhkgdxEMH-RSwxR4	15
\.


--
-- Data for Name: Users; Type: TABLE DATA; Schema: erp; Owner: postgres
--

COPY erp."Users" ("UserID", "FirstName", "LastName", "Password", "AccessLevelID", "Email") FROM stdin;
20	Антон	Лосеев	3cpDEV7dvk	3	piek_zavod@mail.ru
19	Анастасия	Козлова	EmDBYw52Xw	4	zavod@piek.ru
15	Михаил	Лосеев	SUVBLEpnZZpGHDMM	2	mishavzhik@gmail.com
17	Денис	Новосельцев	nhIRNwPLgW	3	d.nov@piek.ru
16	Павел	Злобин	SjGkQYZyMP	2	zlobin@piek.ru
18	Эдуард	Лосеев	98mHsK6LAA	1	info@piek.ru
\.


--
-- Data for Name: hdb_action_log; Type: TABLE DATA; Schema: hdb_catalog; Owner: postgres
--

COPY hdb_catalog.hdb_action_log (id, action_name, input_payload, request_headers, session_variables, response_payload, errors, created_at, response_received_at, status) FROM stdin;
\.


--
-- Data for Name: hdb_cron_event_invocation_logs; Type: TABLE DATA; Schema: hdb_catalog; Owner: postgres
--

COPY hdb_catalog.hdb_cron_event_invocation_logs (id, event_id, status, request, response, created_at) FROM stdin;
\.


--
-- Data for Name: hdb_cron_events; Type: TABLE DATA; Schema: hdb_catalog; Owner: postgres
--

COPY hdb_catalog.hdb_cron_events (id, trigger_name, scheduled_time, status, tries, created_at, next_retry_at) FROM stdin;
\.


--
-- Data for Name: hdb_metadata; Type: TABLE DATA; Schema: hdb_catalog; Owner: postgres
--

COPY hdb_catalog.hdb_metadata (id, metadata, resource_version) FROM stdin;
1	{"rest_endpoints":[{"definition":{"query":{"collection_name":"allowed-queries","query_name":"getInputData"}},"url":"getInputData","methods":["GET"],"name":"getInputData","comment":null},{"definition":{"query":{"collection_name":"allowed-queries","query_name":"getStopLosses"}},"url":"getStopLosses","methods":["GET"],"name":"getStopLosses","comment":null},{"definition":{"query":{"collection_name":"allowed-queries","query_name":"testMutation"}},"url":"testMutation","methods":["PUT"],"name":"testMutation","comment":null},{"definition":{"query":{"collection_name":"allowed-queries","query_name":"testrest"}},"url":"testrest","methods":["GET"],"name":"testrest","comment":null}],"allowlist":[{"collection":"allowed-queries"}],"sources":[{"kind":"postgres","name":"default","tables":[{"table":{"schema":"attendance","name":"config"}},{"object_relationships":[{"using":{"foreign_key_constraint_on":"card"},"name":"user"}],"table":{"schema":"attendance","name":"intervals"}},{"table":{"schema":"attendance","name":"users"},"array_relationships":[{"using":{"foreign_key_constraint_on":{"column":"card","table":{"schema":"attendance","name":"intervals"}}},"name":"intervals"}]},{"table":{"schema":"erp","name":"AccessLevels"},"array_relationships":[{"using":{"foreign_key_constraint_on":{"column":"AccessLevelID","table":{"schema":"erp","name":"Users"}}},"name":"Users"}]},{"table":{"schema":"erp","name":"CheckListTPLs"},"array_relationships":[{"using":{"foreign_key_constraint_on":{"column":"CheckListTPLID","table":{"schema":"erp","name":"Orders"}}},"name":"Orders"}]},{"object_relationships":[{"using":{"foreign_key_constraint_on":"OrderID"},"name":"Order"}],"table":{"schema":"erp","name":"CheckListUnits"}},{"object_relationships":[{"using":{"foreign_key_constraint_on":"OrderID"},"name":"Order"},{"using":{"foreign_key_constraint_on":"UserID"},"name":"User"}],"table":{"schema":"erp","name":"Comments"},"array_relationships":[{"using":{"foreign_key_constraint_on":{"column":"CommentID","table":{"schema":"erp","name":"Notifications"}}},"name":"Notifications"}]},{"object_relationships":[{"using":{"foreign_key_constraint_on":"OrderID"},"name":"Order"}],"table":{"schema":"erp","name":"Docs"}},{"object_relationships":[{"using":{"foreign_key_constraint_on":"CommentID"},"name":"Comment"},{"using":{"foreign_key_constraint_on":"OrderID"},"name":"Order"},{"using":{"foreign_key_constraint_on":"MentionedUser"},"name":"User"}],"table":{"schema":"erp","name":"Notifications"}},{"object_relationships":[{"using":{"foreign_key_constraint_on":"OrderID"},"name":"Order"}],"table":{"schema":"erp","name":"OrderItems"}},{"table":{"schema":"erp","name":"OrderStatus"},"array_relationships":[{"using":{"foreign_key_constraint_on":{"column":"OrderStatusID","table":{"schema":"erp","name":"Orders"}}},"name":"Orders"}]},{"object_relationships":[{"using":{"foreign_key_constraint_on":"CheckListTPLID"},"name":"CheckListTPL"},{"using":{"foreign_key_constraint_on":"OrderStatusID"},"name":"OrderStatus"},{"using":{"foreign_key_constraint_on":"ManagerID"},"name":"User"}],"table":{"schema":"erp","name":"Orders"},"array_relationships":[{"using":{"foreign_key_constraint_on":{"column":"OrderID","table":{"schema":"erp","name":"CheckListUnits"}}},"name":"CheckListUnits"},{"using":{"foreign_key_constraint_on":{"column":"OrderID","table":{"schema":"erp","name":"Comments"}}},"name":"Comments"},{"using":{"foreign_key_constraint_on":{"column":"OrderID","table":{"schema":"erp","name":"Docs"}}},"name":"Docs"},{"using":{"foreign_key_constraint_on":{"column":"OrderID","table":{"schema":"erp","name":"Notifications"}}},"name":"Notifications"},{"using":{"foreign_key_constraint_on":{"column":"OrderID","table":{"schema":"erp","name":"OrderItems"}}},"name":"OrderItems"},{"using":{"foreign_key_constraint_on":{"column":"OrderID","table":{"schema":"erp","name":"PaymentHistory"}}},"name":"PaymentHistories"}]},{"object_relationships":[{"using":{"foreign_key_constraint_on":"OrderID"},"name":"Order"}],"table":{"schema":"erp","name":"PaymentHistory"}},{"object_relationships":[{"using":{"foreign_key_constraint_on":"UserID"},"name":"User"}],"table":{"schema":"erp","name":"Tokens"}},{"object_relationships":[{"using":{"foreign_key_constraint_on":"AccessLevelID"},"name":"AccessLevel"}],"table":{"schema":"erp","name":"Users"},"array_relationships":[{"using":{"foreign_key_constraint_on":{"column":"UserID","table":{"schema":"erp","name":"Comments"}}},"name":"Comments"},{"using":{"foreign_key_constraint_on":{"column":"MentionedUser","table":{"schema":"erp","name":"Notifications"}}},"name":"Notifications"},{"using":{"foreign_key_constraint_on":{"column":"ManagerID","table":{"schema":"erp","name":"Orders"}}},"name":"Orders"},{"using":{"foreign_key_constraint_on":{"column":"UserID","table":{"schema":"erp","name":"Tokens"}}},"name":"Tokrns"}]},{"table":{"schema":"traderBot","name":"inpurData1"}},{"table":{"schema":"traderBot","name":"inputData"}}],"configuration":{"connection_info":{"use_prepared_statements":true,"database_url":{"from_env":"PG_DATABASE_URL"},"isolation_level":"read-committed","pool_settings":{"connection_lifetime":600,"retries":1,"idle_timeout":180,"max_connections":50}}}}],"version":3,"query_collections":[{"definition":{"queries":[{"name":"testrest","query":"query MyQuery {\\n  erp_Orders {\\n    Entity\\n    InvoiceNumber\\n    OrderItems {\\n      Quantity\\n      OrderItemID\\n      Name\\n      OrderID\\n    }\\n    City\\n    ShippingDate\\n  }\\n}"},{"name":"testMutation","query":"mutation MyMutation {\\n  update_traderBot_inputData(where: {Ticker: {_eq: \\"XRP\\"}}, _set: {TPid: 10, FirstBuy: true}) {\\n    returning {\\n      TPid\\n    }\\n  }\\n}"},{"name":"getStopLosses","query":"query MyQuery {\\n  traderBot_inputData(where: {stopLossed: {_eq: true}}) {\\n    Ticker\\n  }\\n}"},{"name":"getInputData","query":"query MyQuery {\\n  traderBot_inputData(where: {stopLossed: {_eq: false}}) {\\n    ATH\\n    PosFromFund\\n    ProfitValue\\n    Ticker\\n    ValFirstBuy\\n    ValForcedSale\\n    ValSecBuy\\n    id\\n    TPid\\n    FirstBuy\\n    SecBuy\\n    stopLossed\\n    SumFirstBuy\\n  }\\n}"}]},"name":"allowed-queries"}]}	198
\.


--
-- Data for Name: hdb_scheduled_event_invocation_logs; Type: TABLE DATA; Schema: hdb_catalog; Owner: postgres
--

COPY hdb_catalog.hdb_scheduled_event_invocation_logs (id, event_id, status, request, response, created_at) FROM stdin;
\.


--
-- Data for Name: hdb_scheduled_events; Type: TABLE DATA; Schema: hdb_catalog; Owner: postgres
--

COPY hdb_catalog.hdb_scheduled_events (id, webhook_conf, scheduled_time, retry_conf, payload, header_conf, status, tries, created_at, next_retry_at, comment) FROM stdin;
\.


--
-- Data for Name: hdb_schema_notifications; Type: TABLE DATA; Schema: hdb_catalog; Owner: postgres
--

COPY hdb_catalog.hdb_schema_notifications (id, notification, resource_version, instance_id, updated_at) FROM stdin;
1	{"metadata":false,"remote_schemas":[],"sources":[]}	198	9a17607e-8c90-4e86-b946-972d81aafca1	2021-06-17 18:31:48.157854+00
\.


--
-- Data for Name: hdb_version; Type: TABLE DATA; Schema: hdb_catalog; Owner: postgres
--

COPY hdb_catalog.hdb_version (hasura_uuid, version, upgraded_on, cli_state, console_state) FROM stdin;
98678032-bc9d-4f35-a68e-43d25687b5ae	46	2021-08-08 14:05:52.543417+00	{}	{"console_notifications": {"admin": {"date": "2022-03-10T00:57:15.650Z", "read": [], "showBadge": false}}, "telemetryNotificationShown": true}
\.


--
-- Data for Name: inpurData1; Type: TABLE DATA; Schema: traderBot; Owner: postgres
--

COPY "traderBot"."inpurData1" (id, "Ticker", "ATH") FROM stdin;
1	UNI	24.147
2	XRP	0.9
3	EOS	5
4	LTC	178
5	XMR	290
6	XLM	0.35
7	DOT	18.5
8	CRO	0.155
9	NEO	43.61
10	BCH	646.6
\.


--
-- Data for Name: inputData; Type: TABLE DATA; Schema: traderBot; Owner: postgres
--

COPY "traderBot"."inputData" (id, "Ticker", "ATH", "PosFromFund", "ProfitValue", "ValFirstBuy", "ValSecBuy", "ValForcedSale", "FirstBuy", "SecBuy", "TPid", "stopLossed", "SumFirstBuy") FROM stdin;
1	TRX	0.06	10%	10.50%	-25%	-40%	-50%	t	f	1337	t	\N
2	ETH	2000	10%	10.50%	-25%	-40%	-50%	f	f	340200872336568320	f	134.83570796356
\.


--
-- Name: Intervals_ID_seq; Type: SEQUENCE SET; Schema: attendance; Owner: postgres
--

SELECT pg_catalog.setval('attendance."Intervals_ID_seq"', 159214, true);


--
-- Name: config_ID_seq; Type: SEQUENCE SET; Schema: attendance; Owner: postgres
--

SELECT pg_catalog.setval('attendance."config_ID_seq"', 1, false);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: attendance; Owner: postgres
--

SELECT pg_catalog.setval('attendance.users_id_seq', 11697, true);


--
-- Name: AccessLevels_AccessLevelID_seq; Type: SEQUENCE SET; Schema: erp; Owner: postgres
--

SELECT pg_catalog.setval('erp."AccessLevels_AccessLevelID_seq"', 1, false);


--
-- Name: CheckListTPLs_CheckListTPLID_seq; Type: SEQUENCE SET; Schema: erp; Owner: postgres
--

SELECT pg_catalog.setval('erp."CheckListTPLs_CheckListTPLID_seq"', 1, false);


--
-- Name: CheckListUnits_CheckListUnitID_seq; Type: SEQUENCE SET; Schema: erp; Owner: postgres
--

SELECT pg_catalog.setval('erp."CheckListUnits_CheckListUnitID_seq"', 289, true);


--
-- Name: Comments_CommentID_seq; Type: SEQUENCE SET; Schema: erp; Owner: postgres
--

SELECT pg_catalog.setval('erp."Comments_CommentID_seq"', 549, true);


--
-- Name: Docs_ID_seq; Type: SEQUENCE SET; Schema: erp; Owner: postgres
--

SELECT pg_catalog.setval('erp."Docs_ID_seq"', 377, true);


--
-- Name: Notifications_ID_seq; Type: SEQUENCE SET; Schema: erp; Owner: postgres
--

SELECT pg_catalog.setval('erp."Notifications_ID_seq"', 86, true);


--
-- Name: OrderItems_OrderItemID_seq; Type: SEQUENCE SET; Schema: erp; Owner: postgres
--

SELECT pg_catalog.setval('erp."OrderItems_OrderItemID_seq"', 546, true);


--
-- Name: OrderStatus_OrderStatusID_seq; Type: SEQUENCE SET; Schema: erp; Owner: postgres
--

SELECT pg_catalog.setval('erp."OrderStatus_OrderStatusID_seq"', 4, true);


--
-- Name: Orders_OrderID_seq; Type: SEQUENCE SET; Schema: erp; Owner: postgres
--

SELECT pg_catalog.setval('erp."Orders_OrderID_seq"', 285, true);


--
-- Name: PaymentHistory_id_seq; Type: SEQUENCE SET; Schema: erp; Owner: postgres
--

SELECT pg_catalog.setval('erp."PaymentHistory_id_seq"', 201, true);


--
-- Name: Tokrns_ID_seq; Type: SEQUENCE SET; Schema: erp; Owner: postgres
--

SELECT pg_catalog.setval('erp."Tokrns_ID_seq"', 1107, true);


--
-- Name: Users_UserID_seq; Type: SEQUENCE SET; Schema: erp; Owner: postgres
--

SELECT pg_catalog.setval('erp."Users_UserID_seq"', 20, true);


--
-- Name: inpurData1_id_seq; Type: SEQUENCE SET; Schema: traderBot; Owner: postgres
--

SELECT pg_catalog.setval('"traderBot"."inpurData1_id_seq"', 1, true);


--
-- Name: inputData_id_seq; Type: SEQUENCE SET; Schema: traderBot; Owner: postgres
--

SELECT pg_catalog.setval('"traderBot"."inputData_id_seq"', 1, true);


--
-- Name: intervals Intervals_pkey; Type: CONSTRAINT; Schema: attendance; Owner: postgres
--

ALTER TABLE ONLY attendance.intervals
    ADD CONSTRAINT "Intervals_pkey" PRIMARY KEY (id);


--
-- Name: config config_pkey; Type: CONSTRAINT; Schema: attendance; Owner: postgres
--

ALTER TABLE ONLY attendance.config
    ADD CONSTRAINT config_pkey PRIMARY KEY ("ID");


--
-- Name: intervals intervals_id_key; Type: CONSTRAINT; Schema: attendance; Owner: postgres
--

ALTER TABLE ONLY attendance.intervals
    ADD CONSTRAINT intervals_id_key UNIQUE (id);


--
-- Name: users users_card_key; Type: CONSTRAINT; Schema: attendance; Owner: postgres
--

ALTER TABLE ONLY attendance.users
    ADD CONSTRAINT users_card_key UNIQUE (card);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: attendance; Owner: postgres
--

ALTER TABLE ONLY attendance.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: AccessLevels AccessLevels_pkey; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp."AccessLevels"
    ADD CONSTRAINT "AccessLevels_pkey" PRIMARY KEY ("AccessLevelID");


--
-- Name: CheckListTPLs CheckListTPLs_pkey; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp."CheckListTPLs"
    ADD CONSTRAINT "CheckListTPLs_pkey" PRIMARY KEY ("CheckListTPLID");


--
-- Name: CheckListUnits CheckListUnits_pkey; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp."CheckListUnits"
    ADD CONSTRAINT "CheckListUnits_pkey" PRIMARY KEY ("CheckListUnitID");


--
-- Name: Comments Comments_pkey; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp."Comments"
    ADD CONSTRAINT "Comments_pkey" PRIMARY KEY ("CommentID");


--
-- Name: Docs Docs_ID_key; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp."Docs"
    ADD CONSTRAINT "Docs_ID_key" UNIQUE ("ID");


--
-- Name: Docs Docs_Key_key; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp."Docs"
    ADD CONSTRAINT "Docs_Key_key" UNIQUE ("Key");


--
-- Name: Docs Docs_pkey; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp."Docs"
    ADD CONSTRAINT "Docs_pkey" PRIMARY KEY ("ID");


--
-- Name: Notifications Notifications_pkey; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp."Notifications"
    ADD CONSTRAINT "Notifications_pkey" PRIMARY KEY ("ID");


--
-- Name: OrderItems OrderItems_pkey; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp."OrderItems"
    ADD CONSTRAINT "OrderItems_pkey" PRIMARY KEY ("OrderItemID");


--
-- Name: OrderStatus OrderStatus_pkey; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp."OrderStatus"
    ADD CONSTRAINT "OrderStatus_pkey" PRIMARY KEY ("ID");


--
-- Name: Orders Orders_pkey; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp."Orders"
    ADD CONSTRAINT "Orders_pkey" PRIMARY KEY ("OrderID");


--
-- Name: PaymentHistory PaymentHistory_id_key; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp."PaymentHistory"
    ADD CONSTRAINT "PaymentHistory_id_key" UNIQUE ("ID");


--
-- Name: PaymentHistory PaymentHistory_pkey; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp."PaymentHistory"
    ADD CONSTRAINT "PaymentHistory_pkey" PRIMARY KEY ("ID");


--
-- Name: Tokens Tokrns_pkey; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp."Tokens"
    ADD CONSTRAINT "Tokrns_pkey" PRIMARY KEY ("ID");


--
-- Name: Users Users_pkey; Type: CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp."Users"
    ADD CONSTRAINT "Users_pkey" PRIMARY KEY ("UserID");


--
-- Name: hdb_action_log hdb_action_log_pkey; Type: CONSTRAINT; Schema: hdb_catalog; Owner: postgres
--

ALTER TABLE ONLY hdb_catalog.hdb_action_log
    ADD CONSTRAINT hdb_action_log_pkey PRIMARY KEY (id);


--
-- Name: hdb_cron_event_invocation_logs hdb_cron_event_invocation_logs_pkey; Type: CONSTRAINT; Schema: hdb_catalog; Owner: postgres
--

ALTER TABLE ONLY hdb_catalog.hdb_cron_event_invocation_logs
    ADD CONSTRAINT hdb_cron_event_invocation_logs_pkey PRIMARY KEY (id);


--
-- Name: hdb_cron_events hdb_cron_events_pkey; Type: CONSTRAINT; Schema: hdb_catalog; Owner: postgres
--

ALTER TABLE ONLY hdb_catalog.hdb_cron_events
    ADD CONSTRAINT hdb_cron_events_pkey PRIMARY KEY (id);


--
-- Name: hdb_metadata hdb_metadata_pkey; Type: CONSTRAINT; Schema: hdb_catalog; Owner: postgres
--

ALTER TABLE ONLY hdb_catalog.hdb_metadata
    ADD CONSTRAINT hdb_metadata_pkey PRIMARY KEY (id);


--
-- Name: hdb_metadata hdb_metadata_resource_version_key; Type: CONSTRAINT; Schema: hdb_catalog; Owner: postgres
--

ALTER TABLE ONLY hdb_catalog.hdb_metadata
    ADD CONSTRAINT hdb_metadata_resource_version_key UNIQUE (resource_version);


--
-- Name: hdb_scheduled_event_invocation_logs hdb_scheduled_event_invocation_logs_pkey; Type: CONSTRAINT; Schema: hdb_catalog; Owner: postgres
--

ALTER TABLE ONLY hdb_catalog.hdb_scheduled_event_invocation_logs
    ADD CONSTRAINT hdb_scheduled_event_invocation_logs_pkey PRIMARY KEY (id);


--
-- Name: hdb_scheduled_events hdb_scheduled_events_pkey; Type: CONSTRAINT; Schema: hdb_catalog; Owner: postgres
--

ALTER TABLE ONLY hdb_catalog.hdb_scheduled_events
    ADD CONSTRAINT hdb_scheduled_events_pkey PRIMARY KEY (id);


--
-- Name: hdb_schema_notifications hdb_schema_notifications_pkey; Type: CONSTRAINT; Schema: hdb_catalog; Owner: postgres
--

ALTER TABLE ONLY hdb_catalog.hdb_schema_notifications
    ADD CONSTRAINT hdb_schema_notifications_pkey PRIMARY KEY (id);


--
-- Name: hdb_version hdb_version_pkey; Type: CONSTRAINT; Schema: hdb_catalog; Owner: postgres
--

ALTER TABLE ONLY hdb_catalog.hdb_version
    ADD CONSTRAINT hdb_version_pkey PRIMARY KEY (hasura_uuid);


--
-- Name: inpurData1 inpurData1_Ticker_key; Type: CONSTRAINT; Schema: traderBot; Owner: postgres
--

ALTER TABLE ONLY "traderBot"."inpurData1"
    ADD CONSTRAINT "inpurData1_Ticker_key" UNIQUE ("Ticker");


--
-- Name: inpurData1 inpurData1_pkey; Type: CONSTRAINT; Schema: traderBot; Owner: postgres
--

ALTER TABLE ONLY "traderBot"."inpurData1"
    ADD CONSTRAINT "inpurData1_pkey" PRIMARY KEY (id);


--
-- Name: inputData inputData_pkey; Type: CONSTRAINT; Schema: traderBot; Owner: postgres
--

ALTER TABLE ONLY "traderBot"."inputData"
    ADD CONSTRAINT "inputData_pkey" PRIMARY KEY (id);


--
-- Name: hdb_cron_event_status; Type: INDEX; Schema: hdb_catalog; Owner: postgres
--

CREATE INDEX hdb_cron_event_status ON hdb_catalog.hdb_cron_events USING btree (status);


--
-- Name: hdb_cron_events_unique_scheduled; Type: INDEX; Schema: hdb_catalog; Owner: postgres
--

CREATE UNIQUE INDEX hdb_cron_events_unique_scheduled ON hdb_catalog.hdb_cron_events USING btree (trigger_name, scheduled_time) WHERE (status = 'scheduled'::text);


--
-- Name: hdb_scheduled_event_status; Type: INDEX; Schema: hdb_catalog; Owner: postgres
--

CREATE INDEX hdb_scheduled_event_status ON hdb_catalog.hdb_scheduled_events USING btree (status);


--
-- Name: hdb_version_one_row; Type: INDEX; Schema: hdb_catalog; Owner: postgres
--

CREATE UNIQUE INDEX hdb_version_one_row ON hdb_catalog.hdb_version USING btree (((version IS NOT NULL)));


--
-- Name: intervals Intervals_Card_fkey; Type: FK CONSTRAINT; Schema: attendance; Owner: postgres
--

ALTER TABLE ONLY attendance.intervals
    ADD CONSTRAINT "Intervals_Card_fkey" FOREIGN KEY (card) REFERENCES attendance.users(card) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: CheckListUnits CheckListUnits_OrderID_fkey; Type: FK CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp."CheckListUnits"
    ADD CONSTRAINT "CheckListUnits_OrderID_fkey" FOREIGN KEY ("OrderID") REFERENCES erp."Orders"("OrderID") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Comments Comments_OrderID_fkey; Type: FK CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp."Comments"
    ADD CONSTRAINT "Comments_OrderID_fkey" FOREIGN KEY ("OrderID") REFERENCES erp."Orders"("OrderID") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Comments Comments_UserID_fkey; Type: FK CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp."Comments"
    ADD CONSTRAINT "Comments_UserID_fkey" FOREIGN KEY ("UserID") REFERENCES erp."Users"("UserID") ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: Docs Docs_OrderID_fkey; Type: FK CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp."Docs"
    ADD CONSTRAINT "Docs_OrderID_fkey" FOREIGN KEY ("OrderID") REFERENCES erp."Orders"("OrderID") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Notifications Notifications_CommentID_fkey; Type: FK CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp."Notifications"
    ADD CONSTRAINT "Notifications_CommentID_fkey" FOREIGN KEY ("CommentID") REFERENCES erp."Comments"("CommentID") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Notifications Notifications_MentionedUser_fkey; Type: FK CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp."Notifications"
    ADD CONSTRAINT "Notifications_MentionedUser_fkey" FOREIGN KEY ("MentionedUser") REFERENCES erp."Users"("UserID") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Notifications Notifications_OrderID_fkey; Type: FK CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp."Notifications"
    ADD CONSTRAINT "Notifications_OrderID_fkey" FOREIGN KEY ("OrderID") REFERENCES erp."Orders"("OrderID") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: OrderItems OrderItems_OrderID_fkey; Type: FK CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp."OrderItems"
    ADD CONSTRAINT "OrderItems_OrderID_fkey" FOREIGN KEY ("OrderID") REFERENCES erp."Orders"("OrderID") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Orders Orders_CheckListTPLID_fkey; Type: FK CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp."Orders"
    ADD CONSTRAINT "Orders_CheckListTPLID_fkey" FOREIGN KEY ("CheckListTPLID") REFERENCES erp."CheckListTPLs"("CheckListTPLID") ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: Orders Orders_ManagerID_fkey; Type: FK CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp."Orders"
    ADD CONSTRAINT "Orders_ManagerID_fkey" FOREIGN KEY ("ManagerID") REFERENCES erp."Users"("UserID") ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: Orders Orders_OrderStatusID_fkey; Type: FK CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp."Orders"
    ADD CONSTRAINT "Orders_OrderStatusID_fkey" FOREIGN KEY ("OrderStatusID") REFERENCES erp."OrderStatus"("ID") ON UPDATE SET NULL ON DELETE SET NULL;


--
-- Name: PaymentHistory PaymentHistory_OrderID_fkey; Type: FK CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp."PaymentHistory"
    ADD CONSTRAINT "PaymentHistory_OrderID_fkey" FOREIGN KEY ("OrderID") REFERENCES erp."Orders"("OrderID") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Tokens Tokrns_UserID_fkey; Type: FK CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp."Tokens"
    ADD CONSTRAINT "Tokrns_UserID_fkey" FOREIGN KEY ("UserID") REFERENCES erp."Users"("UserID") ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: Users Users_AccessLevelID_fkey; Type: FK CONSTRAINT; Schema: erp; Owner: postgres
--

ALTER TABLE ONLY erp."Users"
    ADD CONSTRAINT "Users_AccessLevelID_fkey" FOREIGN KEY ("AccessLevelID") REFERENCES erp."AccessLevels"("AccessLevelID") ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: hdb_cron_event_invocation_logs hdb_cron_event_invocation_logs_event_id_fkey; Type: FK CONSTRAINT; Schema: hdb_catalog; Owner: postgres
--

ALTER TABLE ONLY hdb_catalog.hdb_cron_event_invocation_logs
    ADD CONSTRAINT hdb_cron_event_invocation_logs_event_id_fkey FOREIGN KEY (event_id) REFERENCES hdb_catalog.hdb_cron_events(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: hdb_scheduled_event_invocation_logs hdb_scheduled_event_invocation_logs_event_id_fkey; Type: FK CONSTRAINT; Schema: hdb_catalog; Owner: postgres
--

ALTER TABLE ONLY hdb_catalog.hdb_scheduled_event_invocation_logs
    ADD CONSTRAINT hdb_scheduled_event_invocation_logs_event_id_fkey FOREIGN KEY (event_id) REFERENCES hdb_catalog.hdb_scheduled_events(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--
