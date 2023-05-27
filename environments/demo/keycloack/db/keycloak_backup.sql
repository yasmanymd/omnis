--
-- PostgreSQL database dump
--

-- Dumped from database version 15.3 (Debian 15.3-1.pgdg110+1)
-- Dumped by pg_dump version 15.3 (Debian 15.3-1.pgdg110+1)

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
-- Name: admin_event_entity; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.admin_event_entity (
    id character varying(36) NOT NULL,
    admin_event_time bigint,
    realm_id character varying(255),
    operation_type character varying(255),
    auth_realm_id character varying(255),
    auth_client_id character varying(255),
    auth_user_id character varying(255),
    ip_address character varying(255),
    resource_path character varying(2550),
    representation text,
    error character varying(255),
    resource_type character varying(64)
);


ALTER TABLE public.admin_event_entity OWNER TO keycloak;

--
-- Name: associated_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.associated_policy (
    policy_id character varying(36) NOT NULL,
    associated_policy_id character varying(36) NOT NULL
);


ALTER TABLE public.associated_policy OWNER TO keycloak;

--
-- Name: authentication_execution; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.authentication_execution (
    id character varying(36) NOT NULL,
    alias character varying(255),
    authenticator character varying(36),
    realm_id character varying(36),
    flow_id character varying(36),
    requirement integer,
    priority integer,
    authenticator_flow boolean DEFAULT false NOT NULL,
    auth_flow_id character varying(36),
    auth_config character varying(36)
);


ALTER TABLE public.authentication_execution OWNER TO keycloak;

--
-- Name: authentication_flow; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.authentication_flow (
    id character varying(36) NOT NULL,
    alias character varying(255),
    description character varying(255),
    realm_id character varying(36),
    provider_id character varying(36) DEFAULT 'basic-flow'::character varying NOT NULL,
    top_level boolean DEFAULT false NOT NULL,
    built_in boolean DEFAULT false NOT NULL
);


ALTER TABLE public.authentication_flow OWNER TO keycloak;

--
-- Name: authenticator_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.authenticator_config (
    id character varying(36) NOT NULL,
    alias character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.authenticator_config OWNER TO keycloak;

--
-- Name: authenticator_config_entry; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.authenticator_config_entry (
    authenticator_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.authenticator_config_entry OWNER TO keycloak;

--
-- Name: broker_link; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.broker_link (
    identity_provider character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL,
    broker_user_id character varying(255),
    broker_username character varying(255),
    token text,
    user_id character varying(255) NOT NULL
);


ALTER TABLE public.broker_link OWNER TO keycloak;

--
-- Name: client; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client (
    id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    full_scope_allowed boolean DEFAULT false NOT NULL,
    client_id character varying(255),
    not_before integer,
    public_client boolean DEFAULT false NOT NULL,
    secret character varying(255),
    base_url character varying(255),
    bearer_only boolean DEFAULT false NOT NULL,
    management_url character varying(255),
    surrogate_auth_required boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    protocol character varying(255),
    node_rereg_timeout integer DEFAULT 0,
    frontchannel_logout boolean DEFAULT false NOT NULL,
    consent_required boolean DEFAULT false NOT NULL,
    name character varying(255),
    service_accounts_enabled boolean DEFAULT false NOT NULL,
    client_authenticator_type character varying(255),
    root_url character varying(255),
    description character varying(255),
    registration_token character varying(255),
    standard_flow_enabled boolean DEFAULT true NOT NULL,
    implicit_flow_enabled boolean DEFAULT false NOT NULL,
    direct_access_grants_enabled boolean DEFAULT false NOT NULL,
    always_display_in_console boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client OWNER TO keycloak;

--
-- Name: client_attributes; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_attributes (
    client_id character varying(36) NOT NULL,
    value character varying(4000),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_attributes OWNER TO keycloak;

--
-- Name: client_auth_flow_bindings; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_auth_flow_bindings (
    client_id character varying(36) NOT NULL,
    flow_id character varying(36),
    binding_name character varying(255) NOT NULL
);


ALTER TABLE public.client_auth_flow_bindings OWNER TO keycloak;

--
-- Name: client_initial_access; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_initial_access (
    id character varying(36) NOT NULL,
    realm_id character varying(36) NOT NULL,
    "timestamp" integer,
    expiration integer,
    count integer,
    remaining_count integer
);


ALTER TABLE public.client_initial_access OWNER TO keycloak;

--
-- Name: client_node_registrations; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_node_registrations (
    client_id character varying(36) NOT NULL,
    value integer,
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_node_registrations OWNER TO keycloak;

--
-- Name: client_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_scope (
    id character varying(36) NOT NULL,
    name character varying(255),
    realm_id character varying(36),
    description character varying(255),
    protocol character varying(255)
);


ALTER TABLE public.client_scope OWNER TO keycloak;

--
-- Name: client_scope_attributes; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_scope_attributes (
    scope_id character varying(36) NOT NULL,
    value character varying(2048),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_scope_attributes OWNER TO keycloak;

--
-- Name: client_scope_client; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_scope_client (
    client_id character varying(255) NOT NULL,
    scope_id character varying(255) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client_scope_client OWNER TO keycloak;

--
-- Name: client_scope_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_scope_role_mapping (
    scope_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.client_scope_role_mapping OWNER TO keycloak;

--
-- Name: client_session; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_session (
    id character varying(36) NOT NULL,
    client_id character varying(36),
    redirect_uri character varying(255),
    state character varying(255),
    "timestamp" integer,
    session_id character varying(36),
    auth_method character varying(255),
    realm_id character varying(255),
    auth_user_id character varying(36),
    current_action character varying(36)
);


ALTER TABLE public.client_session OWNER TO keycloak;

--
-- Name: client_session_auth_status; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_session_auth_status (
    authenticator character varying(36) NOT NULL,
    status integer,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_auth_status OWNER TO keycloak;

--
-- Name: client_session_note; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_session_note (
    name character varying(255) NOT NULL,
    value character varying(255),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_note OWNER TO keycloak;

--
-- Name: client_session_prot_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_session_prot_mapper (
    protocol_mapper_id character varying(36) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_prot_mapper OWNER TO keycloak;

--
-- Name: client_session_role; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_session_role (
    role_id character varying(255) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_role OWNER TO keycloak;

--
-- Name: client_user_session_note; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_user_session_note (
    name character varying(255) NOT NULL,
    value character varying(2048),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_user_session_note OWNER TO keycloak;

--
-- Name: component; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.component (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_id character varying(36),
    provider_id character varying(36),
    provider_type character varying(255),
    realm_id character varying(36),
    sub_type character varying(255)
);


ALTER TABLE public.component OWNER TO keycloak;

--
-- Name: component_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.component_config (
    id character varying(36) NOT NULL,
    component_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(4000)
);


ALTER TABLE public.component_config OWNER TO keycloak;

--
-- Name: composite_role; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.composite_role (
    composite character varying(36) NOT NULL,
    child_role character varying(36) NOT NULL
);


ALTER TABLE public.composite_role OWNER TO keycloak;

--
-- Name: credential; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    user_id character varying(36),
    created_date bigint,
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.credential OWNER TO keycloak;

--
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


ALTER TABLE public.databasechangelog OWNER TO keycloak;

--
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE public.databasechangeloglock OWNER TO keycloak;

--
-- Name: default_client_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.default_client_scope (
    realm_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.default_client_scope OWNER TO keycloak;

--
-- Name: event_entity; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.event_entity (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    details_json character varying(2550),
    error character varying(255),
    ip_address character varying(255),
    realm_id character varying(255),
    session_id character varying(255),
    event_time bigint,
    type character varying(255),
    user_id character varying(255)
);


ALTER TABLE public.event_entity OWNER TO keycloak;

--
-- Name: fed_user_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_attribute (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    value character varying(2024)
);


ALTER TABLE public.fed_user_attribute OWNER TO keycloak;

--
-- Name: fed_user_consent; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.fed_user_consent OWNER TO keycloak;

--
-- Name: fed_user_consent_cl_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_consent_cl_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.fed_user_consent_cl_scope OWNER TO keycloak;

--
-- Name: fed_user_credential; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    created_date bigint,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.fed_user_credential OWNER TO keycloak;

--
-- Name: fed_user_group_membership; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_group_membership OWNER TO keycloak;

--
-- Name: fed_user_required_action; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_required_action (
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_required_action OWNER TO keycloak;

--
-- Name: fed_user_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_role_mapping (
    role_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_role_mapping OWNER TO keycloak;

--
-- Name: federated_identity; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.federated_identity (
    identity_provider character varying(255) NOT NULL,
    realm_id character varying(36),
    federated_user_id character varying(255),
    federated_username character varying(255),
    token text,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_identity OWNER TO keycloak;

--
-- Name: federated_user; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.federated_user (
    id character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_user OWNER TO keycloak;

--
-- Name: group_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.group_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_attribute OWNER TO keycloak;

--
-- Name: group_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.group_role_mapping (
    role_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_role_mapping OWNER TO keycloak;

--
-- Name: identity_provider; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.identity_provider (
    internal_id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    provider_alias character varying(255),
    provider_id character varying(255),
    store_token boolean DEFAULT false NOT NULL,
    authenticate_by_default boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    add_token_role boolean DEFAULT true NOT NULL,
    trust_email boolean DEFAULT false NOT NULL,
    first_broker_login_flow_id character varying(36),
    post_broker_login_flow_id character varying(36),
    provider_display_name character varying(255),
    link_only boolean DEFAULT false NOT NULL
);


ALTER TABLE public.identity_provider OWNER TO keycloak;

--
-- Name: identity_provider_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.identity_provider_config (
    identity_provider_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.identity_provider_config OWNER TO keycloak;

--
-- Name: identity_provider_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.identity_provider_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    idp_alias character varying(255) NOT NULL,
    idp_mapper_name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.identity_provider_mapper OWNER TO keycloak;

--
-- Name: idp_mapper_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.idp_mapper_config (
    idp_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.idp_mapper_config OWNER TO keycloak;

--
-- Name: keycloak_group; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.keycloak_group (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_group character varying(36) NOT NULL,
    realm_id character varying(36)
);


ALTER TABLE public.keycloak_group OWNER TO keycloak;

--
-- Name: keycloak_role; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.keycloak_role (
    id character varying(36) NOT NULL,
    client_realm_constraint character varying(255),
    client_role boolean DEFAULT false NOT NULL,
    description character varying(255),
    name character varying(255),
    realm_id character varying(255),
    client character varying(36),
    realm character varying(36)
);


ALTER TABLE public.keycloak_role OWNER TO keycloak;

--
-- Name: migration_model; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.migration_model (
    id character varying(36) NOT NULL,
    version character varying(36),
    update_time bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.migration_model OWNER TO keycloak;

--
-- Name: offline_client_session; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.offline_client_session (
    user_session_id character varying(36) NOT NULL,
    client_id character varying(255) NOT NULL,
    offline_flag character varying(4) NOT NULL,
    "timestamp" integer,
    data text,
    client_storage_provider character varying(36) DEFAULT 'local'::character varying NOT NULL,
    external_client_id character varying(255) DEFAULT 'local'::character varying NOT NULL
);


ALTER TABLE public.offline_client_session OWNER TO keycloak;

--
-- Name: offline_user_session; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.offline_user_session (
    user_session_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    created_on integer NOT NULL,
    offline_flag character varying(4) NOT NULL,
    data text,
    last_session_refresh integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.offline_user_session OWNER TO keycloak;

--
-- Name: policy_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.policy_config (
    policy_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.policy_config OWNER TO keycloak;

--
-- Name: protocol_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.protocol_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    protocol character varying(255) NOT NULL,
    protocol_mapper_name character varying(255) NOT NULL,
    client_id character varying(36),
    client_scope_id character varying(36)
);


ALTER TABLE public.protocol_mapper OWNER TO keycloak;

--
-- Name: protocol_mapper_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.protocol_mapper_config (
    protocol_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.protocol_mapper_config OWNER TO keycloak;

--
-- Name: realm; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm (
    id character varying(36) NOT NULL,
    access_code_lifespan integer,
    user_action_lifespan integer,
    access_token_lifespan integer,
    account_theme character varying(255),
    admin_theme character varying(255),
    email_theme character varying(255),
    enabled boolean DEFAULT false NOT NULL,
    events_enabled boolean DEFAULT false NOT NULL,
    events_expiration bigint,
    login_theme character varying(255),
    name character varying(255),
    not_before integer,
    password_policy character varying(2550),
    registration_allowed boolean DEFAULT false NOT NULL,
    remember_me boolean DEFAULT false NOT NULL,
    reset_password_allowed boolean DEFAULT false NOT NULL,
    social boolean DEFAULT false NOT NULL,
    ssl_required character varying(255),
    sso_idle_timeout integer,
    sso_max_lifespan integer,
    update_profile_on_soc_login boolean DEFAULT false NOT NULL,
    verify_email boolean DEFAULT false NOT NULL,
    master_admin_client character varying(36),
    login_lifespan integer,
    internationalization_enabled boolean DEFAULT false NOT NULL,
    default_locale character varying(255),
    reg_email_as_username boolean DEFAULT false NOT NULL,
    admin_events_enabled boolean DEFAULT false NOT NULL,
    admin_events_details_enabled boolean DEFAULT false NOT NULL,
    edit_username_allowed boolean DEFAULT false NOT NULL,
    otp_policy_counter integer DEFAULT 0,
    otp_policy_window integer DEFAULT 1,
    otp_policy_period integer DEFAULT 30,
    otp_policy_digits integer DEFAULT 6,
    otp_policy_alg character varying(36) DEFAULT 'HmacSHA1'::character varying,
    otp_policy_type character varying(36) DEFAULT 'totp'::character varying,
    browser_flow character varying(36),
    registration_flow character varying(36),
    direct_grant_flow character varying(36),
    reset_credentials_flow character varying(36),
    client_auth_flow character varying(36),
    offline_session_idle_timeout integer DEFAULT 0,
    revoke_refresh_token boolean DEFAULT false NOT NULL,
    access_token_life_implicit integer DEFAULT 0,
    login_with_email_allowed boolean DEFAULT true NOT NULL,
    duplicate_emails_allowed boolean DEFAULT false NOT NULL,
    docker_auth_flow character varying(36),
    refresh_token_max_reuse integer DEFAULT 0,
    allow_user_managed_access boolean DEFAULT false NOT NULL,
    sso_max_lifespan_remember_me integer DEFAULT 0 NOT NULL,
    sso_idle_timeout_remember_me integer DEFAULT 0 NOT NULL,
    default_role character varying(255)
);


ALTER TABLE public.realm OWNER TO keycloak;

--
-- Name: realm_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_attribute (
    name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    value text
);


ALTER TABLE public.realm_attribute OWNER TO keycloak;

--
-- Name: realm_default_groups; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_default_groups (
    realm_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_default_groups OWNER TO keycloak;

--
-- Name: realm_enabled_event_types; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_enabled_event_types (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_enabled_event_types OWNER TO keycloak;

--
-- Name: realm_events_listeners; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_events_listeners (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_events_listeners OWNER TO keycloak;

--
-- Name: realm_localizations; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_localizations (
    realm_id character varying(255) NOT NULL,
    locale character varying(255) NOT NULL,
    texts text NOT NULL
);


ALTER TABLE public.realm_localizations OWNER TO keycloak;

--
-- Name: realm_required_credential; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_required_credential (
    type character varying(255) NOT NULL,
    form_label character varying(255),
    input boolean DEFAULT false NOT NULL,
    secret boolean DEFAULT false NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_required_credential OWNER TO keycloak;

--
-- Name: realm_smtp_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_smtp_config (
    realm_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.realm_smtp_config OWNER TO keycloak;

--
-- Name: realm_supported_locales; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_supported_locales (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_supported_locales OWNER TO keycloak;

--
-- Name: redirect_uris; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.redirect_uris (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.redirect_uris OWNER TO keycloak;

--
-- Name: required_action_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.required_action_config (
    required_action_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.required_action_config OWNER TO keycloak;

--
-- Name: required_action_provider; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.required_action_provider (
    id character varying(36) NOT NULL,
    alias character varying(255),
    name character varying(255),
    realm_id character varying(36),
    enabled boolean DEFAULT false NOT NULL,
    default_action boolean DEFAULT false NOT NULL,
    provider_id character varying(255),
    priority integer
);


ALTER TABLE public.required_action_provider OWNER TO keycloak;

--
-- Name: resource_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    resource_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_attribute OWNER TO keycloak;

--
-- Name: resource_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_policy (
    resource_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_policy OWNER TO keycloak;

--
-- Name: resource_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_scope (
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_scope OWNER TO keycloak;

--
-- Name: resource_server; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server (
    id character varying(36) NOT NULL,
    allow_rs_remote_mgmt boolean DEFAULT false NOT NULL,
    policy_enforce_mode character varying(15) NOT NULL,
    decision_strategy smallint DEFAULT 1 NOT NULL
);


ALTER TABLE public.resource_server OWNER TO keycloak;

--
-- Name: resource_server_perm_ticket; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server_perm_ticket (
    id character varying(36) NOT NULL,
    owner character varying(255) NOT NULL,
    requester character varying(255) NOT NULL,
    created_timestamp bigint NOT NULL,
    granted_timestamp bigint,
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36),
    resource_server_id character varying(36) NOT NULL,
    policy_id character varying(36)
);


ALTER TABLE public.resource_server_perm_ticket OWNER TO keycloak;

--
-- Name: resource_server_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server_policy (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    type character varying(255) NOT NULL,
    decision_strategy character varying(20),
    logic character varying(20),
    resource_server_id character varying(36) NOT NULL,
    owner character varying(255)
);


ALTER TABLE public.resource_server_policy OWNER TO keycloak;

--
-- Name: resource_server_resource; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server_resource (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(255),
    icon_uri character varying(255),
    owner character varying(255) NOT NULL,
    resource_server_id character varying(36) NOT NULL,
    owner_managed_access boolean DEFAULT false NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_resource OWNER TO keycloak;

--
-- Name: resource_server_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server_scope (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    icon_uri character varying(255),
    resource_server_id character varying(36) NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_scope OWNER TO keycloak;

--
-- Name: resource_uris; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_uris (
    resource_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.resource_uris OWNER TO keycloak;

--
-- Name: role_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.role_attribute (
    id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255)
);


ALTER TABLE public.role_attribute OWNER TO keycloak;

--
-- Name: scope_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.scope_mapping (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_mapping OWNER TO keycloak;

--
-- Name: scope_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.scope_policy (
    scope_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_policy OWNER TO keycloak;

--
-- Name: user_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    user_id character varying(36) NOT NULL,
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL
);


ALTER TABLE public.user_attribute OWNER TO keycloak;

--
-- Name: user_consent; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(36) NOT NULL,
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.user_consent OWNER TO keycloak;

--
-- Name: user_consent_client_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_consent_client_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.user_consent_client_scope OWNER TO keycloak;

--
-- Name: user_entity; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_entity (
    id character varying(36) NOT NULL,
    email character varying(255),
    email_constraint character varying(255),
    email_verified boolean DEFAULT false NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    federation_link character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    realm_id character varying(255),
    username character varying(255),
    created_timestamp bigint,
    service_account_client_link character varying(255),
    not_before integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.user_entity OWNER TO keycloak;

--
-- Name: user_federation_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_federation_config (
    user_federation_provider_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_config OWNER TO keycloak;

--
-- Name: user_federation_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_federation_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    federation_provider_id character varying(36) NOT NULL,
    federation_mapper_type character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.user_federation_mapper OWNER TO keycloak;

--
-- Name: user_federation_mapper_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_federation_mapper_config (
    user_federation_mapper_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_mapper_config OWNER TO keycloak;

--
-- Name: user_federation_provider; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_federation_provider (
    id character varying(36) NOT NULL,
    changed_sync_period integer,
    display_name character varying(255),
    full_sync_period integer,
    last_sync integer,
    priority integer,
    provider_name character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.user_federation_provider OWNER TO keycloak;

--
-- Name: user_group_membership; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_group_membership OWNER TO keycloak;

--
-- Name: user_required_action; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_required_action (
    user_id character varying(36) NOT NULL,
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL
);


ALTER TABLE public.user_required_action OWNER TO keycloak;

--
-- Name: user_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_role_mapping (
    role_id character varying(255) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_role_mapping OWNER TO keycloak;

--
-- Name: user_session; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_session (
    id character varying(36) NOT NULL,
    auth_method character varying(255),
    ip_address character varying(255),
    last_session_refresh integer,
    login_username character varying(255),
    realm_id character varying(255),
    remember_me boolean DEFAULT false NOT NULL,
    started integer,
    user_id character varying(255),
    user_session_state integer,
    broker_session_id character varying(255),
    broker_user_id character varying(255)
);


ALTER TABLE public.user_session OWNER TO keycloak;

--
-- Name: user_session_note; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_session_note (
    user_session character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(2048)
);


ALTER TABLE public.user_session_note OWNER TO keycloak;

--
-- Name: username_login_failure; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.username_login_failure (
    realm_id character varying(36) NOT NULL,
    username character varying(255) NOT NULL,
    failed_login_not_before integer,
    last_failure bigint,
    last_ip_failure character varying(255),
    num_failures integer
);


ALTER TABLE public.username_login_failure OWNER TO keycloak;

--
-- Name: web_origins; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.web_origins (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.web_origins OWNER TO keycloak;

--
-- Data for Name: admin_event_entity; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.admin_event_entity (id, admin_event_time, realm_id, operation_type, auth_realm_id, auth_client_id, auth_user_id, ip_address, resource_path, representation, error, resource_type) FROM stdin;
\.


--
-- Data for Name: associated_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.associated_policy (policy_id, associated_policy_id) FROM stdin;
b6897ac2-baf7-42ae-978a-9a2fa8537b1f	60350c9c-7926-49e6-b374-1df1e2365702
\.


--
-- Data for Name: authentication_execution; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) FROM stdin;
41547329-9db4-45fd-adcc-d7ac63ab855c	\N	auth-cookie	c801dbb6-9ca3-4c23-ad63-1946842fef6b	f1e309d5-3c71-4cb8-9f98-0d05cd190041	2	10	f	\N	\N
b569b104-b932-4860-b468-e55c367dbbe5	\N	auth-spnego	c801dbb6-9ca3-4c23-ad63-1946842fef6b	f1e309d5-3c71-4cb8-9f98-0d05cd190041	3	20	f	\N	\N
7cd3ec86-18bf-4842-852e-e56431c5f547	\N	identity-provider-redirector	c801dbb6-9ca3-4c23-ad63-1946842fef6b	f1e309d5-3c71-4cb8-9f98-0d05cd190041	2	25	f	\N	\N
a84fa995-10ac-4ec7-acf4-302cb66f60ef	\N	\N	c801dbb6-9ca3-4c23-ad63-1946842fef6b	f1e309d5-3c71-4cb8-9f98-0d05cd190041	2	30	t	65745a6b-509c-4a76-83f8-9733df3d9d03	\N
ce3025f6-df06-49ed-b198-8c48b7d872f1	\N	auth-username-password-form	c801dbb6-9ca3-4c23-ad63-1946842fef6b	65745a6b-509c-4a76-83f8-9733df3d9d03	0	10	f	\N	\N
390d7970-4155-4687-9891-18d14ede6123	\N	\N	c801dbb6-9ca3-4c23-ad63-1946842fef6b	65745a6b-509c-4a76-83f8-9733df3d9d03	1	20	t	69b2041f-d264-45c3-986b-bfec7997e5c1	\N
9f8de72f-11fa-45ab-92c9-3bf397cd7ae4	\N	conditional-user-configured	c801dbb6-9ca3-4c23-ad63-1946842fef6b	69b2041f-d264-45c3-986b-bfec7997e5c1	0	10	f	\N	\N
1768ac7e-eb66-4682-a167-2866ff398303	\N	auth-otp-form	c801dbb6-9ca3-4c23-ad63-1946842fef6b	69b2041f-d264-45c3-986b-bfec7997e5c1	0	20	f	\N	\N
d2a9132d-d3e2-456f-bf61-44ede8f3ce77	\N	direct-grant-validate-username	c801dbb6-9ca3-4c23-ad63-1946842fef6b	12c50607-69b9-4641-bb6e-ca0caefde962	0	10	f	\N	\N
3875ad17-2f58-467d-b255-bb47fbb99dd2	\N	direct-grant-validate-password	c801dbb6-9ca3-4c23-ad63-1946842fef6b	12c50607-69b9-4641-bb6e-ca0caefde962	0	20	f	\N	\N
f8469a73-5bb4-4019-a643-8bfcda75b269	\N	\N	c801dbb6-9ca3-4c23-ad63-1946842fef6b	12c50607-69b9-4641-bb6e-ca0caefde962	1	30	t	d0331265-1ca3-44c5-9289-a2e0189160f0	\N
7d26f52c-9512-48aa-9790-05c357e029af	\N	conditional-user-configured	c801dbb6-9ca3-4c23-ad63-1946842fef6b	d0331265-1ca3-44c5-9289-a2e0189160f0	0	10	f	\N	\N
68d4545a-ccfc-4c18-8aef-c6f13ea10090	\N	direct-grant-validate-otp	c801dbb6-9ca3-4c23-ad63-1946842fef6b	d0331265-1ca3-44c5-9289-a2e0189160f0	0	20	f	\N	\N
588dd793-4f7c-4d43-af24-c96ddd2c0bf0	\N	registration-page-form	c801dbb6-9ca3-4c23-ad63-1946842fef6b	e152966d-24d4-42e1-8ada-8e7606ebdbc4	0	10	t	64e4c54a-e5fb-43ac-be67-f7bb83cd2b3b	\N
4da3b06a-148e-406b-b7d1-cf7285298d4f	\N	registration-user-creation	c801dbb6-9ca3-4c23-ad63-1946842fef6b	64e4c54a-e5fb-43ac-be67-f7bb83cd2b3b	0	20	f	\N	\N
59875cae-caff-4ba2-924c-14615b205ee7	\N	registration-profile-action	c801dbb6-9ca3-4c23-ad63-1946842fef6b	64e4c54a-e5fb-43ac-be67-f7bb83cd2b3b	0	40	f	\N	\N
a5f3b925-39be-4d7b-a5a5-f9e31332cfe6	\N	registration-password-action	c801dbb6-9ca3-4c23-ad63-1946842fef6b	64e4c54a-e5fb-43ac-be67-f7bb83cd2b3b	0	50	f	\N	\N
9e881716-3bb7-4ba8-a52c-46e7ca041524	\N	registration-recaptcha-action	c801dbb6-9ca3-4c23-ad63-1946842fef6b	64e4c54a-e5fb-43ac-be67-f7bb83cd2b3b	3	60	f	\N	\N
9cf09aae-730a-4449-b827-6ce81831dca2	\N	reset-credentials-choose-user	c801dbb6-9ca3-4c23-ad63-1946842fef6b	f5e1958d-126b-41cb-acf0-3fadee0634d3	0	10	f	\N	\N
e46b9616-1df8-42f2-8369-a408716d35a1	\N	reset-credential-email	c801dbb6-9ca3-4c23-ad63-1946842fef6b	f5e1958d-126b-41cb-acf0-3fadee0634d3	0	20	f	\N	\N
558001c2-52b7-471d-8155-35f3c6b6c866	\N	reset-password	c801dbb6-9ca3-4c23-ad63-1946842fef6b	f5e1958d-126b-41cb-acf0-3fadee0634d3	0	30	f	\N	\N
a5df530e-785e-4ca7-9ea0-71aad6de24d8	\N	\N	c801dbb6-9ca3-4c23-ad63-1946842fef6b	f5e1958d-126b-41cb-acf0-3fadee0634d3	1	40	t	79e8063b-fea6-47ce-925a-1187be8dc27a	\N
f9432938-db19-4e83-8f75-7901705b34d7	\N	conditional-user-configured	c801dbb6-9ca3-4c23-ad63-1946842fef6b	79e8063b-fea6-47ce-925a-1187be8dc27a	0	10	f	\N	\N
c5de46db-6857-494b-8dee-c7aa459afe2a	\N	reset-otp	c801dbb6-9ca3-4c23-ad63-1946842fef6b	79e8063b-fea6-47ce-925a-1187be8dc27a	0	20	f	\N	\N
940f3c37-7aef-4be5-9d46-3b2d2f71bd4e	\N	client-secret	c801dbb6-9ca3-4c23-ad63-1946842fef6b	e7f727ef-0567-42a4-b1f3-615fdaf1de6c	2	10	f	\N	\N
c433e162-a521-4bdc-9273-747519a647e0	\N	client-jwt	c801dbb6-9ca3-4c23-ad63-1946842fef6b	e7f727ef-0567-42a4-b1f3-615fdaf1de6c	2	20	f	\N	\N
198d54e1-d8ea-4e03-a1e3-4d33b2b32184	\N	client-secret-jwt	c801dbb6-9ca3-4c23-ad63-1946842fef6b	e7f727ef-0567-42a4-b1f3-615fdaf1de6c	2	30	f	\N	\N
21089c59-e822-45b7-a2b4-75f679d3ad12	\N	client-x509	c801dbb6-9ca3-4c23-ad63-1946842fef6b	e7f727ef-0567-42a4-b1f3-615fdaf1de6c	2	40	f	\N	\N
9eaa7058-6876-43c4-b6b2-ace5caa07fda	\N	idp-review-profile	c801dbb6-9ca3-4c23-ad63-1946842fef6b	12b2a51c-f72e-4a12-a183-710c243a7676	0	10	f	\N	754d9862-43cf-4c83-8d86-1783e73955ae
d57a2d35-f5cc-4fdf-b09b-06fd3322a359	\N	\N	c801dbb6-9ca3-4c23-ad63-1946842fef6b	12b2a51c-f72e-4a12-a183-710c243a7676	0	20	t	8d88d488-06af-43b9-bfac-585350b07326	\N
c0f5c89f-e37d-433e-95f6-8a71637d696d	\N	idp-create-user-if-unique	c801dbb6-9ca3-4c23-ad63-1946842fef6b	8d88d488-06af-43b9-bfac-585350b07326	2	10	f	\N	0d1d2ece-b69a-4354-a52f-e6ceccc554f3
8352b622-2122-4029-9bb0-3c5107f303f1	\N	\N	c801dbb6-9ca3-4c23-ad63-1946842fef6b	8d88d488-06af-43b9-bfac-585350b07326	2	20	t	a40108cd-1f11-4c5f-aaf3-c195bb4cc530	\N
471463cc-b51a-4123-a21a-e1ee28d53af2	\N	idp-confirm-link	c801dbb6-9ca3-4c23-ad63-1946842fef6b	a40108cd-1f11-4c5f-aaf3-c195bb4cc530	0	10	f	\N	\N
6c814655-4fa8-4477-8ee5-2c405b9c835d	\N	\N	c801dbb6-9ca3-4c23-ad63-1946842fef6b	a40108cd-1f11-4c5f-aaf3-c195bb4cc530	0	20	t	69907f3d-1862-4165-83b9-c51d97d9510d	\N
7d34585c-0eaf-4d87-86a6-22cc8434d12e	\N	idp-email-verification	c801dbb6-9ca3-4c23-ad63-1946842fef6b	69907f3d-1862-4165-83b9-c51d97d9510d	2	10	f	\N	\N
0ff65209-8476-4ce0-8b49-232b3b1a3d96	\N	\N	c801dbb6-9ca3-4c23-ad63-1946842fef6b	69907f3d-1862-4165-83b9-c51d97d9510d	2	20	t	df25d22a-f160-4c96-9c63-e2a2fab39bc4	\N
9cc57901-11a5-41f3-87f5-3c341bf50f94	\N	idp-username-password-form	c801dbb6-9ca3-4c23-ad63-1946842fef6b	df25d22a-f160-4c96-9c63-e2a2fab39bc4	0	10	f	\N	\N
df963123-969f-4d72-bc27-b328c66929d4	\N	\N	c801dbb6-9ca3-4c23-ad63-1946842fef6b	df25d22a-f160-4c96-9c63-e2a2fab39bc4	1	20	t	52e3c352-5ee5-459e-974e-3335989a29ff	\N
f7cc7efe-dab0-401c-96b5-d7d5e2de8037	\N	conditional-user-configured	c801dbb6-9ca3-4c23-ad63-1946842fef6b	52e3c352-5ee5-459e-974e-3335989a29ff	0	10	f	\N	\N
c5e945ea-2fc1-4206-be52-07cbb2f64c6b	\N	auth-otp-form	c801dbb6-9ca3-4c23-ad63-1946842fef6b	52e3c352-5ee5-459e-974e-3335989a29ff	0	20	f	\N	\N
efbdc0bf-d3f1-48c0-b413-aacde3fcf2c1	\N	http-basic-authenticator	c801dbb6-9ca3-4c23-ad63-1946842fef6b	da71de7a-c1b5-4372-993e-887a5d07c4ac	0	10	f	\N	\N
386b101d-8c80-4be2-ada2-47da2536ddb9	\N	docker-http-basic-authenticator	c801dbb6-9ca3-4c23-ad63-1946842fef6b	5717052e-4d87-492a-8547-212df6178d0f	0	10	f	\N	\N
d96f8d5d-06a1-414d-92b3-e219ca6a675f	\N	no-cookie-redirect	c801dbb6-9ca3-4c23-ad63-1946842fef6b	d9e1a7bb-3f6c-4d5b-bbce-4130c9c62446	0	10	f	\N	\N
b2ea3a9d-0946-4534-b0b5-b703fad0de8a	\N	\N	c801dbb6-9ca3-4c23-ad63-1946842fef6b	d9e1a7bb-3f6c-4d5b-bbce-4130c9c62446	0	20	t	a896ce28-aa7f-4564-b2e8-61932e3948d9	\N
499d681c-1801-414f-99a7-fb5b23ebc9b6	\N	basic-auth	c801dbb6-9ca3-4c23-ad63-1946842fef6b	a896ce28-aa7f-4564-b2e8-61932e3948d9	0	10	f	\N	\N
154793c0-d355-4e5b-b748-a3242ac711e9	\N	basic-auth-otp	c801dbb6-9ca3-4c23-ad63-1946842fef6b	a896ce28-aa7f-4564-b2e8-61932e3948d9	3	20	f	\N	\N
6dbc3b40-9a9e-499c-9014-77418a6ce939	\N	auth-spnego	c801dbb6-9ca3-4c23-ad63-1946842fef6b	a896ce28-aa7f-4564-b2e8-61932e3948d9	3	30	f	\N	\N
3d89e502-cf64-4996-92ac-33c36071d57c	\N	auth-cookie	97c3a519-e834-45b3-aeca-7eb9552a7e49	fb085973-11fe-4281-b99a-830d590400a7	2	10	f	\N	\N
3692aeba-6004-4cae-ac55-48ae796a465d	\N	auth-spnego	97c3a519-e834-45b3-aeca-7eb9552a7e49	fb085973-11fe-4281-b99a-830d590400a7	3	20	f	\N	\N
75f73474-1939-4c36-b166-b307b910d60f	\N	identity-provider-redirector	97c3a519-e834-45b3-aeca-7eb9552a7e49	fb085973-11fe-4281-b99a-830d590400a7	2	25	f	\N	\N
99cca988-c378-4074-8b8f-5ccbec87b02e	\N	\N	97c3a519-e834-45b3-aeca-7eb9552a7e49	fb085973-11fe-4281-b99a-830d590400a7	2	30	t	c44e38fd-b4bf-4d75-a0a5-21144cb9f205	\N
c2db511c-003d-446d-a34d-c2d5b14c7b91	\N	auth-username-password-form	97c3a519-e834-45b3-aeca-7eb9552a7e49	c44e38fd-b4bf-4d75-a0a5-21144cb9f205	0	10	f	\N	\N
13b81181-6415-4a80-9eee-2eaca9afb591	\N	\N	97c3a519-e834-45b3-aeca-7eb9552a7e49	c44e38fd-b4bf-4d75-a0a5-21144cb9f205	1	20	t	00332eb7-c382-4578-be0a-cec6ca506f6d	\N
a2a51570-6be5-43d0-8564-bc4d1f465ef9	\N	conditional-user-configured	97c3a519-e834-45b3-aeca-7eb9552a7e49	00332eb7-c382-4578-be0a-cec6ca506f6d	0	10	f	\N	\N
5898c0f6-9f99-40a8-b9f3-b5240a426177	\N	auth-otp-form	97c3a519-e834-45b3-aeca-7eb9552a7e49	00332eb7-c382-4578-be0a-cec6ca506f6d	0	20	f	\N	\N
28e9e1cc-176c-4a2d-85ea-58c6fe419d69	\N	direct-grant-validate-username	97c3a519-e834-45b3-aeca-7eb9552a7e49	922b8906-98e1-4e42-a2b1-40c2b5a59fa5	0	10	f	\N	\N
1de7c086-9d27-4aa0-8200-469f13e5c873	\N	direct-grant-validate-password	97c3a519-e834-45b3-aeca-7eb9552a7e49	922b8906-98e1-4e42-a2b1-40c2b5a59fa5	0	20	f	\N	\N
142d16b9-7db6-4b0d-ab93-af1e058d0cad	\N	\N	97c3a519-e834-45b3-aeca-7eb9552a7e49	922b8906-98e1-4e42-a2b1-40c2b5a59fa5	1	30	t	3a6621b3-8a44-4ce2-bd5f-2d015514d2b0	\N
b333d0dc-2850-4029-ad33-c934299dc351	\N	conditional-user-configured	97c3a519-e834-45b3-aeca-7eb9552a7e49	3a6621b3-8a44-4ce2-bd5f-2d015514d2b0	0	10	f	\N	\N
ebcb9dfd-8cad-4b30-a9db-1b63a0ef0a44	\N	direct-grant-validate-otp	97c3a519-e834-45b3-aeca-7eb9552a7e49	3a6621b3-8a44-4ce2-bd5f-2d015514d2b0	0	20	f	\N	\N
506f2f1b-30d4-4b5c-8eda-1314d2d7a926	\N	registration-page-form	97c3a519-e834-45b3-aeca-7eb9552a7e49	950c9283-a286-440e-9aa3-7d9875fc1f56	0	10	t	528e9b47-223a-43de-ad0f-efb6ee3024f1	\N
9c82e87f-cbea-4b7b-a80d-b175d4e97f12	\N	registration-user-creation	97c3a519-e834-45b3-aeca-7eb9552a7e49	528e9b47-223a-43de-ad0f-efb6ee3024f1	0	20	f	\N	\N
b684732c-9eb0-4453-b218-1c0debfc6c3f	\N	registration-profile-action	97c3a519-e834-45b3-aeca-7eb9552a7e49	528e9b47-223a-43de-ad0f-efb6ee3024f1	0	40	f	\N	\N
376edeb1-bc97-4604-b639-5a2af70cda0f	\N	registration-password-action	97c3a519-e834-45b3-aeca-7eb9552a7e49	528e9b47-223a-43de-ad0f-efb6ee3024f1	0	50	f	\N	\N
10ab5344-0b4d-4791-a4c2-04b19a75fabe	\N	registration-recaptcha-action	97c3a519-e834-45b3-aeca-7eb9552a7e49	528e9b47-223a-43de-ad0f-efb6ee3024f1	3	60	f	\N	\N
f3a3a1a5-980a-482f-9832-ec079a0c84f0	\N	reset-credentials-choose-user	97c3a519-e834-45b3-aeca-7eb9552a7e49	0052c724-45cb-4d54-83f6-ac139887234f	0	10	f	\N	\N
65c21d19-ed53-42f9-87c2-e668c6e1816a	\N	reset-credential-email	97c3a519-e834-45b3-aeca-7eb9552a7e49	0052c724-45cb-4d54-83f6-ac139887234f	0	20	f	\N	\N
43f2f86d-d00c-4cb7-9526-5e025b49ff0c	\N	reset-password	97c3a519-e834-45b3-aeca-7eb9552a7e49	0052c724-45cb-4d54-83f6-ac139887234f	0	30	f	\N	\N
5b4e8139-9341-408e-b6e3-88a3b906344c	\N	\N	97c3a519-e834-45b3-aeca-7eb9552a7e49	0052c724-45cb-4d54-83f6-ac139887234f	1	40	t	3a4329fc-6b6e-4f8f-adf8-db775463d578	\N
0feac893-272d-4328-b641-7151d798b7fb	\N	conditional-user-configured	97c3a519-e834-45b3-aeca-7eb9552a7e49	3a4329fc-6b6e-4f8f-adf8-db775463d578	0	10	f	\N	\N
078d3a1c-ce3b-4ace-9444-a52b3e0cdb9c	\N	reset-otp	97c3a519-e834-45b3-aeca-7eb9552a7e49	3a4329fc-6b6e-4f8f-adf8-db775463d578	0	20	f	\N	\N
a3f75905-495f-4296-a623-27fc2bd4f91a	\N	client-secret	97c3a519-e834-45b3-aeca-7eb9552a7e49	a6b50ec9-28ad-40af-aea6-cd9c1e0854a8	2	10	f	\N	\N
74a62075-2bec-4289-bc07-a200ad803eac	\N	client-jwt	97c3a519-e834-45b3-aeca-7eb9552a7e49	a6b50ec9-28ad-40af-aea6-cd9c1e0854a8	2	20	f	\N	\N
501576c3-d3b5-4bc0-9860-9251a1728bf3	\N	client-secret-jwt	97c3a519-e834-45b3-aeca-7eb9552a7e49	a6b50ec9-28ad-40af-aea6-cd9c1e0854a8	2	30	f	\N	\N
19abfc90-3450-4dc5-943e-94c4f8f25146	\N	client-x509	97c3a519-e834-45b3-aeca-7eb9552a7e49	a6b50ec9-28ad-40af-aea6-cd9c1e0854a8	2	40	f	\N	\N
09c68617-b01e-4318-ba92-dbec7c51d247	\N	idp-review-profile	97c3a519-e834-45b3-aeca-7eb9552a7e49	9c17439c-af93-40a7-9c3e-ba40856295ff	0	10	f	\N	c7f05bc5-5501-4a8b-b59f-4f3d0b0653d4
3d0d5cd0-8a6d-4f8d-9570-6ba05c7fb9be	\N	\N	97c3a519-e834-45b3-aeca-7eb9552a7e49	9c17439c-af93-40a7-9c3e-ba40856295ff	0	20	t	49c9cf3e-f6cb-430e-96a0-ccc44f31237e	\N
7b233171-632e-46a5-a565-3ac97988d224	\N	idp-create-user-if-unique	97c3a519-e834-45b3-aeca-7eb9552a7e49	49c9cf3e-f6cb-430e-96a0-ccc44f31237e	2	10	f	\N	c166cd27-d116-42f1-95b2-3556905a6737
0af661ba-e1d3-40f9-aa7f-96c6311795d0	\N	\N	97c3a519-e834-45b3-aeca-7eb9552a7e49	49c9cf3e-f6cb-430e-96a0-ccc44f31237e	2	20	t	6b5cecbe-f7d5-4c66-bcd1-634cb0ac4189	\N
7359ae15-ce69-4557-801f-6b8a9044bc71	\N	idp-confirm-link	97c3a519-e834-45b3-aeca-7eb9552a7e49	6b5cecbe-f7d5-4c66-bcd1-634cb0ac4189	0	10	f	\N	\N
967cff8e-43b9-4706-95b5-7953124b6db2	\N	\N	97c3a519-e834-45b3-aeca-7eb9552a7e49	6b5cecbe-f7d5-4c66-bcd1-634cb0ac4189	0	20	t	0ef83ddb-865c-453c-9b23-a3fc0b76ec3c	\N
d707daa8-10f1-4c9b-90ba-9d569591188d	\N	idp-email-verification	97c3a519-e834-45b3-aeca-7eb9552a7e49	0ef83ddb-865c-453c-9b23-a3fc0b76ec3c	2	10	f	\N	\N
1c3c5c0b-0656-4bcd-95df-d9631f6126c6	\N	\N	97c3a519-e834-45b3-aeca-7eb9552a7e49	0ef83ddb-865c-453c-9b23-a3fc0b76ec3c	2	20	t	12584f4f-cf12-49b8-b138-2a03503ab325	\N
c755d61d-03e5-4dbe-9a50-7a8b4f4e6fea	\N	idp-username-password-form	97c3a519-e834-45b3-aeca-7eb9552a7e49	12584f4f-cf12-49b8-b138-2a03503ab325	0	10	f	\N	\N
fae05c04-46dc-4874-ba7e-3b3d866d86a1	\N	\N	97c3a519-e834-45b3-aeca-7eb9552a7e49	12584f4f-cf12-49b8-b138-2a03503ab325	1	20	t	699212da-863c-4f25-83d3-9334bd78c47d	\N
d61359a6-dae1-4a3f-835b-93a5389169eb	\N	conditional-user-configured	97c3a519-e834-45b3-aeca-7eb9552a7e49	699212da-863c-4f25-83d3-9334bd78c47d	0	10	f	\N	\N
b71a599c-0275-4a1c-984b-7a674d517b92	\N	auth-otp-form	97c3a519-e834-45b3-aeca-7eb9552a7e49	699212da-863c-4f25-83d3-9334bd78c47d	0	20	f	\N	\N
4cfe1b4e-6928-4e74-bccf-1e0cbed0e9ca	\N	http-basic-authenticator	97c3a519-e834-45b3-aeca-7eb9552a7e49	f983fb26-2eac-47ca-8cd0-c5b0ef4ee4e3	0	10	f	\N	\N
f2c7521b-1053-4016-94da-eaeed0fa9f4e	\N	docker-http-basic-authenticator	97c3a519-e834-45b3-aeca-7eb9552a7e49	2917b054-52ab-4465-8140-a7e259c3173a	0	10	f	\N	\N
e46ebba5-e23e-479e-9e1c-fd2d335cf751	\N	no-cookie-redirect	97c3a519-e834-45b3-aeca-7eb9552a7e49	e525c821-ea40-4750-870f-b788c03afb05	0	10	f	\N	\N
be2ee87e-cf54-4357-b69b-f1514aeeabeb	\N	\N	97c3a519-e834-45b3-aeca-7eb9552a7e49	e525c821-ea40-4750-870f-b788c03afb05	0	20	t	5656643d-6c25-48f6-9ed4-0ba1f31a9f18	\N
fdaf3ff9-b0e4-47a8-8ca5-cb539432f33b	\N	basic-auth	97c3a519-e834-45b3-aeca-7eb9552a7e49	5656643d-6c25-48f6-9ed4-0ba1f31a9f18	0	10	f	\N	\N
00108d6d-c74e-4d6f-84b9-17188c14d35a	\N	basic-auth-otp	97c3a519-e834-45b3-aeca-7eb9552a7e49	5656643d-6c25-48f6-9ed4-0ba1f31a9f18	3	20	f	\N	\N
b2f6880c-ae62-4636-9ae3-d27e0224d1b3	\N	auth-spnego	97c3a519-e834-45b3-aeca-7eb9552a7e49	5656643d-6c25-48f6-9ed4-0ba1f31a9f18	3	30	f	\N	\N
\.


--
-- Data for Name: authentication_flow; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) FROM stdin;
f1e309d5-3c71-4cb8-9f98-0d05cd190041	browser	browser based authentication	c801dbb6-9ca3-4c23-ad63-1946842fef6b	basic-flow	t	t
65745a6b-509c-4a76-83f8-9733df3d9d03	forms	Username, password, otp and other auth forms.	c801dbb6-9ca3-4c23-ad63-1946842fef6b	basic-flow	f	t
69b2041f-d264-45c3-986b-bfec7997e5c1	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	c801dbb6-9ca3-4c23-ad63-1946842fef6b	basic-flow	f	t
12c50607-69b9-4641-bb6e-ca0caefde962	direct grant	OpenID Connect Resource Owner Grant	c801dbb6-9ca3-4c23-ad63-1946842fef6b	basic-flow	t	t
d0331265-1ca3-44c5-9289-a2e0189160f0	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	c801dbb6-9ca3-4c23-ad63-1946842fef6b	basic-flow	f	t
e152966d-24d4-42e1-8ada-8e7606ebdbc4	registration	registration flow	c801dbb6-9ca3-4c23-ad63-1946842fef6b	basic-flow	t	t
64e4c54a-e5fb-43ac-be67-f7bb83cd2b3b	registration form	registration form	c801dbb6-9ca3-4c23-ad63-1946842fef6b	form-flow	f	t
f5e1958d-126b-41cb-acf0-3fadee0634d3	reset credentials	Reset credentials for a user if they forgot their password or something	c801dbb6-9ca3-4c23-ad63-1946842fef6b	basic-flow	t	t
79e8063b-fea6-47ce-925a-1187be8dc27a	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	c801dbb6-9ca3-4c23-ad63-1946842fef6b	basic-flow	f	t
e7f727ef-0567-42a4-b1f3-615fdaf1de6c	clients	Base authentication for clients	c801dbb6-9ca3-4c23-ad63-1946842fef6b	client-flow	t	t
12b2a51c-f72e-4a12-a183-710c243a7676	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	c801dbb6-9ca3-4c23-ad63-1946842fef6b	basic-flow	t	t
8d88d488-06af-43b9-bfac-585350b07326	User creation or linking	Flow for the existing/non-existing user alternatives	c801dbb6-9ca3-4c23-ad63-1946842fef6b	basic-flow	f	t
a40108cd-1f11-4c5f-aaf3-c195bb4cc530	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	c801dbb6-9ca3-4c23-ad63-1946842fef6b	basic-flow	f	t
69907f3d-1862-4165-83b9-c51d97d9510d	Account verification options	Method with which to verity the existing account	c801dbb6-9ca3-4c23-ad63-1946842fef6b	basic-flow	f	t
df25d22a-f160-4c96-9c63-e2a2fab39bc4	Verify Existing Account by Re-authentication	Reauthentication of existing account	c801dbb6-9ca3-4c23-ad63-1946842fef6b	basic-flow	f	t
52e3c352-5ee5-459e-974e-3335989a29ff	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	c801dbb6-9ca3-4c23-ad63-1946842fef6b	basic-flow	f	t
da71de7a-c1b5-4372-993e-887a5d07c4ac	saml ecp	SAML ECP Profile Authentication Flow	c801dbb6-9ca3-4c23-ad63-1946842fef6b	basic-flow	t	t
5717052e-4d87-492a-8547-212df6178d0f	docker auth	Used by Docker clients to authenticate against the IDP	c801dbb6-9ca3-4c23-ad63-1946842fef6b	basic-flow	t	t
d9e1a7bb-3f6c-4d5b-bbce-4130c9c62446	http challenge	An authentication flow based on challenge-response HTTP Authentication Schemes	c801dbb6-9ca3-4c23-ad63-1946842fef6b	basic-flow	t	t
a896ce28-aa7f-4564-b2e8-61932e3948d9	Authentication Options	Authentication options.	c801dbb6-9ca3-4c23-ad63-1946842fef6b	basic-flow	f	t
fb085973-11fe-4281-b99a-830d590400a7	browser	browser based authentication	97c3a519-e834-45b3-aeca-7eb9552a7e49	basic-flow	t	t
c44e38fd-b4bf-4d75-a0a5-21144cb9f205	forms	Username, password, otp and other auth forms.	97c3a519-e834-45b3-aeca-7eb9552a7e49	basic-flow	f	t
00332eb7-c382-4578-be0a-cec6ca506f6d	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	97c3a519-e834-45b3-aeca-7eb9552a7e49	basic-flow	f	t
922b8906-98e1-4e42-a2b1-40c2b5a59fa5	direct grant	OpenID Connect Resource Owner Grant	97c3a519-e834-45b3-aeca-7eb9552a7e49	basic-flow	t	t
3a6621b3-8a44-4ce2-bd5f-2d015514d2b0	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	97c3a519-e834-45b3-aeca-7eb9552a7e49	basic-flow	f	t
950c9283-a286-440e-9aa3-7d9875fc1f56	registration	registration flow	97c3a519-e834-45b3-aeca-7eb9552a7e49	basic-flow	t	t
528e9b47-223a-43de-ad0f-efb6ee3024f1	registration form	registration form	97c3a519-e834-45b3-aeca-7eb9552a7e49	form-flow	f	t
0052c724-45cb-4d54-83f6-ac139887234f	reset credentials	Reset credentials for a user if they forgot their password or something	97c3a519-e834-45b3-aeca-7eb9552a7e49	basic-flow	t	t
3a4329fc-6b6e-4f8f-adf8-db775463d578	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	97c3a519-e834-45b3-aeca-7eb9552a7e49	basic-flow	f	t
a6b50ec9-28ad-40af-aea6-cd9c1e0854a8	clients	Base authentication for clients	97c3a519-e834-45b3-aeca-7eb9552a7e49	client-flow	t	t
9c17439c-af93-40a7-9c3e-ba40856295ff	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	97c3a519-e834-45b3-aeca-7eb9552a7e49	basic-flow	t	t
49c9cf3e-f6cb-430e-96a0-ccc44f31237e	User creation or linking	Flow for the existing/non-existing user alternatives	97c3a519-e834-45b3-aeca-7eb9552a7e49	basic-flow	f	t
6b5cecbe-f7d5-4c66-bcd1-634cb0ac4189	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	97c3a519-e834-45b3-aeca-7eb9552a7e49	basic-flow	f	t
0ef83ddb-865c-453c-9b23-a3fc0b76ec3c	Account verification options	Method with which to verity the existing account	97c3a519-e834-45b3-aeca-7eb9552a7e49	basic-flow	f	t
12584f4f-cf12-49b8-b138-2a03503ab325	Verify Existing Account by Re-authentication	Reauthentication of existing account	97c3a519-e834-45b3-aeca-7eb9552a7e49	basic-flow	f	t
699212da-863c-4f25-83d3-9334bd78c47d	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	97c3a519-e834-45b3-aeca-7eb9552a7e49	basic-flow	f	t
f983fb26-2eac-47ca-8cd0-c5b0ef4ee4e3	saml ecp	SAML ECP Profile Authentication Flow	97c3a519-e834-45b3-aeca-7eb9552a7e49	basic-flow	t	t
2917b054-52ab-4465-8140-a7e259c3173a	docker auth	Used by Docker clients to authenticate against the IDP	97c3a519-e834-45b3-aeca-7eb9552a7e49	basic-flow	t	t
e525c821-ea40-4750-870f-b788c03afb05	http challenge	An authentication flow based on challenge-response HTTP Authentication Schemes	97c3a519-e834-45b3-aeca-7eb9552a7e49	basic-flow	t	t
5656643d-6c25-48f6-9ed4-0ba1f31a9f18	Authentication Options	Authentication options.	97c3a519-e834-45b3-aeca-7eb9552a7e49	basic-flow	f	t
\.


--
-- Data for Name: authenticator_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authenticator_config (id, alias, realm_id) FROM stdin;
754d9862-43cf-4c83-8d86-1783e73955ae	review profile config	c801dbb6-9ca3-4c23-ad63-1946842fef6b
0d1d2ece-b69a-4354-a52f-e6ceccc554f3	create unique user config	c801dbb6-9ca3-4c23-ad63-1946842fef6b
c7f05bc5-5501-4a8b-b59f-4f3d0b0653d4	review profile config	97c3a519-e834-45b3-aeca-7eb9552a7e49
c166cd27-d116-42f1-95b2-3556905a6737	create unique user config	97c3a519-e834-45b3-aeca-7eb9552a7e49
\.


--
-- Data for Name: authenticator_config_entry; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authenticator_config_entry (authenticator_id, value, name) FROM stdin;
754d9862-43cf-4c83-8d86-1783e73955ae	missing	update.profile.on.first.login
0d1d2ece-b69a-4354-a52f-e6ceccc554f3	false	require.password.update.after.registration
c7f05bc5-5501-4a8b-b59f-4f3d0b0653d4	missing	update.profile.on.first.login
c166cd27-d116-42f1-95b2-3556905a6737	false	require.password.update.after.registration
\.


--
-- Data for Name: broker_link; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.broker_link (identity_provider, storage_provider_id, realm_id, broker_user_id, broker_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) FROM stdin;
a6441220-7d8d-4c25-a07a-db8b6dcaaff0	t	f	master-realm	0	f	\N	\N	t	\N	f	c801dbb6-9ca3-4c23-ad63-1946842fef6b	\N	0	f	f	master Realm	f	client-secret	\N	\N	\N	t	f	f	f
4baf3ada-e710-46b8-9b40-5d1bfeaf4597	t	f	account	0	t	\N	/realms/master/account/	f	\N	f	c801dbb6-9ca3-4c23-ad63-1946842fef6b	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
61c79e81-07a8-4f10-9025-22f887c523ac	t	f	account-console	0	t	\N	/realms/master/account/	f	\N	f	c801dbb6-9ca3-4c23-ad63-1946842fef6b	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
c7d8a24b-00dc-4dd0-8d35-62261ad32f0b	t	f	broker	0	f	\N	\N	t	\N	f	c801dbb6-9ca3-4c23-ad63-1946842fef6b	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
f216da3e-8d34-4377-8579-f848e3b74d43	t	f	security-admin-console	0	t	\N	/admin/master/console/	f	\N	f	c801dbb6-9ca3-4c23-ad63-1946842fef6b	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
46bf0997-0d24-4abb-b634-abe867521f17	t	f	admin-cli	0	t	\N	\N	f	\N	f	c801dbb6-9ca3-4c23-ad63-1946842fef6b	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
7ca1ce99-6a05-4290-b9a9-8070dab16cf0	t	f	omnis-realm	0	f	\N	\N	t	\N	f	c801dbb6-9ca3-4c23-ad63-1946842fef6b	\N	0	f	f	omnis Realm	f	client-secret	\N	\N	\N	t	f	f	f
31a936f1-8990-4ea8-92fd-a1e396039fe6	t	f	realm-management	0	f	\N	\N	t	\N	f	97c3a519-e834-45b3-aeca-7eb9552a7e49	openid-connect	0	f	f	${client_realm-management}	f	client-secret	\N	\N	\N	t	f	f	f
598bff12-62ca-4834-84b9-1c82e941d841	t	f	account	0	t	\N	/realms/omnis/account/	f	\N	f	97c3a519-e834-45b3-aeca-7eb9552a7e49	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
d630f008-dba1-4dfc-a87d-f924946512da	t	f	account-console	0	t	\N	/realms/omnis/account/	f	\N	f	97c3a519-e834-45b3-aeca-7eb9552a7e49	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
b6a04fec-e20e-4053-b116-f51a85d8d931	t	f	broker	0	f	\N	\N	t	\N	f	97c3a519-e834-45b3-aeca-7eb9552a7e49	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
544f2483-84b5-425f-b5fe-5a2a3ab837ee	t	f	security-admin-console	0	t	\N	/admin/omnis/console/	f	\N	f	97c3a519-e834-45b3-aeca-7eb9552a7e49	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
b270cf7c-e6ba-4ddd-9ec0-36f3c20b4b3e	t	f	admin-cli	0	t	\N	\N	f	\N	f	97c3a519-e834-45b3-aeca-7eb9552a7e49	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
053a6fde-90c3-4bca-a2bf-62bca14b8624	t	t	omnis_client	0	f	g8oaKVT3XgbpviaS6bMprPgAodMt2ajd	http://omnis.ca:3000	f		f	97c3a519-e834-45b3-aeca-7eb9552a7e49	openid-connect	-1	t	f		t	client-secret	http://omnis.ca:3000		\N	t	f	t	f
\.


--
-- Data for Name: client_attributes; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_attributes (client_id, value, name) FROM stdin;
4baf3ada-e710-46b8-9b40-5d1bfeaf4597	+	post.logout.redirect.uris
61c79e81-07a8-4f10-9025-22f887c523ac	+	post.logout.redirect.uris
61c79e81-07a8-4f10-9025-22f887c523ac	S256	pkce.code.challenge.method
f216da3e-8d34-4377-8579-f848e3b74d43	+	post.logout.redirect.uris
f216da3e-8d34-4377-8579-f848e3b74d43	S256	pkce.code.challenge.method
598bff12-62ca-4834-84b9-1c82e941d841	+	post.logout.redirect.uris
d630f008-dba1-4dfc-a87d-f924946512da	+	post.logout.redirect.uris
d630f008-dba1-4dfc-a87d-f924946512da	S256	pkce.code.challenge.method
544f2483-84b5-425f-b5fe-5a2a3ab837ee	+	post.logout.redirect.uris
544f2483-84b5-425f-b5fe-5a2a3ab837ee	S256	pkce.code.challenge.method
053a6fde-90c3-4bca-a2bf-62bca14b8624	1683680664	client.secret.creation.time
053a6fde-90c3-4bca-a2bf-62bca14b8624	false	oauth2.device.authorization.grant.enabled
053a6fde-90c3-4bca-a2bf-62bca14b8624	false	oidc.ciba.grant.enabled
053a6fde-90c3-4bca-a2bf-62bca14b8624	true	backchannel.logout.session.required
053a6fde-90c3-4bca-a2bf-62bca14b8624	false	backchannel.logout.revoke.offline.tokens
053a6fde-90c3-4bca-a2bf-62bca14b8624	false	display.on.consent.screen
053a6fde-90c3-4bca-a2bf-62bca14b8624	{}	acr.loa.map
053a6fde-90c3-4bca-a2bf-62bca14b8624	true	use.refresh.tokens
053a6fde-90c3-4bca-a2bf-62bca14b8624	false	client_credentials.use_refresh_token
053a6fde-90c3-4bca-a2bf-62bca14b8624	false	token.response.type.bearer.lower-case
053a6fde-90c3-4bca-a2bf-62bca14b8624	false	tls-client-certificate-bound-access-tokens
053a6fde-90c3-4bca-a2bf-62bca14b8624	false	require.pushed.authorization.requests
053a6fde-90c3-4bca-a2bf-62bca14b8624	true	use.jwks.url
053a6fde-90c3-4bca-a2bf-62bca14b8624	http://omnis.ca:3000/*	post.logout.redirect.uris
\.


--
-- Data for Name: client_auth_flow_bindings; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_auth_flow_bindings (client_id, flow_id, binding_name) FROM stdin;
\.


--
-- Data for Name: client_initial_access; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_initial_access (id, realm_id, "timestamp", expiration, count, remaining_count) FROM stdin;
\.


--
-- Data for Name: client_node_registrations; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_node_registrations (client_id, value, name) FROM stdin;
\.


--
-- Data for Name: client_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_scope (id, name, realm_id, description, protocol) FROM stdin;
714f2e31-4609-453f-9d20-67ad85c3f4b5	offline_access	c801dbb6-9ca3-4c23-ad63-1946842fef6b	OpenID Connect built-in scope: offline_access	openid-connect
f1157cd1-88c9-4021-8aea-704abf0a25eb	role_list	c801dbb6-9ca3-4c23-ad63-1946842fef6b	SAML role list	saml
e5091011-e71b-43e6-9c6d-3dad4b98fab1	profile	c801dbb6-9ca3-4c23-ad63-1946842fef6b	OpenID Connect built-in scope: profile	openid-connect
0a92e094-92c4-4aaa-b8bf-0ba9ab16cf22	email	c801dbb6-9ca3-4c23-ad63-1946842fef6b	OpenID Connect built-in scope: email	openid-connect
f62f49f0-a3fa-4123-b076-246859393cc0	address	c801dbb6-9ca3-4c23-ad63-1946842fef6b	OpenID Connect built-in scope: address	openid-connect
38ab7168-1818-4f79-ad18-e94abb949e84	phone	c801dbb6-9ca3-4c23-ad63-1946842fef6b	OpenID Connect built-in scope: phone	openid-connect
eb4fadf3-e7de-4618-afc3-4f4aa6d0f567	roles	c801dbb6-9ca3-4c23-ad63-1946842fef6b	OpenID Connect scope for add user roles to the access token	openid-connect
6fa0d628-a0d1-4d8f-91ec-d26e39ec74b8	web-origins	c801dbb6-9ca3-4c23-ad63-1946842fef6b	OpenID Connect scope for add allowed web origins to the access token	openid-connect
e9001f98-9a53-407f-a8d1-9cd0cc518afa	microprofile-jwt	c801dbb6-9ca3-4c23-ad63-1946842fef6b	Microprofile - JWT built-in scope	openid-connect
52a9f12f-ee5a-481a-b8ce-67733ccd9578	acr	c801dbb6-9ca3-4c23-ad63-1946842fef6b	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
2c4d73e5-637f-41dd-badd-95a25981f3cd	offline_access	97c3a519-e834-45b3-aeca-7eb9552a7e49	OpenID Connect built-in scope: offline_access	openid-connect
cbfd286a-b181-4b3a-87f5-6bd7bf8fc66c	role_list	97c3a519-e834-45b3-aeca-7eb9552a7e49	SAML role list	saml
d594a42f-9fe9-4fdc-adbe-83af44961325	profile	97c3a519-e834-45b3-aeca-7eb9552a7e49	OpenID Connect built-in scope: profile	openid-connect
cd4d4eae-7a6e-4a8d-85b1-384f2323af5e	email	97c3a519-e834-45b3-aeca-7eb9552a7e49	OpenID Connect built-in scope: email	openid-connect
9949741e-4dff-4b58-9aa3-187fec2b8410	address	97c3a519-e834-45b3-aeca-7eb9552a7e49	OpenID Connect built-in scope: address	openid-connect
1d93e603-29d1-42b4-bc30-899cd8a707da	phone	97c3a519-e834-45b3-aeca-7eb9552a7e49	OpenID Connect built-in scope: phone	openid-connect
de1a4f93-9c77-45eb-a52b-59806e316cf7	roles	97c3a519-e834-45b3-aeca-7eb9552a7e49	OpenID Connect scope for add user roles to the access token	openid-connect
05db5e88-6d9d-43bf-ad99-f2eec3962c60	web-origins	97c3a519-e834-45b3-aeca-7eb9552a7e49	OpenID Connect scope for add allowed web origins to the access token	openid-connect
19283dfb-d711-4819-8a71-f96ccfd51d10	microprofile-jwt	97c3a519-e834-45b3-aeca-7eb9552a7e49	Microprofile - JWT built-in scope	openid-connect
97eca1dc-a2c0-421e-affb-34476bb0f4b9	acr	97c3a519-e834-45b3-aeca-7eb9552a7e49	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
\.


--
-- Data for Name: client_scope_attributes; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_scope_attributes (scope_id, value, name) FROM stdin;
714f2e31-4609-453f-9d20-67ad85c3f4b5	true	display.on.consent.screen
714f2e31-4609-453f-9d20-67ad85c3f4b5	${offlineAccessScopeConsentText}	consent.screen.text
f1157cd1-88c9-4021-8aea-704abf0a25eb	true	display.on.consent.screen
f1157cd1-88c9-4021-8aea-704abf0a25eb	${samlRoleListScopeConsentText}	consent.screen.text
e5091011-e71b-43e6-9c6d-3dad4b98fab1	true	display.on.consent.screen
e5091011-e71b-43e6-9c6d-3dad4b98fab1	${profileScopeConsentText}	consent.screen.text
e5091011-e71b-43e6-9c6d-3dad4b98fab1	true	include.in.token.scope
0a92e094-92c4-4aaa-b8bf-0ba9ab16cf22	true	display.on.consent.screen
0a92e094-92c4-4aaa-b8bf-0ba9ab16cf22	${emailScopeConsentText}	consent.screen.text
0a92e094-92c4-4aaa-b8bf-0ba9ab16cf22	true	include.in.token.scope
f62f49f0-a3fa-4123-b076-246859393cc0	true	display.on.consent.screen
f62f49f0-a3fa-4123-b076-246859393cc0	${addressScopeConsentText}	consent.screen.text
f62f49f0-a3fa-4123-b076-246859393cc0	true	include.in.token.scope
38ab7168-1818-4f79-ad18-e94abb949e84	true	display.on.consent.screen
38ab7168-1818-4f79-ad18-e94abb949e84	${phoneScopeConsentText}	consent.screen.text
38ab7168-1818-4f79-ad18-e94abb949e84	true	include.in.token.scope
eb4fadf3-e7de-4618-afc3-4f4aa6d0f567	true	display.on.consent.screen
eb4fadf3-e7de-4618-afc3-4f4aa6d0f567	${rolesScopeConsentText}	consent.screen.text
eb4fadf3-e7de-4618-afc3-4f4aa6d0f567	false	include.in.token.scope
6fa0d628-a0d1-4d8f-91ec-d26e39ec74b8	false	display.on.consent.screen
6fa0d628-a0d1-4d8f-91ec-d26e39ec74b8		consent.screen.text
6fa0d628-a0d1-4d8f-91ec-d26e39ec74b8	false	include.in.token.scope
e9001f98-9a53-407f-a8d1-9cd0cc518afa	false	display.on.consent.screen
e9001f98-9a53-407f-a8d1-9cd0cc518afa	true	include.in.token.scope
52a9f12f-ee5a-481a-b8ce-67733ccd9578	false	display.on.consent.screen
52a9f12f-ee5a-481a-b8ce-67733ccd9578	false	include.in.token.scope
2c4d73e5-637f-41dd-badd-95a25981f3cd	true	display.on.consent.screen
2c4d73e5-637f-41dd-badd-95a25981f3cd	${offlineAccessScopeConsentText}	consent.screen.text
cbfd286a-b181-4b3a-87f5-6bd7bf8fc66c	true	display.on.consent.screen
cbfd286a-b181-4b3a-87f5-6bd7bf8fc66c	${samlRoleListScopeConsentText}	consent.screen.text
d594a42f-9fe9-4fdc-adbe-83af44961325	true	display.on.consent.screen
d594a42f-9fe9-4fdc-adbe-83af44961325	${profileScopeConsentText}	consent.screen.text
d594a42f-9fe9-4fdc-adbe-83af44961325	true	include.in.token.scope
cd4d4eae-7a6e-4a8d-85b1-384f2323af5e	true	display.on.consent.screen
cd4d4eae-7a6e-4a8d-85b1-384f2323af5e	${emailScopeConsentText}	consent.screen.text
cd4d4eae-7a6e-4a8d-85b1-384f2323af5e	true	include.in.token.scope
9949741e-4dff-4b58-9aa3-187fec2b8410	true	display.on.consent.screen
9949741e-4dff-4b58-9aa3-187fec2b8410	${addressScopeConsentText}	consent.screen.text
9949741e-4dff-4b58-9aa3-187fec2b8410	true	include.in.token.scope
1d93e603-29d1-42b4-bc30-899cd8a707da	true	display.on.consent.screen
1d93e603-29d1-42b4-bc30-899cd8a707da	${phoneScopeConsentText}	consent.screen.text
1d93e603-29d1-42b4-bc30-899cd8a707da	true	include.in.token.scope
de1a4f93-9c77-45eb-a52b-59806e316cf7	true	display.on.consent.screen
de1a4f93-9c77-45eb-a52b-59806e316cf7	${rolesScopeConsentText}	consent.screen.text
de1a4f93-9c77-45eb-a52b-59806e316cf7	false	include.in.token.scope
05db5e88-6d9d-43bf-ad99-f2eec3962c60	false	display.on.consent.screen
05db5e88-6d9d-43bf-ad99-f2eec3962c60		consent.screen.text
05db5e88-6d9d-43bf-ad99-f2eec3962c60	false	include.in.token.scope
19283dfb-d711-4819-8a71-f96ccfd51d10	false	display.on.consent.screen
19283dfb-d711-4819-8a71-f96ccfd51d10	true	include.in.token.scope
97eca1dc-a2c0-421e-affb-34476bb0f4b9	false	display.on.consent.screen
97eca1dc-a2c0-421e-affb-34476bb0f4b9	false	include.in.token.scope
\.


--
-- Data for Name: client_scope_client; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_scope_client (client_id, scope_id, default_scope) FROM stdin;
4baf3ada-e710-46b8-9b40-5d1bfeaf4597	0a92e094-92c4-4aaa-b8bf-0ba9ab16cf22	t
4baf3ada-e710-46b8-9b40-5d1bfeaf4597	6fa0d628-a0d1-4d8f-91ec-d26e39ec74b8	t
4baf3ada-e710-46b8-9b40-5d1bfeaf4597	eb4fadf3-e7de-4618-afc3-4f4aa6d0f567	t
4baf3ada-e710-46b8-9b40-5d1bfeaf4597	e5091011-e71b-43e6-9c6d-3dad4b98fab1	t
4baf3ada-e710-46b8-9b40-5d1bfeaf4597	52a9f12f-ee5a-481a-b8ce-67733ccd9578	t
4baf3ada-e710-46b8-9b40-5d1bfeaf4597	714f2e31-4609-453f-9d20-67ad85c3f4b5	f
4baf3ada-e710-46b8-9b40-5d1bfeaf4597	f62f49f0-a3fa-4123-b076-246859393cc0	f
4baf3ada-e710-46b8-9b40-5d1bfeaf4597	e9001f98-9a53-407f-a8d1-9cd0cc518afa	f
4baf3ada-e710-46b8-9b40-5d1bfeaf4597	38ab7168-1818-4f79-ad18-e94abb949e84	f
61c79e81-07a8-4f10-9025-22f887c523ac	0a92e094-92c4-4aaa-b8bf-0ba9ab16cf22	t
61c79e81-07a8-4f10-9025-22f887c523ac	6fa0d628-a0d1-4d8f-91ec-d26e39ec74b8	t
61c79e81-07a8-4f10-9025-22f887c523ac	eb4fadf3-e7de-4618-afc3-4f4aa6d0f567	t
61c79e81-07a8-4f10-9025-22f887c523ac	e5091011-e71b-43e6-9c6d-3dad4b98fab1	t
61c79e81-07a8-4f10-9025-22f887c523ac	52a9f12f-ee5a-481a-b8ce-67733ccd9578	t
61c79e81-07a8-4f10-9025-22f887c523ac	714f2e31-4609-453f-9d20-67ad85c3f4b5	f
61c79e81-07a8-4f10-9025-22f887c523ac	f62f49f0-a3fa-4123-b076-246859393cc0	f
61c79e81-07a8-4f10-9025-22f887c523ac	e9001f98-9a53-407f-a8d1-9cd0cc518afa	f
61c79e81-07a8-4f10-9025-22f887c523ac	38ab7168-1818-4f79-ad18-e94abb949e84	f
46bf0997-0d24-4abb-b634-abe867521f17	0a92e094-92c4-4aaa-b8bf-0ba9ab16cf22	t
46bf0997-0d24-4abb-b634-abe867521f17	6fa0d628-a0d1-4d8f-91ec-d26e39ec74b8	t
46bf0997-0d24-4abb-b634-abe867521f17	eb4fadf3-e7de-4618-afc3-4f4aa6d0f567	t
46bf0997-0d24-4abb-b634-abe867521f17	e5091011-e71b-43e6-9c6d-3dad4b98fab1	t
46bf0997-0d24-4abb-b634-abe867521f17	52a9f12f-ee5a-481a-b8ce-67733ccd9578	t
46bf0997-0d24-4abb-b634-abe867521f17	714f2e31-4609-453f-9d20-67ad85c3f4b5	f
46bf0997-0d24-4abb-b634-abe867521f17	f62f49f0-a3fa-4123-b076-246859393cc0	f
46bf0997-0d24-4abb-b634-abe867521f17	e9001f98-9a53-407f-a8d1-9cd0cc518afa	f
46bf0997-0d24-4abb-b634-abe867521f17	38ab7168-1818-4f79-ad18-e94abb949e84	f
c7d8a24b-00dc-4dd0-8d35-62261ad32f0b	0a92e094-92c4-4aaa-b8bf-0ba9ab16cf22	t
c7d8a24b-00dc-4dd0-8d35-62261ad32f0b	6fa0d628-a0d1-4d8f-91ec-d26e39ec74b8	t
c7d8a24b-00dc-4dd0-8d35-62261ad32f0b	eb4fadf3-e7de-4618-afc3-4f4aa6d0f567	t
c7d8a24b-00dc-4dd0-8d35-62261ad32f0b	e5091011-e71b-43e6-9c6d-3dad4b98fab1	t
c7d8a24b-00dc-4dd0-8d35-62261ad32f0b	52a9f12f-ee5a-481a-b8ce-67733ccd9578	t
c7d8a24b-00dc-4dd0-8d35-62261ad32f0b	714f2e31-4609-453f-9d20-67ad85c3f4b5	f
c7d8a24b-00dc-4dd0-8d35-62261ad32f0b	f62f49f0-a3fa-4123-b076-246859393cc0	f
c7d8a24b-00dc-4dd0-8d35-62261ad32f0b	e9001f98-9a53-407f-a8d1-9cd0cc518afa	f
c7d8a24b-00dc-4dd0-8d35-62261ad32f0b	38ab7168-1818-4f79-ad18-e94abb949e84	f
a6441220-7d8d-4c25-a07a-db8b6dcaaff0	0a92e094-92c4-4aaa-b8bf-0ba9ab16cf22	t
a6441220-7d8d-4c25-a07a-db8b6dcaaff0	6fa0d628-a0d1-4d8f-91ec-d26e39ec74b8	t
a6441220-7d8d-4c25-a07a-db8b6dcaaff0	eb4fadf3-e7de-4618-afc3-4f4aa6d0f567	t
a6441220-7d8d-4c25-a07a-db8b6dcaaff0	e5091011-e71b-43e6-9c6d-3dad4b98fab1	t
a6441220-7d8d-4c25-a07a-db8b6dcaaff0	52a9f12f-ee5a-481a-b8ce-67733ccd9578	t
a6441220-7d8d-4c25-a07a-db8b6dcaaff0	714f2e31-4609-453f-9d20-67ad85c3f4b5	f
a6441220-7d8d-4c25-a07a-db8b6dcaaff0	f62f49f0-a3fa-4123-b076-246859393cc0	f
a6441220-7d8d-4c25-a07a-db8b6dcaaff0	e9001f98-9a53-407f-a8d1-9cd0cc518afa	f
a6441220-7d8d-4c25-a07a-db8b6dcaaff0	38ab7168-1818-4f79-ad18-e94abb949e84	f
f216da3e-8d34-4377-8579-f848e3b74d43	0a92e094-92c4-4aaa-b8bf-0ba9ab16cf22	t
f216da3e-8d34-4377-8579-f848e3b74d43	6fa0d628-a0d1-4d8f-91ec-d26e39ec74b8	t
f216da3e-8d34-4377-8579-f848e3b74d43	eb4fadf3-e7de-4618-afc3-4f4aa6d0f567	t
f216da3e-8d34-4377-8579-f848e3b74d43	e5091011-e71b-43e6-9c6d-3dad4b98fab1	t
f216da3e-8d34-4377-8579-f848e3b74d43	52a9f12f-ee5a-481a-b8ce-67733ccd9578	t
f216da3e-8d34-4377-8579-f848e3b74d43	714f2e31-4609-453f-9d20-67ad85c3f4b5	f
f216da3e-8d34-4377-8579-f848e3b74d43	f62f49f0-a3fa-4123-b076-246859393cc0	f
f216da3e-8d34-4377-8579-f848e3b74d43	e9001f98-9a53-407f-a8d1-9cd0cc518afa	f
f216da3e-8d34-4377-8579-f848e3b74d43	38ab7168-1818-4f79-ad18-e94abb949e84	f
598bff12-62ca-4834-84b9-1c82e941d841	05db5e88-6d9d-43bf-ad99-f2eec3962c60	t
598bff12-62ca-4834-84b9-1c82e941d841	97eca1dc-a2c0-421e-affb-34476bb0f4b9	t
598bff12-62ca-4834-84b9-1c82e941d841	d594a42f-9fe9-4fdc-adbe-83af44961325	t
598bff12-62ca-4834-84b9-1c82e941d841	de1a4f93-9c77-45eb-a52b-59806e316cf7	t
598bff12-62ca-4834-84b9-1c82e941d841	cd4d4eae-7a6e-4a8d-85b1-384f2323af5e	t
598bff12-62ca-4834-84b9-1c82e941d841	19283dfb-d711-4819-8a71-f96ccfd51d10	f
598bff12-62ca-4834-84b9-1c82e941d841	1d93e603-29d1-42b4-bc30-899cd8a707da	f
598bff12-62ca-4834-84b9-1c82e941d841	9949741e-4dff-4b58-9aa3-187fec2b8410	f
598bff12-62ca-4834-84b9-1c82e941d841	2c4d73e5-637f-41dd-badd-95a25981f3cd	f
d630f008-dba1-4dfc-a87d-f924946512da	05db5e88-6d9d-43bf-ad99-f2eec3962c60	t
d630f008-dba1-4dfc-a87d-f924946512da	97eca1dc-a2c0-421e-affb-34476bb0f4b9	t
d630f008-dba1-4dfc-a87d-f924946512da	d594a42f-9fe9-4fdc-adbe-83af44961325	t
d630f008-dba1-4dfc-a87d-f924946512da	de1a4f93-9c77-45eb-a52b-59806e316cf7	t
d630f008-dba1-4dfc-a87d-f924946512da	cd4d4eae-7a6e-4a8d-85b1-384f2323af5e	t
d630f008-dba1-4dfc-a87d-f924946512da	19283dfb-d711-4819-8a71-f96ccfd51d10	f
d630f008-dba1-4dfc-a87d-f924946512da	1d93e603-29d1-42b4-bc30-899cd8a707da	f
d630f008-dba1-4dfc-a87d-f924946512da	9949741e-4dff-4b58-9aa3-187fec2b8410	f
d630f008-dba1-4dfc-a87d-f924946512da	2c4d73e5-637f-41dd-badd-95a25981f3cd	f
b270cf7c-e6ba-4ddd-9ec0-36f3c20b4b3e	05db5e88-6d9d-43bf-ad99-f2eec3962c60	t
b270cf7c-e6ba-4ddd-9ec0-36f3c20b4b3e	97eca1dc-a2c0-421e-affb-34476bb0f4b9	t
b270cf7c-e6ba-4ddd-9ec0-36f3c20b4b3e	d594a42f-9fe9-4fdc-adbe-83af44961325	t
b270cf7c-e6ba-4ddd-9ec0-36f3c20b4b3e	de1a4f93-9c77-45eb-a52b-59806e316cf7	t
b270cf7c-e6ba-4ddd-9ec0-36f3c20b4b3e	cd4d4eae-7a6e-4a8d-85b1-384f2323af5e	t
b270cf7c-e6ba-4ddd-9ec0-36f3c20b4b3e	19283dfb-d711-4819-8a71-f96ccfd51d10	f
b270cf7c-e6ba-4ddd-9ec0-36f3c20b4b3e	1d93e603-29d1-42b4-bc30-899cd8a707da	f
b270cf7c-e6ba-4ddd-9ec0-36f3c20b4b3e	9949741e-4dff-4b58-9aa3-187fec2b8410	f
b270cf7c-e6ba-4ddd-9ec0-36f3c20b4b3e	2c4d73e5-637f-41dd-badd-95a25981f3cd	f
b6a04fec-e20e-4053-b116-f51a85d8d931	05db5e88-6d9d-43bf-ad99-f2eec3962c60	t
b6a04fec-e20e-4053-b116-f51a85d8d931	97eca1dc-a2c0-421e-affb-34476bb0f4b9	t
b6a04fec-e20e-4053-b116-f51a85d8d931	d594a42f-9fe9-4fdc-adbe-83af44961325	t
b6a04fec-e20e-4053-b116-f51a85d8d931	de1a4f93-9c77-45eb-a52b-59806e316cf7	t
b6a04fec-e20e-4053-b116-f51a85d8d931	cd4d4eae-7a6e-4a8d-85b1-384f2323af5e	t
b6a04fec-e20e-4053-b116-f51a85d8d931	19283dfb-d711-4819-8a71-f96ccfd51d10	f
b6a04fec-e20e-4053-b116-f51a85d8d931	1d93e603-29d1-42b4-bc30-899cd8a707da	f
b6a04fec-e20e-4053-b116-f51a85d8d931	9949741e-4dff-4b58-9aa3-187fec2b8410	f
b6a04fec-e20e-4053-b116-f51a85d8d931	2c4d73e5-637f-41dd-badd-95a25981f3cd	f
31a936f1-8990-4ea8-92fd-a1e396039fe6	05db5e88-6d9d-43bf-ad99-f2eec3962c60	t
31a936f1-8990-4ea8-92fd-a1e396039fe6	97eca1dc-a2c0-421e-affb-34476bb0f4b9	t
31a936f1-8990-4ea8-92fd-a1e396039fe6	d594a42f-9fe9-4fdc-adbe-83af44961325	t
31a936f1-8990-4ea8-92fd-a1e396039fe6	de1a4f93-9c77-45eb-a52b-59806e316cf7	t
31a936f1-8990-4ea8-92fd-a1e396039fe6	cd4d4eae-7a6e-4a8d-85b1-384f2323af5e	t
31a936f1-8990-4ea8-92fd-a1e396039fe6	19283dfb-d711-4819-8a71-f96ccfd51d10	f
31a936f1-8990-4ea8-92fd-a1e396039fe6	1d93e603-29d1-42b4-bc30-899cd8a707da	f
31a936f1-8990-4ea8-92fd-a1e396039fe6	9949741e-4dff-4b58-9aa3-187fec2b8410	f
31a936f1-8990-4ea8-92fd-a1e396039fe6	2c4d73e5-637f-41dd-badd-95a25981f3cd	f
544f2483-84b5-425f-b5fe-5a2a3ab837ee	05db5e88-6d9d-43bf-ad99-f2eec3962c60	t
544f2483-84b5-425f-b5fe-5a2a3ab837ee	97eca1dc-a2c0-421e-affb-34476bb0f4b9	t
544f2483-84b5-425f-b5fe-5a2a3ab837ee	d594a42f-9fe9-4fdc-adbe-83af44961325	t
544f2483-84b5-425f-b5fe-5a2a3ab837ee	de1a4f93-9c77-45eb-a52b-59806e316cf7	t
544f2483-84b5-425f-b5fe-5a2a3ab837ee	cd4d4eae-7a6e-4a8d-85b1-384f2323af5e	t
544f2483-84b5-425f-b5fe-5a2a3ab837ee	19283dfb-d711-4819-8a71-f96ccfd51d10	f
544f2483-84b5-425f-b5fe-5a2a3ab837ee	1d93e603-29d1-42b4-bc30-899cd8a707da	f
544f2483-84b5-425f-b5fe-5a2a3ab837ee	9949741e-4dff-4b58-9aa3-187fec2b8410	f
544f2483-84b5-425f-b5fe-5a2a3ab837ee	2c4d73e5-637f-41dd-badd-95a25981f3cd	f
053a6fde-90c3-4bca-a2bf-62bca14b8624	05db5e88-6d9d-43bf-ad99-f2eec3962c60	t
053a6fde-90c3-4bca-a2bf-62bca14b8624	97eca1dc-a2c0-421e-affb-34476bb0f4b9	t
053a6fde-90c3-4bca-a2bf-62bca14b8624	d594a42f-9fe9-4fdc-adbe-83af44961325	t
053a6fde-90c3-4bca-a2bf-62bca14b8624	de1a4f93-9c77-45eb-a52b-59806e316cf7	t
053a6fde-90c3-4bca-a2bf-62bca14b8624	cd4d4eae-7a6e-4a8d-85b1-384f2323af5e	t
053a6fde-90c3-4bca-a2bf-62bca14b8624	19283dfb-d711-4819-8a71-f96ccfd51d10	f
053a6fde-90c3-4bca-a2bf-62bca14b8624	1d93e603-29d1-42b4-bc30-899cd8a707da	f
053a6fde-90c3-4bca-a2bf-62bca14b8624	9949741e-4dff-4b58-9aa3-187fec2b8410	f
053a6fde-90c3-4bca-a2bf-62bca14b8624	2c4d73e5-637f-41dd-badd-95a25981f3cd	f
\.


--
-- Data for Name: client_scope_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_scope_role_mapping (scope_id, role_id) FROM stdin;
714f2e31-4609-453f-9d20-67ad85c3f4b5	bc76a878-37e1-4168-9752-5b8c05226275
2c4d73e5-637f-41dd-badd-95a25981f3cd	42526fc0-ed41-411f-b6fc-8a74214604cc
\.


--
-- Data for Name: client_session; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_session (id, client_id, redirect_uri, state, "timestamp", session_id, auth_method, realm_id, auth_user_id, current_action) FROM stdin;
\.


--
-- Data for Name: client_session_auth_status; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_session_auth_status (authenticator, status, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_note; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_prot_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_session_prot_mapper (protocol_mapper_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_role; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_session_role (role_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_user_session_note; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_user_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: component; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) FROM stdin;
764f46fe-64cd-4c7a-a903-630efaf583b7	Trusted Hosts	c801dbb6-9ca3-4c23-ad63-1946842fef6b	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	c801dbb6-9ca3-4c23-ad63-1946842fef6b	anonymous
e5ab36a6-7bcd-401b-b6c6-08a74d59e1c9	Consent Required	c801dbb6-9ca3-4c23-ad63-1946842fef6b	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	c801dbb6-9ca3-4c23-ad63-1946842fef6b	anonymous
9cdc27dc-4613-4e02-852c-edb46340ef31	Full Scope Disabled	c801dbb6-9ca3-4c23-ad63-1946842fef6b	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	c801dbb6-9ca3-4c23-ad63-1946842fef6b	anonymous
3d5cce69-ee28-4e5d-bfb3-face78db5de3	Max Clients Limit	c801dbb6-9ca3-4c23-ad63-1946842fef6b	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	c801dbb6-9ca3-4c23-ad63-1946842fef6b	anonymous
0b141ca2-5143-4852-9f27-ddc5560ec81f	Allowed Protocol Mapper Types	c801dbb6-9ca3-4c23-ad63-1946842fef6b	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	c801dbb6-9ca3-4c23-ad63-1946842fef6b	anonymous
eb8df667-1a5a-4c0a-b964-0fec50f7c331	Allowed Client Scopes	c801dbb6-9ca3-4c23-ad63-1946842fef6b	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	c801dbb6-9ca3-4c23-ad63-1946842fef6b	anonymous
5f3be08e-8f82-4c97-9e11-197130ae4284	Allowed Protocol Mapper Types	c801dbb6-9ca3-4c23-ad63-1946842fef6b	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	c801dbb6-9ca3-4c23-ad63-1946842fef6b	authenticated
ccbadc08-a1d7-4623-8d07-4d12e2c504da	Allowed Client Scopes	c801dbb6-9ca3-4c23-ad63-1946842fef6b	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	c801dbb6-9ca3-4c23-ad63-1946842fef6b	authenticated
ee29ad9b-dbe5-4ce2-b022-720ce2377fc4	rsa-generated	c801dbb6-9ca3-4c23-ad63-1946842fef6b	rsa-generated	org.keycloak.keys.KeyProvider	c801dbb6-9ca3-4c23-ad63-1946842fef6b	\N
b9144019-4a3e-4b5f-989a-509004d25ed3	rsa-enc-generated	c801dbb6-9ca3-4c23-ad63-1946842fef6b	rsa-enc-generated	org.keycloak.keys.KeyProvider	c801dbb6-9ca3-4c23-ad63-1946842fef6b	\N
e2dfd255-b7bb-43f0-8663-2ec1ce388bd0	hmac-generated	c801dbb6-9ca3-4c23-ad63-1946842fef6b	hmac-generated	org.keycloak.keys.KeyProvider	c801dbb6-9ca3-4c23-ad63-1946842fef6b	\N
7875cc29-1597-4413-a8b8-74f6f7a4ba58	aes-generated	c801dbb6-9ca3-4c23-ad63-1946842fef6b	aes-generated	org.keycloak.keys.KeyProvider	c801dbb6-9ca3-4c23-ad63-1946842fef6b	\N
e226afd0-488a-4f24-82e7-a583505b9306	rsa-generated	97c3a519-e834-45b3-aeca-7eb9552a7e49	rsa-generated	org.keycloak.keys.KeyProvider	97c3a519-e834-45b3-aeca-7eb9552a7e49	\N
e6a8b2ef-6dd2-41c0-a945-f22d50b4280a	rsa-enc-generated	97c3a519-e834-45b3-aeca-7eb9552a7e49	rsa-enc-generated	org.keycloak.keys.KeyProvider	97c3a519-e834-45b3-aeca-7eb9552a7e49	\N
a7e3b012-a78d-4551-ba39-10d39c1ea028	hmac-generated	97c3a519-e834-45b3-aeca-7eb9552a7e49	hmac-generated	org.keycloak.keys.KeyProvider	97c3a519-e834-45b3-aeca-7eb9552a7e49	\N
a2b52d45-6880-4323-9842-be6f28e0f033	aes-generated	97c3a519-e834-45b3-aeca-7eb9552a7e49	aes-generated	org.keycloak.keys.KeyProvider	97c3a519-e834-45b3-aeca-7eb9552a7e49	\N
3e513626-4559-4d26-bbb6-438405f18317	Trusted Hosts	97c3a519-e834-45b3-aeca-7eb9552a7e49	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	97c3a519-e834-45b3-aeca-7eb9552a7e49	anonymous
000003dd-c546-4cc3-a93f-ea841a3fae0b	Consent Required	97c3a519-e834-45b3-aeca-7eb9552a7e49	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	97c3a519-e834-45b3-aeca-7eb9552a7e49	anonymous
8970087a-8a31-4fa5-ab1e-cb40d4a4290c	Full Scope Disabled	97c3a519-e834-45b3-aeca-7eb9552a7e49	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	97c3a519-e834-45b3-aeca-7eb9552a7e49	anonymous
a86eadab-630c-4156-8dd6-fed71cec27bb	Max Clients Limit	97c3a519-e834-45b3-aeca-7eb9552a7e49	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	97c3a519-e834-45b3-aeca-7eb9552a7e49	anonymous
fb7e96db-c69e-41e3-b6f0-fa171d76a8d8	Allowed Protocol Mapper Types	97c3a519-e834-45b3-aeca-7eb9552a7e49	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	97c3a519-e834-45b3-aeca-7eb9552a7e49	anonymous
360308b8-22c2-4aa2-abaa-2d6422673ec9	Allowed Client Scopes	97c3a519-e834-45b3-aeca-7eb9552a7e49	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	97c3a519-e834-45b3-aeca-7eb9552a7e49	anonymous
6f7cc781-792a-464c-b6f3-705f84891582	Allowed Protocol Mapper Types	97c3a519-e834-45b3-aeca-7eb9552a7e49	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	97c3a519-e834-45b3-aeca-7eb9552a7e49	authenticated
7e953725-f70c-424b-83a1-06a55ed28904	Allowed Client Scopes	97c3a519-e834-45b3-aeca-7eb9552a7e49	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	97c3a519-e834-45b3-aeca-7eb9552a7e49	authenticated
c13b027c-2122-4ec1-854d-acbf7a434b22	\N	97c3a519-e834-45b3-aeca-7eb9552a7e49	declarative-user-profile	org.keycloak.userprofile.UserProfileProvider	97c3a519-e834-45b3-aeca-7eb9552a7e49	\N
7d88d1a3-079c-446e-97b1-9f7ceff2f905	\N	c801dbb6-9ca3-4c23-ad63-1946842fef6b	declarative-user-profile	org.keycloak.userprofile.UserProfileProvider	c801dbb6-9ca3-4c23-ad63-1946842fef6b	\N
\.


--
-- Data for Name: component_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.component_config (id, component_id, name, value) FROM stdin;
f12086cd-f0db-4e2c-872f-41625d47e221	764f46fe-64cd-4c7a-a903-630efaf583b7	host-sending-registration-request-must-match	true
9085ef3e-e76c-4b46-878a-b8f248445b64	764f46fe-64cd-4c7a-a903-630efaf583b7	client-uris-must-match	true
e37c0d59-34a6-43b8-a932-0323b968c62b	eb8df667-1a5a-4c0a-b964-0fec50f7c331	allow-default-scopes	true
fbf89b6e-cf0d-49d4-88c3-c03a109c7010	3d5cce69-ee28-4e5d-bfb3-face78db5de3	max-clients	200
a640598c-bb65-4e37-858b-2d6fa9771c61	0b141ca2-5143-4852-9f27-ddc5560ec81f	allowed-protocol-mapper-types	saml-user-attribute-mapper
a6d209da-fde0-4d98-901d-64de9b75817f	0b141ca2-5143-4852-9f27-ddc5560ec81f	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
09687a3e-454e-4b9b-b114-1fd57fdded33	0b141ca2-5143-4852-9f27-ddc5560ec81f	allowed-protocol-mapper-types	saml-user-property-mapper
ea53c6f6-47c3-4222-870a-d5c3045fa485	0b141ca2-5143-4852-9f27-ddc5560ec81f	allowed-protocol-mapper-types	saml-role-list-mapper
cfe7bbf8-520e-4491-b911-88d20475944d	0b141ca2-5143-4852-9f27-ddc5560ec81f	allowed-protocol-mapper-types	oidc-address-mapper
3238c599-5edc-47c9-9d9c-afc627074993	0b141ca2-5143-4852-9f27-ddc5560ec81f	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
16b9be2c-c6b1-417e-b8c4-c43fb7af7946	0b141ca2-5143-4852-9f27-ddc5560ec81f	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
18512af6-b9da-4505-9289-d85a7b8973dd	0b141ca2-5143-4852-9f27-ddc5560ec81f	allowed-protocol-mapper-types	oidc-full-name-mapper
5f538124-151c-49cf-a052-6ecdf46b86c3	5f3be08e-8f82-4c97-9e11-197130ae4284	allowed-protocol-mapper-types	saml-user-attribute-mapper
bb26683d-e267-4470-813a-b0d0bde40ce5	5f3be08e-8f82-4c97-9e11-197130ae4284	allowed-protocol-mapper-types	oidc-full-name-mapper
2e29063f-b74b-463d-b450-e6c5e43583f7	5f3be08e-8f82-4c97-9e11-197130ae4284	allowed-protocol-mapper-types	oidc-address-mapper
34c76f84-cab0-4b56-b7ea-f4816532af6a	5f3be08e-8f82-4c97-9e11-197130ae4284	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
1a3bf208-9667-4cf5-85db-27fd4bcffea1	5f3be08e-8f82-4c97-9e11-197130ae4284	allowed-protocol-mapper-types	saml-role-list-mapper
d0b389c0-33cc-4137-98c9-9b37e5318f75	5f3be08e-8f82-4c97-9e11-197130ae4284	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
1d07c893-bcff-4bc2-ab40-55b78766438d	5f3be08e-8f82-4c97-9e11-197130ae4284	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
d22ecf76-47df-42c5-9a7c-8458f2121c46	5f3be08e-8f82-4c97-9e11-197130ae4284	allowed-protocol-mapper-types	saml-user-property-mapper
fba460cb-3cc7-425e-8930-4105207d0edb	ccbadc08-a1d7-4623-8d07-4d12e2c504da	allow-default-scopes	true
aa12485d-ab6a-497b-a0ba-eb4213c490fd	ee29ad9b-dbe5-4ce2-b022-720ce2377fc4	privateKey	MIIEpAIBAAKCAQEAvTgQoQPjbQFnRRRVZ0LpiJ+m8iP7dvvoIBK8mnl0aArYIXwK/1c9xS8xIBkEcCQ6zTQnjRKrHD4T2AbFK9OD8WwBezz4iQtYc9irPTNx7wKnbKXn2hkfSPjyvo7EmA0PK6r+2I6Vg0WHaMtKfJk/laDR+1bhTkEhw2IZhBW15TIY7PJkCYAhIUwiDxHV00nsrLihlYjX5IabfCIrFkQyI1acaCzVDTfdpqQNpAmb0QSWEzombkayQdN86A1E6BdQPUtR41+Y650EunejFbwZ0PoEWM1+9n3WTvp8bNVAdWKRoKxqP4f4kKMyMFRVMLi2TdC1ILjP4XdlyCO/9Wp4CQIDAQABAoIBABHecouSH28S29rFMc9/nSg+03g4d63j2ib1PgRkhd6xb3myCiPU7EtrynragfXJJhhs3XNQGQKgxiT3drVN0z8AUR9/QYVHogHGq10rN443tPHotP1+s9qjT+E5AE3PpegczNZMmMf9z+zQjec4Xa3Wsx3GNZ67PeICqKA1oKjVKb2T+5YcoylixkvDmzpWnDgioLQHKvXUz+pWZrEnTwazOQwuUkonxa0dwdzl32qlyoB/RLYcJqnMeVB8KkC7DUAgf83sMKhT4UVcwQmphf05DPwOVknFDQXDEpwGtG3s0KELHvFD5Wb3H1NJwDaMvU7TJLO0oUEWZcv3m2wvQdECgYEA3RZZcxN4N6XIsNQQtuEVgD6lEO40qDzGorDFH6wr7zIyoRpKofHr2qkALWAxIcjj+Q1nJuzC8yUUfuPJbqJUfpBhpgQfP1EKYzemFOwW3yrf2xabqnHcwIwvQNVSRyP/tRs14zPI/XfUyENPB3J2nyybEYbbYClyqAm6zJkMAg0CgYEA2xlpSJDDZwU3Q3W+sOvCPJUr5MKiXTJefPH7699Ryn2PX04TPM6wU112QLK2FyalLYkfQ53FkMl5qXiPVixkeB2ZDmyh/Fk8vC46j60I44GI90lrhK6EQ1n5a7GZX8qHxrqAaf4aSMifKhWtl4YL/hTSt3Y8st0i29drFd3kWu0CgYEAzrIxaKPgNe55xdBN3BxtdJucyUpa0psXfkzTzruxy4xbx0CEXAmIXsK31rRi2totQM/mC384+AdHtSYTUarUYgtsL8EU0aZbls0VKeRbscMszHDDkkOnhiDJoMyPgtFGJLTO2Z61nztkJOLAxQ6flksmouk4uhumBTIrgVLo5hUCgYAEeR5XJu12Wvrn262K+yU6C2mcAAVEldSsBFy6UhLfaXTV40gtQ6MB8LSLWZqyGk3hAh2rSbtQ22wqc5WpkrpyYVhQnRMpjcDZrq/vYv79dhWPxuX1DYMRxPJ8qmGRPRdMjV41y8RJnB7zwwGKSGhSRaaPrFBM7orZpio/hgo1eQKBgQCbodzMsxpFscB/E9qcy4YgkwI34t+vy6D/F0atm1M7xcEsC89ebfqVo5Qd2MnWClOoJfZJ4JoYvLDdQEhMx6Bs8e9COWP3WLElvN/b7JCzyDS1kwHjcR10Zxvg5K8C4wuCDdM4M52N7uBpGTfoR385HVEjAxSlTm4c60ngRTYEUg==
ae8afa9d-9b33-4522-b932-cd72fba5bc69	ee29ad9b-dbe5-4ce2-b022-720ce2377fc4	priority	100
699f475c-ef0b-435f-b60a-83ce5e530997	ee29ad9b-dbe5-4ce2-b022-720ce2377fc4	keyUse	SIG
bb45eab9-ba26-47f5-b25c-c477d20d4aa6	ee29ad9b-dbe5-4ce2-b022-720ce2377fc4	certificate	MIICmzCCAYMCBgGH+7fVyDANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjMwNTA4MTQxNDAxWhcNMzMwNTA4MTQxNTQxWjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC9OBChA+NtAWdFFFVnQumIn6byI/t2++ggEryaeXRoCtghfAr/Vz3FLzEgGQRwJDrNNCeNEqscPhPYBsUr04PxbAF7PPiJC1hz2Ks9M3HvAqdspefaGR9I+PK+jsSYDQ8rqv7YjpWDRYdoy0p8mT+VoNH7VuFOQSHDYhmEFbXlMhjs8mQJgCEhTCIPEdXTSeysuKGViNfkhpt8IisWRDIjVpxoLNUNN92mpA2kCZvRBJYTOiZuRrJB03zoDUToF1A9S1HjX5jrnQS6d6MVvBnQ+gRYzX72fdZO+nxs1UB1YpGgrGo/h/iQozIwVFUwuLZN0LUguM/hd2XII7/1angJAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAEu7z59Pc28Jaa00YbZAo+7g12r5dL9/IByZKGVhEJv8lKw3KK+yLydMacQDhKdqTOPWdhcZY1J+rcTPsnPm8pNV9Wx9gOBJ5k9F0SLizV0SbtKT/lrsmYo2YYee/lcP2pparBh1fuOm1fYZvcuUcPeovd+zyDcXk43Qo+ly4OEyS63BAAM5VwCKutMzRU4Kf0gLvvOud5OF3xqKK+CfsG5/A6korPK5e9nSXVdYu3E14TdyZzoRQXtKSsFswhR2dsK45wOlA+/64lCBmwGO1ZdlQRhxRY+U2COaJVEQIri+Ev9oEjJnoOj2Nmwh50v+10NJ4EkSYQFyMfoi45JSycY=
9b9e59f8-09d8-4dbd-81c5-ab74b529c9b3	7875cc29-1597-4413-a8b8-74f6f7a4ba58	secret	66FIcgoRm_uax0pcTe9fbA
7f0f4160-c2e8-46e3-9878-9230cbe20c9f	7875cc29-1597-4413-a8b8-74f6f7a4ba58	kid	a57ea1dd-a775-46a1-864e-ee1e3bb7aded
2812d5e6-acc0-4cad-90a0-b879a1e6584f	7875cc29-1597-4413-a8b8-74f6f7a4ba58	priority	100
a99fe649-e484-43f5-86e8-4a719a0b54f4	e2dfd255-b7bb-43f0-8663-2ec1ce388bd0	algorithm	HS256
c0c2499b-7d98-42bb-9af2-1ce316b3ef44	e2dfd255-b7bb-43f0-8663-2ec1ce388bd0	priority	100
99fb4387-4187-4290-b7c3-7d7701ae5fe8	e2dfd255-b7bb-43f0-8663-2ec1ce388bd0	secret	Mq_RjNwHMbwlkA6TVsd2DOcTHjBTMwXSieiQ1mNtD71drDr68y7zerY1vUSjOCA0SZTvkq1LVMtjzGTAqronKQ
52872e86-3930-484b-bfcf-26c8e4f294e4	e2dfd255-b7bb-43f0-8663-2ec1ce388bd0	kid	baab7d9a-a348-4965-90c8-bb242a3bccbc
9be5ecc6-d9e5-44d8-be5b-484b9f982325	b9144019-4a3e-4b5f-989a-509004d25ed3	algorithm	RSA-OAEP
de3c0a6b-cdcc-4310-ae1f-71f8ab83011d	b9144019-4a3e-4b5f-989a-509004d25ed3	priority	100
c804118c-f982-4392-8948-ae479d46d644	b9144019-4a3e-4b5f-989a-509004d25ed3	certificate	MIICmzCCAYMCBgGH+7fXETANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjMwNTA4MTQxNDAyWhcNMzMwNTA4MTQxNTQyWjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDAeO0Lng8/We/yZyGvWaLqPn1tr6onLRu75zmp5pJ/Mzg5hEjKWAMpbe/kbfyxFHtFIangKzJ30+jk77/mIp96gLMs1fvbL1QtfBtlJx5C4JUS/J+TkoSV7YJ6Yo1l6oG/6nUzukGHsLg8UBxzs9Is65gODfJQnPMmRjUwV5PE64yHBworF1zTI7hA2+CW6g8cspxYaQDNrEqzcbFCE9D/3mUlos0BTbVXH7zGDIkJ4gCtFjFRhPtiWRPbePD50Vf50cxSFKVmbKjEm00Gjj4jhKhtZ1XtsjY/BFGBvy/v2bSAbjTxdmJOAprHAOYif2pX8mxL/sQ5swEpBHEhLeurAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAJ3Wa3TyRMUTwH98nLw1d0xvL1CJJ3uqrtMBLo+KW1CWEW0OnHqB73rk22wZaVS1jKKObAYV8SOdLsTGic5WnFpCDxHg9ShBatrsIG10Jr8DOLVPfE+T4JLRaCGomLc8XVdf/XUHFTR4PMyJpsm4VNs8ptIZbctCPMWxgiypiSN3iDlUieU/JCAXikZjS1hOt2eIzf3aFBnkm0P46PcViNihsGw6jVc55W7Q8j4QTgCnHAgZfLAz5E+EVLunREeyhDAENst5W9oMsPsuzTNYg3Ft0X5qfN+5cHK511EI+7u8NvJ90cg9aprNdh4zVxYDiIIuuYI3yBGyQe0y2p/91tQ=
0b86281b-ff9e-4a11-a7b3-814823b3a25e	b9144019-4a3e-4b5f-989a-509004d25ed3	privateKey	MIIEpAIBAAKCAQEAwHjtC54PP1nv8mchr1mi6j59ba+qJy0bu+c5qeaSfzM4OYRIylgDKW3v5G38sRR7RSGp4Csyd9Po5O+/5iKfeoCzLNX72y9ULXwbZSceQuCVEvyfk5KEle2CemKNZeqBv+p1M7pBh7C4PFAcc7PSLOuYDg3yUJzzJkY1MFeTxOuMhwcKKxdc0yO4QNvgluoPHLKcWGkAzaxKs3GxQhPQ/95lJaLNAU21Vx+8xgyJCeIArRYxUYT7YlkT23jw+dFX+dHMUhSlZmyoxJtNBo4+I4SobWdV7bI2PwRRgb8v79m0gG408XZiTgKaxwDmIn9qV/JsS/7EObMBKQRxIS3rqwIDAQABAoIBAE34DqrAnlOfBtUvExW6HYV/yAbJfQe+vbfqTNE3Psw5fwLJxET3z1wWlXH3XkCL1/3iy7KsPRcOqI8pUhcTmoAhJ7Q3gP3DF/oPBvf8l0UnPiyBWtGIrp4fp1YVm0sYavRIMa9BOe+SVqfUGhqC01bwH1o+KxWd5t/v2/cX2xwPTCvyvtIWiB41ilaj/9H6NyPh+pfG4GsEjcudQFzuj+Woi+7bmkOgRu5LrAmEZK3YFZbrETL19ZH543kEXgSFG182EaKo5wDTahpITmAWILdc5FaPznjHskj/nayGnypDnRxE0aFMg0nUfLOfqQvJ0YgAOX0xL8zkj8iRslco5xUCgYEA/Q04YIhiI4KYGBJ2v68VtLr2Q+xGI9jXN9z2xdEcbONPsfZ9DHvsmEI48yc2KiRudwu65NPMKKYW+MWmC5GGHG/QjBxUQY6wZH8RmXkpP+YrDsxHbGsZfUfRb/SjXPc3O3ty0LECLiSXZ+YzkIAfWCnMy4MHjO1Q5bwftycNakcCgYEAwrcD6rYNehtL9sVtBERTuQT3eY/fV8Rm6D6HkjhcBPgtCtUqfr2tkzgGL5hmyvNPaWn2ZC2eSAGNIHFUfT9qyhlUhaeaVVoxVIISLaAgHzBerg2anZUb5s4mjlVFBVTcH3zj2FRuqcVWyiNC2A/04R1vBNuqg1NhX2GY4eizQX0CgYEAnjhy5KDBw/Q2xu5cg1Ok3cD8k9GatXUydAJb5anu/QJP5TT6USD2+OiHFTmSO11WGGckL0liYJQgzuE+BgOyd/tNyR05bVgbYGq3BV/lc8elanY9vkNkx5ltEXRD5K/KQA3a5zOV6mYEqPkdip8heg2AuEqwIOSNbWdn6SuozqcCgYEAv2Jj1y9Zz8tEvykOHkOKhzD6jeF8BShmfZ/4YSBEUh4dJ6iePDTzhuBqNB3360N7qoEcTRsJmHzt2hWKlhDfRgXfrf8vEvWzxvySIYZiDEXeyfVVI86LvjCidQQa80KVmd2HlfpnSzdMNyKxcO0+JIZpuLywvKQX8UhcnK+8gYECgYAzZ71JwBs/RoRkPrytmA//moPD0T0ThOupX9C1ijZt4IX5NJIyM3EeyGekjTpqXpbbNVyCqGP20tO5jHM5bRXl1o6wPS3C+RLZrMjI7SoAdg5XMMUc4hUjo6xsKi1M2Gx8Dt8gIakIZbgrPCbvA51bUHp/iksk6idqd50gXG+VfQ==
5d2d7a2b-73dd-4bc4-8587-fb832a3e032c	b9144019-4a3e-4b5f-989a-509004d25ed3	keyUse	ENC
5a0923d6-d0da-4399-84c3-aae67c8480ea	e226afd0-488a-4f24-82e7-a583505b9306	privateKey	MIIEpAIBAAKCAQEAqZUkuJmDrgZDmRweU0RDQFAbmA+xRrtRmgDMZ/jIlATwzl8qtoH0+vKHynnrNfpbgBtEcrPl4y02aBt4nONK+85/qYtUJpCJosg+Hwf6jGy0qx5ZrNYXxPNdMskODuxP1E+3qLNWsCYRQmni0d4ahPkDFdsm0NGR8CpvwruReW7NmdtYn36Ts0kZZzNfy+86JaJv+R8VZHAfgQ4rqSv77zF6g0X1Esi0Y6AX4N3l+N4aKQ6rNIPKOvR9I/7v6fTEk+F6vmPmCZWiyH0TMVCsorLcztZxF+utAn4gzp9wxerSDrm53XDdlFlobDA+oVvQjxKgRP3oeOMlVcjiPsPWtwIDAQABAoIBAAm/O5yWn5XFi2YbUneOZrUlcD3rDPvtRqaXjCgftFukSw5O3v7IH8NlZD5UMpuSzRE4aqnobXquExX5xOgePPrrJrWhKfrgzOBmf6zl7FXc5lIoN5byY+xbNoygN2bOg1THKN277RbJIVh+td2X1VC2RUygy4LYwM7GiaTuMKbY37Qc7n8vi/ghWYz4/iYVUIQNNMsjod5Y4xbk9EpfVuUie+/R7KA8JFJwaTYIloS8ouLcbHaNi9WoBEcl0GD2Xxk7R6WueVo0yD4ZXHcp5sbama0P0EzramqfgwcCCjk0cA0OHeSHtyDeu+uK2DOiTXXGJurPfl4RtAvLlmIqcSUCgYEA3TCt6N+U2Bq7VKC9iyMa3Zuz1iOaY+k973rmMgDUq5Gtv/AWUkaptlynzotqyP5RswF8undODP6adTqOinU9BiVtRgklyT4qeqH6lKNKb1K52rxvDWWq9L9LoDxJ2EY51XL+2lax3Pe+kMtFlFhGwfZvG+kWxifSZlt5jaePpbMCgYEAxEVLwFJMoQiW5a5DU7Vh3LNoUb+mrG5J40mgskl7AnL28+zZIsUAOXcom7fk9OeTnwTpSHH0AV1kIK8cRPZ8F5QogUINAgc0TdIPdwgxwvm5+MAI/SNCHOCCtZd1/H+8rnEPtD9bPyRVYI1qlhdM0w6CsJ2paa7zFZKANJBC0O0CgYEAswd0q9lTyzqPx6a25AhM9XPSMo/spdOiitRpv61GdXvbK1CzcHK7aNxEAnx7uSWHkSCyCOcJ6KCm+h2kQ9Myyme+s4Ix8Fn93fZ/MJGebM6DmdUM+cYBgknXd2F0z7W/l9GVD7o+CkEIIIA22CQ/WT0Sn3+hLFAND0YY85vdO9sCgYAB0iLBxgGv/MRpnRRC0ov14DQ3je+d6egFk8lJ3iSmASsJWEkraWh3IAPgbfRR0VQtRX5kjaoV2Sf0pas9eIvuLBG0IUi9nBOAJVK/Z/QOOwLeq+lpb8pNOkf8J0uQ7B5z/9iFc5EFJPEl1CoI+m5cBuZvfQb1VAotSQ6nbi8wgQKBgQCGvHO/wnqpwXt8NzxHvCTgOwig2zPIZSQkLwJayGyi0uTwGYnfT7i9au/3tPIdNlNj+zyOwU4ZlhgUiZyKkjhbKj0WofWM2mClYr87Pd9ee4i6/mhlJtGc0Em1LjxErD0kN7XpPhIvdfMn6X2hcUatqYmBc+TSDFZO8XmoqmtYuA==
19e9616d-31bf-45e5-bc1a-935493045e61	e226afd0-488a-4f24-82e7-a583505b9306	keyUse	SIG
3cf65ecd-d189-4944-adc5-a7f30c5618d5	e226afd0-488a-4f24-82e7-a583505b9306	certificate	MIICmTCCAYECBgGIAy/brDANBgkqhkiG9w0BAQsFADAQMQ4wDAYDVQQDDAVvbW5pczAeFw0yMzA1MTAwMTAyMjhaFw0zMzA1MTAwMTA0MDhaMBAxDjAMBgNVBAMMBW9tbmlzMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAqZUkuJmDrgZDmRweU0RDQFAbmA+xRrtRmgDMZ/jIlATwzl8qtoH0+vKHynnrNfpbgBtEcrPl4y02aBt4nONK+85/qYtUJpCJosg+Hwf6jGy0qx5ZrNYXxPNdMskODuxP1E+3qLNWsCYRQmni0d4ahPkDFdsm0NGR8CpvwruReW7NmdtYn36Ts0kZZzNfy+86JaJv+R8VZHAfgQ4rqSv77zF6g0X1Esi0Y6AX4N3l+N4aKQ6rNIPKOvR9I/7v6fTEk+F6vmPmCZWiyH0TMVCsorLcztZxF+utAn4gzp9wxerSDrm53XDdlFlobDA+oVvQjxKgRP3oeOMlVcjiPsPWtwIDAQABMA0GCSqGSIb3DQEBCwUAA4IBAQCUA7Vge+UxFqhfV2MgYSiJRxAeUsQQIZcmsTpYL9KHw71UJmBeejlKxSlLdM5UO+/86kPC/l6mJq81CEZ0wg5tZMU94/RvPfJuHWrcrchoxRCTrZp2j6r7Z+XrVwpysY1AED4GRnfe3EP9eDEcPHf1cU1H6gFfHbQPxFAoSLvHk5aQNNFlj5MsCkl57VRv/Xr5D3NAAA+8CnFAony7Kz0kLkMUTImWMiVWGVk84hNdI05Go4pnKTwss9Ajmqhldb20cFd6yGWaY9SaYLEKzv9aMYetHNXs8LhWB5lO2FZSO1TNt1/jM6xvLd+5+oN7a40TBjOfZbKv6Un5lSU+yNgL
9fc362df-e457-4eed-8be7-76fcbeb3513c	e226afd0-488a-4f24-82e7-a583505b9306	priority	100
d4c86d5c-51a5-48a5-8aa4-3189b7a6267a	e6a8b2ef-6dd2-41c0-a945-f22d50b4280a	algorithm	RSA-OAEP
4e4a1b31-c2da-4031-b448-b4e8d8902e73	e6a8b2ef-6dd2-41c0-a945-f22d50b4280a	privateKey	MIIEpAIBAAKCAQEA/UHwXUBEE7ROxKSAtvINDhh/FmfoaPgncFs5FNmW3vtPrdFQEvDrvQfhToX4wQeLEHCrAoFd0eAPDXIXDeIf1z7EHiU1WhOzRbf7G4/5Io3nUNSqnPEkxEvo78JtJd36gw6LupP8sEMsr5BgOqzROiHXE3nuIPxSQ2TFo56T5i2JUZ8WH9Wi8GGFqBSdUmw3HH51swbwacocSx+wwFfpRt5y0uvkAZ2QurUoR9xuJlzoblUFH+aYaMmJdukcaPF+wA3bzWO8nvvu2C4hUqQ7/DveuSZnzZJyDPue9MggnN2NDOSqyYqd+RXzZE4BV6NEqRI7zQnjIvdiMRD7Z4kfDwIDAQABAoIBAEjP3mVRBsGLg2Hx0bfHW42D6XXtpdoYDm61K3IdJM0y/7N/jEAF2CDe1R4YUm5c1tSBMAlmXCzs+CbreElbi7/8obHxDKe7Jj2TKbTA7eXLWofYvLymb+Wn1W6pPWw3p8BqPC4GQg4DIiPPpHr6GKVX+Vf2JEqDgLszi8cA3pC8UGb04ExIyzwDLYopLl5UIlSnkMiwf46EVnFcwi8sAK7dMuXwrikDlK5FnAksvaFKkh3L9udvz12DmCl5v+GaJls+gwKVCYQyXdYjWe/X/kGBRXQFlAncoMQQmRGD85ilDHCM/k++CFkU3UF6uOXvvSNmPdb6p1JHH6US3suEj2ECgYEA/qoCPU5rCkIRHA4drLikJ2T61nFYQkgZgLSbH73TyLYw0o44+XIBkjR+TZXO5/Bf7jjiOLu64EgCSAv6hZEQv0FtrzKb8id18c0qM5hMQpjYWKlSu3TtIgPWQdU1n2sDuwlL+iZ1z+sdUhr8nFypgh3KjdMz42FIlMUH0V7oEncCgYEA/pYKlT/VgLrxsT1EPaTOmejjtvLA6QCfEWNxXG4soYuSPRH41PZa8gbLaB9AfZG/9EC5aZHrxP1+i0mXbQhF8Sz8NPWJ6nXXGbQ8GErTQhxkKa6dIrGaKb00gtagDI8E++u4AlZWzsXrEOHzbIaOcBWuplLZXU09MRdUWscDpikCgYEA52pSMqep+V5j8dyZ9rSq5umKT4gcLc8a7awxMrzrUP7OiueWuoZxCw0MoTA7HuV+Jxol6Gwfu2N0P0gzVWCnmUS5iXUx5PEa6qoHaW9CDVqbbqYfeh0cx8Y40wYOfllewH4IPr7oXBJJSK0hVG2X05eC0zJTepKSxC3vlsDpnq0CgYEAsiz6bShG2Zh8zQnO98GfYrJOpNzSzH/F1Bqf3QuyqsEO8TThzNI6JkdBFrdAoGFgUab23P7mXnD3nq47j3CJ2tgcD0iFZJVinLe6k1nS7uMF6vItQXnBJlMoLCXfz8pMt69qkiAxEvgLoz4v6pVlnOZf3EIBpL4JBJGKVRoR4LkCgYApTz1ciPkXa2Atf7hh13Xb71MH+3UJtn0QHZcQwST9TwfpsufKgUydEAC/B6ELve4PDCFQXuUnNXpwGhcNNf+dGlOPwaRovokIwVws31geKcdbNZdfqplm//Pztaq9HSNAoE9do88LjQriKlu49Op3AvMZxvJXMTzgkxCt8Xcyng==
3743e54f-e2ca-4ae9-a773-96c016a88878	e6a8b2ef-6dd2-41c0-a945-f22d50b4280a	keyUse	ENC
cdcd4ada-1f66-4d6f-ae2d-a68ccc5e70a4	e6a8b2ef-6dd2-41c0-a945-f22d50b4280a	priority	100
13dc5eb4-cc63-4228-97a8-01af19dad038	e6a8b2ef-6dd2-41c0-a945-f22d50b4280a	certificate	MIICmTCCAYECBgGIAy/cwjANBgkqhkiG9w0BAQsFADAQMQ4wDAYDVQQDDAVvbW5pczAeFw0yMzA1MTAwMTAyMjhaFw0zMzA1MTAwMTA0MDhaMBAxDjAMBgNVBAMMBW9tbmlzMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA/UHwXUBEE7ROxKSAtvINDhh/FmfoaPgncFs5FNmW3vtPrdFQEvDrvQfhToX4wQeLEHCrAoFd0eAPDXIXDeIf1z7EHiU1WhOzRbf7G4/5Io3nUNSqnPEkxEvo78JtJd36gw6LupP8sEMsr5BgOqzROiHXE3nuIPxSQ2TFo56T5i2JUZ8WH9Wi8GGFqBSdUmw3HH51swbwacocSx+wwFfpRt5y0uvkAZ2QurUoR9xuJlzoblUFH+aYaMmJdukcaPF+wA3bzWO8nvvu2C4hUqQ7/DveuSZnzZJyDPue9MggnN2NDOSqyYqd+RXzZE4BV6NEqRI7zQnjIvdiMRD7Z4kfDwIDAQABMA0GCSqGSIb3DQEBCwUAA4IBAQCreRx9wUEwx9E2GMutShbzkhr1qCK1+UbWLdh/XwIvIHViolTH6PODma/ciFmFXmhaDrqGDRgREc6Ic5fjcfFBPoP78xWIOVfgT2dX5Nsw5O8VJxtui1VD39SgmcCfcOVuf8VuAhW8eK8SgUI2pDGyMVY51dlqtCi3iqMYDieOE0raUXdC7PSIntsiGU1J7PruZMvSDGLGffDxw/R8nRwJQd44mfb4WKp02wGncQETFqNZ4gQfL7kl3ZFDlz+0UfBFs56FGe3b/8/7MqaZPtYyjIqlpwI0lgRxX9Hs8tYbbJJGDKOb4pqaIzLtQOrJfFZL51b9C3H04PVmuNi9F81w
2389baa4-0eb7-4cea-937f-56502c3f5bad	a2b52d45-6880-4323-9842-be6f28e0f033	kid	62c2f99a-242f-463e-911d-96ebf6693a72
4c164053-7082-4b2f-95f1-b9fa4b6ec2c7	a2b52d45-6880-4323-9842-be6f28e0f033	secret	dF8hWzb4oKTzLk2v3rEEug
0ad2182e-98d9-4ae0-9bbe-c456c7b5a309	a2b52d45-6880-4323-9842-be6f28e0f033	priority	100
17f2957f-e8a6-4cfd-9da7-077d55e85f75	a7e3b012-a78d-4551-ba39-10d39c1ea028	priority	100
df75593d-a62d-4ef8-bbc2-821760e12095	a7e3b012-a78d-4551-ba39-10d39c1ea028	algorithm	HS256
60d7b0e6-4b1a-42f9-98a3-cc9d7d714ad0	a7e3b012-a78d-4551-ba39-10d39c1ea028	kid	55e9b0c5-ed16-4ad9-a038-87cfa96595f0
d5e61666-3421-4a04-be7d-758f1014a5a4	a7e3b012-a78d-4551-ba39-10d39c1ea028	secret	E-xgQp1VcWZnkQo8JPO9PGgTQ_ZNbnzF6PB1XJ7ueZaQlDjMVSMzVsjJYgykDP-DVxnZ-XLbahgbaAVtILVu9w
73375508-7860-4819-b830-dc6123c2f5a9	3e513626-4559-4d26-bbb6-438405f18317	host-sending-registration-request-must-match	true
9bbe52f4-1b27-4fa0-844f-cb86c1f0ffdf	3e513626-4559-4d26-bbb6-438405f18317	client-uris-must-match	true
95626208-d5a2-4441-a0fd-58b68db12531	fb7e96db-c69e-41e3-b6f0-fa171d76a8d8	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
c1fd45bf-ad36-4bfd-94bb-b304419af131	fb7e96db-c69e-41e3-b6f0-fa171d76a8d8	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
27dd6bad-c39d-4129-9a28-8b33e73fc69e	fb7e96db-c69e-41e3-b6f0-fa171d76a8d8	allowed-protocol-mapper-types	saml-user-attribute-mapper
45317d5d-d1c0-444f-b043-751866d47239	fb7e96db-c69e-41e3-b6f0-fa171d76a8d8	allowed-protocol-mapper-types	oidc-address-mapper
1e1a2bdd-c589-45dc-be75-85f5979c9fac	fb7e96db-c69e-41e3-b6f0-fa171d76a8d8	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
9bbf403c-0bc5-4fc8-bd15-1ed3352867f8	fb7e96db-c69e-41e3-b6f0-fa171d76a8d8	allowed-protocol-mapper-types	saml-user-property-mapper
8a30b7b8-a5a4-4f35-a302-0b67d627bab2	fb7e96db-c69e-41e3-b6f0-fa171d76a8d8	allowed-protocol-mapper-types	saml-role-list-mapper
a6958133-24e1-4978-a8b7-9a3385dad1ed	fb7e96db-c69e-41e3-b6f0-fa171d76a8d8	allowed-protocol-mapper-types	oidc-full-name-mapper
c7080a2b-928d-457c-a440-38ac798f8ec2	360308b8-22c2-4aa2-abaa-2d6422673ec9	allow-default-scopes	true
a4f8d0ca-035d-48e8-9ad9-3b1138991253	a86eadab-630c-4156-8dd6-fed71cec27bb	max-clients	200
09c23a4e-27b7-41e9-93fc-e3895f869cad	7e953725-f70c-424b-83a1-06a55ed28904	allow-default-scopes	true
ac02a6b1-7eed-4446-8b79-2cb56966bb42	6f7cc781-792a-464c-b6f3-705f84891582	allowed-protocol-mapper-types	saml-user-property-mapper
c614fc15-24f2-457a-9f2b-7ccd8dadd079	6f7cc781-792a-464c-b6f3-705f84891582	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
4a37435b-9c6c-418e-a361-123d9d456629	6f7cc781-792a-464c-b6f3-705f84891582	allowed-protocol-mapper-types	oidc-full-name-mapper
e4222707-38ce-49c0-98c7-c8bcc8d9d146	6f7cc781-792a-464c-b6f3-705f84891582	allowed-protocol-mapper-types	saml-user-attribute-mapper
ecc34632-2147-43de-863c-b4a0d0074e2c	6f7cc781-792a-464c-b6f3-705f84891582	allowed-protocol-mapper-types	saml-role-list-mapper
06c17822-cd9b-42f9-8c9b-a17ddd7e161c	6f7cc781-792a-464c-b6f3-705f84891582	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
3db67f0a-e9a4-4514-8861-87561af37a80	6f7cc781-792a-464c-b6f3-705f84891582	allowed-protocol-mapper-types	oidc-address-mapper
4b4c8387-49e8-44b0-9431-37c203b6ca85	6f7cc781-792a-464c-b6f3-705f84891582	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
\.


--
-- Data for Name: composite_role; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.composite_role (composite, child_role) FROM stdin;
47b2d91b-8d7b-4abe-aaeb-0d9ad4b08e11	c948e6fa-47fe-4674-8556-a8e88b34c188
47b2d91b-8d7b-4abe-aaeb-0d9ad4b08e11	6365711e-6226-4db2-97b7-e4073e4533b2
47b2d91b-8d7b-4abe-aaeb-0d9ad4b08e11	2affedb5-0719-4009-9638-a5037cfbd590
47b2d91b-8d7b-4abe-aaeb-0d9ad4b08e11	84457725-6cf7-47a8-b4db-cb42c4d8bcc7
47b2d91b-8d7b-4abe-aaeb-0d9ad4b08e11	e0edfe3d-4477-4283-9577-f9f91695a17c
47b2d91b-8d7b-4abe-aaeb-0d9ad4b08e11	23331682-5e79-4ae8-a7ac-65045bada7a1
47b2d91b-8d7b-4abe-aaeb-0d9ad4b08e11	413da4a5-cc43-4c7d-b8e3-d68460452d8f
47b2d91b-8d7b-4abe-aaeb-0d9ad4b08e11	fed8fd51-4317-4c96-b2d7-919b9bf0a21d
47b2d91b-8d7b-4abe-aaeb-0d9ad4b08e11	3d78f377-e3d0-4969-88a4-a07fba8a7f00
47b2d91b-8d7b-4abe-aaeb-0d9ad4b08e11	84342f80-3a93-46c0-9d62-6f2a18ae88ae
47b2d91b-8d7b-4abe-aaeb-0d9ad4b08e11	b9609fe2-f153-4048-84b8-04c120c8dc29
47b2d91b-8d7b-4abe-aaeb-0d9ad4b08e11	254c95fc-dfe6-4606-8ccc-a4113b59f3d0
47b2d91b-8d7b-4abe-aaeb-0d9ad4b08e11	7efef5fa-c467-4939-b35f-4cf26ba61764
47b2d91b-8d7b-4abe-aaeb-0d9ad4b08e11	66fe1aa0-46b3-4aea-9c00-6f07f2bfc28f
47b2d91b-8d7b-4abe-aaeb-0d9ad4b08e11	56013eab-1835-40f3-a38b-c0f7f585c488
47b2d91b-8d7b-4abe-aaeb-0d9ad4b08e11	9101ded1-70da-44cc-904f-eab391962f04
47b2d91b-8d7b-4abe-aaeb-0d9ad4b08e11	6f97a505-0b84-4ee8-82e6-40039b9d0e45
47b2d91b-8d7b-4abe-aaeb-0d9ad4b08e11	6264bc98-afad-4776-b5b4-afa354d62a23
e0edfe3d-4477-4283-9577-f9f91695a17c	9101ded1-70da-44cc-904f-eab391962f04
84457725-6cf7-47a8-b4db-cb42c4d8bcc7	56013eab-1835-40f3-a38b-c0f7f585c488
84457725-6cf7-47a8-b4db-cb42c4d8bcc7	6264bc98-afad-4776-b5b4-afa354d62a23
6537ee5a-325e-45fe-a57d-68e71ca3a991	c0f24659-8581-44e2-a3ad-cadbc152bffc
6537ee5a-325e-45fe-a57d-68e71ca3a991	96679f24-2cb5-4b44-acc8-91b3cb50e3f0
96679f24-2cb5-4b44-acc8-91b3cb50e3f0	e9eae5dc-bfe8-442a-8c47-0bf2c69e26fa
ca6b1d93-bccf-46f4-93e3-25b350074a7e	aed2eba5-dec4-46ea-8cd5-ed0ca704d62b
47b2d91b-8d7b-4abe-aaeb-0d9ad4b08e11	7a86eb27-9908-4587-a744-0f9e355258f2
6537ee5a-325e-45fe-a57d-68e71ca3a991	bc76a878-37e1-4168-9752-5b8c05226275
6537ee5a-325e-45fe-a57d-68e71ca3a991	4ea1901e-a7fb-4477-a4e1-3eef7f6c5b51
47b2d91b-8d7b-4abe-aaeb-0d9ad4b08e11	e76c8ff7-ed2f-4887-a72d-77c1f78f8a05
47b2d91b-8d7b-4abe-aaeb-0d9ad4b08e11	47ede815-30b6-4f27-9413-fc0c50336dbb
47b2d91b-8d7b-4abe-aaeb-0d9ad4b08e11	25943332-c4ca-41fe-9869-309f9a84bed3
47b2d91b-8d7b-4abe-aaeb-0d9ad4b08e11	4185b06c-f40d-4296-b0f1-ad1bfdb84c18
47b2d91b-8d7b-4abe-aaeb-0d9ad4b08e11	00ccbfd0-0dc6-4b1f-ad60-e21d3dd47c2d
47b2d91b-8d7b-4abe-aaeb-0d9ad4b08e11	855d464d-4068-44d7-87d9-763f89bb516b
47b2d91b-8d7b-4abe-aaeb-0d9ad4b08e11	40d9a219-8b78-4ad2-b7d4-c0ac9384997f
47b2d91b-8d7b-4abe-aaeb-0d9ad4b08e11	75884b9c-3a12-4bcb-93a1-2efa20cee9b4
47b2d91b-8d7b-4abe-aaeb-0d9ad4b08e11	68ed575b-254d-442c-aff4-aebdde13bd03
47b2d91b-8d7b-4abe-aaeb-0d9ad4b08e11	b315154c-b374-446b-a12f-a24cc1b5a964
47b2d91b-8d7b-4abe-aaeb-0d9ad4b08e11	6a3c6da3-60c2-4d7f-b164-e40933030106
47b2d91b-8d7b-4abe-aaeb-0d9ad4b08e11	a5ebf57a-7153-4612-9dad-775b82f9d808
47b2d91b-8d7b-4abe-aaeb-0d9ad4b08e11	c4af971b-f302-49b6-96d0-c487aa1f952d
47b2d91b-8d7b-4abe-aaeb-0d9ad4b08e11	bc3526a1-f236-4809-a1df-b019f7f0571c
47b2d91b-8d7b-4abe-aaeb-0d9ad4b08e11	ce6ed041-0fed-405b-98c3-d763b25f6931
47b2d91b-8d7b-4abe-aaeb-0d9ad4b08e11	a0cfc807-8e12-4871-be62-89a83b9639f7
47b2d91b-8d7b-4abe-aaeb-0d9ad4b08e11	5e2c759c-7a60-403e-bda3-1df7f2267f1a
4185b06c-f40d-4296-b0f1-ad1bfdb84c18	ce6ed041-0fed-405b-98c3-d763b25f6931
25943332-c4ca-41fe-9869-309f9a84bed3	5e2c759c-7a60-403e-bda3-1df7f2267f1a
25943332-c4ca-41fe-9869-309f9a84bed3	bc3526a1-f236-4809-a1df-b019f7f0571c
c19931bf-b8bc-4b8c-a749-7275e000143c	314ee546-57cd-4417-a907-02d92aae8163
c19931bf-b8bc-4b8c-a749-7275e000143c	0fd169cf-970a-4f57-9941-302086149f8a
c19931bf-b8bc-4b8c-a749-7275e000143c	cba9f998-41a1-46e7-bbaa-e8f915c75f52
c19931bf-b8bc-4b8c-a749-7275e000143c	f6b8a722-a3d8-4dfc-9567-e5dd4c484947
c19931bf-b8bc-4b8c-a749-7275e000143c	736ece19-2297-44dc-b134-00f9264f6baf
c19931bf-b8bc-4b8c-a749-7275e000143c	7feb0a8d-f007-4b12-b9f4-160b73465869
c19931bf-b8bc-4b8c-a749-7275e000143c	bf16ad4f-50f2-49ca-9084-ad9299353387
c19931bf-b8bc-4b8c-a749-7275e000143c	b7128eb4-9655-4411-9cd2-9fcf10b4470a
c19931bf-b8bc-4b8c-a749-7275e000143c	2eb2d53c-0e8d-49ec-8568-3ec978efed8a
c19931bf-b8bc-4b8c-a749-7275e000143c	9975ff84-736a-4496-a0a9-0a7d508d286c
c19931bf-b8bc-4b8c-a749-7275e000143c	58ed4dab-e1d0-4e69-b372-d0c563d95bdd
c19931bf-b8bc-4b8c-a749-7275e000143c	dacb7933-93dc-4fbb-9c8c-eefbc2c1d325
c19931bf-b8bc-4b8c-a749-7275e000143c	fba82127-abdc-450f-9cba-c4daf8251ec4
c19931bf-b8bc-4b8c-a749-7275e000143c	b26413fb-8900-4186-b4c2-3c4bead53bd3
c19931bf-b8bc-4b8c-a749-7275e000143c	1caac4df-6669-41b7-a70f-275a31779330
c19931bf-b8bc-4b8c-a749-7275e000143c	4c70cc23-3e22-4d50-a3cf-460997f35fe7
c19931bf-b8bc-4b8c-a749-7275e000143c	e45f61cb-48c2-473a-b690-879f9c121399
f6b8a722-a3d8-4dfc-9567-e5dd4c484947	1caac4df-6669-41b7-a70f-275a31779330
cba9f998-41a1-46e7-bbaa-e8f915c75f52	e45f61cb-48c2-473a-b690-879f9c121399
cba9f998-41a1-46e7-bbaa-e8f915c75f52	b26413fb-8900-4186-b4c2-3c4bead53bd3
1c4dee70-4cf0-4218-9fa9-b95c0a710886	2e419e1a-ad99-42c1-9acf-07f5e9645e5b
1c4dee70-4cf0-4218-9fa9-b95c0a710886	63ef9c07-e52b-46d5-a5d6-0a803a8314c5
63ef9c07-e52b-46d5-a5d6-0a803a8314c5	4a9c3184-6308-4e0a-af60-1824cf08ad63
c4e048ff-e9aa-493e-bc51-995082d0ca88	15ed7c44-1384-471f-8dfd-ddd359d67ba7
47b2d91b-8d7b-4abe-aaeb-0d9ad4b08e11	72ebe76a-98e8-42e7-acda-0613e5b88aa0
c19931bf-b8bc-4b8c-a749-7275e000143c	beef3a73-15c7-458d-a7b1-1ffc0f3301f3
1c4dee70-4cf0-4218-9fa9-b95c0a710886	42526fc0-ed41-411f-b6fc-8a74214604cc
1c4dee70-4cf0-4218-9fa9-b95c0a710886	5f01e211-c0af-43d3-86f5-5768fc2e2e3c
\.


--
-- Data for Name: credential; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.credential (id, salt, type, user_id, created_date, user_label, secret_data, credential_data, priority) FROM stdin;
e8f85e7b-3122-4218-818d-dcdf7ea4721f	\N	password	929953af-32a3-4550-988f-3ec066267d09	1683684259613	\N	{"value":"rnpab8O9Mti3dPzbhWCpZdo4BEZL9X/32CVtHTkCCCKu7Ey7uSSe3HJLbaZ7526VN9G6LL9UnVjmZFmxc8QG3w==","salt":"GHbtwKNgZj8esw/DHeaVmQ==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
147c34de-170e-4049-bf56-c0ce59223fef	\N	password	fb9ed89f-82cd-4dd7-b3cd-4c4bccb4ebc8	1685153038628	My password	{"value":"/ljJ2D0KiS1pDCpsFXKE85eNa3a6r2kugwkLb6fLuNTA+PjEqfuTtDTIAkQQn3fun1xvYn4h8Q0ErD0ZIL11nQ==","salt":"hjiqS74T7PTJh7W9JpIY4g==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
\.


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/jpa-changelog-1.0.0.Final.xml	2023-05-08 14:15:38.380217	1	EXECUTED	8:bda77d94bf90182a1e30c24f1c155ec7	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.8.0	\N	\N	3555338231
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/db2-jpa-changelog-1.0.0.Final.xml	2023-05-08 14:15:38.386231	2	MARK_RAN	8:1ecb330f30986693d1cba9ab579fa219	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.8.0	\N	\N	3555338231
1.1.0.Beta1	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Beta1.xml	2023-05-08 14:15:38.407044	3	EXECUTED	8:cb7ace19bc6d959f305605d255d4c843	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...		\N	4.8.0	\N	\N	3555338231
1.1.0.Final	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Final.xml	2023-05-08 14:15:38.409036	4	EXECUTED	8:80230013e961310e6872e871be424a63	renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY		\N	4.8.0	\N	\N	3555338231
1.2.0.Beta1	psilva@redhat.com	META-INF/jpa-changelog-1.2.0.Beta1.xml	2023-05-08 14:15:38.452347	5	EXECUTED	8:67f4c20929126adc0c8e9bf48279d244	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.8.0	\N	\N	3555338231
1.2.0.Beta1	psilva@redhat.com	META-INF/db2-jpa-changelog-1.2.0.Beta1.xml	2023-05-08 14:15:38.453923	6	MARK_RAN	8:7311018b0b8179ce14628ab412bb6783	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.8.0	\N	\N	3555338231
1.2.0.RC1	bburke@redhat.com	META-INF/jpa-changelog-1.2.0.CR1.xml	2023-05-08 14:15:38.498043	7	EXECUTED	8:037ba1216c3640f8785ee6b8e7c8e3c1	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.8.0	\N	\N	3555338231
1.2.0.RC1	bburke@redhat.com	META-INF/db2-jpa-changelog-1.2.0.CR1.xml	2023-05-08 14:15:38.499403	8	MARK_RAN	8:7fe6ffe4af4df289b3157de32c624263	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.8.0	\N	\N	3555338231
1.2.0.Final	keycloak	META-INF/jpa-changelog-1.2.0.Final.xml	2023-05-08 14:15:38.501221	9	EXECUTED	8:9c136bc3187083a98745c7d03bc8a303	update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT		\N	4.8.0	\N	\N	3555338231
1.3.0	bburke@redhat.com	META-INF/jpa-changelog-1.3.0.xml	2023-05-08 14:15:38.541884	10	EXECUTED	8:b5f09474dca81fb56a97cf5b6553d331	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...		\N	4.8.0	\N	\N	3555338231
1.4.0	bburke@redhat.com	META-INF/jpa-changelog-1.4.0.xml	2023-05-08 14:15:38.562618	11	EXECUTED	8:ca924f31bd2a3b219fdcfe78c82dacf4	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.8.0	\N	\N	3555338231
1.4.0	bburke@redhat.com	META-INF/db2-jpa-changelog-1.4.0.xml	2023-05-08 14:15:38.563765	12	MARK_RAN	8:8acad7483e106416bcfa6f3b824a16cd	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.8.0	\N	\N	3555338231
1.5.0	bburke@redhat.com	META-INF/jpa-changelog-1.5.0.xml	2023-05-08 14:15:38.570791	13	EXECUTED	8:9b1266d17f4f87c78226f5055408fd5e	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.8.0	\N	\N	3555338231
1.6.1_from15	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2023-05-08 14:15:38.578897	14	EXECUTED	8:d80ec4ab6dbfe573550ff72396c7e910	addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...		\N	4.8.0	\N	\N	3555338231
1.6.1_from16-pre	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2023-05-08 14:15:38.579965	15	MARK_RAN	8:d86eb172171e7c20b9c849b584d147b2	delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION		\N	4.8.0	\N	\N	3555338231
1.6.1_from16	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2023-05-08 14:15:38.580785	16	MARK_RAN	8:5735f46f0fa60689deb0ecdc2a0dea22	dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...		\N	4.8.0	\N	\N	3555338231
1.6.1	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2023-05-08 14:15:38.581676	17	EXECUTED	8:d41d8cd98f00b204e9800998ecf8427e	empty		\N	4.8.0	\N	\N	3555338231
1.7.0	bburke@redhat.com	META-INF/jpa-changelog-1.7.0.xml	2023-05-08 14:15:38.604556	18	EXECUTED	8:5c1a8fd2014ac7fc43b90a700f117b23	createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...		\N	4.8.0	\N	\N	3555338231
1.8.0	mposolda@redhat.com	META-INF/jpa-changelog-1.8.0.xml	2023-05-08 14:15:38.621875	19	EXECUTED	8:1f6c2c2dfc362aff4ed75b3f0ef6b331	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.8.0	\N	\N	3555338231
1.8.0-2	keycloak	META-INF/jpa-changelog-1.8.0.xml	2023-05-08 14:15:38.623512	20	EXECUTED	8:dee9246280915712591f83a127665107	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.8.0	\N	\N	3555338231
authz-3.4.0.CR1-resource-server-pk-change-part1	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2023-05-08 14:15:39.119816	45	EXECUTED	8:a164ae073c56ffdbc98a615493609a52	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE		\N	4.8.0	\N	\N	3555338231
1.8.0	mposolda@redhat.com	META-INF/db2-jpa-changelog-1.8.0.xml	2023-05-08 14:15:38.624494	21	MARK_RAN	8:9eb2ee1fa8ad1c5e426421a6f8fdfa6a	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.8.0	\N	\N	3555338231
1.8.0-2	keycloak	META-INF/db2-jpa-changelog-1.8.0.xml	2023-05-08 14:15:38.625461	22	MARK_RAN	8:dee9246280915712591f83a127665107	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.8.0	\N	\N	3555338231
1.9.0	mposolda@redhat.com	META-INF/jpa-changelog-1.9.0.xml	2023-05-08 14:15:38.645453	23	EXECUTED	8:d9fa18ffa355320395b86270680dd4fe	update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...		\N	4.8.0	\N	\N	3555338231
1.9.1	keycloak	META-INF/jpa-changelog-1.9.1.xml	2023-05-08 14:15:38.648339	24	EXECUTED	8:90cff506fedb06141ffc1c71c4a1214c	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.8.0	\N	\N	3555338231
1.9.1	keycloak	META-INF/db2-jpa-changelog-1.9.1.xml	2023-05-08 14:15:38.649175	25	MARK_RAN	8:11a788aed4961d6d29c427c063af828c	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.8.0	\N	\N	3555338231
1.9.2	keycloak	META-INF/jpa-changelog-1.9.2.xml	2023-05-08 14:15:38.726473	26	EXECUTED	8:a4218e51e1faf380518cce2af5d39b43	createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...		\N	4.8.0	\N	\N	3555338231
authz-2.0.0	psilva@redhat.com	META-INF/jpa-changelog-authz-2.0.0.xml	2023-05-08 14:15:38.75995	27	EXECUTED	8:d9e9a1bfaa644da9952456050f07bbdc	createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...		\N	4.8.0	\N	\N	3555338231
authz-2.5.1	psilva@redhat.com	META-INF/jpa-changelog-authz-2.5.1.xml	2023-05-08 14:15:38.761811	28	EXECUTED	8:d1bf991a6163c0acbfe664b615314505	update tableName=RESOURCE_SERVER_POLICY		\N	4.8.0	\N	\N	3555338231
2.1.0-KEYCLOAK-5461	bburke@redhat.com	META-INF/jpa-changelog-2.1.0.xml	2023-05-08 14:15:38.800463	29	EXECUTED	8:88a743a1e87ec5e30bf603da68058a8c	createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...		\N	4.8.0	\N	\N	3555338231
2.2.0	bburke@redhat.com	META-INF/jpa-changelog-2.2.0.xml	2023-05-08 14:15:38.807479	30	EXECUTED	8:c5517863c875d325dea463d00ec26d7a	addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...		\N	4.8.0	\N	\N	3555338231
2.3.0	bburke@redhat.com	META-INF/jpa-changelog-2.3.0.xml	2023-05-08 14:15:38.816234	31	EXECUTED	8:ada8b4833b74a498f376d7136bc7d327	createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...		\N	4.8.0	\N	\N	3555338231
2.4.0	bburke@redhat.com	META-INF/jpa-changelog-2.4.0.xml	2023-05-08 14:15:38.817989	32	EXECUTED	8:b9b73c8ea7299457f99fcbb825c263ba	customChange		\N	4.8.0	\N	\N	3555338231
2.5.0	bburke@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2023-05-08 14:15:38.820042	33	EXECUTED	8:07724333e625ccfcfc5adc63d57314f3	customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION		\N	4.8.0	\N	\N	3555338231
2.5.0-unicode-oracle	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2023-05-08 14:15:38.82074	34	MARK_RAN	8:8b6fd445958882efe55deb26fc541a7b	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.8.0	\N	\N	3555338231
2.5.0-unicode-other-dbs	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2023-05-08 14:15:38.832576	35	EXECUTED	8:29b29cfebfd12600897680147277a9d7	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.8.0	\N	\N	3555338231
2.5.0-duplicate-email-support	slawomir@dabek.name	META-INF/jpa-changelog-2.5.0.xml	2023-05-08 14:15:38.834846	36	EXECUTED	8:73ad77ca8fd0410c7f9f15a471fa52bc	addColumn tableName=REALM		\N	4.8.0	\N	\N	3555338231
2.5.0-unique-group-names	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2023-05-08 14:15:38.838662	37	EXECUTED	8:64f27a6fdcad57f6f9153210f2ec1bdb	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.8.0	\N	\N	3555338231
2.5.1	bburke@redhat.com	META-INF/jpa-changelog-2.5.1.xml	2023-05-08 14:15:38.840925	38	EXECUTED	8:27180251182e6c31846c2ddab4bc5781	addColumn tableName=FED_USER_CONSENT		\N	4.8.0	\N	\N	3555338231
3.0.0	bburke@redhat.com	META-INF/jpa-changelog-3.0.0.xml	2023-05-08 14:15:38.842362	39	EXECUTED	8:d56f201bfcfa7a1413eb3e9bc02978f9	addColumn tableName=IDENTITY_PROVIDER		\N	4.8.0	\N	\N	3555338231
3.2.0-fix	keycloak	META-INF/jpa-changelog-3.2.0.xml	2023-05-08 14:15:38.843139	40	MARK_RAN	8:91f5522bf6afdc2077dfab57fbd3455c	addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS		\N	4.8.0	\N	\N	3555338231
3.2.0-fix-with-keycloak-5416	keycloak	META-INF/jpa-changelog-3.2.0.xml	2023-05-08 14:15:38.843731	41	MARK_RAN	8:0f01b554f256c22caeb7d8aee3a1cdc8	dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS		\N	4.8.0	\N	\N	3555338231
3.2.0-fix-offline-sessions	hmlnarik	META-INF/jpa-changelog-3.2.0.xml	2023-05-08 14:15:38.84561	42	EXECUTED	8:ab91cf9cee415867ade0e2df9651a947	customChange		\N	4.8.0	\N	\N	3555338231
3.2.0-fixed	keycloak	META-INF/jpa-changelog-3.2.0.xml	2023-05-08 14:15:39.112362	43	EXECUTED	8:ceac9b1889e97d602caf373eadb0d4b7	addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...		\N	4.8.0	\N	\N	3555338231
3.3.0	keycloak	META-INF/jpa-changelog-3.3.0.xml	2023-05-08 14:15:39.1179	44	EXECUTED	8:84b986e628fe8f7fd8fd3c275c5259f2	addColumn tableName=USER_ENTITY		\N	4.8.0	\N	\N	3555338231
authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2023-05-08 14:15:39.12168	46	EXECUTED	8:70a2b4f1f4bd4dbf487114bdb1810e64	customChange		\N	4.8.0	\N	\N	3555338231
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2023-05-08 14:15:39.122365	47	MARK_RAN	8:7be68b71d2f5b94b8df2e824f2860fa2	dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE		\N	4.8.0	\N	\N	3555338231
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2023-05-08 14:15:39.148208	48	EXECUTED	8:bab7c631093c3861d6cf6144cd944982	addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...		\N	4.8.0	\N	\N	3555338231
authn-3.4.0.CR1-refresh-token-max-reuse	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2023-05-08 14:15:39.149622	49	EXECUTED	8:fa809ac11877d74d76fe40869916daad	addColumn tableName=REALM		\N	4.8.0	\N	\N	3555338231
3.4.0	keycloak	META-INF/jpa-changelog-3.4.0.xml	2023-05-08 14:15:39.166047	50	EXECUTED	8:fac23540a40208f5f5e326f6ceb4d291	addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...		\N	4.8.0	\N	\N	3555338231
3.4.0-KEYCLOAK-5230	hmlnarik@redhat.com	META-INF/jpa-changelog-3.4.0.xml	2023-05-08 14:15:39.21717	51	EXECUTED	8:2612d1b8a97e2b5588c346e817307593	createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...		\N	4.8.0	\N	\N	3555338231
3.4.1	psilva@redhat.com	META-INF/jpa-changelog-3.4.1.xml	2023-05-08 14:15:39.218721	52	EXECUTED	8:9842f155c5db2206c88bcb5d1046e941	modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	3555338231
3.4.2	keycloak	META-INF/jpa-changelog-3.4.2.xml	2023-05-08 14:15:39.220049	53	EXECUTED	8:2e12e06e45498406db72d5b3da5bbc76	update tableName=REALM		\N	4.8.0	\N	\N	3555338231
3.4.2-KEYCLOAK-5172	mkanis@redhat.com	META-INF/jpa-changelog-3.4.2.xml	2023-05-08 14:15:39.221152	54	EXECUTED	8:33560e7c7989250c40da3abdabdc75a4	update tableName=CLIENT		\N	4.8.0	\N	\N	3555338231
4.0.0-KEYCLOAK-6335	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2023-05-08 14:15:39.225247	55	EXECUTED	8:87a8d8542046817a9107c7eb9cbad1cd	createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS		\N	4.8.0	\N	\N	3555338231
4.0.0-CLEANUP-UNUSED-TABLE	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2023-05-08 14:15:39.227102	56	EXECUTED	8:3ea08490a70215ed0088c273d776311e	dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING		\N	4.8.0	\N	\N	3555338231
4.0.0-KEYCLOAK-6228	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2023-05-08 14:15:39.238724	57	EXECUTED	8:2d56697c8723d4592ab608ce14b6ed68	dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...		\N	4.8.0	\N	\N	3555338231
4.0.0-KEYCLOAK-5579-fixed	mposolda@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2023-05-08 14:15:39.330562	58	EXECUTED	8:3e423e249f6068ea2bbe48bf907f9d86	dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...		\N	4.8.0	\N	\N	3555338231
authz-4.0.0.CR1	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.CR1.xml	2023-05-08 14:15:39.344214	59	EXECUTED	8:15cabee5e5df0ff099510a0fc03e4103	createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...		\N	4.8.0	\N	\N	3555338231
authz-4.0.0.Beta3	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.Beta3.xml	2023-05-08 14:15:39.349645	60	EXECUTED	8:4b80200af916ac54d2ffbfc47918ab0e	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY		\N	4.8.0	\N	\N	3555338231
authz-4.2.0.Final	mhajas@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2023-05-08 14:15:39.380183	61	EXECUTED	8:66564cd5e168045d52252c5027485bbb	createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...		\N	4.8.0	\N	\N	3555338231
authz-4.2.0.Final-KEYCLOAK-9944	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2023-05-08 14:15:39.385896	62	EXECUTED	8:1c7064fafb030222be2bd16ccf690f6f	addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS		\N	4.8.0	\N	\N	3555338231
4.2.0-KEYCLOAK-6313	wadahiro@gmail.com	META-INF/jpa-changelog-4.2.0.xml	2023-05-08 14:15:39.408939	63	EXECUTED	8:2de18a0dce10cdda5c7e65c9b719b6e5	addColumn tableName=REQUIRED_ACTION_PROVIDER		\N	4.8.0	\N	\N	3555338231
4.3.0-KEYCLOAK-7984	wadahiro@gmail.com	META-INF/jpa-changelog-4.3.0.xml	2023-05-08 14:15:39.410916	64	EXECUTED	8:03e413dd182dcbd5c57e41c34d0ef682	update tableName=REQUIRED_ACTION_PROVIDER		\N	4.8.0	\N	\N	3555338231
4.6.0-KEYCLOAK-7950	psilva@redhat.com	META-INF/jpa-changelog-4.6.0.xml	2023-05-08 14:15:39.412432	65	EXECUTED	8:d27b42bb2571c18fbe3fe4e4fb7582a7	update tableName=RESOURCE_SERVER_RESOURCE		\N	4.8.0	\N	\N	3555338231
4.6.0-KEYCLOAK-8377	keycloak	META-INF/jpa-changelog-4.6.0.xml	2023-05-08 14:15:39.422016	66	EXECUTED	8:698baf84d9fd0027e9192717c2154fb8	createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...		\N	4.8.0	\N	\N	3555338231
4.6.0-KEYCLOAK-8555	gideonray@gmail.com	META-INF/jpa-changelog-4.6.0.xml	2023-05-08 14:15:39.428613	67	EXECUTED	8:ced8822edf0f75ef26eb51582f9a821a	createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT		\N	4.8.0	\N	\N	3555338231
4.7.0-KEYCLOAK-1267	sguilhen@redhat.com	META-INF/jpa-changelog-4.7.0.xml	2023-05-08 14:15:39.430908	68	EXECUTED	8:f0abba004cf429e8afc43056df06487d	addColumn tableName=REALM		\N	4.8.0	\N	\N	3555338231
4.7.0-KEYCLOAK-7275	keycloak	META-INF/jpa-changelog-4.7.0.xml	2023-05-08 14:15:39.439551	69	EXECUTED	8:6662f8b0b611caa359fcf13bf63b4e24	renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...		\N	4.8.0	\N	\N	3555338231
4.8.0-KEYCLOAK-8835	sguilhen@redhat.com	META-INF/jpa-changelog-4.8.0.xml	2023-05-08 14:15:39.441323	70	EXECUTED	8:9e6b8009560f684250bdbdf97670d39e	addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM		\N	4.8.0	\N	\N	3555338231
authz-7.0.0-KEYCLOAK-10443	psilva@redhat.com	META-INF/jpa-changelog-authz-7.0.0.xml	2023-05-08 14:15:39.442776	71	EXECUTED	8:4223f561f3b8dc655846562b57bb502e	addColumn tableName=RESOURCE_SERVER		\N	4.8.0	\N	\N	3555338231
8.0.0-adding-credential-columns	keycloak	META-INF/jpa-changelog-8.0.0.xml	2023-05-08 14:15:39.444921	72	EXECUTED	8:215a31c398b363ce383a2b301202f29e	addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL		\N	4.8.0	\N	\N	3555338231
8.0.0-updating-credential-data-not-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2023-05-08 14:15:39.447159	73	EXECUTED	8:83f7a671792ca98b3cbd3a1a34862d3d	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.8.0	\N	\N	3555338231
8.0.0-updating-credential-data-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2023-05-08 14:15:39.447927	74	MARK_RAN	8:f58ad148698cf30707a6efbdf8061aa7	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.8.0	\N	\N	3555338231
8.0.0-credential-cleanup-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2023-05-08 14:15:39.457828	75	EXECUTED	8:79e4fd6c6442980e58d52ffc3ee7b19c	dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...		\N	4.8.0	\N	\N	3555338231
8.0.0-resource-tag-support	keycloak	META-INF/jpa-changelog-8.0.0.xml	2023-05-08 14:15:39.464949	76	EXECUTED	8:87af6a1e6d241ca4b15801d1f86a297d	addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL		\N	4.8.0	\N	\N	3555338231
9.0.0-always-display-client	keycloak	META-INF/jpa-changelog-9.0.0.xml	2023-05-08 14:15:39.466517	77	EXECUTED	8:b44f8d9b7b6ea455305a6d72a200ed15	addColumn tableName=CLIENT		\N	4.8.0	\N	\N	3555338231
9.0.0-drop-constraints-for-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2023-05-08 14:15:39.467144	78	MARK_RAN	8:2d8ed5aaaeffd0cb004c046b4a903ac5	dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...		\N	4.8.0	\N	\N	3555338231
9.0.0-increase-column-size-federated-fk	keycloak	META-INF/jpa-changelog-9.0.0.xml	2023-05-08 14:15:39.473595	79	EXECUTED	8:e290c01fcbc275326c511633f6e2acde	modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...		\N	4.8.0	\N	\N	3555338231
9.0.0-recreate-constraints-after-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2023-05-08 14:15:39.474297	80	MARK_RAN	8:c9db8784c33cea210872ac2d805439f8	addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...		\N	4.8.0	\N	\N	3555338231
9.0.1-add-index-to-client.client_id	keycloak	META-INF/jpa-changelog-9.0.1.xml	2023-05-08 14:15:39.480022	81	EXECUTED	8:95b676ce8fc546a1fcfb4c92fae4add5	createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT		\N	4.8.0	\N	\N	3555338231
9.0.1-KEYCLOAK-12579-drop-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2023-05-08 14:15:39.480813	82	MARK_RAN	8:38a6b2a41f5651018b1aca93a41401e5	dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.8.0	\N	\N	3555338231
9.0.1-KEYCLOAK-12579-add-not-null-constraint	keycloak	META-INF/jpa-changelog-9.0.1.xml	2023-05-08 14:15:39.482175	83	EXECUTED	8:3fb99bcad86a0229783123ac52f7609c	addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP		\N	4.8.0	\N	\N	3555338231
9.0.1-KEYCLOAK-12579-recreate-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2023-05-08 14:15:39.482749	84	MARK_RAN	8:64f27a6fdcad57f6f9153210f2ec1bdb	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.8.0	\N	\N	3555338231
9.0.1-add-index-to-events	keycloak	META-INF/jpa-changelog-9.0.1.xml	2023-05-08 14:15:39.487962	85	EXECUTED	8:ab4f863f39adafd4c862f7ec01890abc	createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY		\N	4.8.0	\N	\N	3555338231
map-remove-ri	keycloak	META-INF/jpa-changelog-11.0.0.xml	2023-05-08 14:15:39.490419	86	EXECUTED	8:13c419a0eb336e91ee3a3bf8fda6e2a7	dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9		\N	4.8.0	\N	\N	3555338231
map-remove-ri	keycloak	META-INF/jpa-changelog-12.0.0.xml	2023-05-08 14:15:39.492912	87	EXECUTED	8:e3fb1e698e0471487f51af1ed80fe3ac	dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...		\N	4.8.0	\N	\N	3555338231
12.1.0-add-realm-localization-table	keycloak	META-INF/jpa-changelog-12.0.0.xml	2023-05-08 14:15:39.497832	88	EXECUTED	8:babadb686aab7b56562817e60bf0abd0	createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS		\N	4.8.0	\N	\N	3555338231
default-roles	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-05-08 14:15:39.50039	89	EXECUTED	8:72d03345fda8e2f17093d08801947773	addColumn tableName=REALM; customChange		\N	4.8.0	\N	\N	3555338231
default-roles-cleanup	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-05-08 14:15:39.50331	90	EXECUTED	8:61c9233951bd96ffecd9ba75f7d978a4	dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES		\N	4.8.0	\N	\N	3555338231
13.0.0-KEYCLOAK-16844	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-05-08 14:15:39.509146	91	EXECUTED	8:ea82e6ad945cec250af6372767b25525	createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION		\N	4.8.0	\N	\N	3555338231
map-remove-ri-13.0.0	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-05-08 14:15:39.51252	92	EXECUTED	8:d3f4a33f41d960ddacd7e2ef30d126b3	dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...		\N	4.8.0	\N	\N	3555338231
13.0.0-KEYCLOAK-17992-drop-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-05-08 14:15:39.51338	93	MARK_RAN	8:1284a27fbd049d65831cb6fc07c8a783	dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT		\N	4.8.0	\N	\N	3555338231
13.0.0-increase-column-size-federated	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-05-08 14:15:39.516484	94	EXECUTED	8:9d11b619db2ae27c25853b8a37cd0dea	modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT		\N	4.8.0	\N	\N	3555338231
13.0.0-KEYCLOAK-17992-recreate-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-05-08 14:15:39.517184	95	MARK_RAN	8:3002bb3997451bb9e8bac5c5cd8d6327	addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...		\N	4.8.0	\N	\N	3555338231
json-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-05-08 14:15:39.520178	96	EXECUTED	8:dfbee0d6237a23ef4ccbb7a4e063c163	addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE		\N	4.8.0	\N	\N	3555338231
14.0.0-KEYCLOAK-11019	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-05-08 14:15:39.536234	97	EXECUTED	8:75f3e372df18d38c62734eebb986b960	createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION		\N	4.8.0	\N	\N	3555338231
14.0.0-KEYCLOAK-18286	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-05-08 14:15:39.537063	98	MARK_RAN	8:7fee73eddf84a6035691512c85637eef	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	3555338231
14.0.0-KEYCLOAK-18286-revert	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-05-08 14:15:39.541085	99	MARK_RAN	8:7a11134ab12820f999fbf3bb13c3adc8	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	3555338231
14.0.0-KEYCLOAK-18286-supported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-05-08 14:15:39.547226	100	EXECUTED	8:c0f6eaac1f3be773ffe54cb5b8482b70	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	3555338231
14.0.0-KEYCLOAK-18286-unsupported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-05-08 14:15:39.547996	101	MARK_RAN	8:18186f0008b86e0f0f49b0c4d0e842ac	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	3555338231
KEYCLOAK-17267-add-index-to-user-attributes	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-05-08 14:15:39.553044	102	EXECUTED	8:09c2780bcb23b310a7019d217dc7b433	createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE		\N	4.8.0	\N	\N	3555338231
KEYCLOAK-18146-add-saml-art-binding-identifier	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-05-08 14:15:39.554511	103	EXECUTED	8:276a44955eab693c970a42880197fff2	customChange		\N	4.8.0	\N	\N	3555338231
15.0.0-KEYCLOAK-18467	keycloak	META-INF/jpa-changelog-15.0.0.xml	2023-05-08 14:15:39.557061	104	EXECUTED	8:ba8ee3b694d043f2bfc1a1079d0760d7	addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...		\N	4.8.0	\N	\N	3555338231
17.0.0-9562	keycloak	META-INF/jpa-changelog-17.0.0.xml	2023-05-08 14:15:39.562184	105	EXECUTED	8:5e06b1d75f5d17685485e610c2851b17	createIndex indexName=IDX_USER_SERVICE_ACCOUNT, tableName=USER_ENTITY		\N	4.8.0	\N	\N	3555338231
18.0.0-10625-IDX_ADMIN_EVENT_TIME	keycloak	META-INF/jpa-changelog-18.0.0.xml	2023-05-08 14:15:39.567167	106	EXECUTED	8:4b80546c1dc550ac552ee7b24a4ab7c0	createIndex indexName=IDX_ADMIN_EVENT_TIME, tableName=ADMIN_EVENT_ENTITY		\N	4.8.0	\N	\N	3555338231
19.0.0-10135	keycloak	META-INF/jpa-changelog-19.0.0.xml	2023-05-08 14:15:39.568727	107	EXECUTED	8:af510cd1bb2ab6339c45372f3e491696	customChange		\N	4.8.0	\N	\N	3555338231
\.


--
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
1000	f	\N	\N
1001	f	\N	\N
\.


--
-- Data for Name: default_client_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.default_client_scope (realm_id, scope_id, default_scope) FROM stdin;
c801dbb6-9ca3-4c23-ad63-1946842fef6b	714f2e31-4609-453f-9d20-67ad85c3f4b5	f
c801dbb6-9ca3-4c23-ad63-1946842fef6b	f1157cd1-88c9-4021-8aea-704abf0a25eb	t
c801dbb6-9ca3-4c23-ad63-1946842fef6b	e5091011-e71b-43e6-9c6d-3dad4b98fab1	t
c801dbb6-9ca3-4c23-ad63-1946842fef6b	0a92e094-92c4-4aaa-b8bf-0ba9ab16cf22	t
c801dbb6-9ca3-4c23-ad63-1946842fef6b	f62f49f0-a3fa-4123-b076-246859393cc0	f
c801dbb6-9ca3-4c23-ad63-1946842fef6b	38ab7168-1818-4f79-ad18-e94abb949e84	f
c801dbb6-9ca3-4c23-ad63-1946842fef6b	eb4fadf3-e7de-4618-afc3-4f4aa6d0f567	t
c801dbb6-9ca3-4c23-ad63-1946842fef6b	6fa0d628-a0d1-4d8f-91ec-d26e39ec74b8	t
c801dbb6-9ca3-4c23-ad63-1946842fef6b	e9001f98-9a53-407f-a8d1-9cd0cc518afa	f
c801dbb6-9ca3-4c23-ad63-1946842fef6b	52a9f12f-ee5a-481a-b8ce-67733ccd9578	t
97c3a519-e834-45b3-aeca-7eb9552a7e49	2c4d73e5-637f-41dd-badd-95a25981f3cd	f
97c3a519-e834-45b3-aeca-7eb9552a7e49	cbfd286a-b181-4b3a-87f5-6bd7bf8fc66c	t
97c3a519-e834-45b3-aeca-7eb9552a7e49	d594a42f-9fe9-4fdc-adbe-83af44961325	t
97c3a519-e834-45b3-aeca-7eb9552a7e49	cd4d4eae-7a6e-4a8d-85b1-384f2323af5e	t
97c3a519-e834-45b3-aeca-7eb9552a7e49	9949741e-4dff-4b58-9aa3-187fec2b8410	f
97c3a519-e834-45b3-aeca-7eb9552a7e49	1d93e603-29d1-42b4-bc30-899cd8a707da	f
97c3a519-e834-45b3-aeca-7eb9552a7e49	de1a4f93-9c77-45eb-a52b-59806e316cf7	t
97c3a519-e834-45b3-aeca-7eb9552a7e49	05db5e88-6d9d-43bf-ad99-f2eec3962c60	t
97c3a519-e834-45b3-aeca-7eb9552a7e49	19283dfb-d711-4819-8a71-f96ccfd51d10	f
97c3a519-e834-45b3-aeca-7eb9552a7e49	97eca1dc-a2c0-421e-affb-34476bb0f4b9	t
\.


--
-- Data for Name: event_entity; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.event_entity (id, client_id, details_json, error, ip_address, realm_id, session_id, event_time, type, user_id) FROM stdin;
\.


--
-- Data for Name: fed_user_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_attribute (id, name, user_id, realm_id, storage_provider_id, value) FROM stdin;
\.


--
-- Data for Name: fed_user_consent; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_consent (id, client_id, user_id, realm_id, storage_provider_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: fed_user_consent_cl_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_consent_cl_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: fed_user_credential; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_credential (id, salt, type, created_date, user_id, realm_id, storage_provider_id, user_label, secret_data, credential_data, priority) FROM stdin;
\.


--
-- Data for Name: fed_user_group_membership; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_group_membership (group_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_required_action; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_required_action (required_action, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_role_mapping (role_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: federated_identity; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.federated_identity (identity_provider, realm_id, federated_user_id, federated_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: federated_user; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.federated_user (id, storage_provider_id, realm_id) FROM stdin;
\.


--
-- Data for Name: group_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.group_attribute (id, name, value, group_id) FROM stdin;
\.


--
-- Data for Name: group_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.group_role_mapping (role_id, group_id) FROM stdin;
a06ee5f8-5d50-4b2c-bfa9-c44c02e6250f	3b1ce55f-daa0-40df-a33a-43a2a50580ef
1cd72533-b9f2-4089-87af-f45016d1edad	3b1ce55f-daa0-40df-a33a-43a2a50580ef
76131968-3ce1-4848-9256-edac290701e8	3b1ce55f-daa0-40df-a33a-43a2a50580ef
66bf650c-40d8-49ee-8a43-063acb4ddeaf	3b1ce55f-daa0-40df-a33a-43a2a50580ef
b91a52e9-7fb1-4857-8b81-415c9eacb7c9	3b1ce55f-daa0-40df-a33a-43a2a50580ef
3db0c21c-9365-4cb1-a8d4-cd46b5c42242	3b1ce55f-daa0-40df-a33a-43a2a50580ef
32a28099-f91a-4acb-bb90-8edba8f3347f	3b1ce55f-daa0-40df-a33a-43a2a50580ef
fabed5cc-f4b4-44e0-9050-1e61b1aa5fdf	3b1ce55f-daa0-40df-a33a-43a2a50580ef
abaa4bf0-6b47-4632-ad91-6fb9da687058	3b1ce55f-daa0-40df-a33a-43a2a50580ef
a1fff27d-5c93-4735-a1d3-f7854fad0c6e	3b1ce55f-daa0-40df-a33a-43a2a50580ef
dec5152b-c755-4063-99bb-483cce89af70	3b1ce55f-daa0-40df-a33a-43a2a50580ef
cd766e07-c6bb-4af6-8347-8906f1bdcae9	3b1ce55f-daa0-40df-a33a-43a2a50580ef
48b5dd31-9371-4b17-aff4-754c61314cae	3b1ce55f-daa0-40df-a33a-43a2a50580ef
8598c3f6-e6df-4590-bad5-8a3e814976cb	3b1ce55f-daa0-40df-a33a-43a2a50580ef
3fb5d1fa-4f0f-469e-9229-e4988527c56c	3b1ce55f-daa0-40df-a33a-43a2a50580ef
4cefe907-757a-4db2-99a9-f2f0dfdc4995	3b1ce55f-daa0-40df-a33a-43a2a50580ef
5535056e-62b5-411b-954b-815fba85f7b1	3b1ce55f-daa0-40df-a33a-43a2a50580ef
e877edb3-2392-4a3c-aa19-4e39ab40de48	3b1ce55f-daa0-40df-a33a-43a2a50580ef
9b048fe9-850b-4b79-84bf-8dca1997a241	3b1ce55f-daa0-40df-a33a-43a2a50580ef
a580ab42-7a8b-43e0-9e70-f129e1bf9ae9	3b1ce55f-daa0-40df-a33a-43a2a50580ef
533f462c-1508-4391-a7ca-2677caf76a62	3b1ce55f-daa0-40df-a33a-43a2a50580ef
cef8abcc-bb8e-43fc-8909-cc4dd27ca8df	3b1ce55f-daa0-40df-a33a-43a2a50580ef
198d9211-4d19-4ca3-b121-b5053b979a41	3b1ce55f-daa0-40df-a33a-43a2a50580ef
219180a9-f79a-4a84-9dfd-3dbc4cac71df	3b1ce55f-daa0-40df-a33a-43a2a50580ef
5dfca332-2005-46e9-a734-92651dbecb7b	3b1ce55f-daa0-40df-a33a-43a2a50580ef
12acede8-fe1e-462a-832f-f1f69982b547	3b1ce55f-daa0-40df-a33a-43a2a50580ef
\.


--
-- Data for Name: identity_provider; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.identity_provider (internal_id, enabled, provider_alias, provider_id, store_token, authenticate_by_default, realm_id, add_token_role, trust_email, first_broker_login_flow_id, post_broker_login_flow_id, provider_display_name, link_only) FROM stdin;
\.


--
-- Data for Name: identity_provider_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.identity_provider_config (identity_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: identity_provider_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.identity_provider_mapper (id, name, idp_alias, idp_mapper_name, realm_id) FROM stdin;
\.


--
-- Data for Name: idp_mapper_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.idp_mapper_config (idp_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: keycloak_group; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.keycloak_group (id, name, parent_group, realm_id) FROM stdin;
3b1ce55f-daa0-40df-a33a-43a2a50580ef	OmnisUserGroup	 	97c3a519-e834-45b3-aeca-7eb9552a7e49
\.


--
-- Data for Name: keycloak_role; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) FROM stdin;
6537ee5a-325e-45fe-a57d-68e71ca3a991	c801dbb6-9ca3-4c23-ad63-1946842fef6b	f	${role_default-roles}	default-roles-master	c801dbb6-9ca3-4c23-ad63-1946842fef6b	\N	\N
47b2d91b-8d7b-4abe-aaeb-0d9ad4b08e11	c801dbb6-9ca3-4c23-ad63-1946842fef6b	f	${role_admin}	admin	c801dbb6-9ca3-4c23-ad63-1946842fef6b	\N	\N
c948e6fa-47fe-4674-8556-a8e88b34c188	c801dbb6-9ca3-4c23-ad63-1946842fef6b	f	${role_create-realm}	create-realm	c801dbb6-9ca3-4c23-ad63-1946842fef6b	\N	\N
6365711e-6226-4db2-97b7-e4073e4533b2	a6441220-7d8d-4c25-a07a-db8b6dcaaff0	t	${role_create-client}	create-client	c801dbb6-9ca3-4c23-ad63-1946842fef6b	a6441220-7d8d-4c25-a07a-db8b6dcaaff0	\N
2affedb5-0719-4009-9638-a5037cfbd590	a6441220-7d8d-4c25-a07a-db8b6dcaaff0	t	${role_view-realm}	view-realm	c801dbb6-9ca3-4c23-ad63-1946842fef6b	a6441220-7d8d-4c25-a07a-db8b6dcaaff0	\N
84457725-6cf7-47a8-b4db-cb42c4d8bcc7	a6441220-7d8d-4c25-a07a-db8b6dcaaff0	t	${role_view-users}	view-users	c801dbb6-9ca3-4c23-ad63-1946842fef6b	a6441220-7d8d-4c25-a07a-db8b6dcaaff0	\N
e0edfe3d-4477-4283-9577-f9f91695a17c	a6441220-7d8d-4c25-a07a-db8b6dcaaff0	t	${role_view-clients}	view-clients	c801dbb6-9ca3-4c23-ad63-1946842fef6b	a6441220-7d8d-4c25-a07a-db8b6dcaaff0	\N
23331682-5e79-4ae8-a7ac-65045bada7a1	a6441220-7d8d-4c25-a07a-db8b6dcaaff0	t	${role_view-events}	view-events	c801dbb6-9ca3-4c23-ad63-1946842fef6b	a6441220-7d8d-4c25-a07a-db8b6dcaaff0	\N
413da4a5-cc43-4c7d-b8e3-d68460452d8f	a6441220-7d8d-4c25-a07a-db8b6dcaaff0	t	${role_view-identity-providers}	view-identity-providers	c801dbb6-9ca3-4c23-ad63-1946842fef6b	a6441220-7d8d-4c25-a07a-db8b6dcaaff0	\N
fed8fd51-4317-4c96-b2d7-919b9bf0a21d	a6441220-7d8d-4c25-a07a-db8b6dcaaff0	t	${role_view-authorization}	view-authorization	c801dbb6-9ca3-4c23-ad63-1946842fef6b	a6441220-7d8d-4c25-a07a-db8b6dcaaff0	\N
3d78f377-e3d0-4969-88a4-a07fba8a7f00	a6441220-7d8d-4c25-a07a-db8b6dcaaff0	t	${role_manage-realm}	manage-realm	c801dbb6-9ca3-4c23-ad63-1946842fef6b	a6441220-7d8d-4c25-a07a-db8b6dcaaff0	\N
84342f80-3a93-46c0-9d62-6f2a18ae88ae	a6441220-7d8d-4c25-a07a-db8b6dcaaff0	t	${role_manage-users}	manage-users	c801dbb6-9ca3-4c23-ad63-1946842fef6b	a6441220-7d8d-4c25-a07a-db8b6dcaaff0	\N
b9609fe2-f153-4048-84b8-04c120c8dc29	a6441220-7d8d-4c25-a07a-db8b6dcaaff0	t	${role_manage-clients}	manage-clients	c801dbb6-9ca3-4c23-ad63-1946842fef6b	a6441220-7d8d-4c25-a07a-db8b6dcaaff0	\N
254c95fc-dfe6-4606-8ccc-a4113b59f3d0	a6441220-7d8d-4c25-a07a-db8b6dcaaff0	t	${role_manage-events}	manage-events	c801dbb6-9ca3-4c23-ad63-1946842fef6b	a6441220-7d8d-4c25-a07a-db8b6dcaaff0	\N
7efef5fa-c467-4939-b35f-4cf26ba61764	a6441220-7d8d-4c25-a07a-db8b6dcaaff0	t	${role_manage-identity-providers}	manage-identity-providers	c801dbb6-9ca3-4c23-ad63-1946842fef6b	a6441220-7d8d-4c25-a07a-db8b6dcaaff0	\N
66fe1aa0-46b3-4aea-9c00-6f07f2bfc28f	a6441220-7d8d-4c25-a07a-db8b6dcaaff0	t	${role_manage-authorization}	manage-authorization	c801dbb6-9ca3-4c23-ad63-1946842fef6b	a6441220-7d8d-4c25-a07a-db8b6dcaaff0	\N
56013eab-1835-40f3-a38b-c0f7f585c488	a6441220-7d8d-4c25-a07a-db8b6dcaaff0	t	${role_query-users}	query-users	c801dbb6-9ca3-4c23-ad63-1946842fef6b	a6441220-7d8d-4c25-a07a-db8b6dcaaff0	\N
9101ded1-70da-44cc-904f-eab391962f04	a6441220-7d8d-4c25-a07a-db8b6dcaaff0	t	${role_query-clients}	query-clients	c801dbb6-9ca3-4c23-ad63-1946842fef6b	a6441220-7d8d-4c25-a07a-db8b6dcaaff0	\N
6f97a505-0b84-4ee8-82e6-40039b9d0e45	a6441220-7d8d-4c25-a07a-db8b6dcaaff0	t	${role_query-realms}	query-realms	c801dbb6-9ca3-4c23-ad63-1946842fef6b	a6441220-7d8d-4c25-a07a-db8b6dcaaff0	\N
6264bc98-afad-4776-b5b4-afa354d62a23	a6441220-7d8d-4c25-a07a-db8b6dcaaff0	t	${role_query-groups}	query-groups	c801dbb6-9ca3-4c23-ad63-1946842fef6b	a6441220-7d8d-4c25-a07a-db8b6dcaaff0	\N
c0f24659-8581-44e2-a3ad-cadbc152bffc	4baf3ada-e710-46b8-9b40-5d1bfeaf4597	t	${role_view-profile}	view-profile	c801dbb6-9ca3-4c23-ad63-1946842fef6b	4baf3ada-e710-46b8-9b40-5d1bfeaf4597	\N
96679f24-2cb5-4b44-acc8-91b3cb50e3f0	4baf3ada-e710-46b8-9b40-5d1bfeaf4597	t	${role_manage-account}	manage-account	c801dbb6-9ca3-4c23-ad63-1946842fef6b	4baf3ada-e710-46b8-9b40-5d1bfeaf4597	\N
e9eae5dc-bfe8-442a-8c47-0bf2c69e26fa	4baf3ada-e710-46b8-9b40-5d1bfeaf4597	t	${role_manage-account-links}	manage-account-links	c801dbb6-9ca3-4c23-ad63-1946842fef6b	4baf3ada-e710-46b8-9b40-5d1bfeaf4597	\N
ad5607a0-a96c-4ab3-958a-36742ade5c5a	4baf3ada-e710-46b8-9b40-5d1bfeaf4597	t	${role_view-applications}	view-applications	c801dbb6-9ca3-4c23-ad63-1946842fef6b	4baf3ada-e710-46b8-9b40-5d1bfeaf4597	\N
aed2eba5-dec4-46ea-8cd5-ed0ca704d62b	4baf3ada-e710-46b8-9b40-5d1bfeaf4597	t	${role_view-consent}	view-consent	c801dbb6-9ca3-4c23-ad63-1946842fef6b	4baf3ada-e710-46b8-9b40-5d1bfeaf4597	\N
ca6b1d93-bccf-46f4-93e3-25b350074a7e	4baf3ada-e710-46b8-9b40-5d1bfeaf4597	t	${role_manage-consent}	manage-consent	c801dbb6-9ca3-4c23-ad63-1946842fef6b	4baf3ada-e710-46b8-9b40-5d1bfeaf4597	\N
02e8c850-21dc-439c-a846-8db5a9b37f47	4baf3ada-e710-46b8-9b40-5d1bfeaf4597	t	${role_delete-account}	delete-account	c801dbb6-9ca3-4c23-ad63-1946842fef6b	4baf3ada-e710-46b8-9b40-5d1bfeaf4597	\N
699bb1f7-eeb8-42b1-b7bf-b7ef3e782241	c7d8a24b-00dc-4dd0-8d35-62261ad32f0b	t	${role_read-token}	read-token	c801dbb6-9ca3-4c23-ad63-1946842fef6b	c7d8a24b-00dc-4dd0-8d35-62261ad32f0b	\N
7a86eb27-9908-4587-a744-0f9e355258f2	a6441220-7d8d-4c25-a07a-db8b6dcaaff0	t	${role_impersonation}	impersonation	c801dbb6-9ca3-4c23-ad63-1946842fef6b	a6441220-7d8d-4c25-a07a-db8b6dcaaff0	\N
bc76a878-37e1-4168-9752-5b8c05226275	c801dbb6-9ca3-4c23-ad63-1946842fef6b	f	${role_offline-access}	offline_access	c801dbb6-9ca3-4c23-ad63-1946842fef6b	\N	\N
4ea1901e-a7fb-4477-a4e1-3eef7f6c5b51	c801dbb6-9ca3-4c23-ad63-1946842fef6b	f	${role_uma_authorization}	uma_authorization	c801dbb6-9ca3-4c23-ad63-1946842fef6b	\N	\N
1c4dee70-4cf0-4218-9fa9-b95c0a710886	97c3a519-e834-45b3-aeca-7eb9552a7e49	f	${role_default-roles}	default-roles-omnis	97c3a519-e834-45b3-aeca-7eb9552a7e49	\N	\N
e76c8ff7-ed2f-4887-a72d-77c1f78f8a05	7ca1ce99-6a05-4290-b9a9-8070dab16cf0	t	${role_create-client}	create-client	c801dbb6-9ca3-4c23-ad63-1946842fef6b	7ca1ce99-6a05-4290-b9a9-8070dab16cf0	\N
47ede815-30b6-4f27-9413-fc0c50336dbb	7ca1ce99-6a05-4290-b9a9-8070dab16cf0	t	${role_view-realm}	view-realm	c801dbb6-9ca3-4c23-ad63-1946842fef6b	7ca1ce99-6a05-4290-b9a9-8070dab16cf0	\N
25943332-c4ca-41fe-9869-309f9a84bed3	7ca1ce99-6a05-4290-b9a9-8070dab16cf0	t	${role_view-users}	view-users	c801dbb6-9ca3-4c23-ad63-1946842fef6b	7ca1ce99-6a05-4290-b9a9-8070dab16cf0	\N
4185b06c-f40d-4296-b0f1-ad1bfdb84c18	7ca1ce99-6a05-4290-b9a9-8070dab16cf0	t	${role_view-clients}	view-clients	c801dbb6-9ca3-4c23-ad63-1946842fef6b	7ca1ce99-6a05-4290-b9a9-8070dab16cf0	\N
00ccbfd0-0dc6-4b1f-ad60-e21d3dd47c2d	7ca1ce99-6a05-4290-b9a9-8070dab16cf0	t	${role_view-events}	view-events	c801dbb6-9ca3-4c23-ad63-1946842fef6b	7ca1ce99-6a05-4290-b9a9-8070dab16cf0	\N
855d464d-4068-44d7-87d9-763f89bb516b	7ca1ce99-6a05-4290-b9a9-8070dab16cf0	t	${role_view-identity-providers}	view-identity-providers	c801dbb6-9ca3-4c23-ad63-1946842fef6b	7ca1ce99-6a05-4290-b9a9-8070dab16cf0	\N
40d9a219-8b78-4ad2-b7d4-c0ac9384997f	7ca1ce99-6a05-4290-b9a9-8070dab16cf0	t	${role_view-authorization}	view-authorization	c801dbb6-9ca3-4c23-ad63-1946842fef6b	7ca1ce99-6a05-4290-b9a9-8070dab16cf0	\N
75884b9c-3a12-4bcb-93a1-2efa20cee9b4	7ca1ce99-6a05-4290-b9a9-8070dab16cf0	t	${role_manage-realm}	manage-realm	c801dbb6-9ca3-4c23-ad63-1946842fef6b	7ca1ce99-6a05-4290-b9a9-8070dab16cf0	\N
68ed575b-254d-442c-aff4-aebdde13bd03	7ca1ce99-6a05-4290-b9a9-8070dab16cf0	t	${role_manage-users}	manage-users	c801dbb6-9ca3-4c23-ad63-1946842fef6b	7ca1ce99-6a05-4290-b9a9-8070dab16cf0	\N
b315154c-b374-446b-a12f-a24cc1b5a964	7ca1ce99-6a05-4290-b9a9-8070dab16cf0	t	${role_manage-clients}	manage-clients	c801dbb6-9ca3-4c23-ad63-1946842fef6b	7ca1ce99-6a05-4290-b9a9-8070dab16cf0	\N
6a3c6da3-60c2-4d7f-b164-e40933030106	7ca1ce99-6a05-4290-b9a9-8070dab16cf0	t	${role_manage-events}	manage-events	c801dbb6-9ca3-4c23-ad63-1946842fef6b	7ca1ce99-6a05-4290-b9a9-8070dab16cf0	\N
a5ebf57a-7153-4612-9dad-775b82f9d808	7ca1ce99-6a05-4290-b9a9-8070dab16cf0	t	${role_manage-identity-providers}	manage-identity-providers	c801dbb6-9ca3-4c23-ad63-1946842fef6b	7ca1ce99-6a05-4290-b9a9-8070dab16cf0	\N
c4af971b-f302-49b6-96d0-c487aa1f952d	7ca1ce99-6a05-4290-b9a9-8070dab16cf0	t	${role_manage-authorization}	manage-authorization	c801dbb6-9ca3-4c23-ad63-1946842fef6b	7ca1ce99-6a05-4290-b9a9-8070dab16cf0	\N
bc3526a1-f236-4809-a1df-b019f7f0571c	7ca1ce99-6a05-4290-b9a9-8070dab16cf0	t	${role_query-users}	query-users	c801dbb6-9ca3-4c23-ad63-1946842fef6b	7ca1ce99-6a05-4290-b9a9-8070dab16cf0	\N
ce6ed041-0fed-405b-98c3-d763b25f6931	7ca1ce99-6a05-4290-b9a9-8070dab16cf0	t	${role_query-clients}	query-clients	c801dbb6-9ca3-4c23-ad63-1946842fef6b	7ca1ce99-6a05-4290-b9a9-8070dab16cf0	\N
a0cfc807-8e12-4871-be62-89a83b9639f7	7ca1ce99-6a05-4290-b9a9-8070dab16cf0	t	${role_query-realms}	query-realms	c801dbb6-9ca3-4c23-ad63-1946842fef6b	7ca1ce99-6a05-4290-b9a9-8070dab16cf0	\N
5e2c759c-7a60-403e-bda3-1df7f2267f1a	7ca1ce99-6a05-4290-b9a9-8070dab16cf0	t	${role_query-groups}	query-groups	c801dbb6-9ca3-4c23-ad63-1946842fef6b	7ca1ce99-6a05-4290-b9a9-8070dab16cf0	\N
c19931bf-b8bc-4b8c-a749-7275e000143c	31a936f1-8990-4ea8-92fd-a1e396039fe6	t	${role_realm-admin}	realm-admin	97c3a519-e834-45b3-aeca-7eb9552a7e49	31a936f1-8990-4ea8-92fd-a1e396039fe6	\N
314ee546-57cd-4417-a907-02d92aae8163	31a936f1-8990-4ea8-92fd-a1e396039fe6	t	${role_create-client}	create-client	97c3a519-e834-45b3-aeca-7eb9552a7e49	31a936f1-8990-4ea8-92fd-a1e396039fe6	\N
0fd169cf-970a-4f57-9941-302086149f8a	31a936f1-8990-4ea8-92fd-a1e396039fe6	t	${role_view-realm}	view-realm	97c3a519-e834-45b3-aeca-7eb9552a7e49	31a936f1-8990-4ea8-92fd-a1e396039fe6	\N
cba9f998-41a1-46e7-bbaa-e8f915c75f52	31a936f1-8990-4ea8-92fd-a1e396039fe6	t	${role_view-users}	view-users	97c3a519-e834-45b3-aeca-7eb9552a7e49	31a936f1-8990-4ea8-92fd-a1e396039fe6	\N
f6b8a722-a3d8-4dfc-9567-e5dd4c484947	31a936f1-8990-4ea8-92fd-a1e396039fe6	t	${role_view-clients}	view-clients	97c3a519-e834-45b3-aeca-7eb9552a7e49	31a936f1-8990-4ea8-92fd-a1e396039fe6	\N
736ece19-2297-44dc-b134-00f9264f6baf	31a936f1-8990-4ea8-92fd-a1e396039fe6	t	${role_view-events}	view-events	97c3a519-e834-45b3-aeca-7eb9552a7e49	31a936f1-8990-4ea8-92fd-a1e396039fe6	\N
7feb0a8d-f007-4b12-b9f4-160b73465869	31a936f1-8990-4ea8-92fd-a1e396039fe6	t	${role_view-identity-providers}	view-identity-providers	97c3a519-e834-45b3-aeca-7eb9552a7e49	31a936f1-8990-4ea8-92fd-a1e396039fe6	\N
bf16ad4f-50f2-49ca-9084-ad9299353387	31a936f1-8990-4ea8-92fd-a1e396039fe6	t	${role_view-authorization}	view-authorization	97c3a519-e834-45b3-aeca-7eb9552a7e49	31a936f1-8990-4ea8-92fd-a1e396039fe6	\N
b7128eb4-9655-4411-9cd2-9fcf10b4470a	31a936f1-8990-4ea8-92fd-a1e396039fe6	t	${role_manage-realm}	manage-realm	97c3a519-e834-45b3-aeca-7eb9552a7e49	31a936f1-8990-4ea8-92fd-a1e396039fe6	\N
2eb2d53c-0e8d-49ec-8568-3ec978efed8a	31a936f1-8990-4ea8-92fd-a1e396039fe6	t	${role_manage-users}	manage-users	97c3a519-e834-45b3-aeca-7eb9552a7e49	31a936f1-8990-4ea8-92fd-a1e396039fe6	\N
9975ff84-736a-4496-a0a9-0a7d508d286c	31a936f1-8990-4ea8-92fd-a1e396039fe6	t	${role_manage-clients}	manage-clients	97c3a519-e834-45b3-aeca-7eb9552a7e49	31a936f1-8990-4ea8-92fd-a1e396039fe6	\N
58ed4dab-e1d0-4e69-b372-d0c563d95bdd	31a936f1-8990-4ea8-92fd-a1e396039fe6	t	${role_manage-events}	manage-events	97c3a519-e834-45b3-aeca-7eb9552a7e49	31a936f1-8990-4ea8-92fd-a1e396039fe6	\N
dacb7933-93dc-4fbb-9c8c-eefbc2c1d325	31a936f1-8990-4ea8-92fd-a1e396039fe6	t	${role_manage-identity-providers}	manage-identity-providers	97c3a519-e834-45b3-aeca-7eb9552a7e49	31a936f1-8990-4ea8-92fd-a1e396039fe6	\N
fba82127-abdc-450f-9cba-c4daf8251ec4	31a936f1-8990-4ea8-92fd-a1e396039fe6	t	${role_manage-authorization}	manage-authorization	97c3a519-e834-45b3-aeca-7eb9552a7e49	31a936f1-8990-4ea8-92fd-a1e396039fe6	\N
b26413fb-8900-4186-b4c2-3c4bead53bd3	31a936f1-8990-4ea8-92fd-a1e396039fe6	t	${role_query-users}	query-users	97c3a519-e834-45b3-aeca-7eb9552a7e49	31a936f1-8990-4ea8-92fd-a1e396039fe6	\N
1caac4df-6669-41b7-a70f-275a31779330	31a936f1-8990-4ea8-92fd-a1e396039fe6	t	${role_query-clients}	query-clients	97c3a519-e834-45b3-aeca-7eb9552a7e49	31a936f1-8990-4ea8-92fd-a1e396039fe6	\N
4c70cc23-3e22-4d50-a3cf-460997f35fe7	31a936f1-8990-4ea8-92fd-a1e396039fe6	t	${role_query-realms}	query-realms	97c3a519-e834-45b3-aeca-7eb9552a7e49	31a936f1-8990-4ea8-92fd-a1e396039fe6	\N
e45f61cb-48c2-473a-b690-879f9c121399	31a936f1-8990-4ea8-92fd-a1e396039fe6	t	${role_query-groups}	query-groups	97c3a519-e834-45b3-aeca-7eb9552a7e49	31a936f1-8990-4ea8-92fd-a1e396039fe6	\N
2e419e1a-ad99-42c1-9acf-07f5e9645e5b	598bff12-62ca-4834-84b9-1c82e941d841	t	${role_view-profile}	view-profile	97c3a519-e834-45b3-aeca-7eb9552a7e49	598bff12-62ca-4834-84b9-1c82e941d841	\N
63ef9c07-e52b-46d5-a5d6-0a803a8314c5	598bff12-62ca-4834-84b9-1c82e941d841	t	${role_manage-account}	manage-account	97c3a519-e834-45b3-aeca-7eb9552a7e49	598bff12-62ca-4834-84b9-1c82e941d841	\N
4a9c3184-6308-4e0a-af60-1824cf08ad63	598bff12-62ca-4834-84b9-1c82e941d841	t	${role_manage-account-links}	manage-account-links	97c3a519-e834-45b3-aeca-7eb9552a7e49	598bff12-62ca-4834-84b9-1c82e941d841	\N
8fdfb2e5-8042-4d71-90a9-d795f182ecaf	598bff12-62ca-4834-84b9-1c82e941d841	t	${role_view-applications}	view-applications	97c3a519-e834-45b3-aeca-7eb9552a7e49	598bff12-62ca-4834-84b9-1c82e941d841	\N
15ed7c44-1384-471f-8dfd-ddd359d67ba7	598bff12-62ca-4834-84b9-1c82e941d841	t	${role_view-consent}	view-consent	97c3a519-e834-45b3-aeca-7eb9552a7e49	598bff12-62ca-4834-84b9-1c82e941d841	\N
c4e048ff-e9aa-493e-bc51-995082d0ca88	598bff12-62ca-4834-84b9-1c82e941d841	t	${role_manage-consent}	manage-consent	97c3a519-e834-45b3-aeca-7eb9552a7e49	598bff12-62ca-4834-84b9-1c82e941d841	\N
103a6df3-8685-4be8-8674-4a4a19a5c114	598bff12-62ca-4834-84b9-1c82e941d841	t	${role_delete-account}	delete-account	97c3a519-e834-45b3-aeca-7eb9552a7e49	598bff12-62ca-4834-84b9-1c82e941d841	\N
72ebe76a-98e8-42e7-acda-0613e5b88aa0	7ca1ce99-6a05-4290-b9a9-8070dab16cf0	t	${role_impersonation}	impersonation	c801dbb6-9ca3-4c23-ad63-1946842fef6b	7ca1ce99-6a05-4290-b9a9-8070dab16cf0	\N
beef3a73-15c7-458d-a7b1-1ffc0f3301f3	31a936f1-8990-4ea8-92fd-a1e396039fe6	t	${role_impersonation}	impersonation	97c3a519-e834-45b3-aeca-7eb9552a7e49	31a936f1-8990-4ea8-92fd-a1e396039fe6	\N
17c3b9cc-91a2-45f8-8ad5-65036d74a4d5	b6a04fec-e20e-4053-b116-f51a85d8d931	t	${role_read-token}	read-token	97c3a519-e834-45b3-aeca-7eb9552a7e49	b6a04fec-e20e-4053-b116-f51a85d8d931	\N
42526fc0-ed41-411f-b6fc-8a74214604cc	97c3a519-e834-45b3-aeca-7eb9552a7e49	f	${role_offline-access}	offline_access	97c3a519-e834-45b3-aeca-7eb9552a7e49	\N	\N
5f01e211-c0af-43d3-86f5-5768fc2e2e3c	97c3a519-e834-45b3-aeca-7eb9552a7e49	f	${role_uma_authorization}	uma_authorization	97c3a519-e834-45b3-aeca-7eb9552a7e49	\N	\N
814f824a-9182-4370-9ad3-1d85d4a9bbff	97c3a519-e834-45b3-aeca-7eb9552a7e49	f	OmnisUser	OmnisUser	97c3a519-e834-45b3-aeca-7eb9552a7e49	\N	\N
b9b8631a-3b67-489f-8341-416a3765914f	053a6fde-90c3-4bca-a2bf-62bca14b8624	t	\N	uma_protection	97c3a519-e834-45b3-aeca-7eb9552a7e49	053a6fde-90c3-4bca-a2bf-62bca14b8624	\N
219180a9-f79a-4a84-9dfd-3dbc4cac71df	053a6fde-90c3-4bca-a2bf-62bca14b8624	t	Delete Candidate	delete-candidate	97c3a519-e834-45b3-aeca-7eb9552a7e49	053a6fde-90c3-4bca-a2bf-62bca14b8624	\N
198d9211-4d19-4ca3-b121-b5053b979a41	053a6fde-90c3-4bca-a2bf-62bca14b8624	t	Create Note	create-note	97c3a519-e834-45b3-aeca-7eb9552a7e49	053a6fde-90c3-4bca-a2bf-62bca14b8624	\N
12acede8-fe1e-462a-832f-f1f69982b547	053a6fde-90c3-4bca-a2bf-62bca14b8624	t	Create candidate	create-candidate	97c3a519-e834-45b3-aeca-7eb9552a7e49	053a6fde-90c3-4bca-a2bf-62bca14b8624	\N
3fb5d1fa-4f0f-469e-9229-e4988527c56c	053a6fde-90c3-4bca-a2bf-62bca14b8624	t	Read Candidate	read-candidate	97c3a519-e834-45b3-aeca-7eb9552a7e49	053a6fde-90c3-4bca-a2bf-62bca14b8624	\N
abaa4bf0-6b47-4632-ad91-6fb9da687058	053a6fde-90c3-4bca-a2bf-62bca14b8624	t	Update Candidate	update-candidate	97c3a519-e834-45b3-aeca-7eb9552a7e49	053a6fde-90c3-4bca-a2bf-62bca14b8624	\N
a1fff27d-5c93-4735-a1d3-f7854fad0c6e	053a6fde-90c3-4bca-a2bf-62bca14b8624	t	Read Note	read-note	97c3a519-e834-45b3-aeca-7eb9552a7e49	053a6fde-90c3-4bca-a2bf-62bca14b8624	\N
76131968-3ce1-4848-9256-edac290701e8	053a6fde-90c3-4bca-a2bf-62bca14b8624	t	Update Note	update-note	97c3a519-e834-45b3-aeca-7eb9552a7e49	053a6fde-90c3-4bca-a2bf-62bca14b8624	\N
e877edb3-2392-4a3c-aa19-4e39ab40de48	053a6fde-90c3-4bca-a2bf-62bca14b8624	t	Delete Note	delete-note	97c3a519-e834-45b3-aeca-7eb9552a7e49	053a6fde-90c3-4bca-a2bf-62bca14b8624	\N
a580ab42-7a8b-43e0-9e70-f129e1bf9ae9	053a6fde-90c3-4bca-a2bf-62bca14b8624	t	Create Job	create-job	97c3a519-e834-45b3-aeca-7eb9552a7e49	053a6fde-90c3-4bca-a2bf-62bca14b8624	\N
66bf650c-40d8-49ee-8a43-063acb4ddeaf	053a6fde-90c3-4bca-a2bf-62bca14b8624	t	Update Job	update-job	97c3a519-e834-45b3-aeca-7eb9552a7e49	053a6fde-90c3-4bca-a2bf-62bca14b8624	\N
cd766e07-c6bb-4af6-8347-8906f1bdcae9	053a6fde-90c3-4bca-a2bf-62bca14b8624	t	Read Job	read-job	97c3a519-e834-45b3-aeca-7eb9552a7e49	053a6fde-90c3-4bca-a2bf-62bca14b8624	\N
4cefe907-757a-4db2-99a9-f2f0dfdc4995	053a6fde-90c3-4bca-a2bf-62bca14b8624	t	Delete Job	delete-job	97c3a519-e834-45b3-aeca-7eb9552a7e49	053a6fde-90c3-4bca-a2bf-62bca14b8624	\N
5dfca332-2005-46e9-a734-92651dbecb7b	053a6fde-90c3-4bca-a2bf-62bca14b8624	t	Create Client	create-client	97c3a519-e834-45b3-aeca-7eb9552a7e49	053a6fde-90c3-4bca-a2bf-62bca14b8624	\N
1cd72533-b9f2-4089-87af-f45016d1edad	053a6fde-90c3-4bca-a2bf-62bca14b8624	t	Update Client	update-client	97c3a519-e834-45b3-aeca-7eb9552a7e49	053a6fde-90c3-4bca-a2bf-62bca14b8624	\N
8598c3f6-e6df-4590-bad5-8a3e814976cb	053a6fde-90c3-4bca-a2bf-62bca14b8624	t	Read Client	read-client	97c3a519-e834-45b3-aeca-7eb9552a7e49	053a6fde-90c3-4bca-a2bf-62bca14b8624	\N
533f462c-1508-4391-a7ca-2677caf76a62	053a6fde-90c3-4bca-a2bf-62bca14b8624	t	Delete Client	delete-client	97c3a519-e834-45b3-aeca-7eb9552a7e49	053a6fde-90c3-4bca-a2bf-62bca14b8624	\N
9b048fe9-850b-4b79-84bf-8dca1997a241	053a6fde-90c3-4bca-a2bf-62bca14b8624	t	Create Workflow	create-workflow	97c3a519-e834-45b3-aeca-7eb9552a7e49	053a6fde-90c3-4bca-a2bf-62bca14b8624	\N
48b5dd31-9371-4b17-aff4-754c61314cae	053a6fde-90c3-4bca-a2bf-62bca14b8624	t	Delete Workflow	delete-workflow	97c3a519-e834-45b3-aeca-7eb9552a7e49	053a6fde-90c3-4bca-a2bf-62bca14b8624	\N
cef8abcc-bb8e-43fc-8909-cc4dd27ca8df	053a6fde-90c3-4bca-a2bf-62bca14b8624	t	Create Meeting	create-meeting	97c3a519-e834-45b3-aeca-7eb9552a7e49	053a6fde-90c3-4bca-a2bf-62bca14b8624	\N
5535056e-62b5-411b-954b-815fba85f7b1	053a6fde-90c3-4bca-a2bf-62bca14b8624	t	Delete Meeting	delete-meeting	97c3a519-e834-45b3-aeca-7eb9552a7e49	053a6fde-90c3-4bca-a2bf-62bca14b8624	\N
a06ee5f8-5d50-4b2c-bfa9-c44c02e6250f	053a6fde-90c3-4bca-a2bf-62bca14b8624	t	Update Workflow	update-workflow	97c3a519-e834-45b3-aeca-7eb9552a7e49	053a6fde-90c3-4bca-a2bf-62bca14b8624	\N
32a28099-f91a-4acb-bb90-8edba8f3347f	053a6fde-90c3-4bca-a2bf-62bca14b8624	t	Read Workflow	read-workflow	97c3a519-e834-45b3-aeca-7eb9552a7e49	053a6fde-90c3-4bca-a2bf-62bca14b8624	\N
fabed5cc-f4b4-44e0-9050-1e61b1aa5fdf	053a6fde-90c3-4bca-a2bf-62bca14b8624	t	Read Token	read-token	97c3a519-e834-45b3-aeca-7eb9552a7e49	053a6fde-90c3-4bca-a2bf-62bca14b8624	\N
3db0c21c-9365-4cb1-a8d4-cd46b5c42242	053a6fde-90c3-4bca-a2bf-62bca14b8624	t	Update Token	update-token	97c3a519-e834-45b3-aeca-7eb9552a7e49	053a6fde-90c3-4bca-a2bf-62bca14b8624	\N
b91a52e9-7fb1-4857-8b81-415c9eacb7c9	053a6fde-90c3-4bca-a2bf-62bca14b8624	t	Update Meeting	update-meeting	97c3a519-e834-45b3-aeca-7eb9552a7e49	053a6fde-90c3-4bca-a2bf-62bca14b8624	\N
dec5152b-c755-4063-99bb-483cce89af70	053a6fde-90c3-4bca-a2bf-62bca14b8624	t	Read Meeting	read-meeting	97c3a519-e834-45b3-aeca-7eb9552a7e49	053a6fde-90c3-4bca-a2bf-62bca14b8624	\N
\.


--
-- Data for Name: migration_model; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.migration_model (id, version, update_time) FROM stdin;
i9jno	19.0.3	1683555341
\.


--
-- Data for Name: offline_client_session; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.offline_client_session (user_session_id, client_id, offline_flag, "timestamp", data, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: offline_user_session; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.offline_user_session (user_session_id, user_id, realm_id, created_on, offline_flag, data, last_session_refresh) FROM stdin;
\.


--
-- Data for Name: policy_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.policy_config (policy_id, name, value) FROM stdin;
60350c9c-7926-49e6-b374-1df1e2365702	code	// by default, grants any permission associated with this policy\n$evaluation.grant();\n
b6897ac2-baf7-42ae-978a-9a2fa8537b1f	defaultResourceType	urn:omnis_client:resources:default
\.


--
-- Data for Name: protocol_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) FROM stdin;
12602479-5df4-440d-ac14-716470bbdd6e	audience resolve	openid-connect	oidc-audience-resolve-mapper	61c79e81-07a8-4f10-9025-22f887c523ac	\N
12330c38-8660-43cb-a054-bdb39e92a4e4	locale	openid-connect	oidc-usermodel-attribute-mapper	f216da3e-8d34-4377-8579-f848e3b74d43	\N
f6e008d1-db96-4970-a77b-d9c57b533eed	role list	saml	saml-role-list-mapper	\N	f1157cd1-88c9-4021-8aea-704abf0a25eb
f4295a91-463d-45ff-9dff-a0e16ada6451	full name	openid-connect	oidc-full-name-mapper	\N	e5091011-e71b-43e6-9c6d-3dad4b98fab1
5a219d74-955f-4e70-9fd9-a5684f6b0a5f	family name	openid-connect	oidc-usermodel-property-mapper	\N	e5091011-e71b-43e6-9c6d-3dad4b98fab1
fbaa7e9b-3c57-4cd9-bedb-0efb2fcb308a	given name	openid-connect	oidc-usermodel-property-mapper	\N	e5091011-e71b-43e6-9c6d-3dad4b98fab1
73b5cf73-a799-4d5b-ab6e-201928218eaa	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	e5091011-e71b-43e6-9c6d-3dad4b98fab1
3a03540e-5311-47d2-b5e1-62f6c3f7d510	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	e5091011-e71b-43e6-9c6d-3dad4b98fab1
b9111043-e33a-4f20-8e0f-d41e4738b214	username	openid-connect	oidc-usermodel-property-mapper	\N	e5091011-e71b-43e6-9c6d-3dad4b98fab1
a4b203ef-7ddb-46bc-ad28-0d0188f8dc34	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	e5091011-e71b-43e6-9c6d-3dad4b98fab1
b8c4e8ad-e973-4bca-bfdb-f3f23773619f	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	e5091011-e71b-43e6-9c6d-3dad4b98fab1
bdcd371a-df2f-4fbd-ae0e-c70c2b3898d8	website	openid-connect	oidc-usermodel-attribute-mapper	\N	e5091011-e71b-43e6-9c6d-3dad4b98fab1
3033d5c3-3ede-4c2c-931d-e4a0dd5d1cb8	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	e5091011-e71b-43e6-9c6d-3dad4b98fab1
d1d21ec6-6bd7-4bc2-8db8-cd039a5ba9a0	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	e5091011-e71b-43e6-9c6d-3dad4b98fab1
29dd4a76-ca89-438e-b941-52a7fa9aaaeb	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	e5091011-e71b-43e6-9c6d-3dad4b98fab1
6eb31f15-cf37-4e22-97a5-4c43949076c3	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	e5091011-e71b-43e6-9c6d-3dad4b98fab1
510df7ee-0ecd-463f-b8cc-cde1145d6745	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	e5091011-e71b-43e6-9c6d-3dad4b98fab1
6e0051ab-4858-44cd-b262-edf941b02d65	email	openid-connect	oidc-usermodel-property-mapper	\N	0a92e094-92c4-4aaa-b8bf-0ba9ab16cf22
6c0fc661-dba4-4d9b-a359-52e75e89fbb8	email verified	openid-connect	oidc-usermodel-property-mapper	\N	0a92e094-92c4-4aaa-b8bf-0ba9ab16cf22
bd578e8e-2c65-4c4c-8f4a-eb76bb83ec5c	address	openid-connect	oidc-address-mapper	\N	f62f49f0-a3fa-4123-b076-246859393cc0
7d4730b3-062e-46bc-9334-17dd80a7fedc	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	38ab7168-1818-4f79-ad18-e94abb949e84
b1ecbd98-f878-49fa-ac90-07061c9a46d5	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	38ab7168-1818-4f79-ad18-e94abb949e84
37a3f218-8a70-4707-802c-0d74680aee39	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	eb4fadf3-e7de-4618-afc3-4f4aa6d0f567
655e06cc-c1f2-4ceb-8f8e-434d77d75155	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	eb4fadf3-e7de-4618-afc3-4f4aa6d0f567
0c7589ec-ce46-4871-8ab2-1cf9adc966f0	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	eb4fadf3-e7de-4618-afc3-4f4aa6d0f567
596e936b-7beb-411a-8302-451bbb05124f	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	6fa0d628-a0d1-4d8f-91ec-d26e39ec74b8
b70d59ed-5191-4e3f-a560-73e0b1097e25	upn	openid-connect	oidc-usermodel-property-mapper	\N	e9001f98-9a53-407f-a8d1-9cd0cc518afa
44f9ac33-2276-4533-be05-f0997af0bc41	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	e9001f98-9a53-407f-a8d1-9cd0cc518afa
efa7d528-9dfd-4c7b-8c22-e19e26a5e56c	acr loa level	openid-connect	oidc-acr-mapper	\N	52a9f12f-ee5a-481a-b8ce-67733ccd9578
7258512e-50c8-467e-ba53-3b585860faa3	audience resolve	openid-connect	oidc-audience-resolve-mapper	d630f008-dba1-4dfc-a87d-f924946512da	\N
27cf62b6-c9c0-41d7-85bc-979b5b4e6309	role list	saml	saml-role-list-mapper	\N	cbfd286a-b181-4b3a-87f5-6bd7bf8fc66c
073adaf7-37b4-4e6d-b194-73b8b064fe36	full name	openid-connect	oidc-full-name-mapper	\N	d594a42f-9fe9-4fdc-adbe-83af44961325
14f192cb-de0a-4f95-b951-99f8158cc548	family name	openid-connect	oidc-usermodel-property-mapper	\N	d594a42f-9fe9-4fdc-adbe-83af44961325
f78646f2-26c8-47a6-951a-0c7e3f4c6934	given name	openid-connect	oidc-usermodel-property-mapper	\N	d594a42f-9fe9-4fdc-adbe-83af44961325
6b212135-42ef-46a4-ba64-df6c2d8443d2	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	d594a42f-9fe9-4fdc-adbe-83af44961325
ad7bb32d-8709-491f-8b44-7bffdb0d3ffe	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	d594a42f-9fe9-4fdc-adbe-83af44961325
ce2cdf57-bdca-4094-b42a-ddbc5b4d776c	username	openid-connect	oidc-usermodel-property-mapper	\N	d594a42f-9fe9-4fdc-adbe-83af44961325
85e19dd1-5192-4349-b633-fa1a95532ee5	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	d594a42f-9fe9-4fdc-adbe-83af44961325
91de30b7-f052-40ab-a80a-6737c46e2399	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	d594a42f-9fe9-4fdc-adbe-83af44961325
32542283-1185-4436-8768-9debbe5b7d9b	website	openid-connect	oidc-usermodel-attribute-mapper	\N	d594a42f-9fe9-4fdc-adbe-83af44961325
849329e1-44f2-406a-a9d0-9e8bca815a89	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	d594a42f-9fe9-4fdc-adbe-83af44961325
9e7b4232-e54a-43bd-8fc7-e9d63de37efa	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	d594a42f-9fe9-4fdc-adbe-83af44961325
9a5b6039-7f8d-4021-bb3e-e10dea5ccd7b	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	d594a42f-9fe9-4fdc-adbe-83af44961325
d5cd5717-394b-4ee8-92bd-191d94a0bc35	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	d594a42f-9fe9-4fdc-adbe-83af44961325
f7b90ce3-e008-4e27-bc92-3888af4c1786	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	d594a42f-9fe9-4fdc-adbe-83af44961325
bf17acc0-c67d-4f5f-b48e-a4a02d362094	email	openid-connect	oidc-usermodel-property-mapper	\N	cd4d4eae-7a6e-4a8d-85b1-384f2323af5e
55841497-078b-492e-84da-81b6ab75b450	email verified	openid-connect	oidc-usermodel-property-mapper	\N	cd4d4eae-7a6e-4a8d-85b1-384f2323af5e
e29a6a42-f0be-4234-bc3e-e98c5aa4658b	address	openid-connect	oidc-address-mapper	\N	9949741e-4dff-4b58-9aa3-187fec2b8410
a3dc228a-bf4d-4049-9ee0-08198d4a3521	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	1d93e603-29d1-42b4-bc30-899cd8a707da
ccc2da73-f0ba-41eb-9c39-32e6d563d6fb	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	1d93e603-29d1-42b4-bc30-899cd8a707da
0573df12-ba0b-4904-b8e8-8cb8571624eb	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	de1a4f93-9c77-45eb-a52b-59806e316cf7
1ae32aae-a85b-48d7-8d21-be083070e668	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	de1a4f93-9c77-45eb-a52b-59806e316cf7
1beaf2d3-3461-4e17-96d7-627b9ef44673	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	de1a4f93-9c77-45eb-a52b-59806e316cf7
f25e6323-75c7-41d4-abce-00b63e9b2c65	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	05db5e88-6d9d-43bf-ad99-f2eec3962c60
90367d30-b96b-458f-b8fc-3fcd62502f4e	upn	openid-connect	oidc-usermodel-property-mapper	\N	19283dfb-d711-4819-8a71-f96ccfd51d10
a79c52c3-e7ed-4dcd-9eb9-335a9c24543b	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	19283dfb-d711-4819-8a71-f96ccfd51d10
3ad73866-a06a-46ef-8d53-5231de9e55b5	acr loa level	openid-connect	oidc-acr-mapper	\N	97eca1dc-a2c0-421e-affb-34476bb0f4b9
e3ed805d-998a-4165-aed6-91576881f062	locale	openid-connect	oidc-usermodel-attribute-mapper	544f2483-84b5-425f-b5fe-5a2a3ab837ee	\N
f7a55b84-5b3f-4b30-abb8-f98c53148eb1	Client ID	openid-connect	oidc-usersessionmodel-note-mapper	053a6fde-90c3-4bca-a2bf-62bca14b8624	\N
260d1942-9ddb-43ec-8457-821411f64e5f	Client Host	openid-connect	oidc-usersessionmodel-note-mapper	053a6fde-90c3-4bca-a2bf-62bca14b8624	\N
4aa8e0d4-e026-49eb-bd20-b6981ad2b73f	Client IP Address	openid-connect	oidc-usersessionmodel-note-mapper	053a6fde-90c3-4bca-a2bf-62bca14b8624	\N
\.


--
-- Data for Name: protocol_mapper_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.protocol_mapper_config (protocol_mapper_id, value, name) FROM stdin;
12330c38-8660-43cb-a054-bdb39e92a4e4	true	userinfo.token.claim
12330c38-8660-43cb-a054-bdb39e92a4e4	locale	user.attribute
12330c38-8660-43cb-a054-bdb39e92a4e4	true	id.token.claim
12330c38-8660-43cb-a054-bdb39e92a4e4	true	access.token.claim
12330c38-8660-43cb-a054-bdb39e92a4e4	locale	claim.name
12330c38-8660-43cb-a054-bdb39e92a4e4	String	jsonType.label
f6e008d1-db96-4970-a77b-d9c57b533eed	false	single
f6e008d1-db96-4970-a77b-d9c57b533eed	Basic	attribute.nameformat
f6e008d1-db96-4970-a77b-d9c57b533eed	Role	attribute.name
f4295a91-463d-45ff-9dff-a0e16ada6451	true	userinfo.token.claim
f4295a91-463d-45ff-9dff-a0e16ada6451	true	id.token.claim
f4295a91-463d-45ff-9dff-a0e16ada6451	true	access.token.claim
5a219d74-955f-4e70-9fd9-a5684f6b0a5f	true	userinfo.token.claim
5a219d74-955f-4e70-9fd9-a5684f6b0a5f	lastName	user.attribute
5a219d74-955f-4e70-9fd9-a5684f6b0a5f	true	id.token.claim
5a219d74-955f-4e70-9fd9-a5684f6b0a5f	true	access.token.claim
5a219d74-955f-4e70-9fd9-a5684f6b0a5f	family_name	claim.name
5a219d74-955f-4e70-9fd9-a5684f6b0a5f	String	jsonType.label
fbaa7e9b-3c57-4cd9-bedb-0efb2fcb308a	true	userinfo.token.claim
fbaa7e9b-3c57-4cd9-bedb-0efb2fcb308a	firstName	user.attribute
fbaa7e9b-3c57-4cd9-bedb-0efb2fcb308a	true	id.token.claim
fbaa7e9b-3c57-4cd9-bedb-0efb2fcb308a	true	access.token.claim
fbaa7e9b-3c57-4cd9-bedb-0efb2fcb308a	given_name	claim.name
fbaa7e9b-3c57-4cd9-bedb-0efb2fcb308a	String	jsonType.label
73b5cf73-a799-4d5b-ab6e-201928218eaa	true	userinfo.token.claim
73b5cf73-a799-4d5b-ab6e-201928218eaa	middleName	user.attribute
73b5cf73-a799-4d5b-ab6e-201928218eaa	true	id.token.claim
73b5cf73-a799-4d5b-ab6e-201928218eaa	true	access.token.claim
73b5cf73-a799-4d5b-ab6e-201928218eaa	middle_name	claim.name
73b5cf73-a799-4d5b-ab6e-201928218eaa	String	jsonType.label
3a03540e-5311-47d2-b5e1-62f6c3f7d510	true	userinfo.token.claim
3a03540e-5311-47d2-b5e1-62f6c3f7d510	nickname	user.attribute
3a03540e-5311-47d2-b5e1-62f6c3f7d510	true	id.token.claim
3a03540e-5311-47d2-b5e1-62f6c3f7d510	true	access.token.claim
3a03540e-5311-47d2-b5e1-62f6c3f7d510	nickname	claim.name
3a03540e-5311-47d2-b5e1-62f6c3f7d510	String	jsonType.label
b9111043-e33a-4f20-8e0f-d41e4738b214	true	userinfo.token.claim
b9111043-e33a-4f20-8e0f-d41e4738b214	username	user.attribute
b9111043-e33a-4f20-8e0f-d41e4738b214	true	id.token.claim
b9111043-e33a-4f20-8e0f-d41e4738b214	true	access.token.claim
b9111043-e33a-4f20-8e0f-d41e4738b214	preferred_username	claim.name
b9111043-e33a-4f20-8e0f-d41e4738b214	String	jsonType.label
a4b203ef-7ddb-46bc-ad28-0d0188f8dc34	true	userinfo.token.claim
a4b203ef-7ddb-46bc-ad28-0d0188f8dc34	profile	user.attribute
a4b203ef-7ddb-46bc-ad28-0d0188f8dc34	true	id.token.claim
a4b203ef-7ddb-46bc-ad28-0d0188f8dc34	true	access.token.claim
a4b203ef-7ddb-46bc-ad28-0d0188f8dc34	profile	claim.name
a4b203ef-7ddb-46bc-ad28-0d0188f8dc34	String	jsonType.label
b8c4e8ad-e973-4bca-bfdb-f3f23773619f	true	userinfo.token.claim
b8c4e8ad-e973-4bca-bfdb-f3f23773619f	picture	user.attribute
b8c4e8ad-e973-4bca-bfdb-f3f23773619f	true	id.token.claim
b8c4e8ad-e973-4bca-bfdb-f3f23773619f	true	access.token.claim
b8c4e8ad-e973-4bca-bfdb-f3f23773619f	picture	claim.name
b8c4e8ad-e973-4bca-bfdb-f3f23773619f	String	jsonType.label
bdcd371a-df2f-4fbd-ae0e-c70c2b3898d8	true	userinfo.token.claim
bdcd371a-df2f-4fbd-ae0e-c70c2b3898d8	website	user.attribute
bdcd371a-df2f-4fbd-ae0e-c70c2b3898d8	true	id.token.claim
bdcd371a-df2f-4fbd-ae0e-c70c2b3898d8	true	access.token.claim
bdcd371a-df2f-4fbd-ae0e-c70c2b3898d8	website	claim.name
bdcd371a-df2f-4fbd-ae0e-c70c2b3898d8	String	jsonType.label
3033d5c3-3ede-4c2c-931d-e4a0dd5d1cb8	true	userinfo.token.claim
3033d5c3-3ede-4c2c-931d-e4a0dd5d1cb8	gender	user.attribute
3033d5c3-3ede-4c2c-931d-e4a0dd5d1cb8	true	id.token.claim
3033d5c3-3ede-4c2c-931d-e4a0dd5d1cb8	true	access.token.claim
3033d5c3-3ede-4c2c-931d-e4a0dd5d1cb8	gender	claim.name
3033d5c3-3ede-4c2c-931d-e4a0dd5d1cb8	String	jsonType.label
d1d21ec6-6bd7-4bc2-8db8-cd039a5ba9a0	true	userinfo.token.claim
d1d21ec6-6bd7-4bc2-8db8-cd039a5ba9a0	birthdate	user.attribute
d1d21ec6-6bd7-4bc2-8db8-cd039a5ba9a0	true	id.token.claim
d1d21ec6-6bd7-4bc2-8db8-cd039a5ba9a0	true	access.token.claim
d1d21ec6-6bd7-4bc2-8db8-cd039a5ba9a0	birthdate	claim.name
d1d21ec6-6bd7-4bc2-8db8-cd039a5ba9a0	String	jsonType.label
29dd4a76-ca89-438e-b941-52a7fa9aaaeb	true	userinfo.token.claim
29dd4a76-ca89-438e-b941-52a7fa9aaaeb	zoneinfo	user.attribute
29dd4a76-ca89-438e-b941-52a7fa9aaaeb	true	id.token.claim
29dd4a76-ca89-438e-b941-52a7fa9aaaeb	true	access.token.claim
29dd4a76-ca89-438e-b941-52a7fa9aaaeb	zoneinfo	claim.name
29dd4a76-ca89-438e-b941-52a7fa9aaaeb	String	jsonType.label
6eb31f15-cf37-4e22-97a5-4c43949076c3	true	userinfo.token.claim
6eb31f15-cf37-4e22-97a5-4c43949076c3	locale	user.attribute
6eb31f15-cf37-4e22-97a5-4c43949076c3	true	id.token.claim
6eb31f15-cf37-4e22-97a5-4c43949076c3	true	access.token.claim
6eb31f15-cf37-4e22-97a5-4c43949076c3	locale	claim.name
6eb31f15-cf37-4e22-97a5-4c43949076c3	String	jsonType.label
510df7ee-0ecd-463f-b8cc-cde1145d6745	true	userinfo.token.claim
510df7ee-0ecd-463f-b8cc-cde1145d6745	updatedAt	user.attribute
510df7ee-0ecd-463f-b8cc-cde1145d6745	true	id.token.claim
510df7ee-0ecd-463f-b8cc-cde1145d6745	true	access.token.claim
510df7ee-0ecd-463f-b8cc-cde1145d6745	updated_at	claim.name
510df7ee-0ecd-463f-b8cc-cde1145d6745	long	jsonType.label
6e0051ab-4858-44cd-b262-edf941b02d65	true	userinfo.token.claim
6e0051ab-4858-44cd-b262-edf941b02d65	email	user.attribute
6e0051ab-4858-44cd-b262-edf941b02d65	true	id.token.claim
6e0051ab-4858-44cd-b262-edf941b02d65	true	access.token.claim
6e0051ab-4858-44cd-b262-edf941b02d65	email	claim.name
6e0051ab-4858-44cd-b262-edf941b02d65	String	jsonType.label
6c0fc661-dba4-4d9b-a359-52e75e89fbb8	true	userinfo.token.claim
6c0fc661-dba4-4d9b-a359-52e75e89fbb8	emailVerified	user.attribute
6c0fc661-dba4-4d9b-a359-52e75e89fbb8	true	id.token.claim
6c0fc661-dba4-4d9b-a359-52e75e89fbb8	true	access.token.claim
6c0fc661-dba4-4d9b-a359-52e75e89fbb8	email_verified	claim.name
6c0fc661-dba4-4d9b-a359-52e75e89fbb8	boolean	jsonType.label
bd578e8e-2c65-4c4c-8f4a-eb76bb83ec5c	formatted	user.attribute.formatted
bd578e8e-2c65-4c4c-8f4a-eb76bb83ec5c	country	user.attribute.country
bd578e8e-2c65-4c4c-8f4a-eb76bb83ec5c	postal_code	user.attribute.postal_code
bd578e8e-2c65-4c4c-8f4a-eb76bb83ec5c	true	userinfo.token.claim
bd578e8e-2c65-4c4c-8f4a-eb76bb83ec5c	street	user.attribute.street
bd578e8e-2c65-4c4c-8f4a-eb76bb83ec5c	true	id.token.claim
bd578e8e-2c65-4c4c-8f4a-eb76bb83ec5c	region	user.attribute.region
bd578e8e-2c65-4c4c-8f4a-eb76bb83ec5c	true	access.token.claim
bd578e8e-2c65-4c4c-8f4a-eb76bb83ec5c	locality	user.attribute.locality
7d4730b3-062e-46bc-9334-17dd80a7fedc	true	userinfo.token.claim
7d4730b3-062e-46bc-9334-17dd80a7fedc	phoneNumber	user.attribute
7d4730b3-062e-46bc-9334-17dd80a7fedc	true	id.token.claim
7d4730b3-062e-46bc-9334-17dd80a7fedc	true	access.token.claim
7d4730b3-062e-46bc-9334-17dd80a7fedc	phone_number	claim.name
7d4730b3-062e-46bc-9334-17dd80a7fedc	String	jsonType.label
b1ecbd98-f878-49fa-ac90-07061c9a46d5	true	userinfo.token.claim
b1ecbd98-f878-49fa-ac90-07061c9a46d5	phoneNumberVerified	user.attribute
b1ecbd98-f878-49fa-ac90-07061c9a46d5	true	id.token.claim
b1ecbd98-f878-49fa-ac90-07061c9a46d5	true	access.token.claim
b1ecbd98-f878-49fa-ac90-07061c9a46d5	phone_number_verified	claim.name
b1ecbd98-f878-49fa-ac90-07061c9a46d5	boolean	jsonType.label
37a3f218-8a70-4707-802c-0d74680aee39	true	multivalued
37a3f218-8a70-4707-802c-0d74680aee39	foo	user.attribute
37a3f218-8a70-4707-802c-0d74680aee39	true	access.token.claim
37a3f218-8a70-4707-802c-0d74680aee39	realm_access.roles	claim.name
37a3f218-8a70-4707-802c-0d74680aee39	String	jsonType.label
655e06cc-c1f2-4ceb-8f8e-434d77d75155	true	multivalued
655e06cc-c1f2-4ceb-8f8e-434d77d75155	foo	user.attribute
655e06cc-c1f2-4ceb-8f8e-434d77d75155	true	access.token.claim
655e06cc-c1f2-4ceb-8f8e-434d77d75155	resource_access.${client_id}.roles	claim.name
655e06cc-c1f2-4ceb-8f8e-434d77d75155	String	jsonType.label
b70d59ed-5191-4e3f-a560-73e0b1097e25	true	userinfo.token.claim
b70d59ed-5191-4e3f-a560-73e0b1097e25	username	user.attribute
b70d59ed-5191-4e3f-a560-73e0b1097e25	true	id.token.claim
b70d59ed-5191-4e3f-a560-73e0b1097e25	true	access.token.claim
b70d59ed-5191-4e3f-a560-73e0b1097e25	upn	claim.name
b70d59ed-5191-4e3f-a560-73e0b1097e25	String	jsonType.label
44f9ac33-2276-4533-be05-f0997af0bc41	true	multivalued
44f9ac33-2276-4533-be05-f0997af0bc41	foo	user.attribute
44f9ac33-2276-4533-be05-f0997af0bc41	true	id.token.claim
44f9ac33-2276-4533-be05-f0997af0bc41	true	access.token.claim
44f9ac33-2276-4533-be05-f0997af0bc41	groups	claim.name
44f9ac33-2276-4533-be05-f0997af0bc41	String	jsonType.label
efa7d528-9dfd-4c7b-8c22-e19e26a5e56c	true	id.token.claim
efa7d528-9dfd-4c7b-8c22-e19e26a5e56c	true	access.token.claim
27cf62b6-c9c0-41d7-85bc-979b5b4e6309	false	single
27cf62b6-c9c0-41d7-85bc-979b5b4e6309	Basic	attribute.nameformat
27cf62b6-c9c0-41d7-85bc-979b5b4e6309	Role	attribute.name
073adaf7-37b4-4e6d-b194-73b8b064fe36	true	userinfo.token.claim
073adaf7-37b4-4e6d-b194-73b8b064fe36	true	id.token.claim
073adaf7-37b4-4e6d-b194-73b8b064fe36	true	access.token.claim
14f192cb-de0a-4f95-b951-99f8158cc548	true	userinfo.token.claim
14f192cb-de0a-4f95-b951-99f8158cc548	lastName	user.attribute
14f192cb-de0a-4f95-b951-99f8158cc548	true	id.token.claim
14f192cb-de0a-4f95-b951-99f8158cc548	true	access.token.claim
14f192cb-de0a-4f95-b951-99f8158cc548	family_name	claim.name
14f192cb-de0a-4f95-b951-99f8158cc548	String	jsonType.label
f78646f2-26c8-47a6-951a-0c7e3f4c6934	true	userinfo.token.claim
f78646f2-26c8-47a6-951a-0c7e3f4c6934	firstName	user.attribute
f78646f2-26c8-47a6-951a-0c7e3f4c6934	true	id.token.claim
f78646f2-26c8-47a6-951a-0c7e3f4c6934	true	access.token.claim
f78646f2-26c8-47a6-951a-0c7e3f4c6934	given_name	claim.name
f78646f2-26c8-47a6-951a-0c7e3f4c6934	String	jsonType.label
6b212135-42ef-46a4-ba64-df6c2d8443d2	true	userinfo.token.claim
6b212135-42ef-46a4-ba64-df6c2d8443d2	middleName	user.attribute
6b212135-42ef-46a4-ba64-df6c2d8443d2	true	id.token.claim
6b212135-42ef-46a4-ba64-df6c2d8443d2	true	access.token.claim
6b212135-42ef-46a4-ba64-df6c2d8443d2	middle_name	claim.name
6b212135-42ef-46a4-ba64-df6c2d8443d2	String	jsonType.label
ad7bb32d-8709-491f-8b44-7bffdb0d3ffe	true	userinfo.token.claim
ad7bb32d-8709-491f-8b44-7bffdb0d3ffe	nickname	user.attribute
ad7bb32d-8709-491f-8b44-7bffdb0d3ffe	true	id.token.claim
ad7bb32d-8709-491f-8b44-7bffdb0d3ffe	true	access.token.claim
ad7bb32d-8709-491f-8b44-7bffdb0d3ffe	nickname	claim.name
ad7bb32d-8709-491f-8b44-7bffdb0d3ffe	String	jsonType.label
ce2cdf57-bdca-4094-b42a-ddbc5b4d776c	true	userinfo.token.claim
ce2cdf57-bdca-4094-b42a-ddbc5b4d776c	username	user.attribute
ce2cdf57-bdca-4094-b42a-ddbc5b4d776c	true	id.token.claim
ce2cdf57-bdca-4094-b42a-ddbc5b4d776c	true	access.token.claim
ce2cdf57-bdca-4094-b42a-ddbc5b4d776c	preferred_username	claim.name
ce2cdf57-bdca-4094-b42a-ddbc5b4d776c	String	jsonType.label
85e19dd1-5192-4349-b633-fa1a95532ee5	true	userinfo.token.claim
85e19dd1-5192-4349-b633-fa1a95532ee5	profile	user.attribute
85e19dd1-5192-4349-b633-fa1a95532ee5	true	id.token.claim
85e19dd1-5192-4349-b633-fa1a95532ee5	true	access.token.claim
85e19dd1-5192-4349-b633-fa1a95532ee5	profile	claim.name
85e19dd1-5192-4349-b633-fa1a95532ee5	String	jsonType.label
91de30b7-f052-40ab-a80a-6737c46e2399	true	userinfo.token.claim
91de30b7-f052-40ab-a80a-6737c46e2399	picture	user.attribute
91de30b7-f052-40ab-a80a-6737c46e2399	true	id.token.claim
91de30b7-f052-40ab-a80a-6737c46e2399	true	access.token.claim
91de30b7-f052-40ab-a80a-6737c46e2399	picture	claim.name
91de30b7-f052-40ab-a80a-6737c46e2399	String	jsonType.label
32542283-1185-4436-8768-9debbe5b7d9b	true	userinfo.token.claim
32542283-1185-4436-8768-9debbe5b7d9b	website	user.attribute
32542283-1185-4436-8768-9debbe5b7d9b	true	id.token.claim
32542283-1185-4436-8768-9debbe5b7d9b	true	access.token.claim
32542283-1185-4436-8768-9debbe5b7d9b	website	claim.name
32542283-1185-4436-8768-9debbe5b7d9b	String	jsonType.label
849329e1-44f2-406a-a9d0-9e8bca815a89	true	userinfo.token.claim
849329e1-44f2-406a-a9d0-9e8bca815a89	gender	user.attribute
849329e1-44f2-406a-a9d0-9e8bca815a89	true	id.token.claim
849329e1-44f2-406a-a9d0-9e8bca815a89	true	access.token.claim
849329e1-44f2-406a-a9d0-9e8bca815a89	gender	claim.name
849329e1-44f2-406a-a9d0-9e8bca815a89	String	jsonType.label
9e7b4232-e54a-43bd-8fc7-e9d63de37efa	true	userinfo.token.claim
9e7b4232-e54a-43bd-8fc7-e9d63de37efa	birthdate	user.attribute
9e7b4232-e54a-43bd-8fc7-e9d63de37efa	true	id.token.claim
9e7b4232-e54a-43bd-8fc7-e9d63de37efa	true	access.token.claim
9e7b4232-e54a-43bd-8fc7-e9d63de37efa	birthdate	claim.name
9e7b4232-e54a-43bd-8fc7-e9d63de37efa	String	jsonType.label
9a5b6039-7f8d-4021-bb3e-e10dea5ccd7b	true	userinfo.token.claim
9a5b6039-7f8d-4021-bb3e-e10dea5ccd7b	zoneinfo	user.attribute
9a5b6039-7f8d-4021-bb3e-e10dea5ccd7b	true	id.token.claim
9a5b6039-7f8d-4021-bb3e-e10dea5ccd7b	true	access.token.claim
9a5b6039-7f8d-4021-bb3e-e10dea5ccd7b	zoneinfo	claim.name
9a5b6039-7f8d-4021-bb3e-e10dea5ccd7b	String	jsonType.label
d5cd5717-394b-4ee8-92bd-191d94a0bc35	true	userinfo.token.claim
d5cd5717-394b-4ee8-92bd-191d94a0bc35	locale	user.attribute
d5cd5717-394b-4ee8-92bd-191d94a0bc35	true	id.token.claim
d5cd5717-394b-4ee8-92bd-191d94a0bc35	true	access.token.claim
d5cd5717-394b-4ee8-92bd-191d94a0bc35	locale	claim.name
d5cd5717-394b-4ee8-92bd-191d94a0bc35	String	jsonType.label
f7b90ce3-e008-4e27-bc92-3888af4c1786	true	userinfo.token.claim
f7b90ce3-e008-4e27-bc92-3888af4c1786	updatedAt	user.attribute
f7b90ce3-e008-4e27-bc92-3888af4c1786	true	id.token.claim
f7b90ce3-e008-4e27-bc92-3888af4c1786	true	access.token.claim
f7b90ce3-e008-4e27-bc92-3888af4c1786	updated_at	claim.name
f7b90ce3-e008-4e27-bc92-3888af4c1786	long	jsonType.label
bf17acc0-c67d-4f5f-b48e-a4a02d362094	true	userinfo.token.claim
bf17acc0-c67d-4f5f-b48e-a4a02d362094	email	user.attribute
bf17acc0-c67d-4f5f-b48e-a4a02d362094	true	id.token.claim
bf17acc0-c67d-4f5f-b48e-a4a02d362094	true	access.token.claim
bf17acc0-c67d-4f5f-b48e-a4a02d362094	email	claim.name
bf17acc0-c67d-4f5f-b48e-a4a02d362094	String	jsonType.label
55841497-078b-492e-84da-81b6ab75b450	true	userinfo.token.claim
55841497-078b-492e-84da-81b6ab75b450	emailVerified	user.attribute
55841497-078b-492e-84da-81b6ab75b450	true	id.token.claim
55841497-078b-492e-84da-81b6ab75b450	true	access.token.claim
55841497-078b-492e-84da-81b6ab75b450	email_verified	claim.name
55841497-078b-492e-84da-81b6ab75b450	boolean	jsonType.label
e29a6a42-f0be-4234-bc3e-e98c5aa4658b	formatted	user.attribute.formatted
e29a6a42-f0be-4234-bc3e-e98c5aa4658b	country	user.attribute.country
e29a6a42-f0be-4234-bc3e-e98c5aa4658b	postal_code	user.attribute.postal_code
e29a6a42-f0be-4234-bc3e-e98c5aa4658b	true	userinfo.token.claim
e29a6a42-f0be-4234-bc3e-e98c5aa4658b	street	user.attribute.street
e29a6a42-f0be-4234-bc3e-e98c5aa4658b	true	id.token.claim
e29a6a42-f0be-4234-bc3e-e98c5aa4658b	region	user.attribute.region
e29a6a42-f0be-4234-bc3e-e98c5aa4658b	true	access.token.claim
e29a6a42-f0be-4234-bc3e-e98c5aa4658b	locality	user.attribute.locality
a3dc228a-bf4d-4049-9ee0-08198d4a3521	true	userinfo.token.claim
a3dc228a-bf4d-4049-9ee0-08198d4a3521	phoneNumber	user.attribute
a3dc228a-bf4d-4049-9ee0-08198d4a3521	true	id.token.claim
a3dc228a-bf4d-4049-9ee0-08198d4a3521	true	access.token.claim
a3dc228a-bf4d-4049-9ee0-08198d4a3521	phone_number	claim.name
a3dc228a-bf4d-4049-9ee0-08198d4a3521	String	jsonType.label
ccc2da73-f0ba-41eb-9c39-32e6d563d6fb	true	userinfo.token.claim
ccc2da73-f0ba-41eb-9c39-32e6d563d6fb	phoneNumberVerified	user.attribute
ccc2da73-f0ba-41eb-9c39-32e6d563d6fb	true	id.token.claim
ccc2da73-f0ba-41eb-9c39-32e6d563d6fb	true	access.token.claim
ccc2da73-f0ba-41eb-9c39-32e6d563d6fb	phone_number_verified	claim.name
ccc2da73-f0ba-41eb-9c39-32e6d563d6fb	boolean	jsonType.label
0573df12-ba0b-4904-b8e8-8cb8571624eb	true	multivalued
0573df12-ba0b-4904-b8e8-8cb8571624eb	foo	user.attribute
0573df12-ba0b-4904-b8e8-8cb8571624eb	true	access.token.claim
0573df12-ba0b-4904-b8e8-8cb8571624eb	realm_access.roles	claim.name
0573df12-ba0b-4904-b8e8-8cb8571624eb	String	jsonType.label
1ae32aae-a85b-48d7-8d21-be083070e668	true	multivalued
1ae32aae-a85b-48d7-8d21-be083070e668	foo	user.attribute
1ae32aae-a85b-48d7-8d21-be083070e668	true	access.token.claim
1ae32aae-a85b-48d7-8d21-be083070e668	resource_access.${client_id}.roles	claim.name
1ae32aae-a85b-48d7-8d21-be083070e668	String	jsonType.label
90367d30-b96b-458f-b8fc-3fcd62502f4e	true	userinfo.token.claim
90367d30-b96b-458f-b8fc-3fcd62502f4e	username	user.attribute
90367d30-b96b-458f-b8fc-3fcd62502f4e	true	id.token.claim
90367d30-b96b-458f-b8fc-3fcd62502f4e	true	access.token.claim
90367d30-b96b-458f-b8fc-3fcd62502f4e	upn	claim.name
90367d30-b96b-458f-b8fc-3fcd62502f4e	String	jsonType.label
a79c52c3-e7ed-4dcd-9eb9-335a9c24543b	true	multivalued
a79c52c3-e7ed-4dcd-9eb9-335a9c24543b	foo	user.attribute
a79c52c3-e7ed-4dcd-9eb9-335a9c24543b	true	id.token.claim
a79c52c3-e7ed-4dcd-9eb9-335a9c24543b	true	access.token.claim
a79c52c3-e7ed-4dcd-9eb9-335a9c24543b	groups	claim.name
a79c52c3-e7ed-4dcd-9eb9-335a9c24543b	String	jsonType.label
3ad73866-a06a-46ef-8d53-5231de9e55b5	true	id.token.claim
3ad73866-a06a-46ef-8d53-5231de9e55b5	true	access.token.claim
e3ed805d-998a-4165-aed6-91576881f062	true	userinfo.token.claim
e3ed805d-998a-4165-aed6-91576881f062	locale	user.attribute
e3ed805d-998a-4165-aed6-91576881f062	true	id.token.claim
e3ed805d-998a-4165-aed6-91576881f062	true	access.token.claim
e3ed805d-998a-4165-aed6-91576881f062	locale	claim.name
e3ed805d-998a-4165-aed6-91576881f062	String	jsonType.label
f7a55b84-5b3f-4b30-abb8-f98c53148eb1	clientId	user.session.note
f7a55b84-5b3f-4b30-abb8-f98c53148eb1	true	id.token.claim
f7a55b84-5b3f-4b30-abb8-f98c53148eb1	true	access.token.claim
f7a55b84-5b3f-4b30-abb8-f98c53148eb1	clientId	claim.name
f7a55b84-5b3f-4b30-abb8-f98c53148eb1	String	jsonType.label
260d1942-9ddb-43ec-8457-821411f64e5f	clientHost	user.session.note
260d1942-9ddb-43ec-8457-821411f64e5f	true	id.token.claim
260d1942-9ddb-43ec-8457-821411f64e5f	true	access.token.claim
260d1942-9ddb-43ec-8457-821411f64e5f	clientHost	claim.name
260d1942-9ddb-43ec-8457-821411f64e5f	String	jsonType.label
4aa8e0d4-e026-49eb-bd20-b6981ad2b73f	clientAddress	user.session.note
4aa8e0d4-e026-49eb-bd20-b6981ad2b73f	true	id.token.claim
4aa8e0d4-e026-49eb-bd20-b6981ad2b73f	true	access.token.claim
4aa8e0d4-e026-49eb-bd20-b6981ad2b73f	clientAddress	claim.name
4aa8e0d4-e026-49eb-bd20-b6981ad2b73f	String	jsonType.label
\.


--
-- Data for Name: realm; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm (id, access_code_lifespan, user_action_lifespan, access_token_lifespan, account_theme, admin_theme, email_theme, enabled, events_enabled, events_expiration, login_theme, name, not_before, password_policy, registration_allowed, remember_me, reset_password_allowed, social, ssl_required, sso_idle_timeout, sso_max_lifespan, update_profile_on_soc_login, verify_email, master_admin_client, login_lifespan, internationalization_enabled, default_locale, reg_email_as_username, admin_events_enabled, admin_events_details_enabled, edit_username_allowed, otp_policy_counter, otp_policy_window, otp_policy_period, otp_policy_digits, otp_policy_alg, otp_policy_type, browser_flow, registration_flow, direct_grant_flow, reset_credentials_flow, client_auth_flow, offline_session_idle_timeout, revoke_refresh_token, access_token_life_implicit, login_with_email_allowed, duplicate_emails_allowed, docker_auth_flow, refresh_token_max_reuse, allow_user_managed_access, sso_max_lifespan_remember_me, sso_idle_timeout_remember_me, default_role) FROM stdin;
97c3a519-e834-45b3-aeca-7eb9552a7e49	60	300	1800	\N	\N	\N	t	f	0	\N	omnis	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	7ca1ce99-6a05-4290-b9a9-8070dab16cf0	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	fb085973-11fe-4281-b99a-830d590400a7	950c9283-a286-440e-9aa3-7d9875fc1f56	922b8906-98e1-4e42-a2b1-40c2b5a59fa5	0052c724-45cb-4d54-83f6-ac139887234f	a6b50ec9-28ad-40af-aea6-cd9c1e0854a8	2592000	f	900	t	f	2917b054-52ab-4465-8140-a7e259c3173a	0	f	0	0	1c4dee70-4cf0-4218-9fa9-b95c0a710886
c801dbb6-9ca3-4c23-ad63-1946842fef6b	60	300	60	\N	\N	\N	t	f	0	\N	master	0	\N	f	f	f	f	NONE	1800	36000	f	f	a6441220-7d8d-4c25-a07a-db8b6dcaaff0	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	f1e309d5-3c71-4cb8-9f98-0d05cd190041	e152966d-24d4-42e1-8ada-8e7606ebdbc4	12c50607-69b9-4641-bb6e-ca0caefde962	f5e1958d-126b-41cb-acf0-3fadee0634d3	e7f727ef-0567-42a4-b1f3-615fdaf1de6c	2592000	f	900	t	f	5717052e-4d87-492a-8547-212df6178d0f	0	f	0	0	6537ee5a-325e-45fe-a57d-68e71ca3a991
\.


--
-- Data for Name: realm_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_attribute (name, realm_id, value) FROM stdin;
oauth2DeviceCodeLifespan	97c3a519-e834-45b3-aeca-7eb9552a7e49	600
oauth2DevicePollingInterval	97c3a519-e834-45b3-aeca-7eb9552a7e49	5
cibaBackchannelTokenDeliveryMode	97c3a519-e834-45b3-aeca-7eb9552a7e49	poll
cibaExpiresIn	97c3a519-e834-45b3-aeca-7eb9552a7e49	120
cibaInterval	97c3a519-e834-45b3-aeca-7eb9552a7e49	5
cibaAuthRequestedUserHint	97c3a519-e834-45b3-aeca-7eb9552a7e49	login_hint
parRequestUriLifespan	97c3a519-e834-45b3-aeca-7eb9552a7e49	60
actionTokenGeneratedByUserLifespan-verify-email	97c3a519-e834-45b3-aeca-7eb9552a7e49	
actionTokenGeneratedByUserLifespan-idp-verify-account-via-email	97c3a519-e834-45b3-aeca-7eb9552a7e49	
actionTokenGeneratedByUserLifespan-reset-credentials	97c3a519-e834-45b3-aeca-7eb9552a7e49	
actionTokenGeneratedByUserLifespan-execute-actions	97c3a519-e834-45b3-aeca-7eb9552a7e49	
bruteForceProtected	97c3a519-e834-45b3-aeca-7eb9552a7e49	false
permanentLockout	97c3a519-e834-45b3-aeca-7eb9552a7e49	false
maxFailureWaitSeconds	97c3a519-e834-45b3-aeca-7eb9552a7e49	900
minimumQuickLoginWaitSeconds	97c3a519-e834-45b3-aeca-7eb9552a7e49	60
waitIncrementSeconds	97c3a519-e834-45b3-aeca-7eb9552a7e49	60
quickLoginCheckMilliSeconds	97c3a519-e834-45b3-aeca-7eb9552a7e49	1000
maxDeltaTimeSeconds	97c3a519-e834-45b3-aeca-7eb9552a7e49	43200
failureFactor	97c3a519-e834-45b3-aeca-7eb9552a7e49	30
actionTokenGeneratedByAdminLifespan	97c3a519-e834-45b3-aeca-7eb9552a7e49	43200
actionTokenGeneratedByUserLifespan	97c3a519-e834-45b3-aeca-7eb9552a7e49	300
defaultSignatureAlgorithm	97c3a519-e834-45b3-aeca-7eb9552a7e49	RS256
offlineSessionMaxLifespanEnabled	97c3a519-e834-45b3-aeca-7eb9552a7e49	false
offlineSessionMaxLifespan	97c3a519-e834-45b3-aeca-7eb9552a7e49	5184000
clientSessionIdleTimeout	97c3a519-e834-45b3-aeca-7eb9552a7e49	0
clientSessionMaxLifespan	97c3a519-e834-45b3-aeca-7eb9552a7e49	0
clientOfflineSessionIdleTimeout	97c3a519-e834-45b3-aeca-7eb9552a7e49	0
clientOfflineSessionMaxLifespan	97c3a519-e834-45b3-aeca-7eb9552a7e49	0
webAuthnPolicyRpEntityName	97c3a519-e834-45b3-aeca-7eb9552a7e49	keycloak
webAuthnPolicySignatureAlgorithms	97c3a519-e834-45b3-aeca-7eb9552a7e49	ES256
webAuthnPolicyRpId	97c3a519-e834-45b3-aeca-7eb9552a7e49	
webAuthnPolicyAttestationConveyancePreference	97c3a519-e834-45b3-aeca-7eb9552a7e49	not specified
webAuthnPolicyAuthenticatorAttachment	97c3a519-e834-45b3-aeca-7eb9552a7e49	not specified
webAuthnPolicyRequireResidentKey	97c3a519-e834-45b3-aeca-7eb9552a7e49	not specified
webAuthnPolicyUserVerificationRequirement	97c3a519-e834-45b3-aeca-7eb9552a7e49	not specified
webAuthnPolicyCreateTimeout	97c3a519-e834-45b3-aeca-7eb9552a7e49	0
webAuthnPolicyAvoidSameAuthenticatorRegister	97c3a519-e834-45b3-aeca-7eb9552a7e49	false
webAuthnPolicyRpEntityNamePasswordless	97c3a519-e834-45b3-aeca-7eb9552a7e49	keycloak
webAuthnPolicySignatureAlgorithmsPasswordless	97c3a519-e834-45b3-aeca-7eb9552a7e49	ES256
webAuthnPolicyRpIdPasswordless	97c3a519-e834-45b3-aeca-7eb9552a7e49	
webAuthnPolicyAttestationConveyancePreferencePasswordless	97c3a519-e834-45b3-aeca-7eb9552a7e49	not specified
webAuthnPolicyAuthenticatorAttachmentPasswordless	97c3a519-e834-45b3-aeca-7eb9552a7e49	not specified
webAuthnPolicyRequireResidentKeyPasswordless	97c3a519-e834-45b3-aeca-7eb9552a7e49	not specified
webAuthnPolicyUserVerificationRequirementPasswordless	97c3a519-e834-45b3-aeca-7eb9552a7e49	not specified
webAuthnPolicyCreateTimeoutPasswordless	97c3a519-e834-45b3-aeca-7eb9552a7e49	0
webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless	97c3a519-e834-45b3-aeca-7eb9552a7e49	false
client-policies.profiles	97c3a519-e834-45b3-aeca-7eb9552a7e49	{"profiles":[]}
client-policies.policies	97c3a519-e834-45b3-aeca-7eb9552a7e49	{"policies":[]}
_browser_header.contentSecurityPolicyReportOnly	97c3a519-e834-45b3-aeca-7eb9552a7e49	
_browser_header.xContentTypeOptions	97c3a519-e834-45b3-aeca-7eb9552a7e49	nosniff
_browser_header.xRobotsTag	97c3a519-e834-45b3-aeca-7eb9552a7e49	none
_browser_header.xFrameOptions	97c3a519-e834-45b3-aeca-7eb9552a7e49	SAMEORIGIN
_browser_header.contentSecurityPolicy	97c3a519-e834-45b3-aeca-7eb9552a7e49	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	97c3a519-e834-45b3-aeca-7eb9552a7e49	1; mode=block
_browser_header.strictTransportSecurity	97c3a519-e834-45b3-aeca-7eb9552a7e49	max-age=31536000; includeSubDomains
cibaBackchannelTokenDeliveryMode	c801dbb6-9ca3-4c23-ad63-1946842fef6b	poll
cibaExpiresIn	c801dbb6-9ca3-4c23-ad63-1946842fef6b	120
cibaAuthRequestedUserHint	c801dbb6-9ca3-4c23-ad63-1946842fef6b	login_hint
parRequestUriLifespan	c801dbb6-9ca3-4c23-ad63-1946842fef6b	60
cibaInterval	c801dbb6-9ca3-4c23-ad63-1946842fef6b	5
displayName	c801dbb6-9ca3-4c23-ad63-1946842fef6b	Keycloak
displayNameHtml	c801dbb6-9ca3-4c23-ad63-1946842fef6b	<div class="kc-logo-text"><span>Keycloak</span></div>
bruteForceProtected	c801dbb6-9ca3-4c23-ad63-1946842fef6b	false
permanentLockout	c801dbb6-9ca3-4c23-ad63-1946842fef6b	false
maxFailureWaitSeconds	c801dbb6-9ca3-4c23-ad63-1946842fef6b	900
minimumQuickLoginWaitSeconds	c801dbb6-9ca3-4c23-ad63-1946842fef6b	60
waitIncrementSeconds	c801dbb6-9ca3-4c23-ad63-1946842fef6b	60
quickLoginCheckMilliSeconds	c801dbb6-9ca3-4c23-ad63-1946842fef6b	1000
maxDeltaTimeSeconds	c801dbb6-9ca3-4c23-ad63-1946842fef6b	43200
failureFactor	c801dbb6-9ca3-4c23-ad63-1946842fef6b	30
actionTokenGeneratedByAdminLifespan	c801dbb6-9ca3-4c23-ad63-1946842fef6b	43200
actionTokenGeneratedByUserLifespan	c801dbb6-9ca3-4c23-ad63-1946842fef6b	300
oauth2DeviceCodeLifespan	c801dbb6-9ca3-4c23-ad63-1946842fef6b	600
oauth2DevicePollingInterval	c801dbb6-9ca3-4c23-ad63-1946842fef6b	5
defaultSignatureAlgorithm	c801dbb6-9ca3-4c23-ad63-1946842fef6b	RS256
offlineSessionMaxLifespanEnabled	c801dbb6-9ca3-4c23-ad63-1946842fef6b	false
offlineSessionMaxLifespan	c801dbb6-9ca3-4c23-ad63-1946842fef6b	5184000
clientSessionIdleTimeout	c801dbb6-9ca3-4c23-ad63-1946842fef6b	0
clientSessionMaxLifespan	c801dbb6-9ca3-4c23-ad63-1946842fef6b	0
clientOfflineSessionIdleTimeout	c801dbb6-9ca3-4c23-ad63-1946842fef6b	0
clientOfflineSessionMaxLifespan	c801dbb6-9ca3-4c23-ad63-1946842fef6b	0
webAuthnPolicyRpEntityName	c801dbb6-9ca3-4c23-ad63-1946842fef6b	keycloak
webAuthnPolicySignatureAlgorithms	c801dbb6-9ca3-4c23-ad63-1946842fef6b	ES256
webAuthnPolicyRpId	c801dbb6-9ca3-4c23-ad63-1946842fef6b	
webAuthnPolicyAttestationConveyancePreference	c801dbb6-9ca3-4c23-ad63-1946842fef6b	not specified
webAuthnPolicyAuthenticatorAttachment	c801dbb6-9ca3-4c23-ad63-1946842fef6b	not specified
webAuthnPolicyRequireResidentKey	c801dbb6-9ca3-4c23-ad63-1946842fef6b	not specified
webAuthnPolicyUserVerificationRequirement	c801dbb6-9ca3-4c23-ad63-1946842fef6b	not specified
webAuthnPolicyCreateTimeout	c801dbb6-9ca3-4c23-ad63-1946842fef6b	0
webAuthnPolicyAvoidSameAuthenticatorRegister	c801dbb6-9ca3-4c23-ad63-1946842fef6b	false
webAuthnPolicyRpEntityNamePasswordless	c801dbb6-9ca3-4c23-ad63-1946842fef6b	keycloak
webAuthnPolicySignatureAlgorithmsPasswordless	c801dbb6-9ca3-4c23-ad63-1946842fef6b	ES256
webAuthnPolicyRpIdPasswordless	c801dbb6-9ca3-4c23-ad63-1946842fef6b	
webAuthnPolicyAttestationConveyancePreferencePasswordless	c801dbb6-9ca3-4c23-ad63-1946842fef6b	not specified
webAuthnPolicyAuthenticatorAttachmentPasswordless	c801dbb6-9ca3-4c23-ad63-1946842fef6b	not specified
webAuthnPolicyRequireResidentKeyPasswordless	c801dbb6-9ca3-4c23-ad63-1946842fef6b	not specified
webAuthnPolicyUserVerificationRequirementPasswordless	c801dbb6-9ca3-4c23-ad63-1946842fef6b	not specified
webAuthnPolicyCreateTimeoutPasswordless	c801dbb6-9ca3-4c23-ad63-1946842fef6b	0
webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless	c801dbb6-9ca3-4c23-ad63-1946842fef6b	false
client-policies.profiles	c801dbb6-9ca3-4c23-ad63-1946842fef6b	{"profiles":[]}
client-policies.policies	c801dbb6-9ca3-4c23-ad63-1946842fef6b	{"policies":[]}
_browser_header.contentSecurityPolicyReportOnly	c801dbb6-9ca3-4c23-ad63-1946842fef6b	
_browser_header.xContentTypeOptions	c801dbb6-9ca3-4c23-ad63-1946842fef6b	nosniff
_browser_header.xRobotsTag	c801dbb6-9ca3-4c23-ad63-1946842fef6b	none
_browser_header.xFrameOptions	c801dbb6-9ca3-4c23-ad63-1946842fef6b	SAMEORIGIN
_browser_header.xXSSProtection	c801dbb6-9ca3-4c23-ad63-1946842fef6b	1; mode=block
_browser_header.contentSecurityPolicy	c801dbb6-9ca3-4c23-ad63-1946842fef6b	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.strictTransportSecurity	c801dbb6-9ca3-4c23-ad63-1946842fef6b	max-age=31536000; includeSubDomains
\.


--
-- Data for Name: realm_default_groups; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_default_groups (realm_id, group_id) FROM stdin;
\.


--
-- Data for Name: realm_enabled_event_types; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_enabled_event_types (realm_id, value) FROM stdin;
\.


--
-- Data for Name: realm_events_listeners; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_events_listeners (realm_id, value) FROM stdin;
97c3a519-e834-45b3-aeca-7eb9552a7e49	jboss-logging
c801dbb6-9ca3-4c23-ad63-1946842fef6b	jboss-logging
\.


--
-- Data for Name: realm_localizations; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_localizations (realm_id, locale, texts) FROM stdin;
\.


--
-- Data for Name: realm_required_credential; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_required_credential (type, form_label, input, secret, realm_id) FROM stdin;
password	password	t	t	c801dbb6-9ca3-4c23-ad63-1946842fef6b
password	password	t	t	97c3a519-e834-45b3-aeca-7eb9552a7e49
\.


--
-- Data for Name: realm_smtp_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_smtp_config (realm_id, value, name) FROM stdin;
\.


--
-- Data for Name: realm_supported_locales; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_supported_locales (realm_id, value) FROM stdin;
\.


--
-- Data for Name: redirect_uris; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.redirect_uris (client_id, value) FROM stdin;
4baf3ada-e710-46b8-9b40-5d1bfeaf4597	/realms/master/account/*
61c79e81-07a8-4f10-9025-22f887c523ac	/realms/master/account/*
f216da3e-8d34-4377-8579-f848e3b74d43	/admin/master/console/*
598bff12-62ca-4834-84b9-1c82e941d841	/realms/omnis/account/*
d630f008-dba1-4dfc-a87d-f924946512da	/realms/omnis/account/*
544f2483-84b5-425f-b5fe-5a2a3ab837ee	/admin/omnis/console/*
053a6fde-90c3-4bca-a2bf-62bca14b8624	http://omnis.ca:3000/api/auth/callback/*
\.


--
-- Data for Name: required_action_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.required_action_config (required_action_id, value, name) FROM stdin;
\.


--
-- Data for Name: required_action_provider; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) FROM stdin;
934e7e95-d896-4f05-bb42-dca5f5770502	VERIFY_EMAIL	Verify Email	c801dbb6-9ca3-4c23-ad63-1946842fef6b	t	f	VERIFY_EMAIL	50
71e707e1-6009-4fc8-9fda-d94748d00566	UPDATE_PROFILE	Update Profile	c801dbb6-9ca3-4c23-ad63-1946842fef6b	t	f	UPDATE_PROFILE	40
a7813d1b-114a-4963-b842-14a08b9fe6f9	CONFIGURE_TOTP	Configure OTP	c801dbb6-9ca3-4c23-ad63-1946842fef6b	t	f	CONFIGURE_TOTP	10
dfcae29d-8a0d-494f-9a9f-e769828556dd	UPDATE_PASSWORD	Update Password	c801dbb6-9ca3-4c23-ad63-1946842fef6b	t	f	UPDATE_PASSWORD	30
94f18b12-1597-4c16-ac72-ddfcd6e7262c	terms_and_conditions	Terms and Conditions	c801dbb6-9ca3-4c23-ad63-1946842fef6b	f	f	terms_and_conditions	20
1bdd8fd7-706d-4aad-9dc9-403d2f3ba7a2	update_user_locale	Update User Locale	c801dbb6-9ca3-4c23-ad63-1946842fef6b	t	f	update_user_locale	1000
f5b77092-3dec-405c-812d-2529cbeba820	delete_account	Delete Account	c801dbb6-9ca3-4c23-ad63-1946842fef6b	f	f	delete_account	60
97f95b4e-cce4-4c29-8272-7b46a765c64e	webauthn-register	Webauthn Register	c801dbb6-9ca3-4c23-ad63-1946842fef6b	t	f	webauthn-register	70
03cdae8e-411e-4eef-80e4-74693c4b860c	webauthn-register-passwordless	Webauthn Register Passwordless	c801dbb6-9ca3-4c23-ad63-1946842fef6b	t	f	webauthn-register-passwordless	80
09d44215-d0fa-4b9f-b65b-ee760ea19e47	VERIFY_EMAIL	Verify Email	97c3a519-e834-45b3-aeca-7eb9552a7e49	t	f	VERIFY_EMAIL	50
263508dc-1e62-4279-bcdb-5e75203069da	UPDATE_PROFILE	Update Profile	97c3a519-e834-45b3-aeca-7eb9552a7e49	t	f	UPDATE_PROFILE	40
d30886ea-85f2-40f9-a3d9-f6cf279efb07	CONFIGURE_TOTP	Configure OTP	97c3a519-e834-45b3-aeca-7eb9552a7e49	t	f	CONFIGURE_TOTP	10
0c4e5ebd-2e4a-408f-8095-3fecc3be08b9	UPDATE_PASSWORD	Update Password	97c3a519-e834-45b3-aeca-7eb9552a7e49	t	f	UPDATE_PASSWORD	30
317c743a-febb-4d91-a20e-84ca9b0143dd	terms_and_conditions	Terms and Conditions	97c3a519-e834-45b3-aeca-7eb9552a7e49	f	f	terms_and_conditions	20
f6fd280d-e4a9-4aa0-aab4-08c9ca5793f7	update_user_locale	Update User Locale	97c3a519-e834-45b3-aeca-7eb9552a7e49	t	f	update_user_locale	1000
bed7c3d2-7958-4a35-93de-2c8188b4dd21	delete_account	Delete Account	97c3a519-e834-45b3-aeca-7eb9552a7e49	f	f	delete_account	60
fb38d3b9-6f30-46f9-9e3d-5d4d36d2a4cd	webauthn-register	Webauthn Register	97c3a519-e834-45b3-aeca-7eb9552a7e49	t	f	webauthn-register	70
2f93caf7-b2b7-40ca-97f1-cc412a57b080	webauthn-register-passwordless	Webauthn Register Passwordless	97c3a519-e834-45b3-aeca-7eb9552a7e49	t	f	webauthn-register-passwordless	80
\.


--
-- Data for Name: resource_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_attribute (id, name, value, resource_id) FROM stdin;
\.


--
-- Data for Name: resource_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_policy (resource_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_scope (resource_id, scope_id) FROM stdin;
\.


--
-- Data for Name: resource_server; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server (id, allow_rs_remote_mgmt, policy_enforce_mode, decision_strategy) FROM stdin;
31a936f1-8990-4ea8-92fd-a1e396039fe6	f	0	1
053a6fde-90c3-4bca-a2bf-62bca14b8624	t	0	1
\.


--
-- Data for Name: resource_server_perm_ticket; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server_perm_ticket (id, owner, requester, created_timestamp, granted_timestamp, resource_id, scope_id, resource_server_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_server_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id, owner) FROM stdin;
60350c9c-7926-49e6-b374-1df1e2365702	Default Policy	A policy that grants access only for users within this realm	js	0	0	053a6fde-90c3-4bca-a2bf-62bca14b8624	\N
b6897ac2-baf7-42ae-978a-9a2fa8537b1f	Default Permission	A permission that applies to the default resource type	resource	1	0	053a6fde-90c3-4bca-a2bf-62bca14b8624	\N
\.


--
-- Data for Name: resource_server_resource; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server_resource (id, name, type, icon_uri, owner, resource_server_id, owner_managed_access, display_name) FROM stdin;
932174a7-130e-4d37-a30e-ddfaf376bb33	Default Resource	urn:omnis_client:resources:default	\N	053a6fde-90c3-4bca-a2bf-62bca14b8624	053a6fde-90c3-4bca-a2bf-62bca14b8624	f	\N
\.


--
-- Data for Name: resource_server_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server_scope (id, name, icon_uri, resource_server_id, display_name) FROM stdin;
a427c604-6e14-415d-b696-f484cb08d3b8	map-role	\N	31a936f1-8990-4ea8-92fd-a1e396039fe6	\N
e9932e49-798c-4aac-abcc-86c5c43776bd	map-role-client-scope	\N	31a936f1-8990-4ea8-92fd-a1e396039fe6	\N
f4e4b7cd-53bb-43e4-9b0c-fb68aab9617c	map-role-composite	\N	31a936f1-8990-4ea8-92fd-a1e396039fe6	\N
\.


--
-- Data for Name: resource_uris; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_uris (resource_id, value) FROM stdin;
932174a7-130e-4d37-a30e-ddfaf376bb33	/*
\.


--
-- Data for Name: role_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.role_attribute (id, role_id, name, value) FROM stdin;
\.


--
-- Data for Name: scope_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.scope_mapping (client_id, role_id) FROM stdin;
61c79e81-07a8-4f10-9025-22f887c523ac	96679f24-2cb5-4b44-acc8-91b3cb50e3f0
d630f008-dba1-4dfc-a87d-f924946512da	63ef9c07-e52b-46d5-a5d6-0a803a8314c5
\.


--
-- Data for Name: scope_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.scope_policy (scope_id, policy_id) FROM stdin;
\.


--
-- Data for Name: user_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_attribute (name, value, user_id, id) FROM stdin;
\.


--
-- Data for Name: user_consent; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_consent (id, client_id, user_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: user_consent_client_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_consent_client_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: user_entity; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name, last_name, realm_id, username, created_timestamp, service_account_client_link, not_before) FROM stdin;
929953af-32a3-4550-988f-3ec066267d09	\N	f8b2996f-78c6-4bb7-87f8-dbbfc89f64ae	f	t	\N	\N	\N	c801dbb6-9ca3-4c23-ad63-1946842fef6b	admin	1683555342375	\N	0
17933924-0e23-46f3-8764-36e8e10adba2	\N	85c74f61-3c8e-4087-a4a8-6d99422eb6a3	f	t	\N	\N	\N	97c3a519-e834-45b3-aeca-7eb9552a7e49	service-account-omnis_client	1684116408252	053a6fde-90c3-4bca-a2bf-62bca14b8624	0
fb9ed89f-82cd-4dd7-b3cd-4c4bccb4ebc8	demo@gmail.com	demo@gmail.com	f	t	\N	Demo	Demo	97c3a519-e834-45b3-aeca-7eb9552a7e49	demo	1685152917272	\N	0
\.


--
-- Data for Name: user_federation_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_federation_config (user_federation_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_federation_mapper (id, name, federation_provider_id, federation_mapper_type, realm_id) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_federation_mapper_config (user_federation_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_provider; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_federation_provider (id, changed_sync_period, display_name, full_sync_period, last_sync, priority, provider_name, realm_id) FROM stdin;
\.


--
-- Data for Name: user_group_membership; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_group_membership (group_id, user_id) FROM stdin;
3b1ce55f-daa0-40df-a33a-43a2a50580ef	fb9ed89f-82cd-4dd7-b3cd-4c4bccb4ebc8
\.


--
-- Data for Name: user_required_action; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_required_action (user_id, required_action) FROM stdin;
\.


--
-- Data for Name: user_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_role_mapping (role_id, user_id) FROM stdin;
6537ee5a-325e-45fe-a57d-68e71ca3a991	929953af-32a3-4550-988f-3ec066267d09
47b2d91b-8d7b-4abe-aaeb-0d9ad4b08e11	929953af-32a3-4550-988f-3ec066267d09
e76c8ff7-ed2f-4887-a72d-77c1f78f8a05	929953af-32a3-4550-988f-3ec066267d09
47ede815-30b6-4f27-9413-fc0c50336dbb	929953af-32a3-4550-988f-3ec066267d09
25943332-c4ca-41fe-9869-309f9a84bed3	929953af-32a3-4550-988f-3ec066267d09
4185b06c-f40d-4296-b0f1-ad1bfdb84c18	929953af-32a3-4550-988f-3ec066267d09
00ccbfd0-0dc6-4b1f-ad60-e21d3dd47c2d	929953af-32a3-4550-988f-3ec066267d09
855d464d-4068-44d7-87d9-763f89bb516b	929953af-32a3-4550-988f-3ec066267d09
40d9a219-8b78-4ad2-b7d4-c0ac9384997f	929953af-32a3-4550-988f-3ec066267d09
75884b9c-3a12-4bcb-93a1-2efa20cee9b4	929953af-32a3-4550-988f-3ec066267d09
68ed575b-254d-442c-aff4-aebdde13bd03	929953af-32a3-4550-988f-3ec066267d09
b315154c-b374-446b-a12f-a24cc1b5a964	929953af-32a3-4550-988f-3ec066267d09
6a3c6da3-60c2-4d7f-b164-e40933030106	929953af-32a3-4550-988f-3ec066267d09
a5ebf57a-7153-4612-9dad-775b82f9d808	929953af-32a3-4550-988f-3ec066267d09
c4af971b-f302-49b6-96d0-c487aa1f952d	929953af-32a3-4550-988f-3ec066267d09
bc3526a1-f236-4809-a1df-b019f7f0571c	929953af-32a3-4550-988f-3ec066267d09
ce6ed041-0fed-405b-98c3-d763b25f6931	929953af-32a3-4550-988f-3ec066267d09
a0cfc807-8e12-4871-be62-89a83b9639f7	929953af-32a3-4550-988f-3ec066267d09
5e2c759c-7a60-403e-bda3-1df7f2267f1a	929953af-32a3-4550-988f-3ec066267d09
1c4dee70-4cf0-4218-9fa9-b95c0a710886	17933924-0e23-46f3-8764-36e8e10adba2
b9b8631a-3b67-489f-8341-416a3765914f	17933924-0e23-46f3-8764-36e8e10adba2
814f824a-9182-4370-9ad3-1d85d4a9bbff	17933924-0e23-46f3-8764-36e8e10adba2
1c4dee70-4cf0-4218-9fa9-b95c0a710886	fb9ed89f-82cd-4dd7-b3cd-4c4bccb4ebc8
\.


--
-- Data for Name: user_session; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_session (id, auth_method, ip_address, last_session_refresh, login_username, realm_id, remember_me, started, user_id, user_session_state, broker_session_id, broker_user_id) FROM stdin;
\.


--
-- Data for Name: user_session_note; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_session_note (user_session, name, value) FROM stdin;
\.


--
-- Data for Name: username_login_failure; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.username_login_failure (realm_id, username, failed_login_not_before, last_failure, last_ip_failure, num_failures) FROM stdin;
\.


--
-- Data for Name: web_origins; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.web_origins (client_id, value) FROM stdin;
f216da3e-8d34-4377-8579-f848e3b74d43	+
544f2483-84b5-425f-b5fe-5a2a3ab837ee	+
\.


--
-- Name: username_login_failure CONSTRAINT_17-2; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.username_login_failure
    ADD CONSTRAINT "CONSTRAINT_17-2" PRIMARY KEY (realm_id, username);


--
-- Name: keycloak_role UK_J3RWUVD56ONTGSUHOGM184WW2-2; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT "UK_J3RWUVD56ONTGSUHOGM184WW2-2" UNIQUE (name, client_realm_constraint);


--
-- Name: client_auth_flow_bindings c_cli_flow_bind; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_auth_flow_bindings
    ADD CONSTRAINT c_cli_flow_bind PRIMARY KEY (client_id, binding_name);


--
-- Name: client_scope_client c_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT c_cli_scope_bind PRIMARY KEY (client_id, scope_id);


--
-- Name: client_initial_access cnstr_client_init_acc_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT cnstr_client_init_acc_pk PRIMARY KEY (id);


--
-- Name: realm_default_groups con_group_id_def_groups; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT con_group_id_def_groups UNIQUE (group_id);


--
-- Name: broker_link constr_broker_link_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.broker_link
    ADD CONSTRAINT constr_broker_link_pk PRIMARY KEY (identity_provider, user_id);


--
-- Name: client_user_session_note constr_cl_usr_ses_note; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT constr_cl_usr_ses_note PRIMARY KEY (client_session, name);


--
-- Name: component_config constr_component_config_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT constr_component_config_pk PRIMARY KEY (id);


--
-- Name: component constr_component_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT constr_component_pk PRIMARY KEY (id);


--
-- Name: fed_user_required_action constr_fed_required_action; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_required_action
    ADD CONSTRAINT constr_fed_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: fed_user_attribute constr_fed_user_attr_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_attribute
    ADD CONSTRAINT constr_fed_user_attr_pk PRIMARY KEY (id);


--
-- Name: fed_user_consent constr_fed_user_consent_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_consent
    ADD CONSTRAINT constr_fed_user_consent_pk PRIMARY KEY (id);


--
-- Name: fed_user_credential constr_fed_user_cred_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_credential
    ADD CONSTRAINT constr_fed_user_cred_pk PRIMARY KEY (id);


--
-- Name: fed_user_group_membership constr_fed_user_group; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_group_membership
    ADD CONSTRAINT constr_fed_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: fed_user_role_mapping constr_fed_user_role; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_role_mapping
    ADD CONSTRAINT constr_fed_user_role PRIMARY KEY (role_id, user_id);


--
-- Name: federated_user constr_federated_user; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.federated_user
    ADD CONSTRAINT constr_federated_user PRIMARY KEY (id);


--
-- Name: realm_default_groups constr_realm_default_groups; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT constr_realm_default_groups PRIMARY KEY (realm_id, group_id);


--
-- Name: realm_enabled_event_types constr_realm_enabl_event_types; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT constr_realm_enabl_event_types PRIMARY KEY (realm_id, value);


--
-- Name: realm_events_listeners constr_realm_events_listeners; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT constr_realm_events_listeners PRIMARY KEY (realm_id, value);


--
-- Name: realm_supported_locales constr_realm_supported_locales; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT constr_realm_supported_locales PRIMARY KEY (realm_id, value);


--
-- Name: identity_provider constraint_2b; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT constraint_2b PRIMARY KEY (internal_id);


--
-- Name: client_attributes constraint_3c; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT constraint_3c PRIMARY KEY (client_id, name);


--
-- Name: event_entity constraint_4; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.event_entity
    ADD CONSTRAINT constraint_4 PRIMARY KEY (id);


--
-- Name: federated_identity constraint_40; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT constraint_40 PRIMARY KEY (identity_provider, user_id);


--
-- Name: realm constraint_4a; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT constraint_4a PRIMARY KEY (id);


--
-- Name: client_session_role constraint_5; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT constraint_5 PRIMARY KEY (client_session, role_id);


--
-- Name: user_session constraint_57; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_session
    ADD CONSTRAINT constraint_57 PRIMARY KEY (id);


--
-- Name: user_federation_provider constraint_5c; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT constraint_5c PRIMARY KEY (id);


--
-- Name: client_session_note constraint_5e; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT constraint_5e PRIMARY KEY (client_session, name);


--
-- Name: client constraint_7; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT constraint_7 PRIMARY KEY (id);


--
-- Name: client_session constraint_8; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT constraint_8 PRIMARY KEY (id);


--
-- Name: scope_mapping constraint_81; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT constraint_81 PRIMARY KEY (client_id, role_id);


--
-- Name: client_node_registrations constraint_84; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT constraint_84 PRIMARY KEY (client_id, name);


--
-- Name: realm_attribute constraint_9; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT constraint_9 PRIMARY KEY (name, realm_id);


--
-- Name: realm_required_credential constraint_92; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT constraint_92 PRIMARY KEY (realm_id, type);


--
-- Name: keycloak_role constraint_a; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT constraint_a PRIMARY KEY (id);


--
-- Name: admin_event_entity constraint_admin_event_entity; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.admin_event_entity
    ADD CONSTRAINT constraint_admin_event_entity PRIMARY KEY (id);


--
-- Name: authenticator_config_entry constraint_auth_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authenticator_config_entry
    ADD CONSTRAINT constraint_auth_cfg_pk PRIMARY KEY (authenticator_id, name);


--
-- Name: authentication_execution constraint_auth_exec_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT constraint_auth_exec_pk PRIMARY KEY (id);


--
-- Name: authentication_flow constraint_auth_flow_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT constraint_auth_flow_pk PRIMARY KEY (id);


--
-- Name: authenticator_config constraint_auth_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT constraint_auth_pk PRIMARY KEY (id);


--
-- Name: client_session_auth_status constraint_auth_status_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT constraint_auth_status_pk PRIMARY KEY (client_session, authenticator);


--
-- Name: user_role_mapping constraint_c; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT constraint_c PRIMARY KEY (role_id, user_id);


--
-- Name: composite_role constraint_composite_role; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT constraint_composite_role PRIMARY KEY (composite, child_role);


--
-- Name: client_session_prot_mapper constraint_cs_pmp_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT constraint_cs_pmp_pk PRIMARY KEY (client_session, protocol_mapper_id);


--
-- Name: identity_provider_config constraint_d; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT constraint_d PRIMARY KEY (identity_provider_id, name);


--
-- Name: policy_config constraint_dpc; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT constraint_dpc PRIMARY KEY (policy_id, name);


--
-- Name: realm_smtp_config constraint_e; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT constraint_e PRIMARY KEY (realm_id, name);


--
-- Name: credential constraint_f; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT constraint_f PRIMARY KEY (id);


--
-- Name: user_federation_config constraint_f9; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT constraint_f9 PRIMARY KEY (user_federation_provider_id, name);


--
-- Name: resource_server_perm_ticket constraint_fapmt; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT constraint_fapmt PRIMARY KEY (id);


--
-- Name: resource_server_resource constraint_farsr; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT constraint_farsr PRIMARY KEY (id);


--
-- Name: resource_server_policy constraint_farsrp; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT constraint_farsrp PRIMARY KEY (id);


--
-- Name: associated_policy constraint_farsrpap; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT constraint_farsrpap PRIMARY KEY (policy_id, associated_policy_id);


--
-- Name: resource_policy constraint_farsrpp; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT constraint_farsrpp PRIMARY KEY (resource_id, policy_id);


--
-- Name: resource_server_scope constraint_farsrs; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT constraint_farsrs PRIMARY KEY (id);


--
-- Name: resource_scope constraint_farsrsp; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT constraint_farsrsp PRIMARY KEY (resource_id, scope_id);


--
-- Name: scope_policy constraint_farsrsps; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT constraint_farsrsps PRIMARY KEY (scope_id, policy_id);


--
-- Name: user_entity constraint_fb; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT constraint_fb PRIMARY KEY (id);


--
-- Name: user_federation_mapper_config constraint_fedmapper_cfg_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT constraint_fedmapper_cfg_pm PRIMARY KEY (user_federation_mapper_id, name);


--
-- Name: user_federation_mapper constraint_fedmapperpm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT constraint_fedmapperpm PRIMARY KEY (id);


--
-- Name: fed_user_consent_cl_scope constraint_fgrntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_consent_cl_scope
    ADD CONSTRAINT constraint_fgrntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent_client_scope constraint_grntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT constraint_grntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent constraint_grntcsnt_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT constraint_grntcsnt_pm PRIMARY KEY (id);


--
-- Name: keycloak_group constraint_group; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT constraint_group PRIMARY KEY (id);


--
-- Name: group_attribute constraint_group_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT constraint_group_attribute_pk PRIMARY KEY (id);


--
-- Name: group_role_mapping constraint_group_role; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT constraint_group_role PRIMARY KEY (role_id, group_id);


--
-- Name: identity_provider_mapper constraint_idpm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT constraint_idpm PRIMARY KEY (id);


--
-- Name: idp_mapper_config constraint_idpmconfig; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT constraint_idpmconfig PRIMARY KEY (idp_mapper_id, name);


--
-- Name: migration_model constraint_migmod; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.migration_model
    ADD CONSTRAINT constraint_migmod PRIMARY KEY (id);


--
-- Name: offline_client_session constraint_offl_cl_ses_pk3; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.offline_client_session
    ADD CONSTRAINT constraint_offl_cl_ses_pk3 PRIMARY KEY (user_session_id, client_id, client_storage_provider, external_client_id, offline_flag);


--
-- Name: offline_user_session constraint_offl_us_ses_pk2; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.offline_user_session
    ADD CONSTRAINT constraint_offl_us_ses_pk2 PRIMARY KEY (user_session_id, offline_flag);


--
-- Name: protocol_mapper constraint_pcm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT constraint_pcm PRIMARY KEY (id);


--
-- Name: protocol_mapper_config constraint_pmconfig; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT constraint_pmconfig PRIMARY KEY (protocol_mapper_id, name);


--
-- Name: redirect_uris constraint_redirect_uris; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT constraint_redirect_uris PRIMARY KEY (client_id, value);


--
-- Name: required_action_config constraint_req_act_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.required_action_config
    ADD CONSTRAINT constraint_req_act_cfg_pk PRIMARY KEY (required_action_id, name);


--
-- Name: required_action_provider constraint_req_act_prv_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT constraint_req_act_prv_pk PRIMARY KEY (id);


--
-- Name: user_required_action constraint_required_action; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT constraint_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: resource_uris constraint_resour_uris_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT constraint_resour_uris_pk PRIMARY KEY (resource_id, value);


--
-- Name: role_attribute constraint_role_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT constraint_role_attribute_pk PRIMARY KEY (id);


--
-- Name: user_attribute constraint_user_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT constraint_user_attribute_pk PRIMARY KEY (id);


--
-- Name: user_group_membership constraint_user_group; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT constraint_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: user_session_note constraint_usn_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT constraint_usn_pk PRIMARY KEY (user_session, name);


--
-- Name: web_origins constraint_web_origins; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT constraint_web_origins PRIMARY KEY (client_id, value);


--
-- Name: databasechangeloglock databasechangeloglock_pkey; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT databasechangeloglock_pkey PRIMARY KEY (id);


--
-- Name: client_scope_attributes pk_cl_tmpl_attr; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT pk_cl_tmpl_attr PRIMARY KEY (scope_id, name);


--
-- Name: client_scope pk_cli_template; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT pk_cli_template PRIMARY KEY (id);


--
-- Name: resource_server pk_resource_server; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server
    ADD CONSTRAINT pk_resource_server PRIMARY KEY (id);


--
-- Name: client_scope_role_mapping pk_template_scope; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT pk_template_scope PRIMARY KEY (scope_id, role_id);


--
-- Name: default_client_scope r_def_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT r_def_cli_scope_bind PRIMARY KEY (realm_id, scope_id);


--
-- Name: realm_localizations realm_localizations_pkey; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_localizations
    ADD CONSTRAINT realm_localizations_pkey PRIMARY KEY (realm_id, locale);


--
-- Name: resource_attribute res_attr_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT res_attr_pk PRIMARY KEY (id);


--
-- Name: keycloak_group sibling_names; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT sibling_names UNIQUE (realm_id, parent_group, name);


--
-- Name: identity_provider uk_2daelwnibji49avxsrtuf6xj33; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT uk_2daelwnibji49avxsrtuf6xj33 UNIQUE (provider_alias, realm_id);


--
-- Name: client uk_b71cjlbenv945rb6gcon438at; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT uk_b71cjlbenv945rb6gcon438at UNIQUE (realm_id, client_id);


--
-- Name: client_scope uk_cli_scope; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT uk_cli_scope UNIQUE (realm_id, name);


--
-- Name: user_entity uk_dykn684sl8up1crfei6eckhd7; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_dykn684sl8up1crfei6eckhd7 UNIQUE (realm_id, email_constraint);


--
-- Name: resource_server_resource uk_frsr6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5ha6 UNIQUE (name, owner, resource_server_id);


--
-- Name: resource_server_perm_ticket uk_frsr6t700s9v50bu18ws5pmt; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5pmt UNIQUE (owner, requester, resource_server_id, resource_id, scope_id);


--
-- Name: resource_server_policy uk_frsrpt700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT uk_frsrpt700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: resource_server_scope uk_frsrst700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT uk_frsrst700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: user_consent uk_jkuwuvd56ontgsuhogm8uewrt; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_jkuwuvd56ontgsuhogm8uewrt UNIQUE (client_id, client_storage_provider, external_client_id, user_id);


--
-- Name: realm uk_orvsdmla56612eaefiq6wl5oi; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT uk_orvsdmla56612eaefiq6wl5oi UNIQUE (name);


--
-- Name: user_entity uk_ru8tt6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_ru8tt6t700s9v50bu18ws5ha6 UNIQUE (realm_id, username);


--
-- Name: idx_admin_event_time; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_admin_event_time ON public.admin_event_entity USING btree (realm_id, admin_event_time);


--
-- Name: idx_assoc_pol_assoc_pol_id; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_assoc_pol_assoc_pol_id ON public.associated_policy USING btree (associated_policy_id);


--
-- Name: idx_auth_config_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_config_realm ON public.authenticator_config USING btree (realm_id);


--
-- Name: idx_auth_exec_flow; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_exec_flow ON public.authentication_execution USING btree (flow_id);


--
-- Name: idx_auth_exec_realm_flow; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_exec_realm_flow ON public.authentication_execution USING btree (realm_id, flow_id);


--
-- Name: idx_auth_flow_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_flow_realm ON public.authentication_flow USING btree (realm_id);


--
-- Name: idx_cl_clscope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_cl_clscope ON public.client_scope_client USING btree (scope_id);


--
-- Name: idx_client_att_by_name_value; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_client_att_by_name_value ON public.client_attributes USING btree (name, ((value)::character varying(250)));


--
-- Name: idx_client_id; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_client_id ON public.client USING btree (client_id);


--
-- Name: idx_client_init_acc_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_client_init_acc_realm ON public.client_initial_access USING btree (realm_id);


--
-- Name: idx_client_session_session; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_client_session_session ON public.client_session USING btree (session_id);


--
-- Name: idx_clscope_attrs; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_clscope_attrs ON public.client_scope_attributes USING btree (scope_id);


--
-- Name: idx_clscope_cl; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_clscope_cl ON public.client_scope_client USING btree (client_id);


--
-- Name: idx_clscope_protmap; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_clscope_protmap ON public.protocol_mapper USING btree (client_scope_id);


--
-- Name: idx_clscope_role; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_clscope_role ON public.client_scope_role_mapping USING btree (scope_id);


--
-- Name: idx_compo_config_compo; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_compo_config_compo ON public.component_config USING btree (component_id);


--
-- Name: idx_component_provider_type; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_component_provider_type ON public.component USING btree (provider_type);


--
-- Name: idx_component_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_component_realm ON public.component USING btree (realm_id);


--
-- Name: idx_composite; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_composite ON public.composite_role USING btree (composite);


--
-- Name: idx_composite_child; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_composite_child ON public.composite_role USING btree (child_role);


--
-- Name: idx_defcls_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_defcls_realm ON public.default_client_scope USING btree (realm_id);


--
-- Name: idx_defcls_scope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_defcls_scope ON public.default_client_scope USING btree (scope_id);


--
-- Name: idx_event_time; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_event_time ON public.event_entity USING btree (realm_id, event_time);


--
-- Name: idx_fedidentity_feduser; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fedidentity_feduser ON public.federated_identity USING btree (federated_user_id);


--
-- Name: idx_fedidentity_user; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fedidentity_user ON public.federated_identity USING btree (user_id);


--
-- Name: idx_fu_attribute; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_attribute ON public.fed_user_attribute USING btree (user_id, realm_id, name);


--
-- Name: idx_fu_cnsnt_ext; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_cnsnt_ext ON public.fed_user_consent USING btree (user_id, client_storage_provider, external_client_id);


--
-- Name: idx_fu_consent; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_consent ON public.fed_user_consent USING btree (user_id, client_id);


--
-- Name: idx_fu_consent_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_consent_ru ON public.fed_user_consent USING btree (realm_id, user_id);


--
-- Name: idx_fu_credential; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_credential ON public.fed_user_credential USING btree (user_id, type);


--
-- Name: idx_fu_credential_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_credential_ru ON public.fed_user_credential USING btree (realm_id, user_id);


--
-- Name: idx_fu_group_membership; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_group_membership ON public.fed_user_group_membership USING btree (user_id, group_id);


--
-- Name: idx_fu_group_membership_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_group_membership_ru ON public.fed_user_group_membership USING btree (realm_id, user_id);


--
-- Name: idx_fu_required_action; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_required_action ON public.fed_user_required_action USING btree (user_id, required_action);


--
-- Name: idx_fu_required_action_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_required_action_ru ON public.fed_user_required_action USING btree (realm_id, user_id);


--
-- Name: idx_fu_role_mapping; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_role_mapping ON public.fed_user_role_mapping USING btree (user_id, role_id);


--
-- Name: idx_fu_role_mapping_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_role_mapping_ru ON public.fed_user_role_mapping USING btree (realm_id, user_id);


--
-- Name: idx_group_attr_group; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_group_attr_group ON public.group_attribute USING btree (group_id);


--
-- Name: idx_group_role_mapp_group; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_group_role_mapp_group ON public.group_role_mapping USING btree (group_id);


--
-- Name: idx_id_prov_mapp_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_id_prov_mapp_realm ON public.identity_provider_mapper USING btree (realm_id);


--
-- Name: idx_ident_prov_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_ident_prov_realm ON public.identity_provider USING btree (realm_id);


--
-- Name: idx_keycloak_role_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_keycloak_role_client ON public.keycloak_role USING btree (client);


--
-- Name: idx_keycloak_role_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_keycloak_role_realm ON public.keycloak_role USING btree (realm);


--
-- Name: idx_offline_css_preload; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_offline_css_preload ON public.offline_client_session USING btree (client_id, offline_flag);


--
-- Name: idx_offline_uss_by_user; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_offline_uss_by_user ON public.offline_user_session USING btree (user_id, realm_id, offline_flag);


--
-- Name: idx_offline_uss_by_usersess; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_offline_uss_by_usersess ON public.offline_user_session USING btree (realm_id, offline_flag, user_session_id);


--
-- Name: idx_offline_uss_createdon; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_offline_uss_createdon ON public.offline_user_session USING btree (created_on);


--
-- Name: idx_offline_uss_preload; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_offline_uss_preload ON public.offline_user_session USING btree (offline_flag, created_on, user_session_id);


--
-- Name: idx_protocol_mapper_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_protocol_mapper_client ON public.protocol_mapper USING btree (client_id);


--
-- Name: idx_realm_attr_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_attr_realm ON public.realm_attribute USING btree (realm_id);


--
-- Name: idx_realm_clscope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_clscope ON public.client_scope USING btree (realm_id);


--
-- Name: idx_realm_def_grp_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_def_grp_realm ON public.realm_default_groups USING btree (realm_id);


--
-- Name: idx_realm_evt_list_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_evt_list_realm ON public.realm_events_listeners USING btree (realm_id);


--
-- Name: idx_realm_evt_types_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_evt_types_realm ON public.realm_enabled_event_types USING btree (realm_id);


--
-- Name: idx_realm_master_adm_cli; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_master_adm_cli ON public.realm USING btree (master_admin_client);


--
-- Name: idx_realm_supp_local_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_supp_local_realm ON public.realm_supported_locales USING btree (realm_id);


--
-- Name: idx_redir_uri_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_redir_uri_client ON public.redirect_uris USING btree (client_id);


--
-- Name: idx_req_act_prov_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_req_act_prov_realm ON public.required_action_provider USING btree (realm_id);


--
-- Name: idx_res_policy_policy; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_policy_policy ON public.resource_policy USING btree (policy_id);


--
-- Name: idx_res_scope_scope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_scope_scope ON public.resource_scope USING btree (scope_id);


--
-- Name: idx_res_serv_pol_res_serv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_serv_pol_res_serv ON public.resource_server_policy USING btree (resource_server_id);


--
-- Name: idx_res_srv_res_res_srv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_srv_res_res_srv ON public.resource_server_resource USING btree (resource_server_id);


--
-- Name: idx_res_srv_scope_res_srv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_srv_scope_res_srv ON public.resource_server_scope USING btree (resource_server_id);


--
-- Name: idx_role_attribute; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_role_attribute ON public.role_attribute USING btree (role_id);


--
-- Name: idx_role_clscope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_role_clscope ON public.client_scope_role_mapping USING btree (role_id);


--
-- Name: idx_scope_mapping_role; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_scope_mapping_role ON public.scope_mapping USING btree (role_id);


--
-- Name: idx_scope_policy_policy; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_scope_policy_policy ON public.scope_policy USING btree (policy_id);


--
-- Name: idx_update_time; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_update_time ON public.migration_model USING btree (update_time);


--
-- Name: idx_us_sess_id_on_cl_sess; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_us_sess_id_on_cl_sess ON public.offline_client_session USING btree (user_session_id);


--
-- Name: idx_usconsent_clscope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usconsent_clscope ON public.user_consent_client_scope USING btree (user_consent_id);


--
-- Name: idx_user_attribute; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_attribute ON public.user_attribute USING btree (user_id);


--
-- Name: idx_user_attribute_name; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_attribute_name ON public.user_attribute USING btree (name, value);


--
-- Name: idx_user_consent; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_consent ON public.user_consent USING btree (user_id);


--
-- Name: idx_user_credential; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_credential ON public.credential USING btree (user_id);


--
-- Name: idx_user_email; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_email ON public.user_entity USING btree (email);


--
-- Name: idx_user_group_mapping; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_group_mapping ON public.user_group_membership USING btree (user_id);


--
-- Name: idx_user_reqactions; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_reqactions ON public.user_required_action USING btree (user_id);


--
-- Name: idx_user_role_mapping; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_role_mapping ON public.user_role_mapping USING btree (user_id);


--
-- Name: idx_user_service_account; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_service_account ON public.user_entity USING btree (realm_id, service_account_client_link);


--
-- Name: idx_usr_fed_map_fed_prv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usr_fed_map_fed_prv ON public.user_federation_mapper USING btree (federation_provider_id);


--
-- Name: idx_usr_fed_map_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usr_fed_map_realm ON public.user_federation_mapper USING btree (realm_id);


--
-- Name: idx_usr_fed_prv_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usr_fed_prv_realm ON public.user_federation_provider USING btree (realm_id);


--
-- Name: idx_web_orig_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_web_orig_client ON public.web_origins USING btree (client_id);


--
-- Name: client_session_auth_status auth_status_constraint; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT auth_status_constraint FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: identity_provider fk2b4ebc52ae5c3b34; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT fk2b4ebc52ae5c3b34 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_attributes fk3c47c64beacca966; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT fk3c47c64beacca966 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: federated_identity fk404288b92ef007a6; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT fk404288b92ef007a6 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_node_registrations fk4129723ba992f594; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT fk4129723ba992f594 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: client_session_note fk5edfb00ff51c2736; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT fk5edfb00ff51c2736 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: user_session_note fk5edfb00ff51d3472; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT fk5edfb00ff51d3472 FOREIGN KEY (user_session) REFERENCES public.user_session(id);


--
-- Name: client_session_role fk_11b7sgqw18i532811v7o2dv76; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT fk_11b7sgqw18i532811v7o2dv76 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: redirect_uris fk_1burs8pb4ouj97h5wuppahv9f; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT fk_1burs8pb4ouj97h5wuppahv9f FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: user_federation_provider fk_1fj32f6ptolw2qy60cd8n01e8; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT fk_1fj32f6ptolw2qy60cd8n01e8 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session_prot_mapper fk_33a8sgqw18i532811v7o2dk89; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT fk_33a8sgqw18i532811v7o2dk89 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: realm_required_credential fk_5hg65lybevavkqfki3kponh9v; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT fk_5hg65lybevavkqfki3kponh9v FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_attribute fk_5hrm2vlf9ql5fu022kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu022kqepovbr FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: user_attribute fk_5hrm2vlf9ql5fu043kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu043kqepovbr FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: user_required_action fk_6qj3w1jw9cvafhe19bwsiuvmd; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT fk_6qj3w1jw9cvafhe19bwsiuvmd FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: keycloak_role fk_6vyqfe4cn4wlq8r6kt5vdsj5c; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT fk_6vyqfe4cn4wlq8r6kt5vdsj5c FOREIGN KEY (realm) REFERENCES public.realm(id);


--
-- Name: realm_smtp_config fk_70ej8xdxgxd0b9hh6180irr0o; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT fk_70ej8xdxgxd0b9hh6180irr0o FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_attribute fk_8shxd6l3e9atqukacxgpffptw; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT fk_8shxd6l3e9atqukacxgpffptw FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: composite_role fk_a63wvekftu8jo1pnj81e7mce2; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_a63wvekftu8jo1pnj81e7mce2 FOREIGN KEY (composite) REFERENCES public.keycloak_role(id);


--
-- Name: authentication_execution fk_auth_exec_flow; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_flow FOREIGN KEY (flow_id) REFERENCES public.authentication_flow(id);


--
-- Name: authentication_execution fk_auth_exec_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authentication_flow fk_auth_flow_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT fk_auth_flow_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authenticator_config fk_auth_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT fk_auth_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session fk_b4ao2vcvat6ukau74wbwtfqo1; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT fk_b4ao2vcvat6ukau74wbwtfqo1 FOREIGN KEY (session_id) REFERENCES public.user_session(id);


--
-- Name: user_role_mapping fk_c4fqv34p1mbylloxang7b1q3l; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT fk_c4fqv34p1mbylloxang7b1q3l FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_scope_attributes fk_cl_scope_attr_scope; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT fk_cl_scope_attr_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_scope_role_mapping fk_cl_scope_rm_scope; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT fk_cl_scope_rm_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_user_session_note fk_cl_usr_ses_note; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT fk_cl_usr_ses_note FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: protocol_mapper fk_cli_scope_mapper; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_cli_scope_mapper FOREIGN KEY (client_scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_initial_access fk_client_init_acc_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT fk_client_init_acc_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: component_config fk_component_config; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT fk_component_config FOREIGN KEY (component_id) REFERENCES public.component(id);


--
-- Name: component fk_component_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT fk_component_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_default_groups fk_def_groups_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT fk_def_groups_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_mapper_config fk_fedmapper_cfg; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT fk_fedmapper_cfg FOREIGN KEY (user_federation_mapper_id) REFERENCES public.user_federation_mapper(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_fedprv; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_fedprv FOREIGN KEY (federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: associated_policy fk_frsr5s213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsr5s213xcx4wnkog82ssrfy FOREIGN KEY (associated_policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrasp13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrasp13xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog82sspmt; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82sspmt FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_resource fk_frsrho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog83sspmt; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog83sspmt FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog84sspmt; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog84sspmt FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: associated_policy fk_frsrpas14xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsrpas14xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrpass3xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrpass3xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_perm_ticket fk_frsrpo2128cx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrpo2128cx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_policy fk_frsrpo213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT fk_frsrpo213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_scope fk_frsrpos13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrpos13xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpos53xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpos53xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpp213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpp213xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_scope fk_frsrps213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrps213xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_scope fk_frsrso213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT fk_frsrso213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: composite_role fk_gr7thllb9lu8q4vqa4524jjy8; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_gr7thllb9lu8q4vqa4524jjy8 FOREIGN KEY (child_role) REFERENCES public.keycloak_role(id);


--
-- Name: user_consent_client_scope fk_grntcsnt_clsc_usc; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT fk_grntcsnt_clsc_usc FOREIGN KEY (user_consent_id) REFERENCES public.user_consent(id);


--
-- Name: user_consent fk_grntcsnt_user; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT fk_grntcsnt_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: group_attribute fk_group_attribute_group; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT fk_group_attribute_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: group_role_mapping fk_group_role_group; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT fk_group_role_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: realm_enabled_event_types fk_h846o4h0w8epx5nwedrf5y69j; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT fk_h846o4h0w8epx5nwedrf5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_events_listeners fk_h846o4h0w8epx5nxev9f5y69j; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT fk_h846o4h0w8epx5nxev9f5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: identity_provider_mapper fk_idpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT fk_idpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: idp_mapper_config fk_idpmconfig; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT fk_idpmconfig FOREIGN KEY (idp_mapper_id) REFERENCES public.identity_provider_mapper(id);


--
-- Name: web_origins fk_lojpho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT fk_lojpho213xcx4wnkog82ssrfy FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: scope_mapping fk_ouse064plmlr732lxjcn1q5f1; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT fk_ouse064plmlr732lxjcn1q5f1 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: protocol_mapper fk_pcm_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_pcm_realm FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: credential fk_pfyr0glasqyl0dei3kl69r6v0; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT fk_pfyr0glasqyl0dei3kl69r6v0 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: protocol_mapper_config fk_pmconfig; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT fk_pmconfig FOREIGN KEY (protocol_mapper_id) REFERENCES public.protocol_mapper(id);


--
-- Name: default_client_scope fk_r_def_cli_scope_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: required_action_provider fk_req_act_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT fk_req_act_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_uris fk_resource_server_uris; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT fk_resource_server_uris FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: role_attribute fk_role_attribute_id; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT fk_role_attribute_id FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: realm_supported_locales fk_supported_locales_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT fk_supported_locales_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_config fk_t13hpu1j94r2ebpekr39x5eu5; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT fk_t13hpu1j94r2ebpekr39x5eu5 FOREIGN KEY (user_federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_group_membership fk_user_group_user; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT fk_user_group_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: policy_config fkdc34197cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT fkdc34197cf864c4e43 FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: identity_provider_config fkdc4897cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT fkdc4897cf864c4e43 FOREIGN KEY (identity_provider_id) REFERENCES public.identity_provider(internal_id);


--
-- PostgreSQL database dump complete
--

