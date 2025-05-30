-- This init differs from Core as it is migrating Detroit prod from 03/01/2025 to prisma

-- CreateEnum
CREATE TYPE "user_role_enum" AS ENUM ('user', 'partner', 'admin', 'jurisdictionAdmin');

-- CreateEnum
CREATE TYPE "languages_enum" AS ENUM ('en', 'es', 'vi', 'zh', 'tl', 'bn', 'ar');

-- CreateEnum
CREATE TYPE "listings_application_address_type_enum" AS ENUM ('leasingAgent');

-- CreateEnum
CREATE TYPE "multiselect_questions_application_section_enum" AS ENUM ('programs', 'preferences');

-- CreateEnum
CREATE TYPE "yes_no_enum" AS ENUM ('yes', 'no');

-- CreateEnum
CREATE TYPE "rule_enum" AS ENUM ('nameAndDOB', 'email');

-- CreateEnum
CREATE TYPE "flagged_set_status_enum" AS ENUM ('flagged', 'pending', 'resolved');

-- CreateEnum
CREATE TYPE "income_period_enum" AS ENUM ('perMonth', 'perYear');

-- CreateEnum
CREATE TYPE "application_status_enum" AS ENUM ('draft', 'submitted', 'removed');

-- CreateEnum
CREATE TYPE "application_submission_type_enum" AS ENUM ('paper', 'electronical');

-- CreateEnum
CREATE TYPE "application_review_status_enum" AS ENUM ('pending', 'pendingAndValid', 'valid', 'duplicate');

-- CreateEnum
CREATE TYPE "monthly_rent_determination_type_enum" AS ENUM ('flatRent', 'percentageOfIncome');

-- CreateEnum
CREATE TYPE "unit_rent_type_enum" AS ENUM ('fixed', 'percentageOfIncome');

-- CreateEnum
CREATE TYPE "unit_type_enum" AS ENUM ('studio', 'oneBdrm', 'twoBdrm', 'threeBdrm', 'fourBdrm', 'SRO', 'fiveBdrm');

-- AlterEnum
ALTER TYPE "listings_review_order_type_enum" ADD VALUE 'waitlist';

-- AlterEnum
-- This migration adds more than one value to an enum.
-- With PostgreSQL versions 11 and earlier, this is not possible
-- in a single migration. This can be worked around by creating
-- multiple migrations, each migration adding only one value to
-- the enum.


ALTER TYPE "listings_status_enum" ADD VALUE 'pendingReview';
ALTER TYPE "listings_status_enum" ADD VALUE 'changesRequested';

-- AlterEnum
CREATE TYPE "property_region_enum_new" AS ENUM ('Greater_Downtown', 'Eastside', 'Southwest', 'Westside');

ALTER TABLE "property" ADD COLUMN "region_TEMP" VARCHAR;

UPDATE "property"
SET "region_TEMP" = "region"
WHERE "region" != 'Greater Downtown';

UPDATE "property"
SET "region_TEMP" = 'Greater_Downtown'
WHERE "region" = 'Greater Downtown';


ALTER TABLE "property"
DROP COLUMN "region";

ALTER TABLE "property" ADD COLUMN "region" "property_region_enum_new";

UPDATE "property"
SET "region" = CAST("region_TEMP" AS "property_region_enum_new");

ALTER TABLE "property"
DROP COLUMN "region_TEMP";

ALTER TYPE "property_region_enum" RENAME TO "property_region_enum_old";
ALTER TYPE "property_region_enum_new" RENAME TO "property_region_enum";
DROP TYPE "property_region_enum_old";

-- DropForeignKey
ALTER TABLE "activity_logs" DROP CONSTRAINT "FK_d54f841fa5478e4734590d44036";

-- DropForeignKey
ALTER TABLE "ami_chart_item" DROP CONSTRAINT "FK_98d10c0d335d9e4aca6fb5335b3";

-- DropForeignKey
ALTER TABLE "application_flagged_set" DROP CONSTRAINT "FK_f2ace84eebd770f1387b47e5e45";

-- DropForeignKey
ALTER TABLE "application_flagged_set_applications_applications" DROP CONSTRAINT "FK_93f583f2d43fb21c5d7ceac57e7";

-- DropForeignKey
ALTER TABLE "application_flagged_set_applications_applications" DROP CONSTRAINT "FK_bbae218ba0eff977157fad5ea31";

-- DropForeignKey
ALTER TABLE "application_methods" DROP CONSTRAINT "FK_3057650361c2aeab15dfee5c3cc";

-- DropForeignKey
ALTER TABLE "application_preference" DROP CONSTRAINT "FK_3a650c5299b1063f57bf6a2422e";

-- DropForeignKey
ALTER TABLE "application_preference" DROP CONSTRAINT "FK_fb3200f0f8c9469aee290c37158";

-- DropForeignKey
ALTER TABLE "applications" DROP CONSTRAINT "FK_cc9d65c58d8deb0ef5353e9037d";

-- DropForeignKey
ALTER TABLE "applications_preferred_unit_unit_types" DROP CONSTRAINT "FK_5838635fbe9294cac64d1a0b605";

-- DropForeignKey
ALTER TABLE "applications_preferred_unit_unit_types" DROP CONSTRAINT "FK_8249d47edacc30250c18c53915a";

-- DropForeignKey
ALTER TABLE "household_member" DROP CONSTRAINT "FK_520996eeecf9f6fb9425dc7352c";

-- DropForeignKey
ALTER TABLE "jurisdictions_preferences_preferences" DROP CONSTRAINT "FK_46e20b8b62dbdabfd76955e95b1";

-- DropForeignKey
ALTER TABLE "jurisdictions_preferences_preferences" DROP CONSTRAINT "FK_7a0eef07c822800c4e9b9d43619";

-- DropForeignKey
ALTER TABLE "jurisdictions_programs_programs" DROP CONSTRAINT "FK_1ec5e2b056309e1248fb43bb08b";

-- DropForeignKey
ALTER TABLE "jurisdictions_programs_programs" DROP CONSTRAINT "FK_cc8517c9311a8e8a4bbabac30f3";

-- DropForeignKey
ALTER TABLE "listing_events" DROP CONSTRAINT "FK_d0b9892bc613e4d9f8b5c25d03e";

-- DropForeignKey
ALTER TABLE "listing_images" DROP CONSTRAINT "FK_94041359df3c1b14c4420808d16";

-- DropForeignKey
ALTER TABLE "listing_preferences" DROP CONSTRAINT "FK_797708bfa7897f574b8eb73cdcb";

-- DropForeignKey
ALTER TABLE "listing_preferences" DROP CONSTRAINT "FK_b7fad48d744befbd6532d8a04a0";

-- DropForeignKey
ALTER TABLE "listing_programs" DROP CONSTRAINT "FK_0fc46ddd2b9468b011d567740b5";

-- DropForeignKey
ALTER TABLE "listing_programs" DROP CONSTRAINT "FK_89b3daa7bbc2dbd95f2760958c2";

-- DropForeignKey
ALTER TABLE "listings" DROP CONSTRAINT "FK_9eef913a9013d6e3d09a92ec075";

-- DropForeignKey
ALTER TABLE "listings_leasing_agents_user_accounts" DROP CONSTRAINT "FK_de53131bc8a08f824a5d3dd51e3";

-- DropForeignKey
ALTER TABLE "listings_leasing_agents_user_accounts" DROP CONSTRAINT "FK_f7b22af2c421e823f60c5f7d28b";

-- DropForeignKey
ALTER TABLE "paper_applications" DROP CONSTRAINT "FK_493291d04c708dda2ffe5b521e7";

-- DropForeignKey
ALTER TABLE "paper_applications" DROP CONSTRAINT "FK_bd67da96ae3e2c0e37394ba1dd3";

-- DropForeignKey
ALTER TABLE "property" DROP CONSTRAINT "FK_f0f7062f34738e0b338163786fd";

-- DropForeignKey
ALTER TABLE "property_group_properties_property" DROP CONSTRAINT "FK_84e6a1949911510df0eff691f0d";

-- DropForeignKey
ALTER TABLE "property_group_properties_property" DROP CONSTRAINT "FK_c99e75ee805d56fea44bf2970f2";

-- DropForeignKey
ALTER TABLE "unit_group_unit_type_unit_types" DROP CONSTRAINT "FK_0cf027359361dfd394f08686da2";

-- DropForeignKey
ALTER TABLE "unit_group_unit_type_unit_types" DROP CONSTRAINT "FK_1ea90313ee94f48800e9eef751e";

-- DropForeignKey
ALTER TABLE "units" DROP CONSTRAINT "FK_f221e6d7bfd686266003b982b5f";

-- DropForeignKey
ALTER TABLE "user_accounts_jurisdictions_jurisdictions" DROP CONSTRAINT "FK_e51e812700e143101aeaabbccc6";

-- DropForeignKey
ALTER TABLE "user_accounts_jurisdictions_jurisdictions" DROP CONSTRAINT "FK_fe359f4430f9e0e7b278e03f0f3";

-- DropForeignKey
ALTER TABLE "user_preferences_favorites_listings" DROP CONSTRAINT "FK_0115bda0994ab10a4c1a883504e";

-- DropForeignKey
ALTER TABLE "user_preferences_favorites_listings" DROP CONSTRAINT "FK_c971c586f08b7fe93fcaf29ec05";

-- AlterTable
ALTER TABLE "accessibility" RENAME CONSTRAINT "PK_9729339e162bc7ec98a8815758c" TO "accessibility_pkey";
ALTER TABLE "accessibility" ALTER COLUMN "updated_at" DROP DEFAULT;

-- AlterTable
ALTER TABLE "address" RENAME CONSTRAINT "PK_d92de1f82754668b5f5f5dd4fd5" TO "address_pkey";
ALTER TABLE "address" ALTER COLUMN "updated_at" DROP DEFAULT;

-- AlterTable
ALTER TABLE "alternate_contact" RENAME CONSTRAINT "PK_4b35560218b2062cccb339975e7" TO "alternate_contact_pkey";
ALTER TABLE "alternate_contact" ALTER COLUMN "updated_at" DROP DEFAULT;

-- AlterTable
ALTER TABLE "ami_chart" RENAME CONSTRAINT "PK_e079bbfad233fdc79072acb33b5" TO "ami_chart_pkey";
ALTER TABLE "ami_chart" ALTER COLUMN "updated_at" DROP DEFAULT;

-- AlterTable
ALTER TABLE "applicant" RENAME CONSTRAINT "PK_f4a6e907b8b17f293eb073fc5ea" TO "applicant_pkey";
ALTER TABLE "applicant" ALTER COLUMN "updated_at" DROP DEFAULT;
ALTER TABLE "applicant" DROP COLUMN "birth_month";
ALTER TABLE "applicant" ADD COLUMN     "birth_month" INTEGER;
ALTER TABLE "applicant" DROP COLUMN "birth_day";
ALTER TABLE "applicant" ADD COLUMN     "birth_day" INTEGER;
ALTER TABLE "applicant" DROP COLUMN "birth_year";
ALTER TABLE "applicant" ADD COLUMN     "birth_year" INTEGER;
ALTER TABLE "applicant" DROP COLUMN "work_in_region";
ALTER TABLE "applicant" ADD COLUMN     "work_in_region" "yes_no_enum";

-- AlterTable
ALTER TABLE "application_flagged_set" RENAME CONSTRAINT "PK_81969e689800a802b75ffd883cc" TO "application_flagged_set_pkey";
ALTER TABLE "application_flagged_set" ADD COLUMN     "rule_key" VARCHAR NOT NULL;
ALTER TABLE "application_flagged_set" ADD COLUMN     "show_confirmation_alert" BOOLEAN NOT NULL DEFAULT false;
ALTER TABLE "application_flagged_set" ALTER COLUMN "updated_at" DROP DEFAULT;
ALTER TABLE "application_flagged_set" DROP COLUMN "rule";
ALTER TABLE "application_flagged_set" ADD COLUMN     "rule" "rule_enum" NOT NULL;
ALTER TABLE "application_flagged_set" DROP COLUMN "status";
ALTER TABLE "application_flagged_set" ADD COLUMN     "status" "flagged_set_status_enum" NOT NULL DEFAULT 'pending';

-- AlterTable
ALTER TABLE "application_methods" RENAME CONSTRAINT "PK_c58506819ffaba3863a4edc5e9e" TO "application_methods_pkey";
ALTER TABLE "application_methods" ALTER COLUMN "updated_at" DROP DEFAULT;

-- AlterTable
ALTER TABLE "applications" RENAME CONSTRAINT "PK_938c0a27255637bde919591888f" TO "applications_pkey";
ALTER TABLE "applications" ADD COLUMN     "review_status" "application_review_status_enum" NOT NULL DEFAULT 'pending';
ALTER TABLE "applications" ALTER COLUMN "updated_at" DROP DEFAULT;
ALTER TABLE "applications" DROP COLUMN "income_period";
ALTER TABLE "applications" ADD COLUMN     "income_period" "income_period_enum";
ALTER TABLE "applications" DROP COLUMN "language";
ALTER TABLE "applications" ADD COLUMN     "language" "languages_enum";
ALTER TABLE "applications" DROP COLUMN "submission_type";
ALTER TABLE "applications" ADD COLUMN     "submission_type" "application_submission_type_enum" NOT NULL;
ALTER TABLE "applications" DROP COLUMN "status";
ALTER TABLE "applications" ADD COLUMN     "status" "application_status_enum" NOT NULL;

-- AlterTable
ALTER TABLE "assets" RENAME CONSTRAINT "PK_da96729a8b113377cfb6a62439c" TO "assets_pkey";
ALTER TABLE "assets" ALTER COLUMN "updated_at" DROP DEFAULT;

-- AlterTable
ALTER TABLE "demographics" RENAME CONSTRAINT "PK_17bf4db5727bd0ad0462c67eda9" TO "demographics_pkey";
ALTER TABLE "demographics" ALTER COLUMN "updated_at" DROP DEFAULT;

-- AlterTable
ALTER TABLE "generated_listing_translations" RENAME CONSTRAINT "PK_4059452831439aefc27c1990b20" TO "generated_listing_translations_pkey";
ALTER TABLE "generated_listing_translations" ALTER COLUMN "updated_at" DROP DEFAULT;

ALTER TABLE "generated_listing_translations" ADD COLUMN "language_TEMP" VARCHAR;

UPDATE "generated_listing_translations"
SET "language_TEMP" = "language";

ALTER TABLE "generated_listing_translations"
DROP COLUMN "language";

ALTER TABLE "generated_listing_translations" ADD COLUMN "language" "languages_enum";

UPDATE "generated_listing_translations"
SET "language" = CAST("language_TEMP" as "languages_enum");

ALTER TABLE "generated_listing_translations" ALTER COLUMN "language" SET NOT NULL;

ALTER TABLE "generated_listing_translations"
DROP COLUMN "language_TEMP";

-- AlterTable
ALTER TABLE "household_member" RENAME CONSTRAINT "PK_84e1d1f2553646d38e7c8b72a10" TO "household_member_pkey";
ALTER TABLE "household_member" DROP COLUMN "email_address";
ALTER TABLE "household_member" DROP COLUMN "no_email";
ALTER TABLE "household_member" DROP COLUMN "no_phone";
ALTER TABLE "household_member" DROP COLUMN "phone_number";
ALTER TABLE "household_member" DROP COLUMN "phone_number_type";
ALTER TABLE "household_member" ALTER COLUMN "updated_at" DROP DEFAULT;
ALTER TABLE "household_member" DROP COLUMN "birth_month";
ALTER TABLE "household_member" ADD COLUMN     "birth_month" INTEGER;
ALTER TABLE "household_member" DROP COLUMN "birth_day";
ALTER TABLE "household_member" ADD COLUMN     "birth_day" INTEGER;
ALTER TABLE "household_member" DROP COLUMN "birth_year";
ALTER TABLE "household_member" ADD COLUMN     "birth_year" INTEGER;
ALTER TABLE "household_member" DROP COLUMN "same_address";
ALTER TABLE "household_member" ADD COLUMN     "same_address" "yes_no_enum";
ALTER TABLE "household_member" DROP COLUMN "work_in_region";
ALTER TABLE "household_member" ADD COLUMN     "work_in_region" "yes_no_enum";

-- AlterTable
ALTER TABLE "jurisdictions" RENAME CONSTRAINT "PK_7cc0bed21c9e2b32866c1109ec5" TO "jurisdictions_pkey";
ALTER TABLE "jurisdictions" ADD COLUMN     "enable_accessibility_features" BOOLEAN NOT NULL DEFAULT false;
ALTER TABLE "jurisdictions" ADD COLUMN     "enable_geocoding_preferences" BOOLEAN NOT NULL DEFAULT false;
ALTER TABLE "jurisdictions" ADD COLUMN     "enable_partner_settings" BOOLEAN NOT NULL DEFAULT false;
ALTER TABLE "jurisdictions" ADD COLUMN     "enable_utilities_included" BOOLEAN NOT NULL DEFAULT false;
ALTER TABLE "jurisdictions" ADD COLUMN     "listing_approval_permission" "user_role_enum"[];
ALTER TABLE "jurisdictions" ADD COLUMN     "rental_assistance_default" TEXT;
ALTER TABLE "jurisdictions" ALTER COLUMN "updated_at" DROP DEFAULT;

UPDATE "jurisdictions"
SET "rental_assistance_default" = 'Housing Choice Vouchers, Section 8 and other valid rental assistance programs will be considered for this property. In the case of a valid rental subsidy, the required minimum income will be based on the portion of the rent that the tenant pays after use of the subsidy.';

ALTER TABLE "jurisdictions" ALTER COLUMN "rental_assistance_default" SET NOT NULL;

ALTER TABLE "jurisdictions" ADD COLUMN "languages_TEMP" "jurisdictions_languages_enum" [];

UPDATE "jurisdictions"
SET "languages_TEMP" = "languages";

ALTER TABLE "jurisdictions"
DROP COLUMN "languages";

ALTER TABLE "jurisdictions" ADD COLUMN "languages" "languages_enum" [] DEFAULT ARRAY ['en'] :: "languages_enum" [];

UPDATE "jurisdictions"
SET "languages" = CAST(CAST("languages_TEMP" AS TEXT []) AS "languages_enum" []);

ALTER TABLE "jurisdictions"
DROP COLUMN "languages_TEMP";

-- AlterTable
ALTER TABLE "listing_events" RENAME CONSTRAINT "PK_a9a209828028e14e2caf8def25c" TO "listing_events_pkey";
ALTER TABLE "listing_events" ADD COLUMN     "start_date" TIMESTAMPTZ(6);
ALTER TABLE "listing_events" ALTER COLUMN "updated_at" DROP DEFAULT;

UPDATE "listing_events"
SET "start_date" = "start_time";

-- AlterTable
ALTER TABLE "listing_features" RENAME CONSTRAINT "PK_88e4fe3e46d21d8b4fdadeb7599" TO "listing_features_pkey";
ALTER TABLE "listing_features" ALTER COLUMN "updated_at" DROP DEFAULT;

-- AlterTable
ALTER TABLE "listing_images" RENAME CONSTRAINT "PK_beb1c8e9f64f578908135aa6899" TO "listing_images_pkey";

-- AlterTable
ALTER TABLE "listing_neighborhood_amenities" RENAME CONSTRAINT "PK_4822e277c626fd1d94cddbb9826" TO "listing_neighborhood_amenities_pkey";

-- AlterTable
ALTER TABLE "listing_utilities" RENAME CONSTRAINT "PK_8e88f883b389f7b31d331de764f" TO "listing_utilities_pkey";
ALTER TABLE "listing_utilities" ALTER COLUMN "updated_at" DROP DEFAULT;

-- AlterTable
ALTER TABLE "listings" RENAME CONSTRAINT "PK_520ecac6c99ec90bcf5a603cdcb" TO "listings_pkey";
ALTER TABLE "listings" ADD COLUMN     "accessibility" TEXT;
ALTER TABLE "listings" ADD COLUMN     "afs_last_run_at" TIMESTAMPTZ(6) DEFAULT '1970-01-01 00:00:00-07'::timestamp with time zone;
ALTER TABLE "listings" ADD COLUMN     "amenities" TEXT;
ALTER TABLE "listings" ADD COLUMN     "building_address_id" UUID;
ALTER TABLE "listings" ADD COLUMN     "building_total_units" INTEGER;
ALTER TABLE "listings" ADD COLUMN     "developer" TEXT;
ALTER TABLE "listings" ADD COLUMN     "household_size_max" INTEGER;
ALTER TABLE "listings" ADD COLUMN     "household_size_min" INTEGER;
ALTER TABLE "listings" ADD COLUMN     "last_application_update_at" TIMESTAMPTZ(6) DEFAULT '1970-01-01 00:00:00-07'::timestamp with time zone;
ALTER TABLE "listings" ADD COLUMN     "neighborhood" TEXT;
ALTER TABLE "listings" ADD COLUMN     "pet_policy" TEXT;
ALTER TABLE "listings" ADD COLUMN     "region" "property_region_enum";
ALTER TABLE "listings" ADD COLUMN     "requested_changes" TEXT;
ALTER TABLE "listings" ADD COLUMN     "requested_changes_date" TIMESTAMPTZ(6) DEFAULT '1970-01-01 00:00:00-07'::timestamp with time zone;
ALTER TABLE "listings" ADD COLUMN     "requested_changes_user_id" UUID;
ALTER TABLE "listings" ADD COLUMN     "services_offered" TEXT;
ALTER TABLE "listings" ADD COLUMN     "smoking_policy" TEXT;
ALTER TABLE "listings" ADD COLUMN     "unit_amenities" TEXT;
ALTER TABLE "listings" ADD COLUMN     "units_available" INTEGER;
ALTER TABLE "listings" ADD COLUMN     "year_built" INTEGER;
ALTER TABLE "listings" ALTER COLUMN "updated_at" DROP DEFAULT;

ALTER TABLE "listings" ADD COLUMN "application_pick_up_address_type_TEMP" "listings_application_pick_up_address_type_enum";

UPDATE "listings"
SET "application_pick_up_address_type_TEMP" = "application_pick_up_address_type";

ALTER TABLE "listings"
DROP COLUMN "application_pick_up_address_type";

ALTER TABLE "listings" ADD COLUMN "application_pick_up_address_type" "listings_application_address_type_enum";

UPDATE "listings"
SET "application_pick_up_address_type" = CAST(CAST("application_pick_up_address_type_TEMP" AS TEXT) AS "listings_application_address_type_enum");

ALTER TABLE "listings"
DROP COLUMN "application_pick_up_address_type_TEMP";


ALTER TABLE "listings" ADD COLUMN "application_drop_off_address_type_TEMP" "listings_application_drop_off_address_type_enum";

UPDATE "listings"
SET "application_drop_off_address_type_TEMP" = "application_drop_off_address_type";

ALTER TABLE "listings"
DROP COLUMN "application_drop_off_address_type";

ALTER TABLE "listings" ADD COLUMN "application_drop_off_address_type" "listings_application_address_type_enum";

UPDATE "listings"
SET "application_drop_off_address_type" = CAST(CAST("application_drop_off_address_type_TEMP" AS TEXT) AS "listings_application_address_type_enum");

ALTER TABLE "listings"
DROP COLUMN "application_drop_off_address_type_TEMP";


ALTER TABLE "listings" ADD COLUMN "application_mailing_address_type_TEMP" "listings_application_mailing_address_type_enum";

UPDATE "listings"
SET "application_mailing_address_type_TEMP" = "application_mailing_address_type";

ALTER TABLE "listings"
DROP COLUMN "application_mailing_address_type";

ALTER TABLE "listings" ADD COLUMN "application_mailing_address_type" "listings_application_address_type_enum";

UPDATE "listings"
SET "application_mailing_address_type" = CAST(CAST("application_mailing_address_type_TEMP" AS TEXT) AS "listings_application_address_type_enum");

ALTER TABLE "listings"
DROP COLUMN "application_mailing_address_type_TEMP";

UPDATE "listings"  "l"
SET "accessibility" = "property"."accessibility", 
"amenities" = "property"."amenities",
"building_total_units" = "property"."building_total_units",
"developer" = "property"."developer",
"household_size_max" = "property"."household_size_max",
"household_size_min" = "property"."household_size_min",
"neighborhood" = "property"."neighborhood",
"pet_policy" = "property"."pet_policy",
"smoking_policy" = "property"."smoking_policy",
"units_available" = "property"."units_available",
"unit_amenities" = "property"."unit_amenities",
"services_offered" = "property"."services_offered",
"year_built" = "property"."year_built",
"building_address_id" = "property"."building_address_id",
"region" = "property"."region"
FROM "property"
WHERE "l"."property_id" = "property"."id";

ALTER TABLE "listings"
DROP COLUMN "property_id";

-- AlterTable
ALTER TABLE "migrations" RENAME CONSTRAINT "PK_8c82d7f526340ab734260ea46be" TO "migrations_pkey";

-- AlterTable
ALTER TABLE "paper_applications" RENAME CONSTRAINT "PK_1bc5b0234d874ec03f500621d43" TO "paper_applications_pkey";
ALTER TABLE "paper_applications" ALTER COLUMN "updated_at" DROP DEFAULT;

ALTER TABLE "paper_applications" ADD COLUMN "language_TEMP" VARCHAR;

UPDATE "paper_applications"
SET "language_TEMP" = "language";

ALTER TABLE "paper_applications"
DROP COLUMN "language";

ALTER TABLE "paper_applications" ADD COLUMN "language" "languages_enum";

UPDATE "paper_applications"
SET "language" = CAST("language_TEMP" AS "languages_enum");

ALTER TABLE "paper_applications" ALTER COLUMN "language" SET NOT NULL;

ALTER TABLE "paper_applications"
DROP COLUMN "language_TEMP";

-- AlterTable
ALTER TABLE "reserved_community_types" RENAME CONSTRAINT "PK_af3937276e7bb53c30159d6ca0b" TO "reserved_community_types_pkey";
ALTER TABLE "reserved_community_types" ALTER COLUMN "updated_at" DROP DEFAULT;

-- AlterTable
ALTER TABLE "translations" RENAME CONSTRAINT "PK_7aef875e43ab80d34a0cdd39c70" TO "translations_pkey";
ALTER TABLE "translations" ALTER COLUMN "updated_at" DROP DEFAULT;

ALTER TABLE "translations" ADD COLUMN "language_TEMP" VARCHAR;

UPDATE "translations"
SET "language_TEMP" = "language";

ALTER TABLE "translations"
DROP COLUMN "language";

ALTER TABLE "translations" ADD COLUMN "language" "languages_enum";

UPDATE "translations"
SET "language" = CAST("language_TEMP" AS "languages_enum");

ALTER TABLE "translations" ALTER COLUMN "language" SET NOT NULL;

ALTER TABLE "translations"
DROP COLUMN "language_TEMP";

-- AlterTable
ALTER TABLE "unit_accessibility_priority_types" RENAME CONSTRAINT "PK_2cf31d2ceea36e6a6b970608565" TO "unit_accessibility_priority_types_pkey";
ALTER TABLE "unit_accessibility_priority_types" ALTER COLUMN "updated_at" DROP DEFAULT;

-- AlterTable
ALTER TABLE "unit_ami_chart_overrides" RENAME CONSTRAINT "PK_839676df1bd1ac12ff09b9d920d" TO "unit_ami_chart_overrides_pkey";
ALTER TABLE "unit_ami_chart_overrides" ALTER COLUMN "updated_at" DROP DEFAULT;

-- AlterTable
ALTER TABLE "unit_group" RENAME CONSTRAINT "PK_8d8c4940fab2a9d1b2e7ddd9e49" TO "unit_group_pkey";

-- AlterTable
ALTER TABLE "unit_group_ami_levels" RENAME CONSTRAINT "PK_4b540cae0d35b199c0448610378" TO "unit_group_ami_levels_pkey";

ALTER TABLE "unit_group_ami_levels" ADD COLUMN "monthly_rent_determination_type_TEMP" VARCHAR;

UPDATE "unit_group_ami_levels"
SET "monthly_rent_determination_type_TEMP" = "monthly_rent_determination_type";

ALTER TABLE "unit_group_ami_levels"
DROP COLUMN "monthly_rent_determination_type";

ALTER TABLE "unit_group_ami_levels" ADD COLUMN "monthly_rent_determination_type" "monthly_rent_determination_type_enum";

UPDATE "unit_group_ami_levels"
SET "monthly_rent_determination_type" = CAST("monthly_rent_determination_type_TEMP" AS "monthly_rent_determination_type_enum");

ALTER TABLE "unit_group_ami_levels" ALTER COLUMN "monthly_rent_determination_type" SET NOT NULL;

ALTER TABLE "unit_group_ami_levels"
DROP COLUMN "monthly_rent_determination_type_TEMP";

-- AlterTable
ALTER TABLE "unit_rent_types" RENAME CONSTRAINT "PK_fb6b318fdee0a5b30521f63c516" TO "unit_rent_types_pkey";
ALTER TABLE "unit_rent_types" ALTER COLUMN "updated_at" DROP DEFAULT;

ALTER TABLE "unit_rent_types" ADD COLUMN "name_TEMP" VARCHAR;

UPDATE "unit_rent_types"
SET "name_TEMP" = "name";

ALTER TABLE "unit_rent_types"
DROP COLUMN "name";

ALTER TABLE "unit_rent_types" ADD COLUMN "name" "unit_rent_type_enum";

UPDATE "unit_rent_types"
SET "name" = CAST("name_TEMP" AS "unit_rent_type_enum");

ALTER TABLE "unit_rent_types" ALTER COLUMN "name" SET NOT NULL;

ALTER TABLE "unit_rent_types"
DROP COLUMN "name_TEMP";

-- AlterTable
ALTER TABLE "unit_types" RENAME CONSTRAINT "PK_105c42fcf447c1da21fd20bcb85" TO "unit_types_pkey";
ALTER TABLE "unit_types" ALTER COLUMN "updated_at" DROP DEFAULT;

ALTER TABLE "unit_types" ADD COLUMN "name_TEMP" VARCHAR;

UPDATE "unit_types"
SET "name_TEMP" = "name";

ALTER TABLE "unit_types"
DROP COLUMN "name";

ALTER TABLE "unit_types" ADD COLUMN "name" "unit_type_enum";

UPDATE "unit_types"
SET "name" = CAST("name_TEMP" AS "unit_type_enum");

ALTER TABLE "unit_types" ALTER COLUMN "name" SET NOT NULL;

ALTER TABLE "unit_types"
DROP COLUMN "name_TEMP";

-- AlterTable
ALTER TABLE "units" RENAME CONSTRAINT "PK_5a8f2f064919b587d93936cb223" TO "units_pkey";
ALTER TABLE "units" DROP COLUMN "property_id";
ALTER TABLE "units" ADD COLUMN     "listing_id" UUID;
ALTER TABLE "units" ALTER COLUMN "updated_at" DROP DEFAULT;

-- AlterTable
ALTER TABLE "user_accounts" RENAME CONSTRAINT "PK_125e915cf23ad1cfb43815ce59b" TO "user_accounts_pkey";
ALTER TABLE "user_accounts" ADD COLUMN     "active_access_token" VARCHAR;
ALTER TABLE "user_accounts" ADD COLUMN     "active_refresh_token" VARCHAR;
ALTER TABLE "user_accounts" ALTER COLUMN "updated_at" DROP DEFAULT;

ALTER TABLE "user_accounts" ADD COLUMN "language_TEMP" VARCHAR;

UPDATE "user_accounts"
SET "language_TEMP" = "language";

ALTER TABLE "user_accounts"
DROP COLUMN "language";

ALTER TABLE "user_accounts" ADD COLUMN "language" "languages_enum";

UPDATE "user_accounts"
SET "language" = CAST("language_TEMP" AS "languages_enum");

ALTER TABLE "user_accounts"
DROP COLUMN "language_TEMP";

-- AlterTable
ALTER TABLE "user_preferences" RENAME CONSTRAINT "PK_458057fa75b66e68a275647da2e" TO "user_preferences_pkey";

-- AlterTable
ALTER TABLE "user_roles" RENAME CONSTRAINT "PK_87b8888186ca9769c960e926870" TO "user_roles_pkey";
ALTER TABLE "user_roles" ADD COLUMN     "is_jurisdictional_admin" BOOLEAN NOT NULL DEFAULT false;

-- DropTable
DROP TABLE "ami_chart_item";

-- DropTable
DROP TABLE "application_flagged_set_applications_applications";

-- DropTable
DROP TABLE "application_preference";

-- DropTable
DROP TABLE "application_preferences";

-- DropTable
DROP TABLE "applications_preferred_unit_unit_types";

-- DropTable
DROP TABLE "listing_preferences";

-- DropTable
DROP TABLE "property";

-- DropTable
DROP TABLE "property_group";

-- DropTable
DROP TABLE "property_group_properties_property";

-- DropTable
DROP TABLE "revoked_tokens";

-- DropTable
DROP TABLE "typeorm_metadata";

-- DropTable
DROP TABLE "user_preferences_favorites_listings";

-- DropEnum
DROP TYPE "jurisdictions_languages_enum";

-- DropEnum
DROP TYPE "listings_application_drop_off_address_type_enum";

-- DropEnum
DROP TYPE "listings_application_mailing_address_type_enum";

-- DropEnum
DROP TYPE "listings_application_pick_up_address_type_enum";

-- DropEnum
DROP TYPE "unit_group_ami_levels_monthly_rent_determination_type_enum";

-- CreateTable
CREATE TABLE "activity_log" (
    "id" UUID NOT NULL DEFAULT uuid_generate_v4(),
    "created_at" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(6) NOT NULL,
    "module" VARCHAR NOT NULL,
    "action" VARCHAR NOT NULL,
    "metadata" JSONB,
    "record_id" UUID NOT NULL,
    "user_id" UUID,

    CONSTRAINT "activity_log_pkey" PRIMARY KEY ("id")
);

INSERT INTO "activity_log" ("created_at",
                            "updated_at",
                            "module",
                            "record_id",
                            "action",
                            "metadata",
                            "user_id")
SELECT "created_at",
       "updated_at",
       "module",
       "record_id",
       "action",
       "metadata",
       "user_id"
FROM "activity_logs";

-- DropTable
DROP TABLE "activity_logs";

-- CreateTable
CREATE TABLE "cron_job" (
    "id" UUID NOT NULL DEFAULT uuid_generate_v4(),
    "name" TEXT,
    "last_run_date" TIMESTAMPTZ(6),
    "created_at" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(6) NOT NULL,

    CONSTRAINT "cron_job_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "listing_multiselect_questions" (
    "ordinal" INTEGER,
    "listing_id" UUID NOT NULL,
    "multiselect_question_id" UUID NOT NULL,

    CONSTRAINT "listing_multiselect_questions_pkey" PRIMARY KEY ("listing_id","multiselect_question_id")
);

-- CreateTable
CREATE TABLE "map_layers" (
    "id" UUID NOT NULL DEFAULT uuid_generate_v4(),
    "name" TEXT NOT NULL,
    "jurisdiction_id" TEXT NOT NULL,
    "feature_collection" JSONB NOT NULL DEFAULT '{}',

    CONSTRAINT "map_layers_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "multiselect_questions" (
    "id" UUID NOT NULL DEFAULT uuid_generate_v4(),
    "created_at" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(6) NOT NULL,
    "text" TEXT NOT NULL,
    "sub_text" TEXT,
    "description" TEXT,
    "links" JSONB,
    "options" JSONB,
    "opt_out_text" TEXT,
    "hide_from_listing" BOOLEAN,
    "application_section" "multiselect_questions_application_section_enum" NOT NULL,

    CONSTRAINT "multiselect_questions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "units_summary" (
    "id" UUID NOT NULL DEFAULT uuid_generate_v4(),
    "monthly_rent_min" INTEGER,
    "monthly_rent_max" INTEGER,
    "monthly_rent_as_percent_of_income" DECIMAL(8,2),
    "ami_percentage" INTEGER,
    "minimum_income_min" TEXT,
    "minimum_income_max" TEXT,
    "max_occupancy" INTEGER,
    "min_occupancy" INTEGER,
    "floor_min" INTEGER,
    "floor_max" INTEGER,
    "sq_feet_min" DECIMAL(8,2),
    "sq_feet_max" DECIMAL(8,2),
    "total_count" INTEGER,
    "total_available" INTEGER,
    "unit_type_id" UUID,
    "listing_id" UUID,
    "priority_type_id" UUID,

    CONSTRAINT "units_summary_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "_ApplicationFlaggedSetToApplications" (
    "A" UUID NOT NULL,
    "B" UUID NOT NULL
);

-- CreateTable
CREATE TABLE "_ApplicationsToUnitTypes" (
    "A" UUID NOT NULL,
    "B" UUID NOT NULL
);

-- CreateTable
CREATE TABLE "_JurisdictionsToMultiselectQuestions" (
    "A" UUID NOT NULL,
    "B" UUID NOT NULL
);

-- CreateTable
CREATE TABLE "_JurisdictionsToUserAccounts" ("A" UUID NOT NULL,
                                                      "B" UUID NOT NULL);

INSERT INTO "_JurisdictionsToUserAccounts" ("A",
                                            "B")
SELECT "jurisdictions_id",
       "user_accounts_id"
FROM "user_accounts_jurisdictions_jurisdictions";

-- DropTable
DROP TABLE "user_accounts_jurisdictions_jurisdictions";

-- CreateTable
CREATE TABLE "_ListingsToUserAccounts" ("A" UUID NOT NULL,
                                                 "B" UUID NOT NULL);


INSERT INTO "_ListingsToUserAccounts" ("A",
                                       "B")
SELECT "listings_id",
       "user_accounts_id"
FROM "listings_leasing_agents_user_accounts";

-- DropTable
DROP TABLE "listings_leasing_agents_user_accounts";

-- CreateTable
CREATE TABLE "_ListingsToUserPreferences" (
    "A" UUID NOT NULL,
    "B" UUID NOT NULL
);

-- CreateTable
CREATE TABLE "_UnitGroupToUnitTypes" (
    "A" UUID NOT NULL,
    "B" UUID NOT NULL
);
INSERT INTO "_UnitGroupToUnitTypes" ("A",
                                       "B")
SELECT "unit_group_id",
       "unit_types_id"
FROM "unit_group_unit_type_unit_types";

-- DropTable
DROP TABLE "unit_group_unit_type_unit_types";

-- CreateIndex
CREATE UNIQUE INDEX "cron_job_name_key" ON "cron_job"("name");

-- CreateIndex
CREATE UNIQUE INDEX "_ApplicationFlaggedSetToApplications_AB_unique" ON "_ApplicationFlaggedSetToApplications"("A", "B");

-- CreateIndex
CREATE INDEX "_ApplicationFlaggedSetToApplications_B_index" ON "_ApplicationFlaggedSetToApplications"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_ApplicationsToUnitTypes_AB_unique" ON "_ApplicationsToUnitTypes"("A", "B");

-- CreateIndex
CREATE INDEX "_ApplicationsToUnitTypes_B_index" ON "_ApplicationsToUnitTypes"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_JurisdictionsToMultiselectQuestions_AB_unique" ON "_JurisdictionsToMultiselectQuestions"("A", "B");

-- CreateIndex
CREATE INDEX "_JurisdictionsToMultiselectQuestions_B_index" ON "_JurisdictionsToMultiselectQuestions"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_JurisdictionsToUserAccounts_AB_unique" ON "_JurisdictionsToUserAccounts"("A", "B");

-- CreateIndex
CREATE INDEX "_JurisdictionsToUserAccounts_B_index" ON "_JurisdictionsToUserAccounts"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_ListingsToUserAccounts_AB_unique" ON "_ListingsToUserAccounts"("A", "B");

-- CreateIndex
CREATE INDEX "_ListingsToUserAccounts_B_index" ON "_ListingsToUserAccounts"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_ListingsToUserPreferences_AB_unique" ON "_ListingsToUserPreferences"("A", "B");

-- CreateIndex
CREATE INDEX "_ListingsToUserPreferences_B_index" ON "_ListingsToUserPreferences"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_UnitGroupToUnitTypes_AB_unique" ON "_UnitGroupToUnitTypes"("A", "B");

-- CreateIndex
CREATE INDEX "_UnitGroupToUnitTypes_B_index" ON "_UnitGroupToUnitTypes"("B");

-- CreateIndex
CREATE UNIQUE INDEX "translations_jurisdiction_id_language_key" ON "translations"("jurisdiction_id", "language");

-- RenameForeignKey
ALTER TABLE "alternate_contact" RENAME CONSTRAINT "FK_5eb038a51b9cd6872359a687b18" TO "alternate_contact_mailing_address_id_fkey";

-- RenameForeignKey
ALTER TABLE "ami_chart" RENAME CONSTRAINT "FK_5566b52b2e7c0056e3b81c171f1" TO "ami_chart_jurisdiction_id_fkey";

-- RenameForeignKey
ALTER TABLE "applicant" RENAME CONSTRAINT "FK_7d357035705ebbbe91b50346781" TO "applicant_work_address_id_fkey";

-- RenameForeignKey
ALTER TABLE "applicant" RENAME CONSTRAINT "FK_8ba2b09030c3a2b857dda5f83fe" TO "applicant_address_id_fkey";

-- RenameForeignKey
ALTER TABLE "application_flagged_set" RENAME CONSTRAINT "FK_3aed12c210529ed798beee9d09e" TO "application_flagged_set_resolving_user_id_fkey";

-- RenameForeignKey
ALTER TABLE "applications" RENAME CONSTRAINT "FK_194d0fca275b8661a56e486cb64" TO "applications_applicant_id_fkey";

-- RenameForeignKey
ALTER TABLE "applications" RENAME CONSTRAINT "FK_3a4c71bc34dce9f6c196f110935" TO "applications_accessibility_id_fkey";

-- RenameForeignKey
ALTER TABLE "applications" RENAME CONSTRAINT "FK_56abaa378952856aaccc64d7eb3" TO "applications_alternate_contact_id_fkey";

-- RenameForeignKey
ALTER TABLE "applications" RENAME CONSTRAINT "FK_7fc41f89f22ca59ffceab5da80e" TO "applications_alternate_address_id_fkey";

-- RenameForeignKey
ALTER TABLE "applications" RENAME CONSTRAINT "FK_9e7594d5b474d9cbebba15c1ae7" TO "applications_user_id_fkey";

-- RenameForeignKey
ALTER TABLE "applications" RENAME CONSTRAINT "FK_b72ba26ebc88981f441b30fe3c5" TO "applications_mailing_address_id_fkey";

-- RenameForeignKey
ALTER TABLE "applications" RENAME CONSTRAINT "FK_fed5da45b7b4dafd9f025a37dd1" TO "applications_demographics_id_fkey";

-- RenameForeignKey
ALTER TABLE "household_member" RENAME CONSTRAINT "FK_7b61da64f1b7a6bbb48eb5bbb43" TO "household_member_address_id_fkey";

-- RenameForeignKey
ALTER TABLE "household_member" RENAME CONSTRAINT "FK_f390552cbb929761927c70b7a0d" TO "household_member_work_address_id_fkey";

-- RenameForeignKey
ALTER TABLE "listing_events" RENAME CONSTRAINT "FK_4fd176b179ce281bedb1b7b9f2b" TO "listing_events_file_id_fkey";

-- RenameForeignKey
ALTER TABLE "listing_images" RENAME CONSTRAINT "FK_6fc0fefe11fb46d5ee863ed483a" TO "listing_images_image_id_fkey";

-- RenameForeignKey
ALTER TABLE "listings" RENAME CONSTRAINT "FK_17e861d96c1bde13c1f4c344cb6" TO "listings_application_drop_off_address_id_fkey";

-- RenameForeignKey
ALTER TABLE "listings" RENAME CONSTRAINT "FK_1f6fac73d27c81b656cc6100267" TO "listings_reserved_community_type_id_fkey";

-- RenameForeignKey
ALTER TABLE "listings" RENAME CONSTRAINT "FK_2634b9bcb29ec36a629d9e379f0" TO "listings_building_selection_criteria_file_id_fkey";

-- RenameForeignKey
ALTER TABLE "listings" RENAME CONSTRAINT "FK_3f7b2aedbfccd6297923943e311" TO "listings_result_id_fkey";

-- RenameForeignKey
ALTER TABLE "listings" RENAME CONSTRAINT "FK_59b4618dfbe6dca2edda375b8d3" TO "listings_neighborhood_amenities_id_fkey";

-- RenameForeignKey
ALTER TABLE "listings" RENAME CONSTRAINT "FK_61b80a947c9db249548ba3c73a5" TO "listings_utilities_id_fkey";

-- RenameForeignKey
ALTER TABLE "listings" RENAME CONSTRAINT "FK_7cedb0a800e3c0af7ede27ab1ec" TO "listings_application_mailing_address_id_fkey";

-- RenameForeignKey
ALTER TABLE "listings" RENAME CONSTRAINT "FK_8a93cc462d190d3f1a04fa69156" TO "listings_leasing_agent_address_id_fkey";

-- RenameForeignKey
ALTER TABLE "listings" RENAME CONSTRAINT "FK_ac59a58a02199c57a588f045830" TO "listings_features_id_fkey";

-- RenameForeignKey
ALTER TABLE "listings" RENAME CONSTRAINT "FK_ba0026e02ecfe91791aed1a4818" TO "listings_jurisdiction_id_fkey";

-- RenameForeignKey
ALTER TABLE "listings" RENAME CONSTRAINT "FK_d54596fd877e83a3126d3953f36" TO "listings_application_pick_up_address_id_fkey";

-- RenameForeignKey
ALTER TABLE "reserved_community_types" RENAME CONSTRAINT "FK_8b43c85a0dd0c39ca795c369edc" TO "reserved_community_types_jurisdiction_id_fkey";

-- RenameForeignKey
ALTER TABLE "translations" RENAME CONSTRAINT "FK_181f8168d13457f0fd00b08b359" TO "translations_jurisdiction_id_fkey";

-- RenameForeignKey
ALTER TABLE "unit_group" RENAME CONSTRAINT "FK_926790e4013043593a3976d84bd" TO "unit_group_listing_id_fkey";

-- RenameForeignKey
ALTER TABLE "unit_group" RENAME CONSTRAINT "FK_e2660f5da2ff575954d765d920b" TO "unit_group_priority_type_id_fkey";

-- RenameForeignKey
ALTER TABLE "unit_group_ami_levels" RENAME CONSTRAINT "FK_ce82398e48c10dc23920c6ff05a" TO "unit_group_ami_levels_unit_group_id_fkey";

-- RenameForeignKey
ALTER TABLE "unit_group_ami_levels" RENAME CONSTRAINT "FK_ff3f8de67facd164607f1ef43ae" TO "unit_group_ami_levels_ami_chart_id_fkey";

-- RenameForeignKey
ALTER TABLE "units" RENAME CONSTRAINT "FK_1e193f5ffdda908517e47d4e021" TO "units_unit_type_id_fkey";

-- RenameForeignKey
ALTER TABLE "units" RENAME CONSTRAINT "FK_35571c6bd2a1ff690201d1dff08" TO "units_ami_chart_id_fkey";

-- RenameForeignKey
ALTER TABLE "units" RENAME CONSTRAINT "FK_4ca3d4c823e6bd5149ecaad363a" TO "units_ami_chart_override_id_fkey";

-- RenameForeignKey
ALTER TABLE "units" RENAME CONSTRAINT "FK_6981f323d01ba8d55190480078d" TO "units_priority_type_id_fkey";

-- RenameForeignKey
ALTER TABLE "units" RENAME CONSTRAINT "FK_ff9559bf9a1daecef4a89bad4a9" TO "units_unit_rent_type_id_fkey";

-- RenameForeignKey
ALTER TABLE "user_preferences" RENAME CONSTRAINT "FK_458057fa75b66e68a275647da2e" TO "user_preferences_user_id_fkey";

-- RenameForeignKey
ALTER TABLE "user_roles" RENAME CONSTRAINT "FK_87b8888186ca9769c960e926870" TO "user_roles_user_id_fkey";

-- AddForeignKey
ALTER TABLE "activity_log" ADD CONSTRAINT "activity_log_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "user_accounts"("id") ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "application_flagged_set" ADD CONSTRAINT "application_flagged_set_listing_id_fkey" FOREIGN KEY ("listing_id") REFERENCES "listings"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "application_methods" ADD CONSTRAINT "application_methods_listing_id_fkey" FOREIGN KEY ("listing_id") REFERENCES "listings"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "applications" ADD CONSTRAINT "applications_listing_id_fkey" FOREIGN KEY ("listing_id") REFERENCES "listings"("id") ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "household_member" ADD CONSTRAINT "household_member_application_id_fkey" FOREIGN KEY ("application_id") REFERENCES "applications"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "listing_events" ADD CONSTRAINT "listing_events_listing_id_fkey" FOREIGN KEY ("listing_id") REFERENCES "listings"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "listing_images" ADD CONSTRAINT "listing_images_listing_id_fkey" FOREIGN KEY ("listing_id") REFERENCES "listings"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "listing_multiselect_questions" ADD CONSTRAINT "listing_multiselect_questions_multiselect_question_id_fkey" FOREIGN KEY ("multiselect_question_id") REFERENCES "multiselect_questions"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "listing_multiselect_questions" ADD CONSTRAINT "listing_multiselect_questions_listing_id_fkey" FOREIGN KEY ("listing_id") REFERENCES "listings"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "listings" ADD CONSTRAINT "listings_building_address_id_fkey" FOREIGN KEY ("building_address_id") REFERENCES "address"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "paper_applications" ADD CONSTRAINT "paper_applications_file_id_fkey" FOREIGN KEY ("file_id") REFERENCES "assets"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "paper_applications" ADD CONSTRAINT "paper_applications_application_method_id_fkey" FOREIGN KEY ("application_method_id") REFERENCES "application_methods"("id") ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "units" ADD CONSTRAINT "units_listing_id_fkey" FOREIGN KEY ("listing_id") REFERENCES "listings"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "units_summary" ADD CONSTRAINT "units_summary_unit_type_id_fkey" FOREIGN KEY ("unit_type_id") REFERENCES "unit_types"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "units_summary" ADD CONSTRAINT "units_summary_priority_type_id_fkey" FOREIGN KEY ("priority_type_id") REFERENCES "unit_accessibility_priority_types"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "units_summary" ADD CONSTRAINT "units_summary_listing_id_fkey" FOREIGN KEY ("listing_id") REFERENCES "listings"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "_ApplicationFlaggedSetToApplications" ADD CONSTRAINT "_ApplicationFlaggedSetToApplications_A_fkey" FOREIGN KEY ("A") REFERENCES "application_flagged_set"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_ApplicationFlaggedSetToApplications" ADD CONSTRAINT "_ApplicationFlaggedSetToApplications_B_fkey" FOREIGN KEY ("B") REFERENCES "applications"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_ApplicationsToUnitTypes" ADD CONSTRAINT "_ApplicationsToUnitTypes_A_fkey" FOREIGN KEY ("A") REFERENCES "applications"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_ApplicationsToUnitTypes" ADD CONSTRAINT "_ApplicationsToUnitTypes_B_fkey" FOREIGN KEY ("B") REFERENCES "unit_types"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_JurisdictionsToMultiselectQuestions" ADD CONSTRAINT "_JurisdictionsToMultiselectQuestions_A_fkey" FOREIGN KEY ("A") REFERENCES "jurisdictions"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_JurisdictionsToMultiselectQuestions" ADD CONSTRAINT "_JurisdictionsToMultiselectQuestions_B_fkey" FOREIGN KEY ("B") REFERENCES "multiselect_questions"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_JurisdictionsToUserAccounts" ADD CONSTRAINT "_JurisdictionsToUserAccounts_A_fkey" FOREIGN KEY ("A") REFERENCES "jurisdictions"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_JurisdictionsToUserAccounts" ADD CONSTRAINT "_JurisdictionsToUserAccounts_B_fkey" FOREIGN KEY ("B") REFERENCES "user_accounts"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_ListingsToUserAccounts" ADD CONSTRAINT "_ListingsToUserAccounts_A_fkey" FOREIGN KEY ("A") REFERENCES "listings"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_ListingsToUserAccounts" ADD CONSTRAINT "_ListingsToUserAccounts_B_fkey" FOREIGN KEY ("B") REFERENCES "user_accounts"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_ListingsToUserPreferences" ADD CONSTRAINT "_ListingsToUserPreferences_A_fkey" FOREIGN KEY ("A") REFERENCES "listings"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_ListingsToUserPreferences" ADD CONSTRAINT "_ListingsToUserPreferences_B_fkey" FOREIGN KEY ("B") REFERENCES "user_preferences"("user_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_UnitGroupToUnitTypes" ADD CONSTRAINT "_UnitGroupToUnitTypes_A_fkey" FOREIGN KEY ("A") REFERENCES "unit_group"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_UnitGroupToUnitTypes" ADD CONSTRAINT "_UnitGroupToUnitTypes_B_fkey" FOREIGN KEY ("B") REFERENCES "unit_types"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- RenameIndex
ALTER INDEX "UQ_5eb038a51b9cd6872359a687b18" RENAME TO "alternate_contact_mailing_address_id_key";

-- RenameIndex
ALTER INDEX "REL_7d357035705ebbbe91b5034678" RENAME TO "applicant_work_address_id_key";

-- RenameIndex
ALTER INDEX "REL_8ba2b09030c3a2b857dda5f83f" RENAME TO "applicant_address_id_key";

-- RenameIndex
ALTER INDEX "IDX_f2ace84eebd770f1387b47e5e4" RENAME TO "application_flagged_set_listing_id_idx";

-- RenameIndex
ALTER INDEX "IDX_cc9d65c58d8deb0ef5353e9037" RENAME TO "applications_listing_id_idx";

-- RenameIndex
ALTER INDEX "UQ_194d0fca275b8661a56e486cb64" RENAME TO "applications_applicant_id_key";

-- RenameIndex
ALTER INDEX "UQ_3a4c71bc34dce9f6c196f110935" RENAME TO "applications_accessibility_id_key";

-- RenameIndex
ALTER INDEX "UQ_556c258a4439f1b7f53de2ed74f" RENAME TO "applications_listing_id_confirmation_code_key";

-- RenameIndex
ALTER INDEX "UQ_56abaa378952856aaccc64d7eb3" RENAME TO "applications_alternate_contact_id_key";

-- RenameIndex
ALTER INDEX "UQ_7fc41f89f22ca59ffceab5da80e" RENAME TO "applications_alternate_address_id_key";

-- RenameIndex
ALTER INDEX "UQ_b72ba26ebc88981f441b30fe3c5" RENAME TO "applications_mailing_address_id_key";

-- RenameIndex
ALTER INDEX "UQ_fed5da45b7b4dafd9f025a37dd1" RENAME TO "applications_demographics_id_key";

-- RenameIndex
ALTER INDEX "IDX_520996eeecf9f6fb9425dc7352" RENAME TO "household_member_application_id_idx";

-- RenameIndex
ALTER INDEX "REL_7b61da64f1b7a6bbb48eb5bbb4" RENAME TO "household_member_address_id_key";

-- RenameIndex
ALTER INDEX "REL_f390552cbb929761927c70b7a0" RENAME TO "household_member_work_address_id_key";

-- RenameIndex
ALTER INDEX "UQ_60b3294568b273d896687dea59f" RENAME TO "jurisdictions_name_key";

-- RenameIndex
ALTER INDEX "IDX_94041359df3c1b14c4420808d1" RENAME TO "listing_images_listing_id_idx";

-- RenameIndex
ALTER INDEX "IDX_ba0026e02ecfe91791aed1a481" RENAME TO "listings_jurisdiction_id_idx";

-- RenameIndex
ALTER INDEX "UQ_59b4618dfbe6dca2edda375b8d3" RENAME TO "listings_neighborhood_amenities_id_key";

-- RenameIndex
ALTER INDEX "UQ_61b80a947c9db249548ba3c73a5" RENAME TO "listings_utilities_id_key";

-- RenameIndex
ALTER INDEX "UQ_ac59a58a02199c57a588f045830" RENAME TO "listings_features_id_key";

-- RenameIndex
ALTER INDEX "UQ_4ca3d4c823e6bd5149ecaad363a" RENAME TO "units_ami_chart_override_id_key";

-- RenameIndex
ALTER INDEX "UQ_df3802ec9c31dd9491e3589378d" RENAME TO "user_accounts_email_key";

-- RenameIndex
ALTER INDEX "UQ_458057fa75b66e68a275647da2e" RENAME TO "user_preferences_user_id_key";
