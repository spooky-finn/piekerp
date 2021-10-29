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
-- Name: intervalsPool; Type: TABLE; Schema: attendance; Owner: postgres
--

CREATE TABLE attendance."intervalsPool" (
    entrance timestamp without time zone NOT NULL,
    exit timestamp without time zone NOT NULL,
    "interval" real NOT NULL,
    status integer,
    card text NOT NULL,
    "IntervalID" integer NOT NULL
);


ALTER TABLE attendance."intervalsPool" OWNER TO postgres;

--
-- Name: intervalsPool_IntervalID_seq; Type: SEQUENCE; Schema: attendance; Owner: postgres
--

CREATE SEQUENCE attendance."intervalsPool_IntervalID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE attendance."intervalsPool_IntervalID_seq" OWNER TO postgres;

--
-- Name: intervalsPool_IntervalID_seq; Type: SEQUENCE OWNED BY; Schema: attendance; Owner: postgres
--

ALTER SEQUENCE attendance."intervalsPool_IntervalID_seq" OWNED BY attendance."intervalsPool"."IntervalID";


--
-- Name: users; Type: TABLE; Schema: attendance; Owner: postgres
--

CREATE TABLE attendance.users (
    id integer NOT NULL,
    firstname text,
    lastname text,
    card text
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
    "MentionedUsers" jsonb,
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
    "ID" integer NOT NULL
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
-- Name: OrderItems; Type: TABLE; Schema: erp; Owner: postgres
--

CREATE TABLE erp."OrderItems" (
    "OrderItemID" integer NOT NULL,
    "OrderID" integer NOT NULL,
    "Name" character varying(255) NOT NULL,
    "Quantity" integer NOT NULL,
    "Fitter" character varying(255),
    "FullName" text,
    "SerialNumber" text
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
    "IsReclamation" boolean NOT NULL,
    "InvoiceNumber" character varying,
    "ShippingDate" date,
    "AwaitingDispatch" boolean DEFAULT false NOT NULL,
    "AcceptanceDate" timestamp with time zone,
    "ActualShippingDate" timestamp with time zone,
    "OrderNumber" character varying
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
-- Name: intervalsPool IntervalID; Type: DEFAULT; Schema: attendance; Owner: postgres
--

ALTER TABLE ONLY attendance."intervalsPool" ALTER COLUMN "IntervalID" SET DEFAULT nextval('attendance."intervalsPool_IntervalID_seq"'::regclass);


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
-- Data for Name: intervalsPool; Type: TABLE DATA; Schema: attendance; Owner: postgres
--

COPY attendance."intervalsPool" (entrance, exit, "interval", status, card, "IntervalID") FROM stdin;
2021-06-01 15:45:30	2021-06-01 23:45:30	8	102	1415737737	35330
2021-06-02 06:23:10	2021-06-02 15:46:21	9.38	100	1415737737	35331
2021-06-03 06:22:56	2021-06-03 15:46:52	9.38	100	1415737737	35332
2021-06-04 06:20:39	2021-06-04 15:39:27	9.3	100	1415737737	35333
2021-06-07 06:38:43	2021-06-07 15:45:03	9.1	100	1415737737	35334
2021-06-08 15:44:45	2021-06-08 23:44:45	8	102	1415737737	35335
2021-06-09 06:19:11	2021-06-09 15:40:50	9.35	100	1415737737	35336
2021-06-10 06:34:30	2021-06-10 15:41:26	9.1	100	1415737737	35337
2021-06-11 06:22:58	2021-06-11 14:43:38	8.33	100	1415737737	35338
2021-06-15 06:18:53	2021-06-15 14:18:53	8	102	1415737737	35339
2021-06-17 06:22:48	2021-06-17 14:56:44	8.55	100	1415737737	35340
2021-06-18 14:30:26	2021-06-18 22:30:26	8	102	1415737737	35341
2021-06-21 06:21:40	2021-06-21 15:43:38	9.35	100	1415737737	35342
2021-06-22 06:11:55	2021-06-22 15:44:56	9.55	100	1415737737	35343
2021-06-23 06:13:34	2021-06-23 14:13:34	8	102	1415737737	35344
2021-06-24 06:28:44	2021-06-24 15:37:58	9.15	100	1415737737	35345
2021-06-25 06:25:00	2021-06-25 14:25:00	8	102	1415737737	35346
2021-06-28 06:26:00	2021-06-28 15:43:06	9.28	100	1415737737	35347
2021-06-29 06:25:29	2021-06-29 14:25:29	8	102	1415737737	35348
2021-06-30 06:28:53	2021-06-30 15:41:21	9.2	100	1415737737	35349
2021-06-11 04:44:58	2021-06-20 11:15:18	8.78	101	1130719028	35350
2021-06-20 21:46:40	2021-06-20 21:46:47	0	100	1130719028	35351
2021-06-22 04:38:25	2021-06-22 12:38:50	8	101	1130719028	35352
2021-06-23 04:45:08	2021-06-23 04:45:11	0	100	1130719028	35353
2021-06-29 04:13:55	2021-06-29 04:14:01	0	101	1130719028	35354
2021-06-03 18:31:35	2021-06-04 02:31:35	8	102	1130719028	35355
2021-06-10 19:50:17	2021-06-11 03:50:17	8	102	1130719028	35356
2021-06-15 05:14:56	2021-06-15 05:15:26	0	101	1130719028	35357
2021-06-16 05:19:48	2021-06-16 05:19:51	0	100	1130719028	35358
2021-06-17 05:19:14	2021-06-17 13:19:14	8	102	1130719028	35359
2021-06-18 05:19:32	2021-06-18 13:26:10	8.1	100	1130719028	35360
2021-06-21 05:17:35	2021-06-21 13:17:35	8	102	1130719028	35361
2021-06-22 05:17:45	2021-06-22 05:18:01	0	100	1130719028	35362
2021-06-02 05:47:15	2021-06-02 13:47:15	8	102	371819779	35363
2021-06-03 05:49:55	2021-06-03 13:49:55	8	102	371819779	35364
2021-06-04 05:58:18	2021-06-04 13:58:18	8	102	371819779	35365
2021-06-05 05:57:31	2021-06-05 13:57:31	8	102	371819779	35366
2021-06-07 05:48:55	2021-06-07 06:21:52	0.53	100	371819779	35367
2021-06-08 05:49:54	2021-06-08 09:25:15	3.58	100	371819779	35368
2021-06-09 05:58:45	2021-06-09 15:36:42	9.62	100	371819779	35369
2021-06-11 05:48:43	2021-06-11 13:48:43	8	102	371819779	35370
2021-06-15 05:47:44	2021-06-15 13:47:44	8	102	371819779	35371
2021-06-16 05:51:40	2021-06-16 13:51:40	8	102	371819779	35372
2021-06-17 05:48:14	2021-06-17 13:48:14	8	102	371819779	35373
2021-06-18 05:53:38	2021-06-18 13:53:38	8	102	371819779	35374
2021-06-21 05:48:34	2021-06-21 13:48:34	8	102	371819779	35375
2021-06-22 05:49:28	2021-06-22 14:33:49	8.73	100	371819779	35376
2021-06-23 14:48:53	2021-06-23 22:48:53	8	102	371819779	35377
2021-06-24 05:59:07	2021-06-24 13:59:07	8	102	371819779	35378
2021-06-25 05:52:58	2021-06-25 14:33:59	8.68	100	371819779	35379
2021-06-26 05:47:56	2021-06-26 11:34:07	5.77	100	371819779	35380
2021-06-28 05:49:49	2021-06-28 15:13:15	9.38	100	371819779	35381
2021-06-29 06:03:35	2021-06-29 11:16:23	5.2	100	371819779	35382
2021-06-30 05:48:37	2021-06-30 14:36:55	8.8	100	371819779	35383
2021-06-30 08:32:18	2021-06-30 16:32:18	8	101	2018780721	35384
2021-06-15 15:27:27	2021-06-15 23:27:27	8	102	2018780721	35385
2021-06-16 14:48:22	2021-06-16 22:48:22	8	102	2018780721	35386
2021-06-17 14:40:54	2021-06-17 22:40:54	8	102	2018780721	35387
2021-06-22 15:39:45	2021-06-23 05:11:47	13.53	100	2018780721	35388
2021-06-23 15:42:21	2021-06-24 05:21:36	13.65	100	2018780721	35389
2021-06-24 15:31:10	2021-06-25 05:12:08	13.67	100	2018780721	35390
2021-06-25 14:40:05	2021-06-25 22:40:05	8	102	2018780721	35391
2021-06-28 05:16:34	2021-06-28 15:37:10	10.33	100	2018780721	35392
2021-06-29 05:18:35	2021-06-29 15:31:48	10.22	100	2018780721	35393
2021-06-30 05:18:02	2021-06-30 15:36:20	10.3	100	2018780721	35394
2021-06-02 06:26:19	2021-06-02 14:26:19	8	102	1383686920	35396
2021-06-03 06:37:44	2021-06-03 14:37:44	8	102	1383686920	35397
2021-06-07 06:33:25	2021-06-07 14:33:25	8	102	1383686920	35398
2021-06-08 06:35:31	2021-06-08 14:35:31	8	102	1383686920	35399
2021-06-09 06:34:14	2021-06-09 14:34:14	8	102	1383686920	35400
2021-06-10 06:36:23	2021-06-10 14:36:23	8	102	1383686920	35401
2021-06-11 06:45:25	2021-06-11 14:45:25	8	102	1383686920	35402
2021-06-15 06:25:56	2021-06-15 14:25:56	8	102	1383686920	35403
2021-06-16 06:45:44	2021-06-16 14:45:44	8	102	1383686920	35404
2021-06-17 06:28:23	2021-06-17 14:28:23	8	102	1383686920	35405
2021-06-18 06:37:15	2021-06-18 14:37:15	8	102	1383686920	35406
2021-06-21 06:23:46	2021-06-21 14:23:46	8	102	1383686920	35407
2021-06-22 06:25:07	2021-06-22 14:25:07	8	102	1383686920	35408
2021-06-23 06:26:35	2021-06-23 14:26:35	8	102	1383686920	35409
2021-06-24 06:56:29	2021-06-24 14:56:29	8	102	1383686920	35410
2021-06-28 06:29:20	2021-06-28 14:29:20	8	102	1383686920	35411
2021-06-29 06:31:07	2021-06-29 14:31:07	8	102	1383686920	35412
2021-06-30 06:27:02	2021-06-30 14:27:02	8	102	1383686920	35413
2021-06-03 13:26:01	2021-06-03 21:26:01	8	102	1383686920	35414
2021-06-07 12:08:36	2021-06-07 20:08:36	8	102	1383686920	35415
2021-06-08 13:49:58	2021-06-08 21:49:58	8	102	1383686920	35416
2021-06-09 13:43:34	2021-06-09 21:43:34	8	102	1383686920	35417
2021-06-11 12:03:33	2021-06-11 20:03:33	8	102	1383686920	35418
2021-06-15 14:09:18	2021-06-15 22:09:18	8	102	1383686920	35419
2021-06-16 14:36:12	2021-06-16 22:36:12	8	102	1383686920	35420
2021-06-17 13:40:17	2021-06-17 21:40:17	8	102	1383686920	35421
2021-06-18 11:48:02	2021-06-18 19:48:02	8	102	1383686920	35422
2021-06-21 14:03:24	2021-06-21 22:03:24	8	102	1383686920	35423
2021-06-22 11:49:38	2021-06-22 19:49:38	8	102	1383686920	35424
2021-06-23 11:45:53	2021-06-23 19:45:53	8	102	1383686920	35425
2021-06-24 13:41:37	2021-06-24 21:41:37	8	102	1383686920	35426
2021-06-28 13:29:41	2021-06-28 21:29:41	8	102	1383686920	35427
2021-06-29 13:35:50	2021-06-29 21:35:50	8	102	1383686920	35428
2021-06-02 06:24:54	2021-06-02 14:24:54	8	102	1947362688	35429
2021-06-03 07:58:07	2021-06-03 15:58:07	8	102	1947362688	35430
2021-06-04 06:26:09	2021-06-04 14:26:09	8	102	1947362688	35431
2021-06-08 06:26:54	2021-06-08 14:26:54	8	102	1947362688	35432
2021-06-10 06:29:56	2021-06-10 14:29:56	8	102	1947362688	35433
2021-06-15 06:30:38	2021-06-15 14:30:38	8	102	1947362688	35434
2021-06-16 06:29:54	2021-06-16 14:29:54	8	102	1947362688	35435
2021-06-17 06:21:28	2021-06-17 14:21:28	8	102	1947362688	35436
2021-06-18 06:24:51	2021-06-18 14:24:51	8	102	1947362688	35437
2021-06-21 06:27:37	2021-06-21 14:27:37	8	102	1947362688	35438
2021-06-22 06:26:04	2021-06-22 14:26:04	8	102	1947362688	35439
2021-06-23 06:20:38	2021-06-23 14:20:38	8	102	1947362688	35440
2021-06-24 06:26:10	2021-06-24 14:26:10	8	102	1947362688	35441
2021-06-25 06:19:36	2021-06-25 14:19:36	8	102	1947362688	35442
2021-06-28 06:24:24	2021-06-28 14:09:21	7.73	100	1947362688	35443
2021-06-29 06:25:43	2021-06-29 14:25:43	8	102	1947362688	35444
2021-06-02 15:35:35	2021-06-02 23:35:35	8	102	1947362688	35445
2021-06-03 15:35:58	2021-06-03 23:35:58	8	102	1947362688	35446
2021-06-08 15:37:32	2021-06-08 23:37:32	8	102	1947362688	35447
2021-06-15 15:29:01	2021-06-15 23:29:01	8	102	1947362688	35448
2021-06-17 13:48:40	2021-06-17 21:48:40	8	102	1947362688	35449
2021-06-22 15:14:44	2021-06-22 23:14:44	8	102	1947362688	35450
2021-06-23 13:44:16	2021-06-23 21:44:16	8	102	1947362688	35451
2021-06-25 13:22:12	2021-06-25 21:22:12	8	102	1947362688	35452
2021-06-29 13:57:53	2021-06-29 21:57:53	8	102	1947362688	35453
2021-06-17 07:05:27	2021-06-17 15:05:27	8	102	1380387121	35454
2021-06-01 06:57:13	2021-06-01 17:11:05	10.22	100	1380387121	35455
2021-06-02 07:12:48	2021-06-02 15:12:48	8	102	1380387121	35456
2021-06-03 19:25:37	2021-06-04 03:25:37	8	102	1380387121	35457
2021-06-07 07:11:42	2021-06-07 16:46:01	9.57	100	1380387121	35458
2021-06-08 07:14:24	2021-06-08 17:17:50	10.05	100	1380387121	35459
2021-06-09 07:11:03	2021-06-09 16:14:29	9.05	100	1380387121	35460
2021-06-10 07:15:08	2021-06-10 18:02:05	10.77	100	1380387121	35461
2021-06-11 07:11:04	2021-06-11 15:11:04	8	102	1380387121	35462
2021-06-15 07:04:22	2021-06-15 16:33:15	9.47	100	1380387121	35463
2021-06-16 07:00:23	2021-06-16 15:00:23	8	102	1380387121	35464
2021-06-18 07:11:51	2021-06-18 17:04:51	9.88	100	1380387121	35465
2021-06-21 07:01:41	2021-06-21 17:38:34	10.6	100	1380387121	35466
2021-06-22 07:08:31	2021-06-22 17:19:39	10.18	100	1380387121	35467
2021-06-23 07:01:41	2021-06-23 16:46:52	9.75	100	1380387121	35468
2021-06-24 07:13:20	2021-06-24 16:46:04	9.53	100	1380387121	35469
2021-06-25 07:10:55	2021-06-25 15:27:56	8.28	100	1380387121	35470
2021-06-28 07:09:57	2021-06-28 17:01:20	9.85	100	1380387121	35471
2021-06-29 06:56:57	2021-06-29 16:15:08	9.3	100	1380387121	35472
2021-06-30 06:57:06	2021-06-30 17:11:54	10.23	100	1380387121	35473
2021-06-20 06:20:36	2021-06-20 12:05:04	5.73	100	2456061779	35474
2021-06-20 20:25:18	2021-06-21 02:49:54	6.38	101	2456061779	35475
2021-06-23 21:46:18	2021-06-24 05:46:18	8	102	2456061779	35476
2021-06-26 22:05:26	2021-06-27 03:48:52	5.72	100	2456061779	35477
2021-06-29 19:01:44	2021-06-30 03:01:44	8	102	2456061779	35478
2021-06-02 07:02:44	2021-06-02 15:02:44	8	102	2456061779	35479
2021-06-03 07:07:53	2021-06-03 15:07:53	8	102	2456061779	35480
2021-06-05 19:20:59	2021-06-06 07:29:17	11.78	101	2456061779	35481
2021-06-08 07:08:51	2021-06-08 15:08:51	8	102	2456061779	35482
2021-06-11 19:23:14	2021-06-12 06:26:45	10.68	101	2456061779	35483
2021-06-14 07:00:55	2021-06-14 15:00:55	8	102	2456061779	35484
2021-06-15 07:11:57	2021-06-15 15:11:57	8	102	2456061779	35485
2021-06-17 19:03:20	2021-06-18 07:18:51	12.25	100	2456061779	35486
2021-06-20 05:43:45	2021-06-20 18:53:53	13.17	100	2456061779	35487
2021-06-20 21:16:13	2021-06-21 07:16:43	10	100	2456061779	35488
2021-06-23 18:53:09	2021-06-24 07:19:36	12.43	100	2456061779	35489
2021-06-26 07:10:15	2021-06-26 15:10:15	8	102	2456061779	35490
2021-06-27 06:14:14	2021-06-27 14:14:14	8	102	2456061779	35491
2021-06-29 18:51:11	2021-06-30 07:31:20	12.67	100	2456061779	35492
2021-06-29 13:53:41	2021-06-29 21:53:41	8	102	694629652	35493
2021-06-30 14:33:33	2021-06-30 14:34:06	0	100	694629652	35494
2021-06-02 14:01:07	2021-06-02 22:01:07	8	102	1631061826	35495
2021-06-03 14:03:52	2021-06-03 22:03:52	8	102	1631061826	35496
2021-06-04 13:54:47	2021-06-04 21:54:47	8	102	1631061826	35497
2021-06-08 05:45:52	2021-06-08 13:45:52	8	102	1631061826	35498
2021-06-11 05:50:20	2021-06-11 13:50:20	8	102	1631061826	35499
2021-06-15 14:01:01	2021-06-15 22:01:01	8	102	1631061826	35500
2021-06-16 12:23:46	2021-06-16 20:23:46	8	102	1631061826	35501
2021-06-17 16:05:49	2021-06-18 00:05:49	8	102	1631061826	35502
2021-06-21 05:52:50	2021-06-21 14:46:20	8.88	100	1631061826	35503
2021-06-22 05:48:20	2021-06-22 14:38:31	8.83	100	1631061826	35504
2021-06-23 05:53:59	2021-06-23 14:39:04	8.75	100	1631061826	35505
2021-06-24 05:50:09	2021-06-24 14:40:39	8.83	100	1631061826	35506
2021-06-25 13:40:19	2021-06-25 21:40:19	8	102	1631061826	35507
2021-06-28 14:06:12	2021-06-28 22:06:12	8	102	1631061826	35508
2021-06-29 13:53:47	2021-06-30 01:03:40	11.15	100	1631061826	35509
2021-06-30 14:02:10	2021-06-30 23:03:44	9.02	100	1631061826	35510
2021-06-02 07:14:25	2021-06-02 15:14:25	8	102	1698169367	35511
2021-06-03 07:11:32	2021-06-03 15:11:32	8	102	1698169367	35512
2021-06-04 07:15:59	2021-06-04 15:15:59	8	102	1698169367	35513
2021-06-07 07:15:26	2021-06-07 15:15:26	8	102	1698169367	35514
2021-06-08 07:15:07	2021-06-08 15:15:07	8	102	1698169367	35515
2021-06-09 07:16:06	2021-06-09 15:16:06	8	102	1698169367	35516
2021-06-10 07:16:55	2021-06-10 15:16:55	8	102	1698169367	35517
2021-06-11 07:14:25	2021-06-11 15:14:25	8	102	1698169367	35518
2021-06-15 07:14:50	2021-06-15 15:14:50	8	102	1698169367	35519
2021-06-16 07:14:27	2021-06-16 15:14:27	8	102	1698169367	35520
2021-06-17 07:12:20	2021-06-17 15:12:20	8	102	1698169367	35521
2021-06-18 07:20:03	2021-06-18 15:20:03	8	102	1698169367	35522
2021-06-21 07:13:33	2021-06-21 16:06:07	8.87	100	1698169367	35523
2021-06-22 07:16:49	2021-06-22 16:05:47	8.8	100	1698169367	35524
2021-06-23 07:14:27	2021-06-23 16:04:30	8.83	100	1698169367	35525
2021-06-24 07:16:59	2021-06-24 16:11:28	8.9	100	1698169367	35526
2021-06-25 07:13:53	2021-06-25 15:04:32	7.83	100	1698169367	35527
2021-06-28 07:15:54	2021-06-28 16:04:44	8.8	100	1698169367	35528
2021-06-29 07:07:23	2021-06-29 16:05:38	8.97	100	1698169367	35529
2021-06-30 07:13:14	2021-06-30 16:04:23	8.85	100	1698169367	35530
2021-06-15 10:43:18	2021-06-15 18:43:18	8	102	1465987648	35531
2021-06-01 05:56:10	2021-06-01 14:32:22	8.6	100	1465987648	35532
2021-06-02 14:34:32	2021-06-02 22:34:32	8	102	1465987648	35533
2021-06-03 14:27:25	2021-06-03 22:27:25	8	102	1465987648	35534
2021-06-04 14:33:15	2021-06-04 22:33:15	8	102	1465987648	35535
2021-06-07 05:57:10	2021-06-07 14:50:21	8.88	100	1465987648	35536
2021-06-08 13:21:38	2021-06-08 21:21:38	8	102	1465987648	35537
2021-06-11 14:41:35	2021-06-11 22:41:35	8	102	1465987648	35538
2021-06-15 10:45:14	2021-06-15 11:13:37	0.47	100	1465987648	35539
2021-06-16 14:29:45	2021-06-16 22:29:45	8	102	1465987648	35540
2021-06-17 14:33:47	2021-06-17 22:33:47	8	102	1465987648	35541
2021-06-18 13:32:33	2021-06-18 21:32:33	8	102	1465987648	35542
2021-06-22 14:29:56	2021-06-22 22:29:56	8	102	1465987648	35543
2021-06-24 14:23:07	2021-06-24 22:23:07	8	102	1465987648	35544
2021-06-28 14:48:33	2021-06-28 22:48:33	8	102	1465987648	35545
2021-06-29 13:38:02	2021-06-29 21:38:02	8	102	1465987648	35546
2021-06-08 14:55:00	2021-06-08 22:55:00	8	102	830838336	35547
2021-06-23 06:10:47	2021-06-23 14:10:47	8	102	830838336	35548
2021-06-04 05:43:59	2021-06-04 13:43:59	8	102	890710116	35549
2021-06-11 13:05:59	2021-06-11 21:05:59	8	102	890710116	35550
2021-06-16 05:43:56	2021-06-16 13:43:56	8	102	890710116	35551
2021-06-17 05:41:21	2021-06-17 13:41:21	8	102	890710116	35552
2021-06-18 05:37:17	2021-06-18 13:37:17	8	102	890710116	35553
2021-06-22 14:07:50	2021-06-22 23:03:02	8.92	100	890710116	35554
2021-06-23 14:05:48	2021-06-23 23:02:33	8.93	100	890710116	35555
2021-06-24 14:03:39	2021-06-24 23:03:50	8.92	101	890710116	35556
2021-06-25 12:59:14	2021-06-25 21:02:12	8.03	100	890710116	35557
2021-06-28 05:45:14	2021-06-28 14:39:17	8.9	100	890710116	35558
2021-06-29 05:43:23	2021-06-29 05:44:18	0	100	890710116	35559
2021-06-29 14:38:47	2021-06-29 22:38:47	8	102	890710116	35560
2021-06-30 05:44:11	2021-06-30 14:39:41	8.92	100	890710116	35561
2021-06-02 05:43:22	2021-06-02 13:43:22	8	102	890710116	35562
2021-06-03 05:40:27	2021-06-03 14:39:05	8.97	100	890710116	35563
2021-06-07 14:13:48	2021-06-07 22:13:48	8	102	890710116	35564
2021-06-08 14:13:24	2021-06-08 22:13:24	8	102	890710116	35565
2021-06-09 14:10:57	2021-06-09 22:10:57	8	102	890710116	35566
2021-06-10 23:02:29	2021-06-11 07:02:29	8	102	890710116	35567
2021-06-15 05:41:55	2021-06-15 14:40:47	8.97	100	890710116	35568
2021-06-02 08:19:06	2021-06-02 16:19:06	8	102	628164963	35569
2021-06-03 08:17:46	2021-06-03 16:17:46	8	102	628164963	35570
2021-06-04 08:25:57	2021-06-04 09:26:17	1	100	628164963	35571
2021-06-07 08:23:19	2021-06-07 16:23:19	8	102	628164963	35572
2021-06-08 08:18:54	2021-06-08 12:50:57	4.53	100	628164963	35573
2021-06-09 08:36:06	2021-06-09 11:33:59	2.95	100	628164963	35574
2021-06-10 08:33:38	2021-06-10 20:36:36	9.88	101	628164963	35575
2021-06-11 08:40:48	2021-06-11 16:40:48	8	102	628164963	35576
2021-06-15 08:53:52	2021-06-15 16:53:52	8	102	628164963	35577
2021-06-16 08:13:30	2021-06-16 11:04:05	2.83	100	628164963	35578
2021-06-17 08:44:59	2021-06-17 10:20:38	1.58	100	628164963	35579
2021-06-18 08:26:09	2021-06-18 16:26:09	8	102	628164963	35580
2021-06-21 08:00:59	2021-06-21 16:28:34	8.07	101	628164963	35581
2021-06-22 08:29:08	2021-06-22 16:27:45	7.97	100	628164963	35582
2021-06-23 08:15:12	2021-06-23 16:07:09	7.85	100	628164963	35583
2021-06-24 16:13:22	2021-06-25 00:13:22	8	102	628164963	35584
2021-06-25 15:27:16	2021-06-25 23:27:16	8	102	628164963	35585
2021-06-30 11:09:55	2021-06-30 12:27:26	1.28	100	628164963	35586
2021-06-19 05:37:10	2021-06-19 11:51:49	6.23	100	305434710	35587
2021-06-21 16:18:46	2021-06-22 00:18:46	8	102	305434710	35588
2021-06-22 15:34:14	2021-06-22 23:34:14	8	102	305434710	35589
2021-06-23 16:31:16	2021-06-24 00:31:16	8	102	305434710	35590
2021-06-24 15:34:19	2021-06-24 23:34:19	8	102	305434710	35591
2021-06-25 14:33:35	2021-06-25 22:33:35	8	102	305434710	35592
2021-06-28 16:36:44	2021-06-29 00:36:44	8	102	305434710	35593
2021-06-02 06:27:44	2021-06-02 07:28:46	1.02	100	2181511494	35594
2021-06-04 06:38:23	2021-06-04 06:41:05	0.03	100	2181511494	35595
2021-06-05 07:24:45	2021-06-05 15:24:45	8	102	2181511494	35596
2021-06-06 16:27:31	2021-06-06 16:27:35	0	100	2181511494	35597
2021-06-07 06:26:04	2021-06-07 14:26:04	8	102	2181511494	35598
2021-06-08 06:20:06	2021-06-08 14:20:06	8	102	2181511494	35599
2021-06-10 06:16:05	2021-06-10 14:16:05	8	102	2181511494	35600
2021-06-11 06:20:15	2021-06-11 14:20:15	8	102	2181511494	35601
2021-06-15 06:23:46	2021-06-15 14:23:46	8	102	2181511494	35602
2021-06-16 06:31:46	2021-06-16 14:31:46	8	102	2181511494	35603
2021-06-17 06:27:48	2021-06-17 14:27:48	8	102	2181511494	35604
2021-06-18 06:32:42	2021-06-18 14:32:42	8	102	2181511494	35605
2021-06-21 06:10:55	2021-06-21 16:31:03	10.33	100	2181511494	35606
2021-06-22 06:19:53	2021-06-22 17:07:29	10.78	100	2181511494	35607
2021-06-23 06:24:54	2021-06-23 16:05:51	9.67	100	2181511494	35608
2021-06-24 06:24:01	2021-06-24 16:45:27	10.35	100	2181511494	35609
2021-06-25 06:34:38	2021-06-25 15:17:38	8.72	100	2181511494	35610
2021-06-28 06:27:52	2021-06-28 16:27:23	9.98	100	2181511494	35611
2021-06-29 06:26:53	2021-06-29 16:44:49	10.28	100	2181511494	35612
2021-06-30 06:33:06	2021-06-30 16:45:00	10.18	100	2181511494	35613
2021-06-01 15:53:45	2021-06-02 05:19:14	13.42	100	2215065125	35614
2021-06-02 14:17:07	2021-06-02 22:17:07	8	102	2215065125	35615
2021-06-03 05:16:48	2021-06-03 13:59:50	8.72	100	2215065125	35616
2021-06-04 13:09:38	2021-06-04 21:09:38	8	102	2215065125	35617
2021-06-05 05:26:43	2021-06-05 10:12:04	4.75	100	2215065125	35618
2021-06-07 05:16:17	2021-06-07 13:16:17	8	102	2215065125	35619
2021-06-08 16:05:14	2021-06-09 05:17:50	13.2	100	2215065125	35620
2021-06-09 13:20:02	2021-06-09 21:20:02	8	102	2215065125	35621
2021-06-10 16:04:32	2021-06-11 00:04:32	8	102	2215065125	35622
2021-06-15 05:15:16	2021-06-15 12:14:00	6.97	100	2215065125	35623
2021-06-17 05:19:09	2021-06-17 13:46:34	8.45	100	2215065125	35624
2021-06-18 05:19:28	2021-06-18 12:44:55	7.42	100	2215065125	35625
2021-06-19 05:22:56	2021-06-19 08:24:33	3.02	100	2215065125	35626
2021-06-21 13:28:26	2021-06-21 21:28:26	8	102	2215065125	35627
2021-06-22 13:11:04	2021-06-22 21:11:04	8	102	2215065125	35628
2021-06-23 13:31:02	2021-06-23 21:31:02	8	102	2215065125	35629
2021-06-24 13:25:14	2021-06-24 21:25:14	8	102	2215065125	35630
2021-06-25 05:34:47	2021-06-25 12:40:07	7.08	100	2215065125	35631
2021-06-26 05:23:48	2021-06-26 09:06:40	3.7	100	2215065125	35632
2021-06-28 14:00:21	2021-06-28 22:00:21	8	102	2215065125	35633
2021-06-29 16:16:12	2021-06-30 00:16:12	8	102	2215065125	35634
2021-06-02 06:38:17	2021-06-02 15:39:47	9.02	100	1497442311	35635
2021-06-03 06:39:37	2021-06-03 17:03:46	10.4	100	1497442311	35636
2021-06-07 06:29:21	2021-06-07 15:32:29	9.05	100	1497442311	35637
2021-06-08 06:38:10	2021-06-08 15:33:27	8.92	100	1497442311	35638
2021-06-09 15:32:50	2021-06-09 23:32:50	8	102	1497442311	35639
2021-06-11 06:34:53	2021-06-11 14:34:53	8	102	1497442311	35640
2021-06-15 06:39:03	2021-06-15 15:44:13	9.08	100	1497442311	35641
2021-06-16 06:37:18	2021-06-16 14:37:18	8	102	1497442311	35642
2021-06-17 06:36:14	2021-06-17 14:36:14	8	102	1497442311	35643
2021-06-18 06:34:55	2021-06-18 14:34:55	8	102	1497442311	35644
2021-06-21 06:37:43	2021-06-21 15:37:30	8.98	100	1497442311	35645
2021-06-22 06:40:03	2021-06-22 15:42:03	9.03	100	1497442311	35646
2021-06-23 06:46:42	2021-06-23 15:39:16	8.87	100	1497442311	35647
2021-06-24 06:36:18	2021-06-24 15:34:33	8.97	100	1497442311	35648
2021-06-25 06:35:31	2021-06-25 14:44:51	8.15	100	1497442311	35649
2021-06-28 06:39:53	2021-06-28 15:33:32	8.88	100	1497442311	35650
2021-06-29 06:33:06	2021-06-29 14:33:06	8	102	1497442311	35651
2021-06-01 15:41:30	2021-06-01 23:41:30	8	102	1905591336	35652
2021-06-02 06:40:36	2021-06-02 14:40:36	8	102	1905591336	35653
2021-06-03 06:42:53	2021-06-03 15:36:39	8.88	100	1905591336	35654
2021-06-04 06:41:34	2021-06-04 14:41:34	8	102	1905591336	35655
2021-06-08 15:38:42	2021-06-08 23:38:42	8	102	1905591336	35656
2021-06-09 06:38:40	2021-06-09 14:38:40	8	102	1905591336	35657
2021-06-10 06:41:14	2021-06-10 15:35:56	8.9	100	1905591336	35658
2021-06-11 06:40:44	2021-06-11 13:42:58	7.03	100	1905591336	35659
2021-06-15 06:44:03	2021-06-15 09:18:17	2.57	100	1905591336	35660
2021-06-16 11:01:05	2021-06-16 12:12:14	1.18	100	1905591336	35661
2021-06-17 06:41:38	2021-06-17 15:36:17	8.9	100	1905591336	35662
2021-06-18 06:44:18	2021-06-18 15:33:56	8.82	100	1905591336	35663
2021-06-21 06:42:45	2021-06-21 15:36:49	8.9	100	1905591336	35664
2021-06-22 06:48:42	2021-06-22 14:48:42	8	102	1905591336	35665
2021-06-23 06:42:09	2021-06-23 15:37:31	8.92	100	1905591336	35666
2021-06-24 06:40:38	2021-06-24 15:37:02	8.93	100	1905591336	35667
2021-06-25 06:39:57	2021-06-25 14:23:50	7.72	100	1905591336	35668
2021-06-28 06:40:40	2021-06-28 15:34:10	8.88	100	1905591336	35669
2021-06-29 06:40:22	2021-06-29 15:35:05	8.9	100	1905591336	35670
2021-06-30 06:39:27	2021-06-30 15:37:45	8.97	100	1905591336	35671
2021-06-01 14:45:03	2021-06-01 22:45:03	8	102	1985091892	35672
2021-06-03 14:56:29	2021-06-03 22:56:29	8	102	1985091892	35673
2021-06-04 05:46:45	2021-06-04 13:46:45	8	102	1985091892	35674
2021-06-08 05:48:28	2021-06-08 13:48:28	8	102	1985091892	35675
2021-06-09 05:46:08	2021-06-09 13:46:08	8	102	1985091892	35676
2021-06-11 05:46:00	2021-06-11 13:46:00	8	102	1985091892	35677
2021-06-15 05:56:30	2021-06-15 13:56:30	8	102	1985091892	35678
2021-06-16 05:43:49	2021-06-16 15:28:11	9.73	100	1985091892	35679
2021-06-17 05:51:24	2021-06-17 15:47:04	9.92	100	1985091892	35680
2021-06-18 05:43:49	2021-06-18 13:43:49	8	102	1985091892	35681
2021-06-22 05:47:05	2021-06-22 13:47:05	8	102	1985091892	35682
2021-06-23 14:45:43	2021-06-23 22:45:43	8	102	1985091892	35683
2021-06-24 05:43:30	2021-06-24 14:47:52	9.07	100	1985091892	35684
2021-06-25 05:44:59	2021-06-25 13:44:59	8	102	1985091892	35685
2021-06-28 05:43:12	2021-06-28 13:43:12	8	102	1985091892	35686
2021-06-01 14:49:35	2021-06-01 22:49:35	8	102	941889031	35687
2021-06-02 15:36:57	2021-06-02 23:36:57	8	102	941889031	35688
2021-06-03 07:15:13	2021-06-03 15:15:13	8	102	941889031	35689
2021-06-04 06:43:41	2021-06-04 12:51:00	6.12	100	941889031	35690
2021-06-07 07:05:23	2021-06-07 18:10:33	11.08	100	941889031	35691
2021-06-08 06:17:24	2021-06-08 09:34:43	3.28	100	941889031	35692
2021-06-10 05:46:20	2021-06-10 13:46:20	8	102	941889031	35693
2021-06-11 07:20:00	2021-06-11 13:39:09	6.32	100	941889031	35694
2021-06-15 06:58:57	2021-06-15 10:05:41	3.1	100	941889031	35695
2021-06-18 07:04:32	2021-06-18 15:17:22	8.2	100	941889031	35696
2021-06-21 07:04:24	2021-06-21 10:25:45	3.35	100	941889031	35697
2021-06-22 07:14:40	2021-06-22 15:18:37	8.05	100	941889031	35698
2021-06-03 10:11:27	2021-06-03 12:03:01	1.85	100	660878601	35699
2021-06-04 09:42:09	2021-06-04 13:34:57	3.87	100	660878601	35700
2021-06-11 10:55:24	2021-06-11 18:55:24	8	102	660878601	35701
2021-06-19 09:06:54	2021-06-19 09:08:13	0.02	100	660878601	35702
2021-06-22 15:16:40	2021-06-22 15:33:41	0.28	100	660878601	35703
2021-06-24 14:05:39	2021-06-24 16:52:28	2.67	101	660878601	35704
2021-06-01 07:00:32	2021-06-01 16:06:24	9.08	100	660878601	35705
2021-06-01 16:08:33	2021-06-02 00:08:33	8	102	660878601	35706
2021-06-02 07:08:05	2021-06-02 16:06:58	8.97	100	660878601	35707
2021-06-03 06:33:55	2021-06-03 17:26:04	10.87	100	660878601	35708
2021-06-04 06:38:54	2021-06-04 13:43:06	7.07	100	660878601	35709
2021-06-04 16:53:57	2021-06-05 00:53:57	8	102	660878601	35710
2021-06-07 07:01:38	2021-06-07 15:49:02	8.78	100	660878601	35711
2021-06-08 06:49:48	2021-06-08 16:07:54	9.3	100	660878601	35712
2021-06-09 07:02:50	2021-06-09 15:47:54	8.75	100	660878601	35713
2021-06-10 06:49:49	2021-06-10 11:57:14	5.12	100	660878601	35714
2021-06-10 15:58:52	2021-06-10 23:58:52	8	102	660878601	35715
2021-06-11 15:20:29	2021-06-11 23:20:29	8	102	660878601	35716
2021-06-15 06:56:54	2021-06-15 16:09:16	9.2	100	660878601	35717
2021-06-16 06:54:21	2021-06-16 15:38:23	8.73	100	660878601	35718
2021-06-17 06:30:27	2021-06-17 15:48:00	9.28	100	660878601	35719
2021-06-18 15:42:48	2021-06-18 23:42:48	8	102	660878601	35720
2021-06-19 10:09:09	2021-06-19 18:09:09	8	102	660878601	35721
2021-06-21 07:49:09	2021-06-21 08:11:51	0.37	100	660878601	35722
2021-06-21 15:49:49	2021-06-21 23:49:49	8	102	660878601	35723
2021-06-22 07:28:09	2021-06-22 15:50:11	8.37	100	660878601	35724
2021-06-22 15:51:56	2021-06-22 23:51:56	8	102	660878601	35725
2021-06-23 14:40:23	2021-06-23 16:49:09	2.13	100	660878601	35726
2021-06-24 06:26:47	2021-06-24 17:00:24	10.55	100	660878601	35727
2021-06-25 06:28:25	2021-06-25 14:55:05	8.43	100	660878601	35728
2021-06-28 06:51:58	2021-06-28 15:46:48	8.9	100	660878601	35729
2021-06-29 07:00:33	2021-06-29 15:39:35	8.65	100	660878601	35730
2021-06-30 06:55:11	2021-06-30 17:04:15	10.15	100	660878601	35731
2021-06-18 15:33:38	2021-06-18 23:33:38	8	102	1113813080	35732
2021-06-29 15:33:23	2021-06-29 23:33:23	8	102	1113813080	35733
2021-06-01 12:53:32	2021-06-01 23:34:43	8.25	101	1701876276	35734
2021-06-02 06:30:16	2021-06-02 15:34:34	9.07	100	1701876276	35735
2021-06-03 06:38:15	2021-06-03 15:34:38	8.93	100	1701876276	35736
2021-06-04 06:36:19	2021-06-04 15:34:27	8.97	100	1701876276	35737
2021-06-07 06:28:02	2021-06-07 15:35:12	9.12	100	1701876276	35738
2021-06-08 05:51:59	2021-06-08 18:04:21	10.48	101	1701876276	35739
2021-06-09 06:31:59	2021-06-09 15:33:28	9.02	100	1701876276	35740
2021-06-10 06:32:04	2021-06-10 15:33:37	8.91	101	1701876276	35741
2021-06-11 06:33:48	2021-06-11 14:38:46	8.07	100	1701876276	35742
2021-06-15 15:33:44	2021-06-15 23:33:44	8	102	1701876276	35743
2021-06-16 06:35:48	2021-06-16 15:34:01	8.97	100	1701876276	35744
2021-06-17 06:39:19	2021-06-17 14:39:19	8	102	1701876276	35745
2021-06-18 05:44:54	2021-06-21 15:35:22	13.45	101	1701876276	35746
2021-06-22 06:32:45	2021-06-22 15:34:26	9.02	100	1701876276	35747
2021-06-23 06:35:07	2021-06-23 14:35:07	8	102	1701876276	35748
2021-06-24 06:35:26	2021-06-24 15:33:54	8.97	100	1701876276	35749
2021-06-25 05:46:03	2021-06-25 14:03:03	8.28	100	1701876276	35750
2021-06-28 06:32:32	2021-06-28 16:06:18	9.55	100	1701876276	35751
2021-06-29 06:28:05	2021-06-29 15:33:38	9.08	100	1701876276	35752
2021-06-30 06:37:39	2021-06-30 15:35:03	8.95	100	1701876276	35753
2021-06-05 05:46:21	2021-06-05 13:46:21	8	102	845744148	35754
2021-06-09 14:01:56	2021-06-09 22:01:56	8	102	845744148	35755
2021-06-10 14:10:16	2021-06-10 22:10:16	8	102	845744148	35756
2021-06-11 12:58:28	2021-06-11 20:58:28	8	102	845744148	35757
2021-06-17 05:45:34	2021-06-17 13:45:34	8	102	845744148	35758
2021-06-18 05:41:40	2021-06-18 13:41:40	8	102	845744148	35759
2021-06-21 13:53:03	2021-06-22 00:06:59	10.22	100	845744148	35760
2021-06-23 00:01:45	2021-06-23 13:31:53	13.5	100	845744148	35761
2021-06-24 00:02:23	2021-06-24 13:53:11	13.83	100	845744148	35762
2021-06-25 00:02:45	2021-06-25 13:08:10	13.08	100	845744148	35763
2021-06-25 22:10:17	2021-06-26 06:10:17	8	102	845744148	35764
2021-06-28 05:42:49	2021-06-28 14:43:27	9	100	845744148	35765
2021-06-29 11:59:12	2021-06-29 15:23:58	3.4	100	845744148	35766
2021-06-01 06:34:08	2021-06-01 14:34:08	8	102	2185646993	35767
2021-06-02 15:41:58	2021-06-02 23:41:58	8	102	2185646993	35768
2021-06-03 06:35:45	2021-06-03 14:35:45	8	102	2185646993	35769
2021-06-04 06:29:06	2021-06-04 14:29:06	8	102	2185646993	35770
2021-06-07 06:34:09	2021-06-07 14:34:09	8	102	2185646993	35771
2021-06-08 06:35:03	2021-06-08 14:35:03	8	102	2185646993	35772
2021-06-09 06:37:51	2021-06-09 14:37:51	8	102	2185646993	35773
2021-06-10 06:32:38	2021-06-10 15:34:09	9.02	100	2185646993	35774
2021-06-11 06:35:46	2021-06-11 14:35:46	8	102	2185646993	35775
2021-06-15 06:43:19	2021-06-15 15:34:14	8.83	100	2185646993	35776
2021-06-16 06:50:14	2021-06-16 14:50:14	8	102	2185646993	35777
2021-06-17 07:11:30	2021-06-17 15:11:30	8	102	2185646993	35778
2021-06-18 06:32:47	2021-06-18 15:43:08	9.17	100	2185646993	35779
2021-06-23 06:35:39	2021-06-23 15:41:27	9.08	100	2185646993	35780
2021-06-25 06:33:30	2021-06-25 14:33:30	8	102	2185646993	35781
2021-06-28 06:35:47	2021-06-28 14:35:47	8	102	2185646993	35782
2021-06-29 06:34:04	2021-06-29 14:34:04	8	102	2185646993	35783
2021-06-02 15:10:55	2021-06-02 23:10:55	8	102	2197903142	35784
2021-06-03 14:48:00	2021-06-03 22:48:00	8	102	2197903142	35785
2021-06-04 06:56:46	2021-06-04 14:16:58	7.33	100	2197903142	35786
2021-06-07 06:44:32	2021-06-07 15:15:57	8.52	100	2197903142	35787
2021-06-08 06:37:20	2021-06-08 15:10:52	8.55	100	2197903142	35788
2021-06-09 06:50:23	2021-06-09 14:45:23	7.92	100	2197903142	35789
2021-06-10 06:39:24	2021-06-10 14:44:07	8.07	100	2197903142	35790
2021-06-11 06:48:39	2021-06-11 14:07:42	7.32	100	2197903142	35791
2021-06-16 06:40:40	2021-06-16 15:19:58	8.65	100	2197903142	35792
2021-06-18 06:40:16	2021-06-18 15:19:30	8.65	100	2197903142	35793
2021-06-21 06:38:20	2021-06-21 14:42:42	8.07	100	2197903142	35794
2021-06-22 06:37:25	2021-06-22 14:34:42	7.95	100	2197903142	35795
2021-06-23 06:46:50	2021-06-23 14:46:50	8	102	2197903142	35796
2021-06-25 06:44:34	2021-06-25 14:17:31	7.53	100	2197903142	35797
2021-06-28 06:44:48	2021-06-28 14:48:09	8.05	100	2197903142	35798
2021-06-30 06:41:49	2021-06-30 14:21:21	7.65	100	2197903142	35799
2021-06-01 16:04:18	2021-06-02 00:04:18	8	102	1631097861	35800
2021-06-02 06:24:24	2021-06-02 06:24:56	0	100	1631097861	35801
2021-06-02 16:03:37	2021-06-03 00:03:37	8	102	1631097861	35802
2021-06-03 06:11:43	2021-06-03 16:27:55	10.27	100	1631097861	35803
2021-06-04 06:11:30	2021-06-04 17:30:09	11.3	100	1631097861	35804
2021-06-05 06:11:08	2021-06-05 12:28:32	6.28	100	1631097861	35805
2021-06-07 15:57:30	2021-06-07 23:57:30	8	102	1631097861	35806
2021-06-08 06:13:10	2021-06-08 15:59:30	9.77	100	1631097861	35807
2021-06-09 16:15:06	2021-06-10 06:11:53	13.93	100	1631097861	35808
2021-06-11 06:11:19	2021-06-11 15:22:42	9.18	100	1631097861	35809
2021-06-02 09:31:03	2021-06-02 17:31:03	8	102	1164448544	35810
2021-06-03 09:25:56	2021-06-03 17:25:56	8	102	1164448544	35811
2021-06-04 09:05:54	2021-06-04 17:05:54	8	102	1164448544	35812
2021-06-07 09:24:12	2021-06-07 17:24:12	8	102	1164448544	35813
2021-06-08 09:27:17	2021-06-08 17:27:17	8	102	1164448544	35814
2021-06-09 09:13:33	2021-06-09 17:13:33	8	102	1164448544	35815
2021-06-11 09:14:19	2021-06-11 17:14:19	8	102	1164448544	35816
2021-06-15 08:23:42	2021-06-15 16:23:42	8	102	1164448544	35817
2021-06-16 08:50:41	2021-06-16 16:50:41	8	102	1164448544	35818
2021-06-17 09:03:27	2021-06-17 17:03:27	8	102	1164448544	35819
2021-06-18 09:06:36	2021-06-18 17:06:36	8	102	1164448544	35820
2021-06-21 09:25:12	2021-06-21 15:53:47	6.47	100	1164448544	35821
2021-06-22 08:02:40	2021-06-22 15:46:52	7.73	100	1164448544	35822
2021-06-23 07:21:31	2021-06-23 14:30:28	7.13	100	1164448544	35823
2021-06-24 08:41:54	2021-06-24 12:13:25	3.52	100	1164448544	35824
2021-06-28 08:03:41	2021-06-28 16:03:41	8	102	1164448544	35825
2021-06-29 08:38:13	2021-06-29 15:57:08	7.3	100	1164448544	35826
2021-06-30 07:38:29	2021-06-30 15:51:56	8.22	100	1164448544	35827
2021-06-02 05:46:06	2021-06-02 13:46:06	8	102	1098023824	35828
2021-06-03 05:48:56	2021-06-03 13:48:56	8	102	1098023824	35829
2021-06-04 05:57:27	2021-06-04 13:57:27	8	102	1098023824	35830
2021-06-05 05:56:20	2021-06-05 13:56:20	8	102	1098023824	35831
2021-06-07 05:47:59	2021-06-07 13:47:59	8	102	1098023824	35832
2021-06-08 05:48:58	2021-06-08 13:48:58	8	102	1098023824	35833
2021-06-09 05:57:50	2021-06-09 13:57:50	8	102	1098023824	35834
2021-06-10 05:56:09	2021-06-10 13:56:09	8	102	1098023824	35835
2021-06-11 05:47:58	2021-06-11 13:47:58	8	102	1098023824	35836
2021-06-15 05:46:53	2021-06-15 13:46:53	8	102	1098023824	35837
2021-06-16 05:50:49	2021-06-16 13:50:49	8	102	1098023824	35838
2021-06-17 05:47:02	2021-06-17 13:47:02	8	102	1098023824	35839
2021-06-18 05:52:38	2021-06-18 13:52:38	8	102	1098023824	35840
2021-06-21 05:47:43	2021-06-21 13:47:43	8	102	1098023824	35841
2021-06-24 05:58:03	2021-06-24 13:58:03	8	102	1098023824	35842
2021-06-26 05:47:36	2021-06-26 13:47:36	8	102	1098023824	35843
2021-06-28 05:49:03	2021-06-28 13:49:03	8	102	1098023824	35844
2021-06-29 06:02:45	2021-06-29 14:02:45	8	102	1098023824	35845
2021-06-30 05:46:42	2021-06-30 13:46:42	8	102	1098023824	35846
2021-06-01 15:42:13	2021-06-01 23:42:13	8	102	1098023824	35847
2021-06-02 15:38:53	2021-06-02 23:38:53	8	102	1098023824	35848
2021-06-03 15:39:23	2021-06-03 23:39:23	8	102	1098023824	35849
2021-06-05 10:22:59	2021-06-05 18:22:59	8	102	1098023824	35850
2021-06-08 15:50:13	2021-06-08 23:50:13	8	102	1098023824	35851
2021-06-09 16:52:00	2021-06-10 00:52:00	8	102	1098023824	35852
2021-06-10 15:47:57	2021-06-10 23:47:57	8	102	1098023824	35853
2021-06-11 14:40:10	2021-06-11 22:40:10	8	102	1098023824	35854
2021-06-15 15:29:18	2021-06-15 23:29:18	8	102	1098023824	35855
2021-06-16 18:32:11	2021-06-17 02:32:11	8	102	1098023824	35856
2021-06-17 18:29:41	2021-06-18 02:29:41	8	102	1098023824	35857
2021-06-19 06:04:44	2021-06-19 14:04:44	8	102	1098023824	35858
2021-06-21 18:26:59	2021-06-22 02:26:59	8	102	1098023824	35859
2021-06-23 15:32:51	2021-06-23 23:32:51	8	102	1098023824	35860
2021-06-25 14:33:05	2021-06-25 22:33:05	8	102	1098023824	35861
2021-06-26 11:55:29	2021-06-26 19:55:29	8	102	1098023824	35862
2021-06-28 15:32:48	2021-06-28 23:32:48	8	102	1098023824	35863
2021-06-29 15:31:28	2021-06-29 23:31:28	8	102	1098023824	35864
2021-06-03 16:24:00	2021-06-04 00:24:00	8	102	427828579	35865
2021-06-04 06:24:51	2021-06-04 17:27:59	11.05	100	427828579	35866
2021-06-05 06:21:53	2021-06-05 14:21:53	8	102	427828579	35867
2021-06-07 06:10:27	2021-06-07 15:54:55	9.73	100	427828579	35868
2021-06-08 08:46:42	2021-06-08 16:46:42	8	102	427828579	35869
2021-06-09 06:10:43	2021-06-09 16:07:21	9.93	100	427828579	35870
2021-06-10 06:27:07	2021-06-10 15:54:16	4.95	101	427828579	35871
2021-06-11 06:29:12	2021-06-11 15:31:06	9.02	100	427828579	35872
2021-06-15 07:16:12	2021-06-15 15:49:03	8.53	100	427828579	35873
2021-06-16 06:16:52	2021-06-16 06:23:41	0.1	100	427828579	35874
2021-06-16 15:49:23	2021-06-16 23:49:23	8	102	427828579	35875
2021-06-17 06:02:02	2021-06-17 15:55:22	9.88	100	427828579	35876
2021-06-18 06:12:48	2021-06-18 15:55:51	9.72	100	427828579	35877
2021-06-28 06:08:57	2021-06-28 14:08:57	8	102	427828579	35878
2021-06-29 06:24:56	2021-06-29 15:56:36	9.52	100	427828579	35879
2021-06-30 07:03:25	2021-06-30 15:48:45	8.75	100	427828579	35880
2021-06-30 15:52:47	2021-06-30 15:56:18	0.05	100	427828579	35881
2021-06-04 05:36:24	2021-06-04 13:36:24	8	102	2237928199	35882
2021-06-07 05:39:19	2021-06-07 13:39:19	8	102	2237928199	35883
2021-06-08 05:34:49	2021-06-08 13:34:49	8	102	2237928199	35884
2021-06-09 05:43:11	2021-06-09 13:43:11	8	102	2237928199	35885
2021-06-10 05:34:26	2021-06-10 13:34:26	8	102	2237928199	35886
2021-06-11 05:34:40	2021-06-11 13:34:40	8	102	2237928199	35887
2021-06-15 05:48:26	2021-06-15 13:48:26	8	102	2237928199	35888
2021-06-16 05:39:42	2021-06-16 13:39:42	8	102	2237928199	35889
2021-06-17 05:39:16	2021-06-17 13:39:16	8	102	2237928199	35890
2021-06-18 05:35:54	2021-06-18 13:35:54	8	102	2237928199	35891
2021-06-21 10:09:48	2021-06-21 18:09:48	8	102	2237928199	35892
2021-06-23 05:45:18	2021-06-23 13:45:18	8	102	2237928199	35893
2021-06-24 05:35:19	2021-06-24 13:35:19	8	102	2237928199	35894
2021-06-25 10:01:58	2021-06-25 18:01:58	8	102	2237928199	35895
2021-06-28 05:37:03	2021-06-28 13:37:03	8	102	2237928199	35896
2021-06-30 05:34:57	2021-06-30 13:34:57	8	102	2237928199	35897
2021-06-01 15:30:39	2021-06-01 23:30:39	8	102	2237928199	35898
2021-06-04 14:32:56	2021-06-04 22:32:56	8	102	2237928199	35899
2021-06-17 14:33:30	2021-06-17 22:33:30	8	102	2237928199	35900
2021-06-18 14:33:40	2021-06-18 22:33:40	8	102	2237928199	35901
2021-06-21 15:02:57	2021-06-21 23:02:57	8	102	2237928199	35902
2021-06-22 14:59:27	2021-06-22 22:59:27	8	102	2237928199	35903
2021-06-23 14:57:34	2021-06-23 22:57:34	8	102	2237928199	35904
2021-06-24 14:59:52	2021-06-24 22:59:52	8	102	2237928199	35905
2021-06-28 14:52:56	2021-06-28 22:52:56	8	102	2237928199	35906
2021-06-01 15:38:20	2021-06-01 23:38:20	8	102	1411807281	35907
2021-06-02 06:50:04	2021-06-02 15:40:25	8.83	100	1411807281	35908
2021-06-03 06:37:23	2021-06-03 15:37:36	9	100	1411807281	35909
2021-06-04 06:40:45	2021-06-04 15:32:01	8.85	100	1411807281	35910
2021-06-07 06:41:16	2021-06-07 15:47:32	9.1	100	1411807281	35911
2021-06-08 06:40:51	2021-06-08 14:40:51	8	102	1411807281	35912
2021-06-09 15:42:22	2021-06-09 23:42:22	8	102	1411807281	35913
2021-06-10 06:38:57	2021-06-10 15:35:35	8.93	100	1411807281	35914
2021-06-15 06:40:32	2021-06-15 15:31:50	8.85	100	1411807281	35915
2021-06-21 06:49:12	2021-06-21 15:38:37	8.82	100	1411807281	35916
2021-06-22 06:50:48	2021-06-22 15:44:09	8.88	100	1411807281	35917
2021-06-23 06:40:18	2021-06-23 15:38:01	8.95	100	1411807281	35918
2021-06-24 06:39:39	2021-06-24 14:39:39	8	102	1411807281	35919
2021-06-25 06:42:42	2021-06-25 14:42:42	8	102	1411807281	35920
2021-06-03 06:41:06	2021-06-03 15:24:22	8.72	100	822384007	35921
2021-06-04 06:47:09	2021-06-04 15:28:03	8.67	100	822384007	35922
2021-06-07 06:57:07	2021-06-07 15:27:03	8.48	100	822384007	35923
2021-06-08 06:58:38	2021-06-08 15:23:12	8.4	100	822384007	35924
2021-06-10 06:56:07	2021-06-10 15:29:04	8.53	100	822384007	35925
2021-06-11 06:45:14	2021-06-11 15:05:59	8.33	100	822384007	35926
2021-06-15 15:26:36	2021-06-15 23:26:36	8	102	822384007	35927
2021-06-16 15:19:47	2021-06-16 23:19:47	8	102	822384007	35928
2021-06-17 15:23:05	2021-06-17 23:23:05	8	102	822384007	35929
2021-06-18 06:45:20	2021-06-18 15:35:07	8.82	100	822384007	35930
2021-06-21 06:47:25	2021-06-21 15:24:38	8.62	100	822384007	35931
2021-06-22 15:35:35	2021-06-22 23:35:35	8	102	822384007	35932
2021-06-23 06:56:23	2021-06-23 15:21:04	8.4	100	822384007	35933
2021-06-24 06:48:01	2021-06-24 15:23:43	8.58	100	822384007	35934
2021-06-25 06:58:56	2021-06-25 14:41:20	7.7	100	822384007	35935
2021-06-28 06:34:10	2021-06-28 15:20:24	8.77	100	822384007	35936
2021-06-29 15:24:04	2021-06-29 23:24:04	8	102	822384007	35937
2021-06-30 06:50:27	2021-06-30 15:20:51	8.5	100	822384007	35938
2021-06-01 14:35:51	2021-06-01 22:35:51	8	102	1634994472	35939
2021-06-02 14:29:48	2021-06-02 22:29:48	8	102	1634994472	35940
2021-06-03 14:25:52	2021-06-03 22:25:52	8	102	1634994472	35941
2021-06-04 10:08:00	2021-06-04 18:08:00	8	102	1634994472	35942
2021-06-07 14:34:14	2021-06-07 22:34:14	8	102	1634994472	35943
2021-06-08 05:16:02	2021-06-08 14:30:31	9.23	100	1634994472	35944
2021-06-09 14:32:17	2021-06-09 22:32:17	8	102	1634994472	35945
2021-06-10 05:16:59	2021-06-10 14:31:37	9.23	100	1634994472	35946
2021-06-11 05:10:55	2021-06-11 13:10:55	8	102	1634994472	35947
2021-06-15 14:29:53	2021-06-15 22:29:53	8	102	1634994472	35948
2021-06-16 05:20:00	2021-06-16 14:32:01	9.2	100	1634994472	35949
2021-06-17 12:36:24	2021-06-17 20:40:45	8	101	1634994472	35950
2021-06-21 05:17:31	2021-06-21 15:01:21	9.72	100	1634994472	35951
2021-06-22 05:17:56	2021-06-22 15:00:33	9.7	100	1634994472	35952
2021-06-23 14:54:50	2021-06-23 22:54:50	8	102	1634994472	35953
2021-06-24 14:57:12	2021-06-24 22:57:12	8	102	1634994472	35954
2021-06-25 12:22:01	2021-06-25 20:22:01	8	102	1634994472	35955
2021-06-28 14:51:20	2021-06-28 22:51:20	8	102	1634994472	35956
2021-06-29 14:37:06	2021-06-29 22:37:06	8	102	1634994472	35957
2021-06-01 14:15:39	2021-06-01 22:15:39	8	102	1983464065	35958
2021-06-02 10:45:22	2021-06-02 15:47:53	5.03	100	1983464065	35959
2021-06-03 10:23:41	2021-06-03 18:23:41	8	102	1983464065	35960
2021-06-04 08:44:48	2021-06-04 14:33:26	5.8	100	1983464065	35961
2021-06-05 10:55:44	2021-06-05 14:08:40	3.2	100	1983464065	35962
2021-06-07 11:11:42	2021-06-07 19:11:42	8	102	1983464065	35963
2021-06-09 18:06:46	2021-06-10 02:06:46	8	102	1983464065	35964
2021-06-10 10:26:44	2021-06-10 14:16:55	3.83	100	1983464065	35965
2021-06-11 08:42:34	2021-06-11 16:42:34	8	102	1983464065	35966
2021-06-15 12:26:24	2021-06-15 20:26:24	8	102	1983464065	35967
2021-06-16 10:47:32	2021-06-16 16:42:17	5.9	100	1983464065	35968
2021-06-17 10:03:42	2021-06-17 12:54:57	2.85	100	1983464065	35969
2021-06-18 09:11:05	2021-06-18 16:44:59	7.55	100	1983464065	35970
2021-06-19 08:03:54	2021-06-19 11:00:32	2.93	100	1983464065	35971
2021-06-21 10:17:40	2021-06-21 12:15:50	1.97	100	1983464065	35972
2021-06-30 10:48:34	2021-06-30 17:28:38	6.67	100	1983464065	35973
2021-06-02 05:33:54	2021-06-02 13:33:54	8	102	1482959107	35974
2021-06-03 05:37:39	2021-06-03 13:37:39	8	102	1482959107	35975
2021-06-04 05:37:08	2021-06-04 13:37:08	8	102	1482959107	35976
2021-06-07 05:40:07	2021-06-07 13:40:07	8	102	1482959107	35977
2021-06-10 05:34:59	2021-06-10 13:34:59	8	102	1482959107	35978
2021-06-16 05:30:14	2021-06-16 13:30:14	8	102	1482959107	35979
2021-06-21 05:43:19	2021-06-21 13:43:19	8	102	1482959107	35980
2021-06-22 15:32:06	2021-06-22 23:32:06	8	102	1482959107	35981
2021-06-23 05:34:50	2021-06-23 13:34:50	8	102	1482959107	35982
2021-06-24 05:36:23	2021-06-24 13:36:23	8	102	1482959107	35983
2021-06-25 05:30:57	2021-06-25 13:30:57	8	102	1482959107	35984
2021-06-30 05:35:49	2021-06-30 13:35:49	8	102	1482959107	35985
2021-06-07 15:36:11	2021-06-07 23:36:11	8	102	1482959107	35986
2021-06-08 15:36:18	2021-06-08 23:36:18	8	102	1482959107	35987
2021-06-09 15:31:40	2021-06-09 23:31:40	8	102	1482959107	35988
2021-06-11 13:53:48	2021-06-11 21:53:48	8	102	1482959107	35989
2021-06-21 15:32:57	2021-06-21 23:32:57	8	102	1482959107	35990
2021-06-25 14:09:56	2021-06-25 22:09:56	8	102	1482959107	35991
2021-06-28 15:41:39	2021-06-28 23:41:39	8	102	1482959107	35992
2021-06-29 14:51:16	2021-06-29 22:51:16	8	102	1482959107	35993
2021-06-02 18:45:39	2021-06-03 02:45:39	8	102	1194744104	35994
2021-06-09 16:19:53	2021-06-09 17:49:04	1.48	100	1194744104	35995
2021-06-23 15:24:44	2021-06-23 17:13:33	1.8	100	1194744104	35996
2021-06-02 05:52:47	2021-06-02 13:52:47	8	102	2185625973	35997
2021-06-03 05:51:43	2021-06-03 13:51:43	8	102	2185625973	35998
2021-06-04 06:08:34	2021-06-04 14:08:34	8	102	2185625973	35999
2021-06-07 05:50:11	2021-06-07 13:50:11	8	102	2185625973	36000
2021-06-08 05:48:17	2021-06-08 13:48:17	8	102	2185625973	36001
2021-06-10 05:56:52	2021-06-10 13:56:52	8	102	2185625973	36002
2021-06-11 05:54:53	2021-06-11 13:54:53	8	102	2185625973	36003
2021-06-15 05:53:46	2021-06-15 13:53:46	8	102	2185625973	36004
2021-06-16 05:57:02	2021-06-16 13:57:02	8	102	2185625973	36005
2021-06-17 06:07:14	2021-06-17 14:07:14	8	102	2185625973	36006
2021-06-18 05:59:59	2021-06-18 13:59:59	8	102	2185625973	36007
2021-06-21 06:00:57	2021-06-21 16:00:41	9.98	100	2185625973	36008
2021-06-22 06:03:19	2021-06-22 15:57:13	9.88	100	2185625973	36009
2021-06-23 05:45:59	2021-06-23 15:58:32	10.2	100	2185625973	36010
2021-06-24 05:55:02	2021-06-24 15:32:40	9.62	100	2185625973	36011
2021-06-25 06:02:41	2021-06-25 13:24:00	7.35	100	2185625973	36012
2021-06-28 05:54:45	2021-06-28 15:56:20	10.02	100	2185625973	36013
2021-06-29 06:01:49	2021-06-29 16:02:45	10	100	2185625973	36014
2021-06-30 05:59:55	2021-06-30 16:13:06	10.22	100	2185625973	36015
2021-06-01 21:34:27	2021-06-02 06:28:37	8.9	100	1679325477	36016
2021-06-03 06:33:34	2021-06-03 14:33:34	8	102	1679325477	36017
2021-06-04 06:23:58	2021-06-04 14:23:58	8	102	1679325477	36018
2021-06-08 20:04:51	2021-06-09 06:32:57	10.47	100	1679325477	36019
2021-06-09 20:55:22	2021-06-09 21:18:51	0.38	100	1679325477	36020
2021-06-10 06:33:51	2021-06-10 14:33:51	8	102	1679325477	36021
2021-06-11 06:20:59	2021-06-11 14:33:55	8.2	100	1679325477	36022
2021-06-14 10:01:03	2021-06-14 18:01:03	8	102	1679325477	36023
2021-06-15 06:33:43	2021-06-15 14:33:43	8	102	1679325477	36024
2021-06-18 06:26:53	2021-06-18 14:26:53	8	102	1679325477	36025
2021-06-18 20:38:55	2021-06-18 20:43:07	0.07	100	1679325477	36026
2021-06-21 06:31:36	2021-06-21 15:58:18	8.76	101	1679325477	36027
2021-06-22 06:32:02	2021-06-22 14:32:02	8	102	1679325477	36028
2021-06-23 15:34:04	2021-06-23 23:34:04	8	102	1679325477	36029
2021-06-24 06:28:53	2021-06-24 15:18:57	5.69	101	1679325477	36030
2021-06-25 06:31:39	2021-06-25 13:13:55	6.7	100	1679325477	36031
2021-06-25 21:55:37	2021-06-25 21:58:25	0.03	100	1679325477	36032
2021-06-27 21:14:23	2021-06-27 21:20:10	0.08	100	1679325477	36033
2021-06-28 06:33:08	2021-06-28 14:33:08	8	102	1679325477	36034
2021-06-29 15:32:41	2021-06-29 23:32:41	8	102	1679325477	36035
2021-06-01 15:32:41	2021-06-01 23:32:41	8	102	1125737093	36036
2021-06-02 15:32:43	2021-06-02 23:32:43	8	102	1125737093	36037
2021-06-04 05:50:10	2021-06-04 14:31:52	8.68	100	1125737093	36038
2021-06-07 06:43:18	2021-06-07 15:32:06	8.8	100	1125737093	36039
2021-06-08 06:34:43	2021-06-08 15:33:04	8.97	100	1125737093	36040
2021-06-09 06:20:39	2021-06-09 14:20:39	8	102	1125737093	36041
2021-06-10 06:36:10	2021-06-10 15:33:01	8.93	100	1125737093	36042
2021-06-11 06:42:14	2021-06-11 14:32:55	7.83	100	1125737093	36043
2021-06-15 06:42:34	2021-06-15 15:32:45	8.83	100	1125737093	36044
2021-06-16 06:38:52	2021-06-16 14:38:52	8	102	1125737093	36045
2021-06-17 06:44:54	2021-06-17 15:33:09	8.8	100	1125737093	36046
2021-06-18 05:24:16	2021-06-18 13:24:16	8	102	1125737093	36047
2021-06-21 06:48:14	2021-06-21 14:48:14	8	102	1125737093	36048
2021-06-22 06:40:33	2021-06-22 15:33:10	8.87	100	1125737093	36049
2021-06-23 15:33:29	2021-06-23 23:33:29	8	102	1125737093	36050
2021-06-24 06:33:37	2021-06-24 15:32:52	8.98	100	1125737093	36051
2021-06-25 06:39:07	2021-06-25 14:32:24	7.88	100	1125737093	36052
2021-06-01 15:24:20	2021-06-01 23:24:20	8	102	1939211652	36053
2021-06-02 06:42:23	2021-06-02 15:52:17	9.15	100	1939211652	36054
2021-06-03 06:56:01	2021-06-03 16:02:08	9.1	100	1939211652	36055
2021-06-04 06:58:10	2021-06-04 15:36:42	8.63	100	1939211652	36056
2021-06-07 06:57:44	2021-06-07 15:18:47	8.35	100	1939211652	36057
2021-06-08 06:50:54	2021-06-08 15:53:58	9.05	100	1939211652	36058
2021-06-15 06:56:20	2021-06-15 15:49:06	8.87	100	1939211652	36059
2021-06-16 06:59:20	2021-06-16 15:32:28	8.55	100	1939211652	36060
2021-06-17 07:26:57	2021-06-17 16:04:29	8.62	100	1939211652	36061
2021-06-18 06:10:44	2021-06-18 15:03:02	8.87	100	1939211652	36062
2021-06-21 05:54:07	2021-06-21 14:39:50	8.75	100	1939211652	36063
2021-06-22 07:27:16	2021-06-22 15:51:38	8.4	100	1939211652	36064
2021-06-28 06:43:40	2021-06-28 16:01:25	9.28	100	1939211652	36065
2021-06-29 07:11:14	2021-06-29 16:01:59	8.83	100	1939211652	36066
2021-06-01 14:39:38	2021-06-01 22:39:38	8	102	1685128504	36067
2021-06-02 05:47:09	2021-06-02 14:48:27	9.02	100	1685128504	36068
2021-06-03 05:43:02	2021-06-03 13:43:02	8	102	1685128504	36069
2021-06-04 05:17:20	2021-06-04 14:38:46	9.35	100	1685128504	36070
2021-06-05 12:11:38	2021-06-05 20:11:38	8	102	1685128504	36071
2021-06-07 14:04:16	2021-06-07 21:15:22	7.18	100	1685128504	36072
2021-06-08 12:59:23	2021-06-08 21:11:21	8.18	100	1685128504	36073
2021-06-09 12:45:34	2021-06-09 21:09:51	8.4	100	1685128504	36074
2021-06-10 13:35:51	2021-06-10 20:44:02	7.13	100	1685128504	36075
2021-06-11 12:56:18	2021-06-11 20:56:18	8	102	1685128504	36076
2021-06-15 06:06:00	2021-06-15 14:40:23	8.57	100	1685128504	36077
2021-06-16 05:46:27	2021-06-16 14:51:12	9.07	100	1685128504	36078
2021-06-17 05:46:51	2021-06-17 13:46:51	8	102	1685128504	36079
2021-06-18 05:40:07	2021-06-18 13:40:07	8	102	1685128504	36080
2021-06-21 21:25:43	2021-06-22 05:25:43	8	102	1685128504	36081
2021-06-22 13:37:50	2021-06-22 21:16:17	7.63	100	1685128504	36082
2021-06-23 13:42:33	2021-06-23 21:07:05	7.4	100	1685128504	36083
2021-06-24 13:37:16	2021-06-24 21:18:53	7.68	100	1685128504	36084
2021-06-25 13:17:48	2021-06-25 21:17:48	8	102	1685128504	36085
2021-06-28 05:46:25	2021-06-28 14:48:02	9.02	100	1685128504	36086
2021-06-29 05:47:12	2021-06-29 13:47:12	8	102	1685128504	36087
2021-06-30 05:46:48	2021-06-30 13:46:48	8	102	1685128504	36088
2021-06-09 08:16:56	2021-06-09 16:16:56	8	102	1685268629	36089
2021-06-10 15:36:41	2021-06-10 23:36:41	8	102	1685268629	36090
2021-06-11 14:30:44	2021-06-11 22:30:44	8	102	1685268629	36091
2021-06-21 07:39:52	2021-06-21 16:23:58	8.73	100	1685268629	36092
2021-06-21 16:25:42	2021-06-22 00:25:42	8	102	1685268629	36093
2021-06-22 15:23:24	2021-06-22 23:23:24	8	102	1685268629	36094
2021-06-24 15:24:49	2021-06-24 23:24:49	8	102	1685268629	36095
2021-06-25 15:10:46	2021-06-25 23:10:46	8	102	1685268629	36096
2021-06-04 12:37:26	2021-06-04 20:37:26	8	102	911765570	36097
2021-06-15 14:33:43	2021-06-15 22:33:43	8	102	911765570	36098
2021-06-30 11:22:25	2021-06-30 15:39:51	4.28	100	911765570	36099
2021-06-01 05:56:49	2021-06-01 13:26:03	7.48	100	911765570	36100
2021-06-01 14:13:56	2021-06-01 15:22:14	1.13	100	911765570	36101
2021-06-02 05:54:32	2021-06-02 13:24:53	7.5	100	911765570	36102
2021-06-02 14:03:04	2021-06-02 15:04:18	1.02	100	911765570	36103
2021-06-03 05:55:28	2021-06-03 13:31:41	7.6	100	911765570	36104
2021-06-03 14:30:18	2021-06-03 15:41:30	1.18	100	911765570	36105
2021-06-04 05:52:15	2021-06-04 07:59:05	2.1	100	911765570	36106
2021-06-07 13:07:38	2021-06-07 23:11:12	8.58	101	911765570	36107
2021-06-08 05:56:17	2021-06-08 12:11:41	6.25	100	911765570	36108
2021-06-08 13:47:27	2021-06-08 15:41:56	1.9	100	911765570	36109
2021-06-09 05:58:19	2021-06-09 13:08:50	7.17	100	911765570	36110
2021-06-09 13:57:47	2021-06-09 15:18:37	1.33	100	911765570	36111
2021-06-10 05:57:45	2021-06-10 15:36:50	6.16	101	911765570	36112
2021-06-11 05:53:48	2021-06-11 12:40:18	6.77	100	911765570	36113
2021-06-11 13:26:56	2021-06-11 14:41:41	1.23	100	911765570	36114
2021-06-15 05:47:02	2021-06-15 14:10:52	8.38	100	911765570	36115
2021-06-15 14:11:24	2021-06-15 14:14:45	0.05	100	911765570	36116
2021-06-16 05:51:36	2021-06-16 15:29:28	6.8	101	911765570	36117
2021-06-18 05:57:50	2021-06-18 13:25:30	7.45	100	911765570	36118
2021-06-18 14:00:38	2021-06-18 15:27:45	1.45	100	911765570	36119
2021-06-21 05:55:41	2021-06-21 15:34:46	9.65	100	911765570	36120
2021-06-22 05:53:04	2021-06-23 15:38:45	17.04	101	911765570	36121
2021-06-24 05:56:09	2021-06-24 12:19:01	6.37	100	911765570	36122
2021-06-24 13:38:51	2021-06-24 15:07:25	1.47	100	911765570	36123
2021-06-25 05:58:27	2021-06-25 14:35:39	7.97	101	911765570	36124
2021-06-26 08:16:17	2021-06-26 08:38:02	0.35	100	911765570	36125
2021-06-28 05:55:09	2021-06-28 13:39:06	7.72	100	911765570	36126
2021-06-28 15:01:27	2021-06-28 15:37:56	0.6	100	911765570	36127
2021-06-29 05:55:51	2021-06-29 13:55:51	8	102	911765570	36128
2021-06-30 05:56:51	2021-06-30 08:44:00	2.78	100	911765570	36129
2021-06-02 07:05:42	2021-06-02 15:05:42	8	102	278030163	36130
2021-06-06 08:40:08	2021-06-06 08:40:10	0	100	278030163	36131
2021-06-07 06:29:11	2021-06-07 14:29:11	8	102	278030163	36132
2021-06-08 07:40:18	2021-06-08 15:40:18	8	102	278030163	36133
2021-06-12 09:41:21	2021-06-12 09:43:03	0.02	100	278030163	36134
2021-06-15 07:36:59	2021-06-15 08:46:47	1.15	100	278030163	36135
2021-06-16 07:03:46	2021-06-16 15:03:46	8	102	278030163	36136
2021-06-18 07:30:36	2021-06-18 15:30:36	8	102	278030163	36137
2021-06-21 07:03:05	2021-06-21 15:39:04	8.58	100	278030163	36138
2021-06-22 07:09:59	2021-06-22 16:22:16	9.2	100	278030163	36139
2021-06-23 06:53:09	2021-06-23 20:02:38	12.98	101	278030163	36140
2021-06-24 07:03:26	2021-06-24 15:32:17	8.47	100	278030163	36141
2021-06-25 07:13:41	2021-06-25 12:04:25	4.83	100	278030163	36142
2021-06-28 07:25:32	2021-06-28 14:50:08	7.4	100	278030163	36143
2021-06-14 05:51:58	2021-06-14 13:51:58	8	102	2216112736	36144
2021-06-28 21:50:42	2021-06-29 05:50:42	8	102	2216112736	36145
2021-06-01 07:13:09	2021-06-01 15:13:09	8	102	2216112736	36146
2021-06-02 02:23:45	2021-06-02 15:13:19	10.38	101	2216112736	36147
2021-06-05 07:26:05	2021-06-05 15:26:05	8	102	2216112736	36148
2021-06-07 07:07:43	2021-06-07 15:07:43	8	102	2216112736	36149
2021-06-08 07:20:31	2021-06-08 15:20:31	8	102	2216112736	36150
2021-06-10 07:07:49	2021-06-10 19:55:17	12.78	100	2216112736	36151
2021-06-10 23:46:52	2021-06-11 07:24:54	7.63	100	2216112736	36152
2021-06-13 07:11:19	2021-06-13 18:14:43	10.95	101	2216112736	36153
2021-06-14 04:39:45	2021-06-14 07:12:37	2.53	100	2216112736	36154
2021-06-16 07:10:11	2021-06-16 15:10:11	8	102	2216112736	36155
2021-06-17 02:11:08	2021-06-17 07:22:51	5.18	100	2216112736	36156
2021-06-19 07:11:40	2021-06-19 15:11:40	8	102	2216112736	36157
2021-06-20 03:46:41	2021-06-20 05:01:55	1.25	100	2216112736	36158
2021-06-25 07:05:26	2021-06-25 15:05:26	8	102	2216112736	36159
2021-06-25 21:10:40	2021-06-26 04:56:01	7.75	100	2216112736	36160
2021-06-26 07:19:43	2021-06-26 15:19:43	8	102	2216112736	36161
2021-06-28 07:15:06	2021-06-28 19:17:56	12.03	100	2216112736	36162
2021-06-29 07:26:49	2021-06-29 07:26:50	0	100	2216112736	36163
2021-06-02 12:28:52	2021-06-02 20:28:52	8	102	1636860469	36164
2021-06-03 12:07:59	2021-06-03 20:07:59	8	102	1636860469	36165
2021-06-09 05:38:47	2021-06-09 13:38:47	8	102	1636860469	36166
2021-06-11 05:41:57	2021-06-11 13:41:57	8	102	1636860469	36167
2021-06-16 13:16:05	2021-06-16 21:16:05	8	102	1636860469	36168
2021-06-17 13:44:02	2021-06-17 21:44:02	8	102	1636860469	36169
2021-06-18 12:58:08	2021-06-18 20:58:08	8	102	1636860469	36170
2021-06-21 05:45:42	2021-06-21 14:43:31	8.95	100	1636860469	36171
2021-06-22 05:43:27	2021-06-22 18:11:35	12.47	100	1636860469	36172
2021-06-23 17:15:33	2021-06-24 05:49:30	12.55	100	1636860469	36173
2021-06-24 18:32:35	2021-06-25 02:32:35	8	102	1636860469	36174
2021-06-28 12:39:28	2021-06-28 12:40:14	0	100	1636860469	36175
2021-06-28 23:06:22	2021-06-29 12:19:23	13.22	100	1636860469	36176
2021-06-30 12:18:42	2021-06-30 23:02:42	10.73	100	1636860469	36177
2021-06-02 05:37:11	2021-06-02 13:37:11	8	102	1075942712	36178
2021-06-03 05:44:53	2021-06-03 13:44:53	8	102	1075942712	36179
2021-06-04 05:39:47	2021-06-04 13:39:47	8	102	1075942712	36180
2021-06-07 05:46:27	2021-06-07 13:46:27	8	102	1075942712	36181
2021-06-09 05:43:54	2021-06-09 13:43:54	8	102	1075942712	36182
2021-06-10 05:43:13	2021-06-10 13:43:13	8	102	1075942712	36183
2021-06-11 05:42:41	2021-06-11 13:42:41	8	102	1075942712	36184
2021-06-17 10:43:22	2021-06-17 18:43:22	8	102	1075942712	36185
2021-06-18 05:40:13	2021-06-18 13:40:13	8	102	1075942712	36186
2021-06-21 05:45:45	2021-06-21 16:35:02	10.82	100	1075942712	36187
2021-06-22 05:37:47	2021-06-22 13:37:47	8	102	1075942712	36188
2021-06-23 15:37:55	2021-06-23 23:37:55	8	102	1075942712	36189
2021-06-24 05:40:17	2021-06-24 15:36:11	9.92	100	1075942712	36190
2021-06-25 05:51:57	2021-06-25 13:51:57	8	102	1075942712	36191
2021-06-28 05:38:00	2021-06-28 20:02:17	14.3	101	1075942712	36192
2021-06-29 05:38:42	2021-06-29 13:38:42	8	102	1075942712	36193
2021-06-30 05:40:18	2021-06-30 15:37:54	9.95	100	1075942712	36194
2021-06-11 08:26:12	2021-06-18 23:06:15	39.54	101	845484153	36195
2021-06-19 12:38:21	2021-06-19 12:38:33	0	100	845484153	36196
2021-06-19 12:41:24	2021-06-19 20:41:24	8	102	845484153	36197
2021-06-24 08:36:48	2021-06-24 16:36:48	8	102	2153027363	36198
2021-06-25 08:38:33	2021-06-25 16:38:33	8	102	2153027363	36199
2021-06-28 16:29:04	2021-06-29 00:29:04	8	102	2153027363	36200
2021-06-02 10:04:12	2021-06-02 14:44:12	4.67	100	428103456	36201
2021-06-02 17:10:18	2021-06-03 01:10:18	8	102	428103456	36202
2021-06-03 10:41:06	2021-06-03 16:13:04	5.52	100	428103456	36203
2021-06-04 06:48:55	2021-06-04 16:10:14	9.35	100	428103456	36204
2021-06-07 11:59:15	2021-06-07 16:30:27	4.52	100	428103456	36205
2021-06-08 06:38:40	2021-06-08 15:57:00	9.3	100	428103456	36206
2021-06-09 06:41:21	2021-06-09 16:33:24	9.87	100	428103456	36207
2021-06-10 06:41:35	2021-06-10 15:50:20	9.13	100	428103456	36208
2021-06-11 06:46:40	2021-06-11 14:46:40	8	102	428103456	36209
2021-06-15 16:41:49	2021-06-16 00:41:49	8	102	428103456	36210
2021-06-16 06:44:47	2021-06-16 16:06:17	9.35	100	428103456	36211
2021-06-17 06:45:33	2021-06-17 15:53:37	9.13	100	428103456	36212
2021-06-18 06:40:50	2021-06-18 16:11:51	9.52	100	428103456	36213
2021-06-21 06:44:38	2021-06-21 16:18:34	9.55	100	428103456	36214
2021-06-22 06:44:53	2021-06-22 16:29:09	9.73	100	428103456	36215
2021-06-23 06:45:32	2021-06-23 16:18:38	9.55	100	428103456	36216
2021-06-24 06:48:24	2021-06-24 16:12:40	9.4	100	428103456	36217
2021-06-25 06:40:45	2021-06-25 14:40:45	8	102	428103456	36218
2021-06-28 16:16:00	2021-06-29 00:16:00	8	102	428103456	36219
2021-06-29 06:46:02	2021-06-29 16:22:41	9.6	100	428103456	36220
2021-06-30 06:51:01	2021-06-30 16:21:27	9.5	100	428103456	36221
2021-06-04 10:19:17	2021-06-04 18:19:17	8	102	1193313813	36222
2021-06-11 08:16:58	2021-06-11 16:16:58	8	102	1193313813	36223
2021-06-15 06:19:23	2021-06-15 14:19:23	8	102	1193313813	36224
2021-06-18 05:51:05	2021-06-18 18:30:58	10.8	101	1193313813	36225
2021-06-21 15:31:39	2021-06-21 23:31:39	8	102	1193313813	36226
2021-06-22 06:12:49	2021-06-22 15:31:43	9.3	100	1193313813	36227
2021-06-23 15:31:28	2021-06-23 23:31:28	8	102	1193313813	36228
2021-06-24 15:31:11	2021-06-24 23:31:11	8	102	1193313813	36229
2021-06-25 14:31:15	2021-06-25 22:31:15	8	102	1193313813	36230
2021-06-28 15:31:25	2021-06-28 23:31:25	8	102	1193313813	36231
2021-06-02 05:39:33	2021-06-02 13:39:33	8	102	426083188	36232
2021-06-03 05:34:50	2021-06-03 13:34:50	8	102	426083188	36233
2021-06-04 05:48:49	2021-06-04 13:48:49	8	102	426083188	36234
2021-06-05 05:44:52	2021-06-05 13:44:52	8	102	426083188	36235
2021-06-08 05:40:36	2021-06-08 13:40:36	8	102	426083188	36236
2021-06-09 05:39:22	2021-06-09 13:39:22	8	102	426083188	36237
2021-06-11 05:44:18	2021-06-11 13:44:18	8	102	426083188	36238
2021-06-16 05:44:43	2021-06-16 13:44:43	8	102	426083188	36239
2021-06-21 05:45:50	2021-06-21 15:35:28	9.82	100	426083188	36240
2021-06-23 14:38:15	2021-06-23 22:38:15	8	102	426083188	36241
2021-06-24 04:52:09	2021-06-24 12:52:09	8	102	426083188	36242
2021-06-25 05:47:11	2021-06-25 13:47:11	8	102	426083188	36243
2021-06-26 05:40:03	2021-06-26 13:40:03	8	102	426083188	36244
2021-06-28 15:32:12	2021-06-28 23:32:12	8	102	426083188	36245
2021-06-30 09:35:50	2021-06-30 17:35:50	8	102	426083188	36246
2021-06-03 15:40:02	2021-06-03 23:40:02	8	102	426083188	36247
2021-06-04 15:33:29	2021-06-04 23:33:29	8	102	426083188	36248
2021-06-09 16:45:43	2021-06-10 00:45:43	8	102	426083188	36249
2021-06-15 15:00:28	2021-06-15 23:00:28	8	102	426083188	36250
2021-06-18 15:34:46	2021-06-18 23:34:46	8	102	426083188	36251
2021-06-22 15:39:35	2021-06-22 23:39:35	8	102	426083188	36252
2021-06-24 15:43:26	2021-06-24 23:43:26	8	102	426083188	36253
2021-06-25 14:41:34	2021-06-25 22:41:34	8	102	426083188	36254
2021-06-28 15:35:31	2021-06-28 23:35:31	8	102	426083188	36255
2021-06-30 05:50:16	2021-06-30 15:39:46	9.82	100	426083188	36256
2021-06-01 15:48:30	2021-06-01 23:48:30	8	102	1164124551	36257
2021-06-02 15:49:21	2021-06-02 23:49:21	8	102	1164124551	36258
2021-06-03 06:46:56	2021-06-03 15:48:27	9.02	100	1164124551	36259
2021-06-04 15:51:13	2021-06-04 23:51:13	8	102	1164124551	36260
2021-06-07 15:52:01	2021-06-07 23:52:01	8	102	1164124551	36261
2021-06-08 15:43:33	2021-06-08 23:43:33	8	102	1164124551	36262
2021-06-09 06:46:12	2021-06-09 15:49:23	9.05	100	1164124551	36263
2021-06-10 15:47:24	2021-06-10 23:47:24	8	102	1164124551	36264
2021-06-15 15:50:33	2021-06-15 23:50:33	8	102	1164124551	36265
2021-06-16 15:50:43	2021-06-16 23:50:43	8	102	1164124551	36266
2021-06-17 15:44:29	2021-06-17 23:44:29	8	102	1164124551	36267
2021-06-05 12:20:49	2021-06-05 14:44:35	2.37	101	2507374886	36268
2021-06-11 19:19:50	2021-06-12 03:19:50	8	102	2507374886	36269
2021-06-20 21:30:35	2021-06-21 05:30:35	8	102	2507374886	36270
2021-06-23 08:20:08	2021-06-23 22:12:44	13.87	100	2507374886	36271
2021-06-23 22:54:15	2021-06-03 15:01:00	27.51	101	2507374886	36272
2021-06-05 07:19:21	2021-06-05 15:44:04	8.4	100	2507374886	36273
2021-06-05 17:49:57	2021-06-06 12:05:35	8.12	101	2507374886	36274
2021-06-08 18:42:53	2021-06-09 07:03:36	12.33	100	2507374886	36275
2021-06-11 07:15:21	2021-06-11 16:35:17	9.32	100	2507374886	36276
2021-06-11 16:58:33	2021-06-15 07:01:29	24.78	101	2507374886	36277
2021-06-17 07:15:56	2021-06-17 17:37:12	10.35	100	2507374886	36278
2021-06-17 18:14:44	2021-06-18 07:31:35	13.27	100	2507374886	36279
2021-06-20 20:17:15	2021-06-21 07:04:08	10.27	101	2507374886	36280
2021-06-23 07:17:07	2021-06-23 17:46:35	10.48	100	2507374886	36281
2021-06-23 18:42:37	2021-06-24 07:26:31	9.52	101	2507374886	36282
2021-06-26 19:07:27	2021-06-27 07:03:09	11.92	100	2507374886	36283
2021-06-29 07:18:41	2021-06-29 18:57:45	11.65	100	2507374886	36284
2021-06-29 21:09:22	2021-06-30 07:38:46	10.48	100	2507374886	36285
2021-06-02 06:44:06	2021-06-02 14:44:06	8	102	2489352498	36286
2021-06-03 06:24:00	2021-06-03 14:24:00	8	102	2489352498	36287
2021-06-04 06:54:44	2021-06-04 14:54:44	8	102	2489352498	36288
2021-06-07 06:55:37	2021-06-07 14:55:37	8	102	2489352498	36289
2021-06-08 06:59:38	2021-06-08 14:59:38	8	102	2489352498	36290
2021-06-09 06:58:40	2021-06-09 14:58:40	8	102	2489352498	36291
2021-06-10 06:49:45	2021-06-10 14:49:45	8	102	2489352498	36292
2021-06-11 06:53:44	2021-06-11 14:53:44	8	102	2489352498	36293
2021-06-15 06:26:36	2021-06-15 14:26:36	8	102	2489352498	36294
2021-06-16 07:04:59	2021-06-16 15:04:59	8	102	2489352498	36295
2021-06-17 06:44:00	2021-06-17 14:44:00	8	102	2489352498	36296
2021-06-18 07:10:13	2021-06-18 15:10:13	8	102	2489352498	36297
2021-06-21 06:49:51	2021-06-21 15:43:27	8.88	100	2489352498	36298
2021-06-22 07:05:51	2021-06-22 15:54:08	8.8	100	2489352498	36299
2021-06-23 06:58:31	2021-06-23 15:44:56	8.77	100	2489352498	36300
2021-06-24 06:54:11	2021-06-24 15:45:39	8.85	100	2489352498	36301
2021-06-25 06:51:14	2021-06-25 14:38:51	7.78	100	2489352498	36302
2021-06-28 07:00:29	2021-06-28 15:00:29	8	102	2489352498	36303
2021-06-29 06:59:41	2021-06-29 15:42:12	8.7	100	2489352498	36304
2021-06-30 06:58:59	2021-06-30 15:45:14	8.77	100	2489352498	36305
2021-06-18 19:15:38	2021-06-19 06:21:43	6.85	101	1213363737	36306
2021-06-21 19:03:33	2021-06-22 03:03:33	8	102	1213363737	36307
2021-06-22 18:06:09	2021-06-25 05:20:43	17.72	101	1213363737	36308
2021-06-27 19:01:27	2021-06-27 19:20:32	0.32	100	1213363737	36309
2021-06-30 20:40:27	2021-06-30 22:42:46	2.03	100	1213363737	36310
2021-06-01 07:32:46	2021-06-01 15:32:46	8	102	1213363737	36311
2021-06-03 17:15:31	2021-06-04 07:12:40	13.95	100	1213363737	36312
2021-06-04 07:12:41	2021-06-04 15:12:41	8	102	1213363737	36313
2021-06-06 07:15:52	2021-06-06 17:34:37	10.3	100	1213363737	36314
2021-06-07 07:38:22	2021-06-07 15:38:22	8	102	1213363737	36315
2021-06-09 18:45:08	2021-06-09 23:02:58	4.28	100	1213363737	36316
2021-06-10 03:40:05	2021-06-10 07:11:52	3.52	100	1213363737	36317
2021-06-12 07:11:45	2021-06-12 08:38:28	1.43	100	1213363737	36318
2021-06-12 17:11:18	2021-06-13 01:11:18	8	102	1213363737	36319
2021-06-13 07:26:36	2021-06-13 15:26:36	8	102	1213363737	36320
2021-06-15 18:28:31	2021-06-16 07:12:50	12.73	100	1213363737	36321
2021-06-18 07:16:10	2021-06-18 15:16:10	8	102	1213363737	36322
2021-06-19 07:29:16	2021-06-19 15:29:16	8	102	1213363737	36323
2021-06-20 06:46:54	2021-06-20 07:15:10	0.47	100	1213363737	36324
2021-06-21 18:31:04	2021-06-22 07:10:55	12.65	100	1213363737	36325
2021-06-22 14:25:45	2021-06-22 22:25:45	8	102	1213363737	36326
2021-06-23 07:29:19	2021-06-23 15:29:19	8	102	1213363737	36327
2021-06-24 07:16:03	2021-06-24 15:16:03	8	102	1213363737	36328
2021-06-25 07:23:32	2021-06-25 15:23:32	8	102	1213363737	36329
2021-06-27 18:55:27	2021-06-28 04:14:42	9.32	100	1213363737	36330
2021-06-28 07:19:36	2021-06-28 15:19:36	8	102	1213363737	36331
2021-06-02 07:07:21	2021-06-02 15:07:21	8	102	419963991	36332
2021-06-03 06:58:48	2021-06-03 14:58:48	8	102	419963991	36333
2021-06-04 07:05:19	2021-06-04 15:05:19	8	102	419963991	36334
2021-06-07 06:57:13	2021-06-07 14:57:13	8	102	419963991	36335
2021-06-08 07:00:49	2021-06-08 15:00:49	8	102	419963991	36336
2021-06-09 07:03:25	2021-06-09 15:03:25	8	102	419963991	36337
2021-06-10 07:03:34	2021-06-10 15:03:34	8	102	419963991	36338
2021-06-11 09:29:20	2021-06-11 17:29:20	8	102	419963991	36339
2021-06-15 08:52:39	2021-06-15 16:52:39	8	102	419963991	36340
2021-06-16 07:06:47	2021-06-16 15:06:47	8	102	419963991	36341
2021-06-17 07:28:00	2021-06-17 15:28:00	8	102	419963991	36342
2021-06-18 06:59:00	2021-06-18 14:59:00	8	102	419963991	36343
2021-06-21 07:22:02	2021-06-21 16:21:09	8.98	100	419963991	36344
2021-06-22 06:56:01	2021-06-22 16:01:50	9.08	100	419963991	36345
2021-06-23 07:04:48	2021-06-23 15:59:15	8.9	100	419963991	36346
2021-06-24 09:10:42	2021-06-24 16:39:24	7.47	100	419963991	36347
2021-06-25 07:03:10	2021-06-25 15:02:27	7.98	100	419963991	36348
2021-06-28 07:03:01	2021-06-28 15:49:28	8.77	100	419963991	36349
2021-06-29 07:09:39	2021-06-29 17:06:36	9.93	100	419963991	36350
2021-06-30 07:06:35	2021-06-30 16:12:09	9.08	100	419963991	36351
2021-06-02 06:24:37	2021-06-02 14:24:37	8	102	2435085160	36352
2021-06-04 06:19:12	2021-06-04 14:19:12	8	102	2435085160	36353
2021-06-07 06:23:51	2021-06-07 14:23:51	8	102	2435085160	36354
2021-06-08 06:24:33	2021-06-08 14:24:33	8	102	2435085160	36355
2021-06-09 06:24:06	2021-06-09 10:33:10	4.15	100	2435085160	36356
2021-06-10 06:21:11	2021-06-10 14:21:11	8	102	2435085160	36357
2021-06-11 06:23:20	2021-06-11 14:23:20	8	102	2435085160	36358
2021-06-16 06:12:01	2021-06-16 14:12:01	8	102	2435085160	36359
2021-06-17 06:27:04	2021-06-17 14:27:04	8	102	2435085160	36360
2021-06-21 06:28:52	2021-06-21 14:28:52	8	102	2435085160	36361
2021-06-22 15:32:57	2021-06-22 23:32:57	8	102	2435085160	36362
2021-06-23 06:21:58	2021-06-23 15:33:22	9.18	100	2435085160	36363
2021-06-24 06:16:09	2021-06-24 15:33:03	9.27	100	2435085160	36364
2021-06-25 06:25:33	2021-06-25 14:25:33	8	102	2435085160	36365
2021-06-28 06:13:48	2021-06-28 15:32:44	9.3	100	2435085160	36366
2021-06-29 06:17:32	2021-06-29 14:17:32	8	102	2435085160	36367
2021-06-30 06:24:56	2021-06-30 15:35:31	9.17	100	2435085160	36368
2021-06-10 14:56:15	2021-06-10 16:14:47	1.3	100	1469059940	36369
2021-06-03 06:08:05	2021-06-03 14:08:05	8	102	544506729	36370
2021-06-07 15:45:18	2021-06-07 23:45:18	8	102	544506729	36371
2021-06-08 15:38:10	2021-06-08 23:38:10	8	102	544506729	36372
2021-06-09 15:35:18	2021-06-09 23:35:18	8	102	544506729	36373
2021-06-11 06:38:44	2021-06-11 14:38:44	8	102	544506729	36374
2021-06-16 06:11:33	2021-06-16 14:11:33	8	102	544506729	36375
2021-06-17 06:40:24	2021-06-17 14:40:24	8	102	544506729	36376
2021-06-18 15:32:27	2021-06-18 23:32:27	8	102	544506729	36377
2021-06-22 15:36:19	2021-06-22 23:36:19	8	102	544506729	36378
2021-06-23 15:35:51	2021-06-23 23:35:51	8	102	544506729	36379
2021-06-28 06:42:45	2021-06-28 14:42:45	8	102	544506729	36380
2021-06-29 06:07:15	2021-06-29 14:07:15	8	102	544506729	36381
2021-06-02 06:40:53	2021-06-02 14:40:53	8	102	561526080	36382
2021-06-03 06:39:19	2021-06-03 14:39:19	8	102	561526080	36383
2021-06-04 06:42:11	2021-06-04 14:42:11	8	102	561526080	36384
2021-06-08 06:39:35	2021-06-08 14:39:35	8	102	561526080	36385
2021-06-09 05:44:34	2021-06-09 13:44:34	8	102	561526080	36386
2021-06-11 06:40:18	2021-06-11 14:40:18	8	102	561526080	36387
2021-06-15 06:40:18	2021-06-15 14:40:18	8	102	561526080	36388
2021-06-16 06:43:03	2021-06-16 14:43:03	8	102	561526080	36389
2021-06-17 06:38:40	2021-06-17 14:38:40	8	102	561526080	36390
2021-06-18 06:38:30	2021-06-18 14:38:30	8	102	561526080	36391
2021-06-21 15:44:05	2021-06-21 23:44:05	8	102	561526080	36392
2021-06-22 06:39:20	2021-06-22 15:42:51	9.05	100	561526080	36393
2021-06-23 15:45:13	2021-06-23 23:45:13	8	102	561526080	36394
2021-06-24 06:40:21	2021-06-24 15:44:57	9.07	100	561526080	36395
2021-06-25 06:40:01	2021-06-25 14:46:04	8.1	100	561526080	36396
2021-06-28 06:41:42	2021-06-28 15:42:28	9	100	561526080	36397
2021-06-29 15:45:37	2021-06-29 23:45:37	8	102	561526080	36398
2021-06-30 06:40:20	2021-06-30 15:43:18	9.03	100	561526080	36399
2021-06-02 06:04:53	2021-06-02 14:04:53	8	102	2016478809	36400
2021-06-03 06:10:56	2021-06-03 14:10:56	8	102	2016478809	36401
2021-06-04 06:05:32	2021-06-04 14:05:32	8	102	2016478809	36402
2021-06-07 06:03:55	2021-06-07 14:03:55	8	102	2016478809	36403
2021-06-08 06:05:18	2021-06-08 14:05:18	8	102	2016478809	36404
2021-06-09 06:03:44	2021-06-09 14:03:44	8	102	2016478809	36405
2021-06-10 06:01:01	2021-06-10 14:01:01	8	102	2016478809	36406
2021-06-11 06:30:53	2021-06-11 14:37:32	8.1	100	2016478809	36407
2021-06-15 06:06:57	2021-06-15 14:06:57	8	102	2016478809	36408
2021-06-16 06:08:53	2021-06-16 14:08:53	8	102	2016478809	36409
2021-06-17 05:46:42	2021-06-17 13:46:42	8	102	2016478809	36410
2021-06-18 06:06:01	2021-06-18 14:06:01	8	102	2016478809	36411
2021-06-21 06:06:11	2021-06-21 15:32:27	9.43	100	2016478809	36412
2021-06-22 06:08:11	2021-06-22 14:08:11	8	102	2016478809	36413
2021-06-23 06:07:40	2021-06-23 15:32:21	9.4	100	2016478809	36414
2021-06-24 06:07:52	2021-06-24 14:07:52	8	102	2016478809	36415
2021-06-25 06:02:19	2021-06-25 14:02:19	8	102	2016478809	36416
2021-06-28 06:13:16	2021-06-28 14:13:16	8	102	2016478809	36417
2021-06-29 06:14:30	2021-06-29 15:31:49	9.28	100	2016478809	36418
2021-06-30 06:03:30	2021-06-30 14:03:30	8	102	2016478809	36419
2021-06-02 07:21:01	2021-06-02 15:21:01	8	102	1884373561	36420
2021-06-03 07:59:25	2021-06-03 15:59:25	8	102	1884373561	36421
2021-06-07 07:12:02	2021-06-07 15:12:02	8	102	1884373561	36422
2021-06-08 07:25:11	2021-06-08 15:25:11	8	102	1884373561	36423
2021-06-09 07:45:38	2021-06-09 15:45:38	8	102	1884373561	36424
2021-06-10 07:19:23	2021-06-10 15:19:23	8	102	1884373561	36425
2021-06-11 07:23:16	2021-06-11 15:23:16	8	102	1884373561	36426
2021-06-15 07:29:34	2021-06-15 15:29:34	8	102	1884373561	36427
2021-06-16 07:44:48	2021-06-16 15:44:48	8	102	1884373561	36428
2021-06-17 07:56:18	2021-06-17 15:56:18	8	102	1884373561	36429
2021-06-18 07:16:46	2021-06-18 15:16:46	8	102	1884373561	36430
2021-06-21 07:45:58	2021-06-21 16:55:39	9.15	100	1884373561	36431
2021-06-22 07:20:36	2021-06-22 16:18:57	8.97	100	1884373561	36432
2021-06-23 07:16:03	2021-06-23 16:44:17	9.47	100	1884373561	36433
2021-06-24 07:41:10	2021-06-24 16:46:33	9.08	100	1884373561	36434
2021-06-25 07:23:10	2021-06-25 16:21:39	8.97	100	1884373561	36435
2021-06-28 07:39:37	2021-06-28 16:35:04	8.92	100	1884373561	36436
2021-06-29 07:45:52	2021-06-29 16:49:56	9.07	100	1884373561	36437
2021-06-30 07:47:04	2021-06-30 16:38:00	8.83	100	1884373561	36438
2021-06-01 15:40:41	2021-06-01 23:40:41	8	102	1158050578	36439
2021-06-02 06:43:45	2021-06-02 15:39:18	8.92	100	1158050578	36440
2021-06-03 05:37:10	2021-06-03 15:39:14	10.03	100	1158050578	36441
2021-06-04 11:59:42	2021-06-04 12:12:29	0.2	100	1158050578	36442
2021-06-07 15:40:51	2021-06-08 05:36:54	13.93	100	1158050578	36443
2021-06-08 15:40:29	2021-06-08 23:40:29	8	102	1158050578	36444
2021-06-09 05:47:19	2021-06-09 15:39:35	9.87	100	1158050578	36445
2021-06-10 15:39:42	2021-06-11 05:37:41	13.95	100	1158050578	36446
2021-06-11 14:42:24	2021-06-11 22:42:24	8	102	1158050578	36447
2021-06-15 05:38:28	2021-06-15 15:43:29	10.08	100	1158050578	36448
2021-06-16 05:38:32	2021-06-16 15:41:33	10.05	100	1158050578	36449
2021-06-17 05:37:57	2021-06-17 15:37:01	9.98	100	1158050578	36450
2021-06-18 05:36:23	2021-06-18 15:38:51	10.03	100	1158050578	36451
2021-06-21 05:38:26	2021-06-21 15:43:48	10.08	100	1158050578	36452
2021-06-22 05:37:48	2021-06-22 15:40:48	10.05	100	1158050578	36453
2021-06-23 05:35:42	2021-06-23 15:43:25	10.12	100	1158050578	36454
2021-06-24 05:40:06	2021-06-24 13:40:06	8	102	1158050578	36455
2021-06-25 05:39:32	2021-06-25 14:43:47	9.07	100	1158050578	36456
2021-06-28 05:38:28	2021-06-28 15:48:25	10.15	100	1158050578	36457
2021-06-29 05:39:45	2021-06-29 15:44:24	10.07	100	1158050578	36458
2021-06-30 05:38:19	2021-06-30 15:42:15	10.05	100	1158050578	36459
2021-06-02 13:23:47	2021-06-02 21:23:47	8	102	1098937891	36460
2021-06-07 07:22:41	2021-06-07 16:57:28	9.57	100	1098937891	36461
2021-06-09 07:24:38	2021-06-09 15:24:38	8	102	1098937891	36462
2021-06-10 07:20:26	2021-06-10 15:20:26	8	102	1098937891	36463
2021-06-11 06:28:15	2021-06-11 12:35:20	6.12	100	1098937891	36464
2021-06-15 07:23:19	2021-06-15 16:27:57	9.07	100	1098937891	36465
2021-06-16 07:43:51	2021-06-16 11:45:56	4.03	100	1098937891	36466
2021-06-17 07:18:18	2021-06-17 15:18:18	8	102	1098937891	36467
2021-06-18 11:59:38	2021-06-18 19:59:38	8	102	1098937891	36468
2021-06-21 07:10:06	2021-06-21 16:17:38	9.12	100	1098937891	36469
2021-06-23 12:25:40	2021-06-23 12:37:23	0.18	100	1098937891	36470
2021-06-25 16:28:48	2021-06-26 00:28:48	8	102	1098937891	36471
2021-06-28 07:10:44	2021-06-28 15:10:44	8	102	1098937891	36472
2021-06-29 07:07:53	2021-06-29 22:31:51	11.83	101	1098937891	36473
2021-06-01 06:12:59	2021-06-01 17:16:59	11.07	100	1098937891	36474
2021-06-02 06:10:55	2021-06-02 16:47:53	10.6	100	1098937891	36475
2021-06-03 06:15:22	2021-06-03 16:46:31	10.52	100	1098937891	36476
2021-06-04 06:03:03	2021-06-04 14:03:03	8	102	1098937891	36477
2021-06-07 17:28:25	2021-06-08 06:16:20	12.78	100	1098937891	36478
2021-06-08 16:27:12	2021-06-09 06:13:22	13.77	100	1098937891	36479
2021-06-15 16:40:07	2021-06-16 06:24:36	13.73	100	1098937891	36480
2021-06-17 20:15:45	2021-06-18 06:43:33	10.45	100	1098937891	36481
2021-06-21 20:22:05	2021-06-22 06:21:47	9.98	100	1098937891	36482
2021-06-22 20:16:19	2021-06-23 06:06:44	9.83	100	1098937891	36483
2021-06-23 20:29:34	2021-06-24 04:29:34	8	102	1098937891	36484
2021-06-29 19:12:21	2021-06-30 06:29:16	11.27	100	1098937891	36485
2021-06-03 05:38:11	2021-06-03 13:38:11	8	102	1192375702	36486
2021-06-04 05:37:40	2021-06-04 13:37:40	8	102	1192375702	36487
2021-06-07 05:37:38	2021-06-07 13:37:38	8	102	1192375702	36488
2021-06-08 05:36:15	2021-06-08 13:36:15	8	102	1192375702	36489
2021-06-09 05:38:13	2021-06-09 08:53:55	3.25	100	1192375702	36490
2021-06-10 09:29:24	2021-06-10 17:29:24	8	102	1192375702	36491
2021-06-11 05:35:01	2021-06-11 13:35:01	8	102	1192375702	36492
2021-06-16 05:37:35	2021-06-16 13:37:35	8	102	1192375702	36493
2021-06-17 05:35:49	2021-06-17 13:35:49	8	102	1192375702	36494
2021-06-18 05:36:54	2021-06-18 13:36:54	8	102	1192375702	36495
2021-06-21 05:38:26	2021-06-21 13:38:26	8	102	1192375702	36496
2021-06-23 15:31:07	2021-06-23 23:31:07	8	102	1192375702	36497
2021-06-24 05:38:57	2021-06-24 13:38:57	8	102	1192375702	36498
2021-06-25 05:41:13	2021-06-25 14:37:24	8.93	100	1192375702	36499
2021-06-28 06:43:19	2021-06-28 19:06:46	9.8	101	1192375702	36500
2021-06-29 05:34:19	2021-06-29 14:29:22	8.92	100	1192375702	36501
2021-06-30 05:38:36	2021-06-30 13:22:18	7.72	100	1192375702	36502
2021-06-07 12:05:26	2021-06-07 15:00:01	2.9	100	1192375702	36503
2021-06-10 05:42:56	2021-06-10 13:42:56	8	102	1192375702	36504
2021-06-01 05:39:47	2021-06-01 14:39:56	9	100	1746113616	36505
2021-06-02 14:42:19	2021-06-02 22:42:19	8	102	1746113616	36506
2021-06-03 05:33:32	2021-06-03 14:45:49	9.2	100	1746113616	36507
2021-06-04 05:38:15	2021-06-04 14:46:36	9.13	100	1746113616	36508
2021-06-07 13:40:47	2021-06-07 23:02:25	9.35	100	1746113616	36509
2021-06-08 13:54:59	2021-06-08 23:02:25	9.12	100	1746113616	36510
2021-06-09 13:50:03	2021-06-09 23:02:20	9.2	100	1746113616	36511
2021-06-10 13:46:21	2021-06-10 21:46:21	8	102	1746113616	36512
2021-06-11 20:01:39	2021-06-12 04:01:39	8	102	1746113616	36513
2021-06-15 14:43:47	2021-06-15 22:43:47	8	102	1746113616	36514
2021-06-16 05:39:34	2021-06-16 06:37:14	0.95	100	1746113616	36515
2021-06-17 05:39:18	2021-06-17 14:47:38	9.13	100	1746113616	36516
2021-06-18 05:41:10	2021-06-18 14:43:14	9.03	100	1746113616	36517
2021-06-21 13:51:47	2021-06-21 23:02:25	9.17	100	1746113616	36518
2021-06-22 13:41:26	2021-06-22 23:02:18	9.33	100	1746113616	36519
2021-06-23 13:33:45	2021-06-23 23:01:40	9.45	100	1746113616	36520
2021-06-24 13:46:04	2021-06-24 23:03:26	9.28	100	1746113616	36521
2021-06-25 13:06:11	2021-06-25 20:59:58	7.88	100	1746113616	36522
2021-06-28 05:34:53	2021-06-28 14:47:35	9.2	100	1746113616	36523
2021-06-29 14:43:19	2021-06-29 22:43:19	8	102	1746113616	36524
2021-06-30 05:45:27	2021-06-30 14:44:57	8.98	100	1746113616	36525
2021-06-01 16:16:58	2021-06-02 05:38:34	13.35	100	942086484	36526
2021-06-02 16:00:07	2021-06-03 05:33:02	13.53	100	942086484	36527
2021-06-03 15:55:59	2021-06-04 05:30:52	13.57	100	942086484	36528
2021-06-04 15:57:51	2021-06-05 05:40:53	13.72	100	942086484	36529
2021-06-05 11:46:38	2021-06-05 19:46:38	8	102	942086484	36530
2021-06-07 05:36:03	2021-06-07 15:47:18	10.18	100	942086484	36531
2021-06-08 15:55:03	2021-06-09 05:38:12	13.72	100	942086484	36532
2021-06-09 15:58:30	2021-06-10 05:36:56	13.63	100	942086484	36533
2021-06-11 05:41:14	2021-06-11 14:53:30	9.2	100	942086484	36534
2021-06-15 05:34:29	2021-06-15 15:58:53	10.4	100	942086484	36535
2021-06-16 16:00:53	2021-06-17 05:33:20	13.53	100	942086484	36536
2021-06-18 05:32:44	2021-06-18 15:37:47	10.08	100	942086484	36537
2021-06-19 05:59:43	2021-06-19 12:12:17	6.18	101	942086484	36538
2021-06-21 16:08:07	2021-06-22 00:08:07	8	102	942086484	36539
2021-06-22 15:47:51	2021-06-22 23:47:51	8	102	942086484	36540
2021-06-24 05:37:25	2021-06-24 15:54:18	10.27	100	942086484	36541
2021-06-25 05:35:30	2021-06-25 14:38:21	9.03	100	942086484	36542
2021-06-28 15:48:55	2021-06-29 05:43:03	13.9	100	942086484	36543
2021-06-02 06:38:49	2021-06-02 14:38:49	8	102	2466743649	36544
2021-06-03 05:45:26	2021-06-03 13:45:26	8	102	2466743649	36545
2021-06-04 06:36:43	2021-06-04 14:36:43	8	102	2466743649	36546
2021-06-07 06:28:51	2021-06-07 14:28:51	8	102	2466743649	36547
2021-06-08 06:38:04	2021-06-08 14:38:04	8	102	2466743649	36548
2021-06-10 06:34:16	2021-06-10 14:34:16	8	102	2466743649	36549
2021-06-11 06:38:57	2021-06-11 14:38:57	8	102	2466743649	36550
2021-06-15 06:33:18	2021-06-15 14:33:18	8	102	2466743649	36551
2021-06-16 06:31:10	2021-06-16 14:31:10	8	102	2466743649	36552
2021-06-17 06:33:58	2021-06-17 14:33:58	8	102	2466743649	36553
2021-06-21 06:40:12	2021-06-21 15:31:57	8.85	100	2466743649	36554
2021-06-22 06:39:43	2021-06-22 14:39:43	8	102	2466743649	36555
2021-06-23 06:40:46	2021-06-23 14:40:46	8	102	2466743649	36556
2021-06-24 06:41:44	2021-06-24 15:31:40	8.82	100	2466743649	36557
2021-06-25 06:43:36	2021-06-25 14:43:36	8	102	2466743649	36558
2021-06-28 06:42:09	2021-06-28 15:31:39	8.82	100	2466743649	36559
2021-06-29 06:33:13	2021-06-29 14:33:13	8	102	2466743649	36560
2021-06-30 06:31:58	2021-06-30 15:31:53	8.98	100	2466743649	36561
2021-06-02 06:13:58	2021-06-02 14:13:58	8	102	1225089667	36562
2021-06-03 06:32:51	2021-06-03 14:32:51	8	102	1225089667	36563
2021-06-04 06:26:52	2021-06-04 14:26:52	8	102	1225089667	36564
2021-06-07 06:43:44	2021-06-07 14:43:44	8	102	1225089667	36565
2021-06-08 07:16:40	2021-06-08 15:16:40	8	102	1225089667	36566
2021-06-09 06:31:48	2021-06-09 14:31:48	8	102	1225089667	36567
2021-06-10 06:26:48	2021-06-10 14:26:48	8	102	1225089667	36568
2021-06-11 09:34:38	2021-06-11 17:34:38	8	102	1225089667	36569
2021-06-15 06:35:06	2021-06-15 14:35:06	8	102	1225089667	36570
2021-06-17 07:09:05	2021-06-17 15:09:05	8	102	1225089667	36571
2021-06-18 07:07:23	2021-06-18 15:07:23	8	102	1225089667	36572
2021-06-21 06:53:33	2021-06-21 14:53:33	8	102	1225089667	36573
2021-06-22 06:42:17	2021-06-23 23:39:19	19.15	101	1225089667	36574
2021-06-24 06:22:47	2021-06-24 15:41:25	9.3	100	1225089667	36575
2021-06-25 14:41:22	2021-06-25 22:41:22	8	102	1225089667	36576
2021-06-11 07:13:47	2021-06-11 15:13:47	8	102	1225089667	36577
2021-06-21 08:19:57	2021-06-21 16:19:57	8	102	389359248	36578
2021-06-28 04:51:46	2021-06-28 12:51:46	8	102	389359248	36579
2021-06-01 06:50:00	2021-06-01 07:15:22	0.42	100	389359248	36580
2021-06-03 06:59:40	2021-06-03 18:34:48	11.58	100	389359248	36581
2021-06-04 07:16:48	2021-06-04 15:16:48	8	102	389359248	36582
2021-06-06 19:00:50	2021-06-07 04:00:45	8.98	100	389359248	36583
2021-06-07 07:13:25	2021-06-07 15:13:25	8	102	389359248	36584
2021-06-09 07:01:50	2021-06-09 15:01:50	8	102	389359248	36585
2021-06-12 18:40:46	2021-06-12 18:53:40	0.2	100	389359248	36586
2021-06-13 06:22:07	2021-06-13 07:12:56	0.83	100	389359248	36587
2021-06-15 06:49:22	2021-06-15 14:49:22	8	102	389359248	36588
2021-06-16 07:32:43	2021-06-16 15:32:43	8	102	389359248	36589
2021-06-18 18:57:44	2021-06-18 23:11:25	4.22	100	389359248	36590
2021-06-19 03:47:46	2021-06-19 07:13:23	3.42	100	389359248	36591
2021-06-21 07:02:32	2021-06-21 15:02:32	8	102	389359248	36592
2021-06-22 07:25:11	2021-06-22 15:25:11	8	102	389359248	36593
2021-06-24 18:46:36	2021-06-24 23:13:19	4.43	100	389359248	36594
2021-06-25 04:10:48	2021-06-25 15:06:52	8.08	101	389359248	36595
2021-06-27 06:54:06	2021-06-27 14:54:06	8	102	389359248	36596
2021-06-28 07:33:17	2021-06-28 15:33:17	8	102	389359248	36597
2021-06-07 06:42:15	2021-06-07 14:42:15	8	102	1631155237	36598
2021-06-21 15:40:55	2021-06-21 23:40:55	8	102	1631155237	36599
2021-06-22 15:38:54	2021-06-22 23:38:54	8	102	1631155237	36600
2021-06-23 06:41:40	2021-06-23 15:36:15	8.9	100	1631155237	36601
2021-06-28 15:33:04	2021-06-28 23:33:04	8	102	1631155237	36602
2021-06-29 06:39:55	2021-06-29 15:34:26	8.9	100	1631155237	36603
2021-06-30 15:38:54	2021-06-30 23:38:54	8	102	1631155237	36604
2021-06-09 06:25:41	2021-06-09 15:37:09	9.18	100	1631155237	36605
2021-06-21 08:21:01	2021-06-21 08:29:58	0.13	100	1631155237	36606
2021-06-02 06:37:16	2021-06-02 14:37:16	8	102	1214730528	36607
2021-06-03 05:37:09	2021-06-03 13:37:09	8	102	1214730528	36608
2021-06-04 06:35:20	2021-06-04 09:55:57	3.33	100	1214730528	36609
2021-06-05 06:40:51	2021-06-05 14:40:51	8	102	1214730528	36610
2021-06-07 06:38:38	2021-06-07 14:38:38	8	102	1214730528	36611
2021-06-08 11:05:45	2021-06-08 19:05:45	8	102	1214730528	36612
2021-06-09 06:39:27	2021-06-09 14:39:27	8	102	1214730528	36613
2021-06-10 06:33:25	2021-06-10 14:33:25	8	102	1214730528	36614
2021-06-11 06:38:01	2021-06-11 13:55:30	7.28	100	1214730528	36615
2021-06-11 09:46:16	2021-06-11 11:15:50	1.48	100	1214730528	36616
2021-06-01 15:35:12	2021-06-01 23:35:12	8	102	810653512	36617
2021-06-02 06:29:04	2021-06-02 14:29:04	8	102	810653512	36618
2021-06-03 06:33:33	2021-06-03 14:33:33	8	102	810653512	36619
2021-06-04 06:26:20	2021-06-04 14:26:20	8	102	810653512	36620
2021-06-07 06:31:20	2021-06-07 14:31:20	8	102	810653512	36621
2021-06-08 06:32:09	2021-06-08 15:34:48	9.03	100	810653512	36622
2021-06-09 06:31:02	2021-06-09 14:31:02	8	102	810653512	36623
2021-06-10 06:27:35	2021-06-10 15:33:19	9.08	100	810653512	36624
2021-06-11 15:27:05	2021-06-11 23:27:05	8	102	810653512	36625
2021-06-15 06:30:14	2021-06-15 14:30:14	8	102	810653512	36626
2021-06-16 06:27:17	2021-06-16 15:33:45	9.1	100	810653512	36627
2021-06-17 06:25:32	2021-06-17 14:25:32	8	102	810653512	36628
2021-06-18 06:29:34	2021-06-18 14:29:34	8	102	810653512	36629
2021-06-21 06:25:20	2021-06-21 15:33:53	9.13	100	810653512	36630
2021-06-22 06:35:08	2021-06-22 14:35:08	8	102	810653512	36631
2021-06-23 06:31:54	2021-06-23 14:31:54	8	102	810653512	36632
2021-06-24 06:32:13	2021-06-24 14:32:13	8	102	810653512	36633
2021-06-25 06:26:47	2021-06-25 14:33:52	8.12	100	810653512	36634
2021-06-28 06:28:36	2021-06-28 14:28:36	8	102	810653512	36635
2021-06-29 06:26:13	2021-06-29 14:26:13	8	102	810653512	36636
2021-06-01 12:45:56	2021-06-01 20:45:56	8	102	2500227640	36637
2021-06-02 06:32:24	2021-06-02 15:37:16	9.07	100	2500227640	36638
2021-06-03 06:31:17	2021-06-03 15:40:47	9.15	100	2500227640	36639
2021-06-04 06:32:39	2021-06-04 15:41:24	9.13	100	2500227640	36640
2021-06-07 06:32:31	2021-06-07 15:38:20	9.08	100	2500227640	36641
2021-06-08 06:32:55	2021-06-08 14:32:55	8	102	2500227640	36642
2021-06-09 06:33:29	2021-06-09 15:38:47	9.08	100	2500227640	36643
2021-06-10 15:38:47	2021-06-10 23:38:47	8	102	2500227640	36644
2021-06-11 14:41:02	2021-06-11 22:41:02	8	102	2500227640	36645
2021-06-15 06:32:50	2021-06-15 15:45:25	9.2	100	2500227640	36646
2021-06-16 06:31:44	2021-06-16 15:46:29	9.23	100	2500227640	36647
2021-06-17 06:34:37	2021-06-17 15:46:30	9.18	100	2500227640	36648
2021-06-18 06:33:45	2021-06-18 15:43:59	9.17	100	2500227640	36649
2021-06-21 15:57:14	2021-06-21 23:57:14	8	102	2500227640	36650
2021-06-22 06:35:52	2021-06-22 14:35:52	8	102	2500227640	36651
2021-06-23 15:46:59	2021-06-23 23:46:59	8	102	2500227640	36652
2021-06-24 06:32:53	2021-06-24 15:46:18	9.22	100	2500227640	36653
2021-06-25 06:35:48	2021-06-25 14:50:03	8.23	100	2500227640	36654
2021-06-28 06:35:37	2021-06-28 15:45:29	9.15	100	2500227640	36655
2021-06-29 06:33:29	2021-06-29 15:45:28	9.18	100	2500227640	36656
2021-06-02 14:05:10	2021-06-02 22:05:10	8	102	391252356	36657
2021-06-03 11:24:36	2021-06-03 19:24:36	8	102	391252356	36658
2021-06-04 14:09:04	2021-06-04 22:09:04	8	102	391252356	36659
2021-06-07 05:42:47	2021-06-07 13:42:47	8	102	391252356	36660
2021-06-08 05:43:52	2021-06-08 13:43:52	8	102	391252356	36661
2021-06-09 05:52:55	2021-06-09 13:52:55	8	102	391252356	36662
2021-06-15 14:06:22	2021-06-15 22:06:22	8	102	391252356	36663
2021-06-16 14:02:10	2021-06-16 22:02:10	8	102	391252356	36664
2021-06-17 14:01:24	2021-06-17 22:01:24	8	102	391252356	36665
2021-06-21 05:49:02	2021-06-21 13:49:02	8	102	391252356	36666
2021-06-22 14:47:56	2021-06-22 22:47:56	8	102	391252356	36667
2021-06-23 14:46:02	2021-06-23 22:46:02	8	102	391252356	36668
2021-06-24 05:53:34	2021-06-24 14:48:01	8.9	100	391252356	36669
2021-06-25 13:46:48	2021-06-25 21:46:48	8	102	391252356	36670
2021-06-28 14:12:26	2021-06-28 22:12:26	8	102	391252356	36671
2021-06-29 14:07:43	2021-06-29 22:07:43	8	102	391252356	36672
2021-06-02 07:30:06	2021-06-02 15:30:06	8	102	638812231	36673
2021-06-03 07:36:07	2021-06-03 15:36:07	8	102	638812231	36674
2021-06-04 07:20:54	2021-06-04 15:20:54	8	102	638812231	36675
2021-06-07 07:21:15	2021-06-07 15:21:15	8	102	638812231	36676
2021-06-08 07:29:37	2021-06-08 15:29:37	8	102	638812231	36677
2021-06-09 07:19:17	2021-06-09 15:19:17	8	102	638812231	36678
2021-06-10 07:26:21	2021-06-10 15:26:21	8	102	638812231	36679
2021-06-11 07:19:06	2021-06-11 15:19:06	8	102	638812231	36680
2021-06-15 07:23:00	2021-06-15 15:23:00	8	102	638812231	36681
2021-06-16 07:26:48	2021-06-16 15:26:48	8	102	638812231	36682
2021-06-17 07:34:10	2021-06-17 15:34:10	8	102	638812231	36683
2021-06-18 07:04:35	2021-06-18 15:04:35	8	102	638812231	36684
2021-06-22 07:24:20	2021-06-22 16:11:02	8.77	100	638812231	36685
2021-06-23 07:18:09	2021-06-23 16:14:45	8.93	100	638812231	36686
2021-06-24 07:12:21	2021-06-24 13:12:43	6	100	638812231	36687
2021-06-25 07:15:56	2021-06-25 15:15:56	8	102	638812231	36688
2021-06-28 07:21:43	2021-06-28 16:16:35	8.9	100	638812231	36689
2021-06-29 07:26:01	2021-06-29 15:45:17	8.32	100	638812231	36690
2021-06-30 07:31:33	2021-06-30 15:58:49	8.45	100	638812231	36691
2021-06-01 14:04:54	2021-06-01 23:03:34	8.97	100	1450414344	36692
2021-06-02 23:03:04	2021-06-03 07:03:04	8	102	1450414344	36693
2021-06-03 14:04:48	2021-06-03 23:03:31	8.97	100	1450414344	36694
2021-06-04 14:04:39	2021-06-04 23:04:16	8.98	100	1450414344	36695
2021-06-07 05:46:09	2021-06-07 14:48:15	9.03	100	1450414344	36696
2021-06-08 14:46:41	2021-06-08 22:46:41	8	102	1450414344	36697
2021-06-09 05:48:22	2021-06-09 14:46:12	8.95	100	1450414344	36698
2021-06-10 05:49:11	2021-06-10 14:46:56	8.95	100	1450414344	36699
2021-06-11 05:48:23	2021-06-11 13:45:19	7.93	100	1450414344	36700
2021-06-11 14:54:02	2021-06-11 14:57:11	0.05	100	1450414344	36701
2021-06-15 14:05:20	2021-06-16 01:03:42	10.97	100	1450414344	36702
2021-06-16 14:08:30	2021-06-16 23:03:44	8.92	100	1450414344	36703
2021-06-17 14:07:02	2021-06-17 23:02:49	8.92	100	1450414344	36704
2021-06-18 14:11:32	2021-06-18 23:03:52	8.87	100	1450414344	36705
2021-06-19 05:52:54	2021-06-19 11:59:19	6.1	100	1450414344	36706
2021-06-21 05:49:19	2021-06-21 14:46:09	8.93	100	1450414344	36707
2021-06-22 05:49:30	2021-06-22 14:45:41	8.93	100	1450414344	36708
2021-06-23 05:51:02	2021-06-23 14:37:59	8.77	100	1450414344	36709
2021-06-24 05:48:29	2021-06-24 14:40:53	8.87	100	1450414344	36710
2021-06-25 05:47:29	2021-06-25 13:47:29	8	102	1450414344	36711
2021-06-26 05:51:25	2021-06-26 11:56:37	6.08	100	1450414344	36712
2021-06-28 14:03:26	2021-06-28 23:04:25	9	100	1450414344	36713
2021-06-29 14:04:56	2021-06-29 23:03:43	8.97	100	1450414344	36714
2021-06-30 14:13:27	2021-06-30 23:02:40	8.82	100	1450414344	36715
2021-06-17 08:10:57	2021-06-17 16:10:57	8	102	2501124214	36716
2021-06-24 08:44:58	2021-06-24 08:48:50	0.05	100	2501124214	36717
2021-06-30 09:01:07	2021-06-30 17:01:07	8	102	2501124214	36718
2021-06-03 17:51:39	2021-06-04 01:51:39	8	102	2501124214	36719
2021-06-04 15:36:06	2021-06-04 23:36:06	8	102	2501124214	36720
2021-06-09 05:49:14	2021-06-09 13:49:14	8	102	2501124214	36721
2021-06-11 14:34:47	2021-06-11 22:34:47	8	102	2501124214	36722
2021-06-15 15:35:38	2021-06-15 23:35:38	8	102	2501124214	36723
2021-06-16 06:40:28	2021-06-16 15:36:50	8.93	100	2501124214	36724
2021-06-18 15:36:35	2021-06-18 23:36:35	8	102	2501124214	36725
2021-06-22 06:42:18	2021-06-22 14:42:18	8	102	2501124214	36726
2021-06-01 15:38:42	2021-06-01 23:38:42	8	102	2538866226	36727
2021-06-02 06:41:17	2021-06-02 15:36:09	8.9	100	2538866226	36728
2021-06-04 15:38:46	2021-06-04 23:38:46	8	102	2538866226	36729
2021-06-07 06:52:05	2021-06-07 15:38:43	8.77	100	2538866226	36730
2021-06-08 06:41:05	2021-06-08 15:38:28	8.95	100	2538866226	36731
2021-06-09 06:32:34	2021-06-09 15:38:04	9.08	100	2538866226	36732
2021-06-10 06:46:11	2021-06-10 15:38:08	8.85	100	2538866226	36733
2021-06-11 06:44:00	2021-06-11 14:48:56	8.07	100	2538866226	36734
2021-06-15 06:52:30	2021-06-15 15:38:50	8.77	100	2538866226	36735
2021-06-16 06:51:21	2021-06-16 15:35:12	8.72	100	2538866226	36736
2021-06-17 06:44:07	2021-06-17 15:37:28	8.88	100	2538866226	36737
2021-06-18 06:41:08	2021-06-18 15:40:37	8.98	100	2538866226	36738
2021-06-21 06:38:07	2021-06-21 15:42:07	9.07	100	2538866226	36739
2021-06-22 15:38:51	2021-06-22 23:38:51	8	102	2538866226	36740
2021-06-23 06:28:34	2021-06-23 14:28:34	8	102	2538866226	36741
2021-06-24 06:27:04	2021-06-24 15:37:35	9.17	100	2538866226	36742
2021-06-25 06:31:11	2021-06-25 13:29:33	6.97	100	2538866226	36743
2021-06-28 06:40:31	2021-06-28 15:39:49	8.98	100	2538866226	36744
2021-06-29 06:36:02	2021-06-29 15:37:02	9.02	100	2538866226	36745
2021-06-30 06:46:37	2021-06-30 15:39:01	8.87	100	2538866226	36746
2021-06-02 06:47:53	2021-06-02 14:47:53	8	102	595153942	36747
2021-06-03 06:56:44	2021-06-03 14:56:44	8	102	595153942	36748
2021-06-04 06:53:59	2021-06-04 14:53:59	8	102	595153942	36749
2021-06-07 06:53:23	2021-06-07 14:53:23	8	102	595153942	36750
2021-06-08 06:47:39	2021-06-08 14:47:39	8	102	595153942	36751
2021-06-09 06:54:51	2021-06-09 14:54:51	8	102	595153942	36752
2021-06-10 06:50:54	2021-06-10 14:50:54	8	102	595153942	36753
2021-06-11 06:49:35	2021-06-11 14:49:35	8	102	595153942	36754
2021-06-15 06:50:11	2021-06-15 14:50:11	8	102	595153942	36755
2021-06-16 06:47:36	2021-06-16 14:47:36	8	102	595153942	36756
2021-06-17 06:46:37	2021-06-17 14:46:37	8	102	595153942	36757
2021-06-18 06:54:03	2021-06-18 14:54:03	8	102	595153942	36758
2021-06-21 06:54:09	2021-06-21 13:57:17	7.05	100	595153942	36759
2021-06-22 06:55:15	2021-06-22 15:24:15	8.48	100	595153942	36760
2021-06-23 06:49:20	2021-06-23 15:22:09	8.53	100	595153942	36761
2021-06-24 06:47:37	2021-06-24 15:15:49	8.47	100	595153942	36762
2021-06-25 06:49:38	2021-06-25 14:07:51	7.3	100	595153942	36763
2021-06-28 15:22:22	2021-06-28 23:22:22	8	102	595153942	36764
2021-06-29 06:55:16	2021-06-29 15:32:18	8.62	100	595153942	36765
2021-06-30 06:44:06	2021-06-30 15:40:02	8.92	100	595153942	36766
2021-06-02 15:48:39	2021-06-02 23:48:39	8	102	595153942	36767
2021-06-11 12:47:16	2021-06-11 20:47:16	8	102	642058033	36768
2021-06-17 05:25:21	2021-06-17 13:25:21	8	102	642058033	36769
2021-06-19 05:51:56	2021-06-19 11:59:58	6.13	100	642058033	36770
2021-06-23 05:12:28	2021-06-23 17:37:08	12.4	100	642058033	36771
2021-06-25 05:14:20	2021-06-25 17:09:09	11.9	100	642058033	36772
2021-06-01 05:39:55	2021-06-01 17:44:07	12.07	100	642058033	36773
2021-06-02 05:28:01	2021-06-02 18:17:28	12.82	100	642058033	36774
2021-06-03 05:26:38	2021-06-03 16:01:21	10.57	100	642058033	36775
2021-06-05 05:49:57	2021-06-05 13:49:57	8	102	642058033	36776
2021-06-07 05:25:24	2021-06-07 18:06:57	12.68	100	642058033	36777
2021-06-08 05:29:46	2021-06-08 18:27:21	12.95	100	642058033	36778
2021-06-09 05:37:28	2021-06-09 18:00:14	12.37	100	642058033	36779
2021-06-10 05:35:09	2021-06-10 13:35:09	8	102	642058033	36780
2021-06-11 05:27:05	2021-06-11 13:27:05	8	102	642058033	36781
2021-06-16 05:36:14	2021-06-16 13:36:14	8	102	642058033	36782
2021-06-18 05:25:45	2021-06-18 15:56:35	10.5	100	642058033	36783
2021-06-21 05:29:41	2021-06-21 15:57:41	10.47	100	642058033	36784
2021-06-22 05:24:59	2021-06-22 18:48:40	13.38	100	642058033	36785
2021-06-24 05:27:03	2021-06-24 18:36:26	13.15	100	642058033	36786
2021-06-26 05:35:41	2021-06-26 13:09:04	7.55	100	642058033	36787
2021-06-28 05:23:59	2021-06-28 18:10:36	12.77	100	642058033	36788
2021-06-29 05:25:51	2021-06-29 16:22:21	10.93	100	642058033	36789
2021-06-30 05:27:33	2021-06-30 19:22:06	13.9	100	642058033	36790
2021-06-05 05:10:31	2021-06-05 13:10:31	8	102	372266793	36791
2021-06-16 06:46:12	2021-06-16 14:46:12	8	102	372266793	36792
2021-06-21 15:40:41	2021-06-21 23:40:41	8	102	372266793	36793
2021-06-22 15:41:22	2021-06-22 15:49:09	0.12	100	372266793	36794
2021-06-23 15:48:45	2021-06-23 23:48:45	8	102	372266793	36795
2021-06-24 15:39:14	2021-06-24 23:39:14	8	102	372266793	36796
2021-06-25 06:28:20	2021-06-25 14:40:07	8.18	100	372266793	36797
2021-06-28 15:40:06	2021-06-28 23:40:06	8	102	372266793	36798
2021-06-29 15:31:12	2021-06-29 23:31:12	8	102	372266793	36799
2021-06-01 06:48:32	2021-06-01 14:48:32	8	102	2257744661	36800
2021-06-02 05:44:51	2021-06-02 14:33:02	8.8	100	2257744661	36801
2021-06-03 06:52:20	2021-06-03 14:52:20	8	102	2257744661	36802
2021-06-04 05:54:26	2021-06-04 14:32:28	8.63	100	2257744661	36803
2021-06-07 06:43:35	2021-06-07 14:43:35	8	102	2257744661	36804
2021-06-08 06:52:02	2021-06-08 15:39:33	8.78	100	2257744661	36805
2021-06-09 06:49:47	2021-06-09 14:49:47	8	102	2257744661	36806
2021-06-10 06:51:54	2021-06-10 14:51:54	8	102	2257744661	36807
2021-06-11 06:43:02	2021-06-11 14:43:02	8	102	2257744661	36808
2021-06-15 06:44:54	2021-06-15 15:39:46	8.9	100	2257744661	36809
2021-06-16 06:45:29	2021-06-16 14:39:12	7.88	100	2257744661	36810
2021-06-17 06:43:26	2021-06-17 14:43:26	8	102	2257744661	36811
2021-06-18 05:45:36	2021-06-18 14:35:47	8.83	100	2257744661	36812
2021-06-21 06:38:36	2021-06-21 14:38:36	8	102	2257744661	36813
2021-06-22 05:55:18	2021-06-22 13:55:18	8	102	2257744661	36814
2021-06-23 05:56:21	2021-06-23 14:32:44	8.6	100	2257744661	36815
2021-06-24 05:47:26	2021-06-24 13:47:26	8	102	2257744661	36816
2021-06-25 05:48:12	2021-06-25 13:37:53	7.82	100	2257744661	36817
2021-06-28 06:53:20	2021-06-28 15:39:02	8.75	100	2257744661	36818
2021-06-30 05:55:05	2021-06-30 14:33:48	8.63	100	2257744661	36819
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: attendance; Owner: postgres
--

COPY attendance.users (id, firstname, lastname, card) FROM stdin;
10992		Посетитель	1480615713
10993	Елена	Гордеева	561526080
10994	Анна	Иванова	1465987648
10995		Орана	2456061779
10996	Ольга	Щербакова	2153027363
10997		Охрана	2507374886
10998	Владимир	Сергеев	278030163
10999	Вера	Иванова	1164124551
11000		Посетитель	557864505
11001	Сергей	Капитонов	1631061826
11002	Оксана	Глухова	810653512
11003	Виталий 	Целищев	306657286
11004	Григорий	Иванов	1075942712
11005	Сергей	Щукин	305434710
11006	Иван	Лосеев	1130719028
11007	Николай	Иванов	1631097861
11008	Алексей	Скачков	371819779
11009		Посетитель	305414998
11010	Павел	Злобин	419963991
11011	Дмитрий 	Яковлев	391252356
11012	Андрей	Александров	1884373561
11013	Алексей	Латышев	642058033
11014	Светлана	Бахтина	2500227640
11015	Андрей	Шабашов	2018780721
11016	Сергей	Целищев	372266793
11017	Вадим	Краденов	1098937891
11018	Владимир	Смирнов	1482959107
11019	Майя	Яковлева	1214730528
11020	Римма	Матвеева	1497442311
11021	Андрей	Волокушин	822384007
11022	Лидия	Лисицына	2237928199
11023	Сергей	Андреев	890710116
11024	Андрей	Смирнов	1905591336
11025	Валерий	Григорьев	1631155237
11026	Алина	Путина	1194744104
11027	Александр	Иванов	1634994472
11028	Алексей	Егоров	1225089667
11029	Владимир	Матвеев	1679325477
11030		Посетитель	1652884537
11031	Николай	Козлов	2538866226
11032		Посетитель	1469059940
11033	Дмитрий 	Павлов	1698169367
11034	Александр	Егоров	942086484
11035	Виктор	Денисов	911765570
11036	Сергей	Польков	1164448544
11037	Юрий	Петров	1985091892
11038	Денис	Новосельцев	2489352498
11039	Галина	Васильева	544506729
11040	Людмила	Маркова	2435085160
11041	Татьяна	Поздеева	1113813080
11042	Александр	Федоров	427828579
11043	Радислав	Марков	1193313813
11044	Николай	Осипов	1450414344
11045	Михаил	Лосеев	694629652
11046	Олег	Максимов	1939211652
11047	Станислав	Филиппов	941889031
11048	Юрий	Митрофанов	2181511494
11049	Николай	Николаев	1380387121
11050		29	595153942
11051	Александр	Недбайлов	1192375702
11052	Вячеслав	Иванов	1415737737
11053	Владимир	Погодин	628164963
11054	Ирина	Алексеева	830838336
11055		Посетитель	845484153
11056	Валерий	Евсеев	2185646993
11057	Лидия	Максимова	910717328
11058		Охрана	1213363737
11059	Анатолий	Ильин	638812231
11060	Андрей	Хохлов	1746113616
11061	Тимофеев	Леонид	1158050578
11062	Юрий	Рыбкин	1125737093
11063	Юрий	Поторский	2215065125
11064	Эдуард	Лосеев	1685268629
11065	Сергей	Смирнов	660878601
11066	Алексей	Киселев	2466743649
11067	Валентина	Коплик	2501124214
11068	Владимир 	Судаков	1701876276
11069	Андрей	Лыченков	2185625973
11070	Лариса	Антонова	2257744661
11071		Охрана	2216112736
11072	Сергей	Трофимов	1636860469
11073	Ольга	Алексеева	1411807281
11074	Сергей	Симулин	845744148
11075	Вячеслав	Петров	428103456
11076	Ирина	Александрова	2016478809
11077		95	1935807808
11078	Петр	Александров	1685128504
11079	Анастасия 	Козлова	1947362688
11080	Дмитрий	Петров	426083188
11081	Александр	Сорокин	2197903142
11082	Вера	Васильева	1983152466
11083		94	829854280
11084	Елена	Федотова	1383686920
11085		Охрана	1208034153
11086		Охрана	389359248
11087	Евгений	Иванов	1098023824
11088	Антон	Лосеев	1983464065
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

COPY erp."Comments" ("CommentID", "OrderID", "UserID", "Timestamp", "MentionedUsers", "Text") FROM stdin;
224	126	17	2021-10-18 03:07:38.899+00	\N	запросить расположение стрел
276	106	16	2021-10-25 04:48:08.565+00	\N	Отгрузка в ящиках вместе с затворами
223	118	15	2021-10-21 08:55:56.208+00	\N	<div><br></div>Чебоксары - Минск<div>ООО «АнканПро», УНП 193434875</div><div>220053 Республика Беларусь, г.Минск, ул.Будславская, 2 пом.3 каб.28<div><div><span style="font-size: medium;">Борухова Юлия Ивановна + 375 (44) 701-20-19</span></div><div><span style="font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Oxygen, Ubuntu, Cantarell, &quot;Fira Sans&quot;, &quot;Droid Sans&quot;, &quot;Helvetica Neue&quot;, sans-serif;">Нетто: 66кг, брутто: 80кг, ящик: </span><span style="color: black; font-size: 11pt; font-family: Calibri, sans-serif;">650х500х650 </span><span style="font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Oxygen, Ubuntu, Cantarell, &quot;Fira Sans&quot;, &quot;Droid Sans&quot;, &quot;Helvetica Neue&quot;, sans-serif;">-1 шт.</span></div><div><span style="background-color: rgb(247, 247, 250); color: rgba(0, 0, 0, 0.87); font-size: 14.4px;">Отгрузить ТК Главдоставка, трек ЧБК-МНС-882082/21-Д</span></div></div></div>
217	93	17	2021-10-06 04:31:34.566888+00	\N	шестерни датчика 1:1, угол поворота указателя 120*
\.


--
-- Data for Name: Docs; Type: TABLE DATA; Schema: erp; Owner: postgres
--

COPY erp."Docs" ("OrderID", "Key", "FileName", "ID") FROM stdin;
66	03115276-039c-4d53-af61-e55c16b67d95	Чертежи клапанов.doc	86
66	70d7db61-1887-40c7-a5d0-b83dbadd32a4	Счет №ПА08611 от 05.08.2021.pdf	87
66	6b04270b-3340-4b9b-a65b-1e99d4ce2ec9	Счет на оплату  № НФ-680 от 01.09.2021 1.pdf	88
66	6746dc2b-21f5-4708-b19e-b0cd9258c4fb	Счет на оплату № 33861       от 30.08.2021 (2).pdf	89
66	0984b9c0-4162-4754-b5c2-312b7b497b54	Счет 497.pdf	37
76	f203dae9-31b2-4c4a-a306-b5abfb13a166	Счет 544 в срм.pdf	93
90	3d636359-f599-4ed8-8f67-728bcb98312c	469  10  2021 ..xls	95
95	2f554ea6-a1e5-4dbe-9af9-caea729cdfac	11420 запрос привод 2.docx	97
94	33528888-e53f-4dd9-a5a8-71809bf0b8d4	Счет на оплату.pdf	99
95	9db3f78d-53a6-4fb9-acc9-d5957800ab55	Чертеж AK BTV 02 DN250 300 400.pdf	100
95	280b30df-9fda-4959-b0b5-b4f589edcacd	Чертеж AK BTV 02 DN600.pdf	101
95	8f4189ac-353f-4459-9bb5-b30e54c386f8	Чертеж задвижка шиберная AK KGV 01  DN250 300 500.pdf	102
95	e1c32332-78e4-4556-900d-82cb416a255c	KOMPAS - Схема управления со шкафа ШУМ-380-13.pdf	103
96	3533771c-bdc1-4ce3-a286-7dc1be8ec301	Реквизиты НоК Горохов.docx	104
76	fbdade18-edcf-41cb-98dd-8ed7d5ddd6b9	Опросный лист для поставки арматуры (1).xlsx	106
99	a91f597d-a535-4947-a9d7-3fc8c483b810	поз. 27 Опросный лист Кран с шаровым затвором Ду50 Ру16 в комплекте с электроприводом 4шт..pdf	107
100	6a7dc39b-ae55-4e1d-8a30-eaa81ec2beaa	Карточка ООО Приборы контроля с 07.11.2019.pdf	108
102	6ef23f28-a7a5-4363-a7f4-b27c006f42ff	Чертеж затвора ЗД2.200.pdf	113
104	55ea7039-af23-4047-ba01-9f184a2ff9ea	Заполненный ОЛ ООО АМТ.jpeg	114
96	ac50e36e-a093-4381-96de-088d08997795	print-barcodes.pdf	115
96	e6fe6031-7bf6-4f27-8fd7-133ec3bf230c	print-order.pdf	116
106	22e57d54-94ff-4188-abac-ad43bbe894b3	Размеры верхнего присоединительного фланца.pdf	120
105	d3b40d5f-e61e-4310-85ad-70b096a80402	Чертеж затвора к сч. 577.pdf	122
107	d17ae3d3-2e4a-4a83-a379-5c42ae3b1aec	Чертеж.jpg	123
107	5f49c8b1-a749-478e-9ac0-2622ee30d8e1	доп_запрос_.doc	124
107	23850e02-87f6-4f2c-b575-3076ca66feda	Приложение №1-2.docx	125
108	6fc81d86-dfef-4cdc-822e-4505a93debdc	Схема подключений НМ с датчиком БСП-3 (220В).pdf	126
91	5de37477-13b0-4bca-830f-6fdd2b879ed5	Упаковочные листы сп. 26, 27.doc	128
119	12a63a30-4fbc-4b87-b1c2-68889a9aea23	SM.DN50.PN16.МFL.PPR.2-00.000ГЧ.jpg	129
109	84108fa4-3740-46a4-805a-fa1f87124942	Опросный лист Арматурз КП_П_1049.pdf	130
127	426cb0f7-4979-479d-9ef4-fb003e970f38	Размеры присоединительного фланца межфланцевых затворов Квант.PNG	132
126	9254bcda-7499-46c2-b7eb-586d3be09b0d	Спецификация №2.pdf	133
127	457ebdec-7a6a-4606-b8d1-75fd526c014f	Счет на оплату № УТ-2655 от 08.10.2021.xlsx	134
126	bfb82445-9ffa-4c01-8138-737ef9054b13	Заказ покупателя ТВ-00000978 от 07.10.2021 153540.pdf	135
135	32a9740f-835c-4bdc-8fe0-8c8662958299	Заказ покупателя ТВ-00000815 от 07.10.2021 154000.pdf	137
137	b52f3968-0194-42a9-891b-a65875922659	Счет 459.pdf	138
\.


--
-- Data for Name: OrderItems; Type: TABLE DATA; Schema: erp; Owner: postgres
--

COPY erp."OrderItems" ("OrderItemID", "OrderID", "Name", "Quantity", "Fitter", "FullName", "SerialNumber") FROM stdin;
252	91	МЭП-2500/30-30У-13К У2, 380В (с БСПТ-10АК) 	4	\N	Клапан регулирующий DN80 КПСР-2.42-80-25-0-СТ-1,6-1-42-У1 с комплектом ответных фланцев и крепежом с МЭП-2500/30-30У-13К У2, 380В (с БСПТ-10АК)\nНастройка: 2,7Кн, ход штока 32мм\nПлощадка: Ø65, h 100мм, М10, толщина плиты 21-22	\N
321	109	МЭОФ-1600/63-0,25М-97СК У2, 380В, IP65, F14	1	\N		\N
322	110	МЭОФ-250/25-0,25М-99К У2, 380В, IP65, F10, кв. 17П, H38	4	\N		\N
256	91	МЭОФ-12,5/25-0,25М-98К У2, 380В, IP65, F05 кв.11П	1	\N	Кран запорный 11с67п ЦФ DN25 PN16, фланцевый, сталь 20, полнопроходной, \nс комплектом ответных фланцев и крепежом с МЭОФ-12,5/25-0,25М-98К У2, 380В, IP65, F05 кв.11П\n	\N
258	91	МЭП-12000/160-80У-14К У2, 380В	2	\N	Клапан регулирующий DN150 КПСР-1-150-160-0-СТ-4,0-1-260-У \nс комплектом ответных фланцев и крепежом с электроприводом \nс МЭП-12000/160-80У-14К У2, 380В\nНастройка: 9Кн, ход штока 75мм\nПлощадка: Ø65, h 80мм, М10, толщина плиты 21-22\n	\N
259	91	МЭП-2500/30-30У-13К У2, 380В	2	\N	Клапан регулирующий DN65 КПСР-1-65-25-0-СТ-4,0-1-260-У \nс комплектом ответных фланцев и крепежом \nс МЭП-2500/30-30У-13К У2, 380В\nНастройка: 1,5Кн, ход штока 32мм\nПлощадка: Ø40, h 66мм, М10, \n	\N
265	92	630/25-0,25У-92К У2 (без БП)	1	Евсеев		
262	92	250/25-0,25У-99К У2 (без БП)	7	\N		\N
248	89	АШК-2,5-380-БУШ-СВ-ПВК35-ПВТ4 УХЛ1	4	\N	2 правых, 2 левых	\N
264	92	100/25-0,25У-99К У2 (без БП)	4	\N		\N
266	93	МЭПК-6300/50-40У-IICТ4-05 У2, 380В, IP65	1	\N		\N
267	94	МЭОФ-40/25-0,25М-96 У2, 220В, IP65, F07 кв.14П	2	\N	Кран шаровой цельносварной фланцевый 11с67п ЦФ.00.0 DN50 PN40 (L-230мм) с МЭОФ-40/25-0,25М-96 У2, 220В, IP65	\N
244	66	МЭП-12000/100-50У-14К У2, 380В (с БСПТ-10АК)	2	\N	Клапан регулирующий DN150 КПСР-2.42-150-25-0-СТ-1,6-2-42-У1 с комплектом ответных фланцев и крепежом с МЭП-12000/100-50У-14К У2, 380В  3,5Кн, ход 25мм, площадка: Ø65, h 103 (138-35)мм, М14х1,5, толщина плиты 21-22 	\N
255	91	МЭОФ-40/25-0,25У-96К У2, 380В, F05 кв.11П (с БСПТ-10АК)	1	\N	Кран регулирующий 11с67п DN25 PN16 равнопроцентный, сталь 20, фланцевый, полнопроходной, \nс комплектом ответных фланцев и крепежом с МЭОФ-40/25-0,25У-96К У2, 380В (с БСПТ-10АК)\n	213122132133\n213213123112\n231231231232\n213123123123\n213123213213
257	91	МЭОФ-12,5/25-0,25М-98К У2, 380В, IP65, F05 кв.11П	1	\N	Кран запорный 11с67п ЦФ DN20 PN16, фланцевый, сталь 20, полнопроходной, \nс комплектом ответных фланцев и крепежом с МЭОФ-12,5/25-0,25М-98К У2, 380В, IP65, F05 кв.11П\n	
207	66	МЭОФ-40/10-0,25М-99К У2, 380В, F05 кв.11П	8	\N	Затвор ПА 342.50.16-02 с комплектом ответных фланцев и крепежом с МЭОФ-40/10-0,25М-99К У2, 380В, F05 кв.11П\n	\N
208	66	МЭОФ-100/25-0,25М-92CК У2, 380В, F07 кв.14П	1	\N	Затвор ПА 342.150.16-02 с комплектом ответных фланцев и крепежом с МЭОФ-100/25-0,25М-92CК У2, 380В, F07 кв.14П	\N
243	80	Диагностика МЭОФ 1000/63-0,25-ЕД-20К зав. №061249	1	\N		\N
212	67	МЭОФ-100/10-0,25М-99К У2, 380В, IP65, F07 кв.17П	1	\N	К крану КШХ80, Мкр 110Нм	\N
213	67	МЭОФ-250/10-0,25М-99К У1, 380В, IP65, F10 кв. 22П	2	\N	К крану КШХ100, Мкр 250Нм	\N
245	88	МЭОФ-100/25-0,25-ЕД-20К У1 F07 кв.17П	79	\N		\N
246	88	МЭОФ-250/25-0,25-ЕД-20К У1 F07 кв.27П	6	\N		\N
247	88	МЭОФ-650/63-0,25-ЕД-20К У1 F12 кв.27П	8	\N		\N
249	90	МЭОФ-140/25-0,25М-IICT4 У2, 380В, IP65, F07 кв.14П	1	\N	Кран шаровой запорный КШТВГ 16-80 с комплектом ответных фланцев \n(80-16-01-1-В), прокладками и крепежом c МЭОФ-140/25-0,25М-IICT4 У2, 380В, IP65, F07 кв.14П	\N
251	91	МЭП-2500/30-30У-13К У2, 380В (с БСПТ-10АК)	4	\N	Клапан регулирующий DN65 КПСР-2.42-65-40-0-СТ-1,6-2-42-У1 с комплектом ответных фланцев и крепежом с МЭП-2500/30-30У-13К У2, 380В (с БСПТ-10АК)\nНастройка: 2,5Кн, ход штока 25мм\nПлощадка: Ø65, h 128мм, М10, толщина плиты 21-22\n	\N
296	95	ПЭМ-А7М-77 с ЧПУ F10, Tr26x5	4	\N	К шиберной задвижке с выдвижным штоком, Мкр 52, датчик 56 оборотов, вылет штока 280мм	\N
297	95	 ПЭМ-А7М-77 с ЧПУ F10, Tr26x5	4	\N	К шиберной задвижке с выдвижным штоком, Мкр 65, датчик 66 оборотов, вылет штока 330мм	\N
300	95	МЭОФ-1000/63-0,25М-92СК F12, кв.27П, H30	4	\N		\N
299	95	МЭОФ-4000/63-0,25М-96СК F16 d60, b16, H40	8	\N		\N
301	95	МЭОФ-650/63-0,25М-92СК F12, кв.22П, H24	3	\N		\N
302	95	МЭОФ-400/63-0,25М-99К F10, кв.22П, H24	3	\N		\N
303	95	Шкаф управления приводом ШУМ-380-13 	36	\N		\N
215	76	МЭОФ-64/10-0,25М-БКП380-IICТ4 У2, IP65, F05 кв.11П	7	\N	К затвору ЗПХ80, 70Нм	\N
214	76	МЭОФ-40/10-0,25М-БКП380-IICТ4 У2, IP65, F05 кв.11П	4	\N	К затвору ЗПХ50, 40Нм	\N
260	91	МЭОФ-40/10-0,25М-99К У2, 380В, F05 кв.11П	9	\N	Затвор поворотный дисковый межфланцевый ПА 342.50.16-02 (корпус - сталь 20Л, диск - сталь коррозионностойкая CF8, уплотнение - EPDM) без управления DN 50 мм PN 16 кгс/см2 \nс комплектом ответных фланцев и крепежом с МЭОФ-40/10-0,25М-99К У2, 380В, F05 кв.11П\n	
275	91	МЭОФ-100/25-0,25М-92CК У2, 380В, F07 кв.14П	1	\N	Затвор поворотный дисковый межфланцевый ПА 342.150.16-02 (корпус - сталь 20Л, диск - сталь коррозионностойкая CF8, уплотнение - EPDM) без управления DN 150 мм PN 16 кгс/см2 \nс комплектом ответных фланцев и крепежом с МЭОФ-100/25-0,25М-92CК У2, 380В, F07 кв.14П\n	\N
323	111	ПЭМ-А11М У2	2	\N	Настройка к 30ч906бр Ду100, 80Нм, 27об	\N
325	118	ПЭМ-А11М У2	1	\N	Настройка к  30с941нж Ду 100, 96Нм, 21об	\N
326	118	ПЭМ-Б7М У2	1	\N	Настройка к  30с964нж Ду 250, 280Нм, 42,5об	\N
330	121	МЭОФ-40/25-0,25М-96 У2, 220В, IP65 с КШФ-16-80 ПЭК (L-140мм)	2	\N		\N
329	120	МЭОФ-40/25-0,25М-96К У2, 380В, IP65, F07 кв.11П	21	\N		\N
332	123	Ремонт МЭОФ 1000/63-0,25-ЕД-20К зав. №061249	1	\N		\N
334	125	МЭОФ-40/25-0,25Р-96К F05 кв.14П	1	\N	К шаровому крану	\N
338	127	МЭОФ-40/25-0,25У-IICT4 F07	1	\N	Затвор поворотный дисковый межфланцевый Квант (сталь + диск. Нерж, NBR) DN 100 мм PN 16 кгс/см2 с электроприводом МЭОФ-40/25-0,25У-IICT4 У2, 380В, IP65	\N
327	66	МЭП-2500/30-30У-13К У2, 380В (с БСПТ-10АК)	4	\N	Клапан регулирующий DN65 КПСР-2.42-65-40-0-СТ-1,6-2-42-У1 с комплектом ответных фланцев и крепежом с МЭП-2500/30-30У-13К У2, 380В, 380В 2,5Кн, ход 25мм, площадка: Ø65,h 103 (138-35)мм , М12х1,25, толщина плиты 21-22\n	\N
346	136	МЭОФ-1600/25-0,25-ЕД-20К У1	2	\N		\N
344	135	АШК-4-380-БУШ-СВ-ПВК35-IIВТ4-УХЛ1 	12			
348	138	МЭОФ-1000/63-0,25М-92СК У2, F12 кв.27П	1	\N	К шаровому крану	\N
349	138	ПЭМ-В38М У2	1	\N	Настройка к 30с941нж Ду400, 590Нм, 50об	\N
363	135	https://youtu.be/deCpB1R6fLM	1	\N		\N
298	95	ПЭМ-Б8М с ЧПУ F14, Tr36x6	10	\N	К шиберной задвижке с выдвижным штоком, Мкр 234, датчик 90 оборотов, вылет штока 540мм	\N
304	96	Пускатель ПБР-22, 220В на Din-рейку	1	\N		\N
306	99	МЭОФ-40/25-0,25У-IICT4 УХЛ1, 380В, IP67, F07 кв.17Д	4	\N	К крану ДУ50 	\N
307	100	БСПТ-10АК	2	\N	Блок сигнализации положения токовый БСПТ-10АК к МЭОФ-40/63-0,25У-02К №061087 2016г	\N
308	101	МЭОФ-250/10-0,25М-99К У1, 380В, IP65, F10 кв. 22П	3	\N	К крану КШХ100, 250Нм	\N
310	103	МЭОФ-2500/63-0,25У-96К У2, 380В, IP65, F14 d42 b12 H80	3	\N	К затвору DN500 PN10  - 2460N*m с учетом запаса	\N
328	119	МЭОФ-80/25-0,25М-99 У2, 220В, IP65, F07 кв.11Д	26	\N		\N
309	102	МЭОФ-1000/25-0,25М-97К У2, 380В, IP65, F12 d28 b10 H80	1	\N	К затвору Ду200	\N
333	124	ПЭМ-А11М У2	1	\N	Настройка к Ду100 3ч906бр, 80Нм, 27об	\N
336	122	ПЭМ-А.70/24У УХЛ1, 380В (c БСПТ-10АК)	1	\N	К шиберной задвижке ПА500 Ду200 Тип А (кулачки), 40Нм, 45об, вылет (высота) штока до 225мм, Tr24*5	\N
337	126	АШК-3-380-БУШ-СВ-ПВК35-IIВТ4-УХЛ1  	3	\N		\N
316	105	МЭОФ-1000/25-0,25-ЕД-20СК У2, 380В, IP65, F10 	2	\N	К затвору Квант Ду300 F10 d31.6 b6.35 H35	\N
313	106	МЭОФ-400/63-0,25М-99К У2, 380В, IP65, F10	2	\N	К затвору квант Ду 250 d28.45, лыска 20.62, H35	\N
342	133	ПЭМ-Б6М У2	1	\N	Настройка к 30с941нж Ду 250, 250Нм, 42,5об	\N
311	104	МЭОФ-40/25-0,25М-ПCТ4 У2, 380В, IP67, F08 кв.17П	2	\N		\N
320	108	НМ-04МТ У2, 220В, IP65, с фланцем тип А (с БСП-3)	5	\N	К шиберной задвижке ПА500 Ду50 Тип А, 12Нм, 18об, ход штока 70мм, Tr18*4 - 3шт., к Ду80, 17Нм, 28об, ход штока 110мм, Tr20*4 - 2шт.	\N
216	66	МЭП-12000/160-80У-14К У2, 380В (с БСПТ-10АК)	2	\N	Клапан регулирующий DN150 КПСР-1-150-160-0-СТ-4,0-1-260-У с комплектом ответных фланцев и крепежом с МЭП-12000/160-80У-14К У2, 380В 9Кн, ход 75мм, площадка: Ø65, h 80мм, М10, толщина плиты 25(28)\n	\N
319	107	МЭОФ-500/25-0,25-ЕДМ-20К УХЛ1, F12 кв.22Д H30	5	\N		\N
314	106	МЭОФ-630/15-0,25М-97К У2, 380В, IP65, F10	2	\N	К затвору квант Ду 300 d31.6, b6.35 H35	
347	137	БСПТ-10М для МЭО(Ф)	3	\N		\N
343	133	ПЭМ-В38М У2	3	\N	Настройка к 30с941нж Ду400, 590Нм, 50об	\N
350	139	МЭОФ-6,3/12-0,25М-98 У2, F05 кв.14П	1	\N	К шаровому крану	\N
351	140	МЭОФ-80/25-0,25М-99К У2, F05 кв.11П	5	\N	К ЗПХ80	\N
364	135	123123123	2	\N		\N
\.


--
-- Data for Name: OrderStatus; Type: TABLE DATA; Schema: erp; Owner: postgres
--

COPY erp."OrderStatus" ("ID", "Name") FROM stdin;
1	pre-order
2	order in production
3	order in archive
\.


--
-- Data for Name: Orders; Type: TABLE DATA; Schema: erp; Owner: postgres
--

COPY erp."Orders" ("OrderID", "OrderStatusID", "CheckListTPLID", "ManagerID", "CreatingDate", "Entity", "City", "TotalAmount", "PaidAmount", "Comment", "IsReclamation", "InvoiceNumber", "ShippingDate", "AwaitingDispatch", "AcceptanceDate", "ActualShippingDate", "OrderNumber") FROM stdin;
135	1	\N	15	2021-10-19 15:22:49.712818+00	Нефтетанк	Москва	2741184	\N	\N	f	663	\N	f	\N	\N	\N
118	3	\N	15	2021-10-04 05:17:10.350779+00	Анкан Про	Минск	96450	96450	Отгрузить ТК Главдоставка, трек ЧБК-МНС-882082/21-Д	f	0709	2021-10-19	f	2021-10-06 10:59:05+00	2021-10-14 11:32:27.37+00	587
100	1	\N	15	2021-09-21 10:55:27.090842+00	Приборы контроля	Москва	19900	\N	\N	f	597	\N	f	\N	\N	\N
99	3	\N	15	2021-09-21 10:53:34.347667+00	НПО Наука	Чебоксары	251616	251616	Гарантийный срок 24 месяца с даты ввода в эксплуатацию, но не более 36 месяцев со дня продажи	f	596	2021-10-11	f	2021-09-28 08:00:02+00	2021-10-20 09:11:32.484+00	564
104	3	\N	16	2021-09-23 10:00:59.038089+00	ООО АМТ	Ставрополь	90782	90782	Отгрузить ТК Деловые Линии до терминала г. Ростов-на-Дону (Ростовская область.)\n\nПлательщик за транспортные расходы: ООО АМТ (АМТ-Нефтегазовое оборудование, ИНН 2635804840)\nГрузополучатель: ООО АМТ (АМТ-Нефтегазовое оборудование, ИНН 2635804840)\n\nКонтактное лицо: +7 918 574 00 09, Дмитрий	f	610	2021-10-11	f	2021-09-28 07:59:57+00	2021-10-10 13:30:08+00	\N
88	2	\N	15	2021-09-15 07:46:03.481902+00	Пауэрз	Великий-Новгород	6922080	1730520		f	486	2021-11-01	f	2021-09-15 10:48:37+00	\N	\N
91	3	\N	15	2021-09-15 08:01:56.616953+00	Пауэрз	Великий-Новгород	2276735	2276735	Требования по изготовлению: \n1)\tГарантия: 18 месяцев с даты ввода в эксплуатацию, но не более 24 месяцев со дня продажи.\n\nТребования по упаковке: \n1.\tОборудование будет отправляться в Казахстан и ждать монтажа в течение полугода.\n2.\tПриводы и арматура поставляются в сборе\n3.\tНа ящих необходимо указать:\n– номер Договора поставки, наименование Грузополучателя;\n– вес, брутто/нетто Оборудования;\n– место назначения Оборудования;\n– количество отгруженных мест;\n– номера мест и их общее количество;\n– адрес отправителя Оборудования;\n4.\tС каждым товарным местом Оборудования должны находиться два экземпляра упаковочного листа. Один экземпляр упаковочного листа должен находиться внутри ящика или упаковки, а другой экземпляр с сопроводительными документами.	f	386	2021-09-30	f	2021-09-15 11:12:33+00	\N	\N
67	3	\N	15	2021-08-31 06:21:05.564207+00	ПП Элмон	Саратов	112140	112140	Упаковка в 1 ящик.\n\nОтгрузить ТК Байкал Сервис по шаблону.	f	526	2021-09-20	f	\N	\N	\N
101	3	\N	15	2021-09-21 10:57:13.851605+00	ПП Элмон	Саратов	117396	117396	Упаковка в 2 ящика\nОтгрузка ТК Байкал Сервис по шаблону	f	593	2021-10-11	f	2021-09-28 07:59:48+00	2021-10-18 09:04:43.701+00	\N
111	2	\N	15	2021-09-30 06:28:43.780805+00	КентаврЭнерго	Минск	80100	80100	\N	f	0928	2021-10-19	f	2021-09-30 11:12:56+00	\N	\N
140	1	\N	15	2021-10-25 17:00:06.412793+00	Элмон	Саратов	99960	\N	Отгрузка ТК Байкал-Сервис по шаблону	f	668	\N	f	\N	\N	\N
107	2	\N	15	2021-09-28 07:25:36.792617+00	НПО Наука	Чебоксары	474420	237210	\N	f	621	2021-11-19	f	2021-10-20 12:23:27+00	\N	\N
126	2	\N	15	2021-10-07 06:55:01.539984+00	ОЗНА-Инжиниринг	Уфа	650448	325224	\N	f	640	2021-11-30	f	2021-10-08 15:15:50+00	\N	\N
90	2	\N	15	2021-09-15 07:51:50.839553+00	АО Акмай	Альметьевск	104280	104280	Отгрузить ТК “ Деловые Линии” до терминала г. Альметьевск\nОтгрузочные документы отправить с грузом\nПлательщик:  АО "АКМАЙ"\nГрузополучатель: АО "АКМАЙ"\nКонтактное лицо: Сахуриев Сергей +7 (8553) 37-10-70	f	487	2021-10-22	t	2021-09-15 10:59:16+00	\N	\N
139	1	\N	15	2021-10-25 16:57:35.81354+00	ТД ПремиумАРМ	Нижний-Новгород	14916	\N	Отгрузить ТК «Байкал-сервис» до терминала г. Нижний-Новгород.\nПлательщик: ООО ТД «ПремиумАРМ» \nГрузополучатель: ТД «ПремиумАРМ» \nКонтактное лицо: Гилядова Дарья, +7(831)2-147-047	f	678	\N	f	\N	\N	\N
95	2	\N	16	2021-09-16 10:08:19.284805+00	Компенсатор Групп	Минск	2909691	1454845	\N	f	0907	2021-11-11	f	2021-09-17 09:13:56+00	\N	\N
96	3	\N	15	2021-09-17 10:23:32.19105+00	Новое качество	Новокуйбышевск	5640	5640	Шевелев Вячеслав\nмоб.: +7 (927) 795-19-13\nООО «Новое Качество»\n446201, РФ, Самарская область,\nг. Новокуйбышевск, ул. Карбышева, д.28, оф.18\nтел.: +7 (846)201-43-93 info@nok-samara.ru\n	f	585	2021-09-24	f	2021-09-17 13:30:08+00	2021-10-09 09:30:08+00	\N
89	2	\N	15	2021-09-15 07:49:03.184865+00	Камышинский опытный завод	Камышин	890016	445008	\N	f	465	2021-10-11	t	2021-09-15 10:50:45+00	\N	463
76	2	\N	15	2021-09-07 17:50:51.046163+00	ПП Элмон	Саратов	856770	856770	Упаковка в 4 ящика.\nОтгрузка ТК Байкал-сервис по шаблону	f	544	2021-10-21	f	2021-09-21 09:32:08+00	2021-10-15 22:51:00.439+00	\N
102	2	\N	15	2021-09-23 09:48:38.018947+00	ТД Энергомашкомплект	Саратов	56202	56202	В Ящик.\n\nОтгрузка ТК Байкал-Сервис до терминала г. Волжский\nПлательщик за доставку: ООО ТД "Энергомашкомплект", ИНН 6454085567 КПП645401001, 410017, Саратовская область, г. Саратов, ул. Шелковичная 37/45, офис 701,\nГрузополучатель: Волжский филиал АО "Гидроремонт-ВКК" в г. Волжский, ИНН 6345012488, 404130, Волгоградская обл, Волжский г, Ленина пр-кт, дом № 1А\n\nОригиналы документов просим отправить почтой по адресу: 410017, г. Саратов, ул. Шелковичная, д. 37/45 и копию на электронный адрес - semynin.a.d@emk.ru\n	f	599	2021-10-27	f	2021-10-11 20:59:22+00	\N	606
127	3	\N	15	2021-10-07 09:32:15.494155+00	Гарант Строй	Санкт-Петербург	61350	61350	Отгрузить ТК “ Деловые Линии” до терминала г. Санкт-Петербург\nОтгрузочные документы отправить ТК отдельным конвертом\nПлательщик:  ООО "Гарант Строй" \nГрузополучатель: ООО "Гарант Строй" \nКонтактное лицо: Капустина Елена 8-911-082-55-27	f	652	2021-10-25	f	2021-10-08 15:15:53+00	2021-10-25 15:57:20.876+00	598
105	2	\N	16	2021-09-27 05:41:36.294483+00	ООО ГК Гранд Арматура	Чебоксары	149472	57081	\N	f	577	2021-10-27	f	2021-09-28 08:00:11+00	\N	\N
92	3	\N	15	2021-09-15 08:13:30.284985+00	Пауэрз	Великий-Новгород	416940	0	Упаковка в 5 ящиков.\nОтгрузка ТК Байкал-Сервис по шаблону. 	f	570	2021-09-30	f	2021-09-15 11:15:30+00	\N	\N
136	1	\N	15	2021-10-21 12:52:33.867709+00	Пауэрз	Великий-Новгород	218040	\N	Отгрузка ТК Байкал-Сервис по шаблону	f	665	\N	f	\N	\N	\N
108	2	\N	15	2021-09-28 07:29:57.86805+00	Промарм	Пенза	142920	71460	Упаковка в 2 ящика\n\nСделать отметки на приводах: "К Ду50", "К Ду80"	f	622	2021-10-20	f	2021-10-01 14:36:20+00	\N	\N
93	3	\N	15	2021-09-15 08:15:53.810049+00	ООО Югра-Нефтегазсервис	Нижневартовск	50364	50364	Упаковка в ящик.\n\nСогласованы присоед. размеры из РЭ исполнения МЭПК-6300/50-40У-IICТ4-05	f	542	2021-09-30	f	2021-09-15 11:18:06+00	\N	\N
80	3	\N	15	2021-09-09 14:13:55.296298+00	Самаранефтегазпроект	Самара	4800	4800	\N	f	565	2021-09-20	f	2021-09-15 10:40:29+00	\N	\N
123	3	\N	15	2021-10-06 07:46:15.541157+00	Самаранефтегазпроект	Самара	32400	32400	Отгрузить ТК Деловые Линии до терминала г. Елец (Липецкая обл.).\n\nПлательщик за транспортные расходы: ООО СНГП (САМАРАНЕФТЕГАЗПРОЕКТ, ИНН 6316134234)\nГрузополучатель: ООО СНГП (САМАРАНЕФТЕГАЗПРОЕКТ, ИНН 6316134234)\n\nКонтактное лицо: +7 (915) 668-65-25, Игорь, +79277509394 Станислав	f	629	2021-10-06	f	2021-10-06 10:59:06+00	\N	\N
119	1	\N	15	2021-10-04 11:53:07.010272+00	АСК Палюр	Пермь	544104	0	Упаковка в 3 ящика	f	639	\N	f	\N	\N	\N
106	2	\N	16	2021-09-27 05:41:53.740146+00	ООО ГК Гранд Арматура	Чебоксары	184745	55423	\N	f	664	2021-10-18	t	2021-09-28 08:00:10+00	\N	\N
124	3	\N	15	2021-10-07 06:23:14.49418+00	ТД ПремиумАрм	Нижний-Новгород	41136	41136	Отгрузить ТК «Байкал-сервис» до терминала г. Нижний-Новгород.\nПлательщик: ООО ТД «ПремиумАРМ» \nГрузополучатель: ТД «ПремиумАРМ» \nКонтактное лицо: Гилядова Дарья, +7(831)2-147-047\n\n 	f	648	2021-10-20	f	2021-10-07 09:50:41+00	2021-10-20 09:12:25.18+00	\N
66	2	\N	15	2021-08-30 06:10:31.224504+00	ООО Пауэрз	Великий Новгород	1835004	458751	Требования по изготовлению: \n1)\tГарантия: 18 месяцев с даты ввода в эксплуатацию, но не более 24 месяцев со дня продажи.\n\nТребования по упаковке: \n1.\tОборудование будет отправляться в Казахстан и ждать монтажа в течение полугода.\n2.\tПриводы и арматура поставляются в сборе\n3.\tС каждым товарным местом Оборудования должны находиться два экземпляра упаковочного листа. Один экземпляр упаковочного листа должен находиться внутри ящика или упаковки, а другой экземпляр с сопроводительными документами.\n\nОтгрузить ТК Байкал Сервис по шаблону.\n	f	497	2021-11-26	f	\N	\N	\N
94	2	\N	15	2021-09-15 08:28:26.751853+00	Железобетонные конструкции № 9	Чебоксары	48600	48600	Заберут самовывозом	f	580	2021-10-20	f	2021-09-16 10:32:13+00	\N	\N
137	2	\N	15	2021-10-25 16:13:28.81437+00	ЭТС-НК	Челябинск	22608	22608	Отгрузить ТК Деловые Линии до терминала г. Челябинск.\nС грузом нулевую накладную, УПД почтой:\n423800 РФ, Республика Татарстан, г. Набережные Челны, пр. Мусы Джалиля, дом 29/2, оф. 308.\nПлательщик: ООО "ЭТС-НК"\nГрузополучатель: Комисаров Константин Евгеньевич, паспорт 9214 715882, +7 937-532-93-48	f	459	\N	f	2021-10-25 19:38:26+00	\N	\N
121	2	\N	15	2021-10-05 06:08:32.060478+00	ТД НефтекамскСтрой	Нефтекамск	57187	57187	Отгрузка ТК "Байкал-Сервис" до адреса:\nг.Нефтекамск, ул. Автозаводская, д. 1, строение 5/5.\nГрузополучатель: ООО «ТД «НефтекамскСтрой», ИНН/КПП: 0264076500/ 026401001\nКонтактное лицо: (34783) 2-66-47, Амиров Ратмир	f	609	2021-10-25	f	2021-10-05 09:22:57+00	\N	\N
120	3	\N	16	2021-10-05 06:07:20.933173+00	АО Эприр	Санкт-Петербург	303240	303240	Отгрузка по шаблону ТК Байкал-Сервис.\n\nС обязательным комментарием: г. Санкт-Петербург, терминал "Софийская"\n\nОтгрузочные документы отправить с продукцией.\nПлательщик за транспортные расходы: АО «ЭПРИР», ИНН 7810434898\nГрузополучатель: АО «ЭПРИР», ИНН 7810434898\nКонтактное лицо: Александр, +7 (812) 448-47-08 Самойленко Василий	f	636	2021-10-25	f	2021-10-05 09:23:28+00	2021-10-18 09:04:56.495+00	\N
133	1	\N	15	2021-10-14 08:51:41.789888+00	Анкан Про	Минск	238970	\N	Чебоксары - Минск\nООО «АнканПро», УНП 193434875\n220053 Республика Беларусь, г.Минск, ул.Будславская, 2 пом.3 каб.28\nБорухова Юлия Ивановна + 375 (44) 701-20-19	f	0709	\N	f	\N	\N	\N
109	2	\N	16	2021-09-29 10:11:28.630088+00	Арматурз	Великий Новгород	66175	33087	\N	f	463	2021-10-14	t	2021-09-30 11:13:28+00	\N	\N
103	3	\N	15	2021-09-23 09:53:50.96106+00	АБО Арматура	Смоленск	232920	232920	В 3 ящика. \n\nОтгрузить ТК  «Байкал Сервис» до терминала в г.Смоленск.\nОтгрузочные документы отправить с продукцией.\nГрузополучатель: ООО "АБО Арматура",\nПлательщик за транспортные услуги: ООО "АБО Арматура"\nКонтактное лицо: Анастасия Стаселько, +7 4812 240020, staselko@aboarmatura.ru	f	608	2021-10-07	f	2021-09-24 08:40:29+00	\N	\N
122	2	\N	15	2021-10-05 07:21:40.204951+00	Промарм	Пенза	48192	48192	Отгрузить ТК «Байкал-Сервис» до терминала г. Пенза.\nГрузополучатель: ООО "ПромАрм"\nПлательщик: ООО "ПромАрм"\nКонтактное лицо: Екатерина Куликова, +7 8412 35-07-97	f	644	2021-10-26	f	2021-10-07 09:50:44+00	\N	\N
110	2	\N	16	2021-09-29 10:23:57.153754+00	Арматурз	Великий Новгород	137894	68947	\N	f	616	2021-10-14	t	2021-09-30 11:13:29+00	\N	\N
125	3	\N	15	2021-10-07 06:43:39.781624+00	Химприбор-1	Тула	25578	25578	Отгрузить ТК «Байкал Сервис» до терминала г. Тула.\nГрузополучатель: ЗАО "ХИМПРИБОР-1"\nПлательщик: ЗАО "ХИМПРИБОР-1"\nКонтактное лицо: +7 (495) 268-06-44, Елизавета Игоревна	f	633	2021-10-21	f	2021-10-07 09:50:44+00	2021-10-25 15:57:12.037+00	\N
138	1	\N	15	2021-10-25 16:53:06.120445+00	Анкан Про	Минск	132900	\N	\N	f	07099	\N	f	\N	\N	07099
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
\.


--
-- Data for Name: Tokens; Type: TABLE DATA; Schema: erp; Owner: postgres
--

COPY erp."Tokens" ("ID", "RefreshToken", "UserID") FROM stdin;
795	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwczovL2hhc3VyYS5pby9qd3QvY2xhaW1zIjp7IngtaGFzdXJhLWFsbG93ZWQtcm9sZXMiOlsiYWRtaW4iXSwieC1oYXN1cmEtZGVmYXVsdC1yb2xlIjoiYWRtaW4ifSwiVXNlcklEIjoxNSwiRmlyc3ROYW1lIjoi0JzQuNGF0LDQuNC7IiwiTGFzdE5hbWUiOiLQm9C-0YHQtdC10LIiLCJFbWFpbCI6Im1pc2hhdnpoaWtAZ21haWwuY29tIiwiaWF0IjoxNjM0MjAzODQ0LCJleHAiOjE2MzY3OTU4NDR9.b6sgbOzip-rjRJnjyLxZRJofqtFlJFoiw9Xs3vkZVY8	15
781	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwczovL2hhc3VyYS5pby9qd3QvY2xhaW1zIjp7IngtaGFzdXJhLWFsbG93ZWQtcm9sZXMiOlsiYWRtaW4iXSwieC1oYXN1cmEtZGVmYXVsdC1yb2xlIjoiYWRtaW4ifSwiVXNlcklEIjoxNSwiRmlyc3ROYW1lIjoi0JzQuNGF0LDQuNC7IiwiTGFzdE5hbWUiOiLQm9C-0YHQtdC10LIiLCJFbWFpbCI6Im1pc2hhdnpoaWtAZ21haWwuY29tIiwiaWF0IjoxNjM1MjQxNTMxLCJleHAiOjE2Mzc4MzM1MzF9.qsghoIIyPCvYmNcutKRhoL5M8thHRGanzGkNttUo5Kg	15
800	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwczovL2hhc3VyYS5pby9qd3QvY2xhaW1zIjp7IngtaGFzdXJhLWFsbG93ZWQtcm9sZXMiOlsiYWRtaW4iXSwieC1oYXN1cmEtZGVmYXVsdC1yb2xlIjoiYWRtaW4ifSwiVXNlcklEIjoxNSwiRmlyc3ROYW1lIjoi0JzQuNGF0LDQuNC7IiwiTGFzdE5hbWUiOiLQm9C-0YHQtdC10LIiLCJFbWFpbCI6Im1pc2hhdnpoaWtAZ21haWwuY29tIiwiaWF0IjoxNjM0NDE0MzU3LCJleHAiOjE2MzcwMDYzNTd9.C3JitMu8Z6EsBYfOR_5XwaswSdN4cJA55tJ0_RhuAfQ	15
798	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwczovL2hhc3VyYS5pby9qd3QvY2xhaW1zIjp7IngtaGFzdXJhLWFsbG93ZWQtcm9sZXMiOlsiYWRtaW4iXSwieC1oYXN1cmEtZGVmYXVsdC1yb2xlIjoiYWRtaW4ifSwiVXNlcklEIjoxNSwiRmlyc3ROYW1lIjoi0JzQuNGF0LDQuNC7IiwiTGFzdE5hbWUiOiLQm9C-0YHQtdC10LIiLCJFbWFpbCI6Im1pc2hhdnpoaWtAZ21haWwuY29tIiwiaWF0IjoxNjM0MzM3MDExLCJleHAiOjE2MzY5MjkwMTF9.1bgbRhghPD2DXxoeuNTrYCQ625b5J1IYgPQPdvZLMac	15
779	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwczovL2hhc3VyYS5pby9qd3QvY2xhaW1zIjp7IngtaGFzdXJhLWFsbG93ZWQtcm9sZXMiOlsiYWRtaW4iXSwieC1oYXN1cmEtZGVmYXVsdC1yb2xlIjoiYWRtaW4ifSwiVXNlcklEIjoxNSwiRmlyc3ROYW1lIjoi0JzQuNGF0LDQuNC7IiwiTGFzdE5hbWUiOiLQm9C-0YHQtdC10LIiLCJFbWFpbCI6Im1pc2hhdnpoaWtAZ21haWwuY29tIiwiaWF0IjoxNjMzNTQxMjg3LCJleHAiOjE2MzYxMzMyODd9.4k3OoiHzxbuVUzrCNzndFnDIcD0MYhEN6pEVCivylrM	15
794	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwczovL2hhc3VyYS5pby9qd3QvY2xhaW1zIjp7IngtaGFzdXJhLWFsbG93ZWQtcm9sZXMiOlsiYWRtaW4iXSwieC1oYXN1cmEtZGVmYXVsdC1yb2xlIjoiYWRtaW4ifSwiVXNlcklEIjoxNSwiRmlyc3ROYW1lIjoi0JzQuNGF0LDQuNC7IiwiTGFzdE5hbWUiOiLQm9C-0YHQtdC10LIiLCJFbWFpbCI6Im1pc2hhdnpoaWtAZ21haWwuY29tIiwiaWF0IjoxNjMzODc4MzUzLCJleHAiOjE2MzY0NzAzNTN9.4NRmY3D7JBqxs0kGbnyES3XA668c0Hoj6hcKAkR_pzg	15
791	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwczovL2hhc3VyYS5pby9qd3QvY2xhaW1zIjp7IngtaGFzdXJhLWFsbG93ZWQtcm9sZXMiOlsiYWRtaW4iXSwieC1oYXN1cmEtZGVmYXVsdC1yb2xlIjoiYWRtaW4ifSwiVXNlcklEIjoxNiwiRmlyc3ROYW1lIjoi0J_QsNCy0LXQuyAiLCJMYXN0TmFtZSI6ItCX0LvQvtCx0LjQvSIsIkVtYWlsIjoiemxvYmluQHBpZWsucnUiLCJpYXQiOjE2MzUxMzg0OTQsImV4cCI6MTYzNzczMDQ5NH0.RFfOj0c7ELQa_eAudX7dJMK6Cb6vH8jEns9Bg9nR118	16
790	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwczovL2hhc3VyYS5pby9qd3QvY2xhaW1zIjp7IngtaGFzdXJhLWFsbG93ZWQtcm9sZXMiOlsiYWRtaW4iXSwieC1oYXN1cmEtZGVmYXVsdC1yb2xlIjoiYWRtaW4ifSwiVXNlcklEIjoxNywiRmlyc3ROYW1lIjoi0JTQtdC90LjRgSAiLCJMYXN0TmFtZSI6ItCd0L7QstC-0YHQtdC70YzRhtC10LIiLCJFbWFpbCI6ImQubm92QHBpZWsucnUiLCJpYXQiOjE2MzQ4MTg1MDAsImV4cCI6MTYzNzQxMDUwMH0.h7dlLoiDr4lq1Q-EEditAAltNexABNz7lDXBGEjLqTs	17
796	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwczovL2hhc3VyYS5pby9qd3QvY2xhaW1zIjp7IngtaGFzdXJhLWFsbG93ZWQtcm9sZXMiOlsiYWRtaW4iXSwieC1oYXN1cmEtZGVmYXVsdC1yb2xlIjoiYWRtaW4ifSwiVXNlcklEIjoxNSwiRmlyc3ROYW1lIjoi0JzQuNGF0LDQuNC7IiwiTGFzdE5hbWUiOiLQm9C-0YHQtdC10LIiLCJFbWFpbCI6Im1pc2hhdnpoaWtAZ21haWwuY29tIiwiaWF0IjoxNjM0ODY2NTg4LCJleHAiOjE2Mzc0NTg1ODh9.GAB0y4FAjsW7a4VkHgOcVuPTuPJqLfxAdAeaK2G0EFk	15
792	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwczovL2hhc3VyYS5pby9qd3QvY2xhaW1zIjp7IngtaGFzdXJhLWFsbG93ZWQtcm9sZXMiOlsiYWRtaW4iXSwieC1oYXN1cmEtZGVmYXVsdC1yb2xlIjoiYWRtaW4ifSwiVXNlcklEIjoxNSwiRmlyc3ROYW1lIjoi0JzQuNGF0LDQuNC7IiwiTGFzdE5hbWUiOiLQm9C-0YHQtdC10LIiLCJFbWFpbCI6Im1pc2hhdnpoaWtAZ21haWwuY29tIiwiaWF0IjoxNjM1MTk2NDcwLCJleHAiOjE2Mzc3ODg0NzB9.EGQqoh4u_6d7B_z_Trf0ACRP0BMwcJseAC0N-JFODis	15
788	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwczovL2hhc3VyYS5pby9qd3QvY2xhaW1zIjp7IngtaGFzdXJhLWFsbG93ZWQtcm9sZXMiOlsiYWRtaW4iXSwieC1oYXN1cmEtZGVmYXVsdC1yb2xlIjoiYWRtaW4ifSwiVXNlcklEIjoxOSwiRmlyc3ROYW1lIjoi0J3QsNGB0YLRjyIsIkxhc3ROYW1lIjoiIiwiRW1haWwiOiJ6YXZvZEBwaWVrLnJ1IiwiaWF0IjoxNjM1MTM2OTg5LCJleHAiOjE2Mzc3Mjg5ODl9.TKAGBd4H36BaJvzBqHPqgn13dh9HiT44I1Eyd_t10Tw	19
793	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwczovL2hhc3VyYS5pby9qd3QvY2xhaW1zIjp7IngtaGFzdXJhLWFsbG93ZWQtcm9sZXMiOlsiYWRtaW4iXSwieC1oYXN1cmEtZGVmYXVsdC1yb2xlIjoiYWRtaW4ifSwiVXNlcklEIjoxNSwiRmlyc3ROYW1lIjoi0JzQuNGF0LDQuNC7IiwiTGFzdE5hbWUiOiLQm9C-0YHQtdC10LIiLCJFbWFpbCI6Im1pc2hhdnpoaWtAZ21haWwuY29tIiwiaWF0IjoxNjM0MjAzNTI1LCJleHAiOjE2MzY3OTU1MjV9.2Ades9OaVEMRCD42Aup4CR6YMygYWcemJrL9GymI--k	15
797	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwczovL2hhc3VyYS5pby9qd3QvY2xhaW1zIjp7IngtaGFzdXJhLWFsbG93ZWQtcm9sZXMiOlsiYWRtaW4iXSwieC1oYXN1cmEtZGVmYXVsdC1yb2xlIjoiYWRtaW4ifSwiVXNlcklEIjoxNSwiRmlyc3ROYW1lIjoi0JzQuNGF0LDQuNC7IiwiTGFzdE5hbWUiOiLQm9C-0YHQtdC10LIiLCJFbWFpbCI6Im1pc2hhdnpoaWtAZ21haWwuY29tIiwiaWF0IjoxNjM0MzIyNDE0LCJleHAiOjE2MzY5MTQ0MTR9.D9uxiJBfMVZvvcNlPMiodtXp9UITcuxpCgGAA6IZO3A	15
799	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwczovL2hhc3VyYS5pby9qd3QvY2xhaW1zIjp7IngtaGFzdXJhLWFsbG93ZWQtcm9sZXMiOlsiYWRtaW4iXSwieC1oYXN1cmEtZGVmYXVsdC1yb2xlIjoiYWRtaW4ifSwiVXNlcklEIjoxNSwiRmlyc3ROYW1lIjoi0JzQuNGF0LDQuNC7IiwiTGFzdE5hbWUiOiLQm9C-0YHQtdC10LIiLCJFbWFpbCI6Im1pc2hhdnpoaWtAZ21haWwuY29tIiwiaWF0IjoxNjM0Mzc1NDYxLCJleHAiOjE2MzY5Njc0NjF9.gfrk50KfJanlwhZ2FHBdYRME-kOgDfvybOEhMrIudd8	15
801	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwczovL2hhc3VyYS5pby9qd3QvY2xhaW1zIjp7IngtaGFzdXJhLWFsbG93ZWQtcm9sZXMiOlsiYWRtaW4iXSwieC1oYXN1cmEtZGVmYXVsdC1yb2xlIjoiYWRtaW4ifSwiVXNlcklEIjoxNSwiRmlyc3ROYW1lIjoi0JzQuNGF0LDQuNC7IiwiTGFzdE5hbWUiOiLQm9C-0YHQtdC10LIiLCJFbWFpbCI6Im1pc2hhdnpoaWtAZ21haWwuY29tIiwiaWF0IjoxNjM0NDE3NzM4LCJleHAiOjE2MzcwMDk3Mzh9.CRB0srhswp2iTLjcCpFOjv_rZ-2txVPPuoBXgE26aMc	15
802	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwczovL2hhc3VyYS5pby9qd3QvY2xhaW1zIjp7IngtaGFzdXJhLWFsbG93ZWQtcm9sZXMiOlsiYWRtaW4iXSwieC1oYXN1cmEtZGVmYXVsdC1yb2xlIjoiYWRtaW4ifSwiVXNlcklEIjoxNSwiRmlyc3ROYW1lIjoi0JzQuNGF0LDQuNC7IiwiTGFzdE5hbWUiOiLQm9C-0YHQtdC10LIiLCJFbWFpbCI6Im1pc2hhdnpoaWtAZ21haWwuY29tIiwiaWF0IjoxNjM0NDI3NzI5LCJleHAiOjE2MzcwMTk3Mjl9.2nNE-5fh7Vj7fZw1DMvA0aRMvItNcKLjAoSap07zsI4	15
789	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwczovL2hhc3VyYS5pby9qd3QvY2xhaW1zIjp7IngtaGFzdXJhLWFsbG93ZWQtcm9sZXMiOlsiYWRtaW4iXSwieC1oYXN1cmEtZGVmYXVsdC1yb2xlIjoiYWRtaW4ifSwiVXNlcklEIjoxNSwiRmlyc3ROYW1lIjoi0JzQuNGF0LDQuNC7IiwiTGFzdE5hbWUiOiLQm9C-0YHQtdC10LIiLCJFbWFpbCI6Im1pc2hhdnpoaWtAZ21haWwuY29tIiwiaWF0IjoxNjM1MjM1NzA0LCJleHAiOjE2Mzc4Mjc3MDR9.RF_rcRk_l3pL0kBp8rZRHcgzfLjbP_nstUWv_3c2apQ	15
803	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwczovL2hhc3VyYS5pby9qd3QvY2xhaW1zIjp7IngtaGFzdXJhLWFsbG93ZWQtcm9sZXMiOlsiYWRtaW4iXSwieC1oYXN1cmEtZGVmYXVsdC1yb2xlIjoiYWRtaW4ifSwiVXNlcklEIjoxNSwiRmlyc3ROYW1lIjoi0JzQuNGF0LDQuNC7IiwiTGFzdE5hbWUiOiLQm9C-0YHQtdC10LIiLCJFbWFpbCI6Im1pc2hhdnpoaWtAZ21haWwuY29tIiwiaWF0IjoxNjM0NDI3ODIyLCJleHAiOjE2MzcwMTk4MjJ9.twi_IdTHRdHmpt-g-gfF0A96bxde0Ul6_63HSFLN0QI	15
804	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwczovL2hhc3VyYS5pby9qd3QvY2xhaW1zIjp7IngtaGFzdXJhLWFsbG93ZWQtcm9sZXMiOlsiYWRtaW4iXSwieC1oYXN1cmEtZGVmYXVsdC1yb2xlIjoiYWRtaW4ifSwiVXNlcklEIjoxNSwiRmlyc3ROYW1lIjoi0JzQuNGF0LDQuNC7IiwiTGFzdE5hbWUiOiLQm9C-0YHQtdC10LIiLCJFbWFpbCI6Im1pc2hhdnpoaWtAZ21haWwuY29tIiwiaWF0IjoxNjM0NDI3ODIyLCJleHAiOjE2MzcwMTk4MjJ9.twi_IdTHRdHmpt-g-gfF0A96bxde0Ul6_63HSFLN0QI	15
806	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwczovL2hhc3VyYS5pby9qd3QvY2xhaW1zIjp7IngtaGFzdXJhLWFsbG93ZWQtcm9sZXMiOlsiYWRtaW4iXSwieC1oYXN1cmEtZGVmYXVsdC1yb2xlIjoiYWRtaW4ifSwiVXNlcklEIjoxNSwiRmlyc3ROYW1lIjoi0JzQuNGF0LDQuNC7IiwiTGFzdE5hbWUiOiLQm9C-0YHQtdC10LIiLCJFbWFpbCI6Im1pc2hhdnpoaWtAZ21haWwuY29tIiwiaWF0IjoxNjM0NDI3ODI0LCJleHAiOjE2MzcwMTk4MjR9.l-h2oHlCuknGGPqS332h9CYg7sMqWZEcyoRibuF5TAo	15
844	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwczovL2hhc3VyYS5pby9qd3QvY2xhaW1zIjp7IngtaGFzdXJhLWFsbG93ZWQtcm9sZXMiOlsiYWRtaW4iXSwieC1oYXN1cmEtZGVmYXVsdC1yb2xlIjoiYWRtaW4ifSwiVXNlcklEIjoxNSwiRmlyc3ROYW1lIjoi0JzQuNGF0LDQuNC7IiwiTGFzdE5hbWUiOiLQm9C-0YHQtdC10LIiLCJFbWFpbCI6Im1pc2hhdnpoaWtAZ21haWwuY29tIiwiaWF0IjoxNjM1MTA5MDgxLCJleHAiOjE2Mzc3MDEwODF9.iigVQ12HYjgY8KLToWS5iHQYnvuWWt3_iNsuMhVMDjE	15
841	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwczovL2hhc3VyYS5pby9qd3QvY2xhaW1zIjp7IngtaGFzdXJhLWFsbG93ZWQtcm9sZXMiOlsiYWRtaW4iXSwieC1oYXN1cmEtZGVmYXVsdC1yb2xlIjoiYWRtaW4ifSwiVXNlcklEIjoxOSwiRmlyc3ROYW1lIjoi0J3QsNGB0YLRjyIsIkxhc3ROYW1lIjoiIiwiRW1haWwiOiJ6YXZvZEBwaWVrLnJ1IiwiaWF0IjoxNjM0ODgwODYwLCJleHAiOjE2Mzc0NzI4NjB9.ZG-3f6vN4Zn8DQR3MiAunG_VIASpAWswWDKVz3XgWdw	19
845	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwczovL2hhc3VyYS5pby9qd3QvY2xhaW1zIjp7IngtaGFzdXJhLWFsbG93ZWQtcm9sZXMiOlsiYWRtaW4iXSwieC1oYXN1cmEtZGVmYXVsdC1yb2xlIjoiYWRtaW4ifSwiVXNlcklEIjoxNSwiRmlyc3ROYW1lIjoi0JzQuNGF0LDQuNC7IiwiTGFzdE5hbWUiOiLQm9C-0YHQtdC10LIiLCJFbWFpbCI6Im1pc2hhdnpoaWtAZ21haWwuY29tIiwiaWF0IjoxNjM1MTI0ODk3LCJleHAiOjE2Mzc3MTY4OTd9.Z-hG_YNj9jszGl258pV6G7cvimiGBRqweJGVTIkfolY	15
851	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwczovL2hhc3VyYS5pby9qd3QvY2xhaW1zIjp7IngtaGFzdXJhLWFsbG93ZWQtcm9sZXMiOlsiYWRtaW4iXSwieC1oYXN1cmEtZGVmYXVsdC1yb2xlIjoiYWRtaW4ifSwiVXNlcklEIjoxNSwiRmlyc3ROYW1lIjoi0JzQuNGF0LDQuNC7IiwiTGFzdE5hbWUiOiLQm9C-0YHQtdC10LIiLCJFbWFpbCI6Im1pc2hhdnpoaWtAZ21haWwuY29tIiwiaWF0IjoxNjM1MjcyODE0LCJleHAiOjE2Mzc4NjQ4MTR9.qjs-VgL6EBYjT_hMiSfMpmZGP32TLlG4gFxgi3-j8U8	15
840	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwczovL2hhc3VyYS5pby9qd3QvY2xhaW1zIjp7IngtaGFzdXJhLWFsbG93ZWQtcm9sZXMiOlsiYWRtaW4iXSwieC1oYXN1cmEtZGVmYXVsdC1yb2xlIjoiYWRtaW4ifSwiVXNlcklEIjoxNSwiRmlyc3ROYW1lIjoi0JzQuNGF0LDQuNC7IiwiTGFzdE5hbWUiOiLQm9C-0YHQtdC10LIiLCJFbWFpbCI6Im1pc2hhdnpoaWtAZ21haWwuY29tIiwiaWF0IjoxNjM1MTQ2Nzk2LCJleHAiOjE2Mzc3Mzg3OTZ9.1RlzjH4JalHeVBkM9QE4UPBlqT7jbzcYrLxZPny6vv4	15
846	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwczovL2hhc3VyYS5pby9qd3QvY2xhaW1zIjp7IngtaGFzdXJhLWFsbG93ZWQtcm9sZXMiOlsiYWRtaW4iXSwieC1oYXN1cmEtZGVmYXVsdC1yb2xlIjoiYWRtaW4ifSwiVXNlcklEIjoxNSwiRmlyc3ROYW1lIjoi0JzQuNGF0LDQuNC7IiwiTGFzdE5hbWUiOiLQm9C-0YHQtdC10LIiLCJFbWFpbCI6Im1pc2hhdnpoaWtAZ21haWwuY29tIiwiaWF0IjoxNjM1MjY5MzM2LCJleHAiOjE2Mzc4NjEzMzZ9.LP9Vv8O7M4VogE1nn8T6FK4x2LYgyfZ0S9C5dX1yF4A	15
805	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwczovL2hhc3VyYS5pby9qd3QvY2xhaW1zIjp7IngtaGFzdXJhLWFsbG93ZWQtcm9sZXMiOlsiYWRtaW4iXSwieC1oYXN1cmEtZGVmYXVsdC1yb2xlIjoiYWRtaW4ifSwiVXNlcklEIjoxNSwiRmlyc3ROYW1lIjoi0JzQuNGF0LDQuNC7IiwiTGFzdE5hbWUiOiLQm9C-0YHQtdC10LIiLCJFbWFpbCI6Im1pc2hhdnpoaWtAZ21haWwuY29tIiwiaWF0IjoxNjM0NTE0MjIyLCJleHAiOjE2MzcxMDYyMjJ9.E-oSPQYo3Anw2zx3rJIFkmEfc7CtAiwx0UCdn_AQXGs	15
807	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwczovL2hhc3VyYS5pby9qd3QvY2xhaW1zIjp7IngtaGFzdXJhLWFsbG93ZWQtcm9sZXMiOlsiYWRtaW4iXSwieC1oYXN1cmEtZGVmYXVsdC1yb2xlIjoiYWRtaW4ifSwiVXNlcklEIjoxNSwiRmlyc3ROYW1lIjoi0JzQuNGF0LDQuNC7IiwiTGFzdE5hbWUiOiLQm9C-0YHQtdC10LIiLCJFbWFpbCI6Im1pc2hhdnpoaWtAZ21haWwuY29tIiwiaWF0IjoxNjM0NzI1MjQ3LCJleHAiOjE2MzczMTcyNDd9.TTOLws6XizeP4zeESmcolc_yPet5pP8i5LZVX6jpZ_Y	15
842	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwczovL2hhc3VyYS5pby9qd3QvY2xhaW1zIjp7IngtaGFzdXJhLWFsbG93ZWQtcm9sZXMiOlsiYWRtaW4iXSwieC1oYXN1cmEtZGVmYXVsdC1yb2xlIjoiYWRtaW4ifSwiVXNlcklEIjoxNSwiRmlyc3ROYW1lIjoi0JzQuNGF0LDQuNC7IiwiTGFzdE5hbWUiOiLQm9C-0YHQtdC10LIiLCJFbWFpbCI6Im1pc2hhdnpoaWtAZ21haWwuY29tIiwiaWF0IjoxNjM1MDM4OTQ5LCJleHAiOjE2Mzc2MzA5NDl9.VBHF0XIGc55BEOQP4VjuOKqC0IqmwlowGyvmBAz3gYQ	15
848	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwczovL2hhc3VyYS5pby9qd3QvY2xhaW1zIjp7IngtaGFzdXJhLWFsbG93ZWQtcm9sZXMiOlsiYWRtaW4iXSwieC1oYXN1cmEtZGVmYXVsdC1yb2xlIjoiYWRtaW4ifSwiVXNlcklEIjoxNSwiRmlyc3ROYW1lIjoi0JzQuNGF0LDQuNC7IiwiTGFzdE5hbWUiOiLQm9C-0YHQtdC10LIiLCJFbWFpbCI6Im1pc2hhdnpoaWtAZ21haWwuY29tIiwiaWF0IjoxNjM1MjY1ODYyLCJleHAiOjE2Mzc4NTc4NjJ9.HeebaMDJcQFYBmGK3-Jq3GO6nc_X0KOSaIi-cUHjv9w	15
849	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwczovL2hhc3VyYS5pby9qd3QvY2xhaW1zIjp7IngtaGFzdXJhLWFsbG93ZWQtcm9sZXMiOlsiYWRtaW4iXSwieC1oYXN1cmEtZGVmYXVsdC1yb2xlIjoiYWRtaW4ifSwiVXNlcklEIjoxOSwiRmlyc3ROYW1lIjoi0J3QsNGB0YLRjyIsIkxhc3ROYW1lIjoiIiwiRW1haWwiOiJ6YXZvZEBwaWVrLnJ1IiwiaWF0IjoxNjM1MjI1MDkyLCJleHAiOjE2Mzc4MTcwOTJ9.44cm5eRQVHoTX4Z7s1ha6LRzLkiCe8CIfzy2ggBdIXo	19
850	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwczovL2hhc3VyYS5pby9qd3QvY2xhaW1zIjp7IngtaGFzdXJhLWFsbG93ZWQtcm9sZXMiOlsiYWRtaW4iXSwieC1oYXN1cmEtZGVmYXVsdC1yb2xlIjoiYWRtaW4ifSwiVXNlcklEIjoxOSwiRmlyc3ROYW1lIjoi0J3QsNGB0YLRjyIsIkxhc3ROYW1lIjoiIiwiRW1haWwiOiJ6YXZvZEBwaWVrLnJ1IiwiaWF0IjoxNjM1MjI3MjA4LCJleHAiOjE2Mzc4MTkyMDh9.vAqwGcos4iHUHAXGHXQ5XOzUabu1xvWNGhdxOPnLmUc	19
852	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwczovL2hhc3VyYS5pby9qd3QvY2xhaW1zIjp7IngtaGFzdXJhLWFsbG93ZWQtcm9sZXMiOlsiYWRtaW4iXSwieC1oYXN1cmEtZGVmYXVsdC1yb2xlIjoiYWRtaW4ifSwiVXNlcklEIjoxNSwiRmlyc3ROYW1lIjoi0JzQuNGF0LDQuNC7IiwiTGFzdE5hbWUiOiLQm9C-0YHQtdC10LIiLCJFbWFpbCI6Im1pc2hhdnpoaWtAZ21haWwuY29tIiwiaWF0IjoxNjM1Mjc3MDM1LCJleHAiOjE2Mzc4NjkwMzV9.5lpe2rCA_8q2rBuBlMDTUPtUHolYDOeroKFJfhRE_Vs	15
853	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwczovL2hhc3VyYS5pby9qd3QvY2xhaW1zIjp7IngtaGFzdXJhLWFsbG93ZWQtcm9sZXMiOlsiYWRtaW4iXSwieC1oYXN1cmEtZGVmYXVsdC1yb2xlIjoiYWRtaW4ifSwiVXNlcklEIjoxNSwiRmlyc3ROYW1lIjoi0JzQuNGF0LDQuNC7IiwiTGFzdE5hbWUiOiLQm9C-0YHQtdC10LIiLCJFbWFpbCI6Im1pc2hhdnpoaWtAZ21haWwuY29tIiwiQWNjZXNzTGV2ZWxJRCI6MiwiaWF0IjoxNjM1Mjc3MzYxLCJleHAiOjE2Mzc4NjkzNjF9.0kdwDaKdH6v8wrgFzSJAiA4BNwd2E0i8TS5jFgZjoac	15
\.


--
-- Data for Name: Users; Type: TABLE DATA; Schema: erp; Owner: postgres
--

COPY erp."Users" ("UserID", "FirstName", "LastName", "Password", "AccessLevelID", "Email") FROM stdin;
15	Михаил	Лосеев	SUVBLEpnZZpGHDMM	2	mishavzhik@gmail.com
16	Павел 	Злобин	SjGkQYZyMP	2	zlobin@piek.ru
17	Денис 	Новосельцев	nhIRNwPLgW	3	d.nov@piek.ru
20	Антон	Лосеев	3cpDEV7dvk	3	piek_zavod@mail.ru
18	Ирина	Энгельс	98mHsK6LAA	4	info@piek.ru
19	Анастасия	Козлова	EmDBYw52Xw	4	zavod@piek.ru
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
1	{"rest_endpoints":[{"definition":{"query":{"collection_name":"allowed-queries","query_name":"getAttendanceLatestInterval"}},"url":"getAttendanceLatestInterval","methods":["GET"],"name":"getAttendanceLatestInterval","comment":"This method return the time of latest entrance"},{"definition":{"query":{"collection_name":"allowed-queries","query_name":"getInputData"}},"url":"getInputData","methods":["GET"],"name":"getInputData","comment":null},{"definition":{"query":{"collection_name":"allowed-queries","query_name":"getStopLosses"}},"url":"getStopLosses","methods":["GET"],"name":"getStopLosses","comment":null},{"definition":{"query":{"collection_name":"allowed-queries","query_name":"testMutation"}},"url":"testMutation","methods":["PUT"],"name":"testMutation","comment":null},{"definition":{"query":{"collection_name":"allowed-queries","query_name":"testrest"}},"url":"testrest","methods":["GET"],"name":"testrest","comment":null}],"allowlist":[{"collection":"allowed-queries"}],"sources":[{"kind":"postgres","name":"default","tables":[{"select_permissions":[{"role":"user","permission":{"columns":["IntervalID","card","entrance","exit","interval","status"],"filter":{}}}],"object_relationships":[{"using":{"foreign_key_constraint_on":"card"},"name":"user"}],"insert_permissions":[{"role":"user","permission":{"backend_only":false,"check":{},"columns":["entrance","exit","interval","status","card","IntervalID"]}}],"table":{"schema":"attendance","name":"intervalsPool"},"update_permissions":[{"role":"user","permission":{"check":null,"columns":["IntervalID","status","interval","card","entrance","exit"],"filter":{}}}],"delete_permissions":[{"role":"user","permission":{"filter":{}}}]},{"table":{"schema":"attendance","name":"users"},"array_relationships":[{"using":{"foreign_key_constraint_on":{"column":"card","table":{"schema":"attendance","name":"intervalsPool"}}},"name":"intervalsPools"}]},{"table":{"schema":"erp","name":"AccessLevels"},"array_relationships":[{"using":{"foreign_key_constraint_on":{"column":"AccessLevelID","table":{"schema":"erp","name":"Users"}}},"name":"Users"}]},{"table":{"schema":"erp","name":"CheckListTPLs"},"array_relationships":[{"using":{"foreign_key_constraint_on":{"column":"CheckListTPLID","table":{"schema":"erp","name":"Orders"}}},"name":"Orders"}]},{"object_relationships":[{"using":{"foreign_key_constraint_on":"OrderID"},"name":"Order"}],"table":{"schema":"erp","name":"CheckListUnits"}},{"object_relationships":[{"using":{"foreign_key_constraint_on":"OrderID"},"name":"Order"},{"using":{"foreign_key_constraint_on":"UserID"},"name":"User"}],"table":{"schema":"erp","name":"Comments"}},{"object_relationships":[{"using":{"foreign_key_constraint_on":"OrderID"},"name":"Order"}],"table":{"schema":"erp","name":"Docs"}},{"object_relationships":[{"using":{"foreign_key_constraint_on":"OrderID"},"name":"Order"}],"table":{"schema":"erp","name":"OrderItems"}},{"table":{"schema":"erp","name":"OrderStatus"},"array_relationships":[{"using":{"foreign_key_constraint_on":{"column":"OrderStatusID","table":{"schema":"erp","name":"Orders"}}},"name":"Orders"}]},{"object_relationships":[{"using":{"foreign_key_constraint_on":"CheckListTPLID"},"name":"CheckListTPL"},{"using":{"foreign_key_constraint_on":"OrderStatusID"},"name":"OrderStatus"},{"using":{"foreign_key_constraint_on":"ManagerID"},"name":"User"}],"table":{"schema":"erp","name":"Orders"},"array_relationships":[{"using":{"foreign_key_constraint_on":{"column":"OrderID","table":{"schema":"erp","name":"CheckListUnits"}}},"name":"CheckListUnits"},{"using":{"foreign_key_constraint_on":{"column":"OrderID","table":{"schema":"erp","name":"Comments"}}},"name":"Comments"},{"using":{"foreign_key_constraint_on":{"column":"OrderID","table":{"schema":"erp","name":"Docs"}}},"name":"Docs"},{"using":{"foreign_key_constraint_on":{"column":"OrderID","table":{"schema":"erp","name":"OrderItems"}}},"name":"OrderItems"},{"using":{"foreign_key_constraint_on":{"column":"OrderID","table":{"schema":"erp","name":"PaymentHistory"}}},"name":"PaymentHistories"}]},{"object_relationships":[{"using":{"foreign_key_constraint_on":"OrderID"},"name":"Order"}],"table":{"schema":"erp","name":"PaymentHistory"}},{"object_relationships":[{"using":{"foreign_key_constraint_on":"UserID"},"name":"User"}],"table":{"schema":"erp","name":"Tokens"}},{"object_relationships":[{"using":{"foreign_key_constraint_on":"AccessLevelID"},"name":"AccessLevel"}],"table":{"schema":"erp","name":"Users"},"array_relationships":[{"using":{"foreign_key_constraint_on":{"column":"UserID","table":{"schema":"erp","name":"Comments"}}},"name":"Comments"},{"using":{"foreign_key_constraint_on":{"column":"ManagerID","table":{"schema":"erp","name":"Orders"}}},"name":"Orders"},{"using":{"foreign_key_constraint_on":{"column":"UserID","table":{"schema":"erp","name":"Tokens"}}},"name":"Tokrns"}]},{"table":{"schema":"traderBot","name":"inpurData1"}},{"table":{"schema":"traderBot","name":"inputData"}}],"configuration":{"connection_info":{"use_prepared_statements":true,"database_url":{"from_env":"PG_DATABASE_URL"},"isolation_level":"read-committed","pool_settings":{"connection_lifetime":600,"retries":1,"idle_timeout":180,"max_connections":50}}}}],"version":3,"query_collections":[{"definition":{"queries":[{"name":"testrest","query":"query MyQuery {\\n  erp_Orders {\\n    Entity\\n    InvoiceNumber\\n    OrderItems {\\n      Quantity\\n      OrderItemID\\n      Name\\n      OrderID\\n    }\\n    City\\n    ShippingDate\\n  }\\n}"},{"name":"testMutation","query":"mutation MyMutation {\\n  update_traderBot_inputData(where: {Ticker: {_eq: \\"XRP\\"}}, _set: {TPid: 10, FirstBuy: true}) {\\n    returning {\\n      TPid\\n    }\\n  }\\n}"},{"name":"getStopLosses","query":"query MyQuery {\\n  traderBot_inputData(where: {stopLossed: {_eq: true}}) {\\n    Ticker\\n  }\\n}"},{"name":"getInputData","query":"query MyQuery {\\n  traderBot_inputData(where: {stopLossed: {_eq: false}}) {\\n    ATH\\n    PosFromFund\\n    ProfitValue\\n    Ticker\\n    ValFirstBuy\\n    ValForcedSale\\n    ValSecBuy\\n    id\\n    TPid\\n    FirstBuy\\n    SecBuy\\n    stopLossed\\n    SumFirstBuy\\n  }\\n}"},{"name":"getAttendanceLatestInterval","query":"query MyQuery {\\n  attendance_intervalsPool_aggregate {\\n    aggregate {\\n      max {\\n        entrance\\n      }\\n    }\\n  }\\n}"}]},"name":"allowed-queries"}]}	98
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
1	{"metadata":false,"remote_schemas":[],"sources":["default"]}	98	01b765f6-1221-4a1e-a1d7-eb2a9ad936ae	2021-06-17 18:31:48.157854+00
\.


--
-- Data for Name: hdb_version; Type: TABLE DATA; Schema: hdb_catalog; Owner: postgres
--

COPY hdb_catalog.hdb_version (hasura_uuid, version, upgraded_on, cli_state, console_state) FROM stdin;
98678032-bc9d-4f35-a68e-43d25687b5ae	46	2021-08-08 14:05:52.543417+00	{}	{"console_notifications": {"admin": {"date": "2021-10-18T22:07:05.312Z", "read": [], "showBadge": true}}, "telemetryNotificationShown": true}
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
-- Name: intervalsPool_IntervalID_seq; Type: SEQUENCE SET; Schema: attendance; Owner: postgres
--

SELECT pg_catalog.setval('attendance."intervalsPool_IntervalID_seq"', 36819, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: attendance; Owner: postgres
--

SELECT pg_catalog.setval('attendance.users_id_seq', 11088, true);


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

SELECT pg_catalog.setval('erp."Comments_CommentID_seq"', 278, true);


--
-- Name: Docs_ID_seq; Type: SEQUENCE SET; Schema: erp; Owner: postgres
--

SELECT pg_catalog.setval('erp."Docs_ID_seq"', 138, true);


--
-- Name: OrderItems_OrderItemID_seq; Type: SEQUENCE SET; Schema: erp; Owner: postgres
--

SELECT pg_catalog.setval('erp."OrderItems_OrderItemID_seq"', 364, true);


--
-- Name: OrderStatus_OrderStatusID_seq; Type: SEQUENCE SET; Schema: erp; Owner: postgres
--

SELECT pg_catalog.setval('erp."OrderStatus_OrderStatusID_seq"', 4, true);


--
-- Name: Orders_OrderID_seq; Type: SEQUENCE SET; Schema: erp; Owner: postgres
--

SELECT pg_catalog.setval('erp."Orders_OrderID_seq"', 140, true);


--
-- Name: PaymentHistory_id_seq; Type: SEQUENCE SET; Schema: erp; Owner: postgres
--

SELECT pg_catalog.setval('erp."PaymentHistory_id_seq"', 26, true);


--
-- Name: Tokrns_ID_seq; Type: SEQUENCE SET; Schema: erp; Owner: postgres
--

SELECT pg_catalog.setval('erp."Tokrns_ID_seq"', 853, true);


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
-- Name: intervalsPool intervalsPool_pkey; Type: CONSTRAINT; Schema: attendance; Owner: postgres
--

ALTER TABLE ONLY attendance."intervalsPool"
    ADD CONSTRAINT "intervalsPool_pkey" PRIMARY KEY ("IntervalID");


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
-- Name: intervalsPool intervalsPool_card_fkey; Type: FK CONSTRAINT; Schema: attendance; Owner: postgres
--

ALTER TABLE ONLY attendance."intervalsPool"
    ADD CONSTRAINT "intervalsPool_card_fkey" FOREIGN KEY (card) REFERENCES attendance.users(card) ON UPDATE RESTRICT ON DELETE RESTRICT;


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
    ADD CONSTRAINT "PaymentHistory_OrderID_fkey" FOREIGN KEY ("OrderID") REFERENCES erp."Orders"("OrderID") ON UPDATE RESTRICT ON DELETE RESTRICT;


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

