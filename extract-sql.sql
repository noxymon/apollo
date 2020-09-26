SELECT
    tmdr.tbmdr_date,
    (
        SELECT
            count(tbmpro_id)
        FROM
            tb_master_promotion tmp
        WHERE
            tmp.tbmpro_status = 23
            AND tbmpro_voucher_gen_type = 158
            AND tmp.tbmpro_disc_percentage IS NOT NULL
            AND tmp.tbmpro_disc_amount IS null
            AND tmdr.tbmdr_date BETWEEN tbmpro_start_date AND tbmpro_end_date
    ) discount_percentage_promo_count_non_voucher,
    (
        SELECT
            count(tbmpro_id)
        FROM
            tb_master_promotion tmp
        WHERE
            tmp.tbmpro_status = 23
            AND tbmpro_voucher_gen_type = 157
            AND tmp.tbmpro_disc_percentage IS NOT NULL
            AND tmp.tbmpro_disc_amount IS null
            AND tmdr.tbmdr_date BETWEEN tbmpro_start_date AND tbmpro_end_date
    ) discount_percentage_promo_count_non_voucher,
    (
        SELECT
            count(tbmpro_id)
        FROM
            tb_master_promotion tmp
        WHERE
            tmp.tbmpro_status = 23
            AND tbmpro_voucher_gen_type = 158
            AND tmp.tbmpro_disc_percentage IS NULL
            AND tmp.tbmpro_disc_amount IS NOT null
            AND tmdr.tbmdr_date BETWEEN tbmpro_start_date AND tbmpro_end_date
    ) fix_discount_promo_count_non_voucher,
    (
        SELECT
            count(tbmpro_id)
        FROM
            tb_master_promotion tmp
        WHERE
            tmp.tbmpro_status = 23
            AND tbmpro_voucher_gen_type = 157
            AND tmp.tbmpro_disc_percentage IS NULL
            AND tmp.tbmpro_disc_amount IS NOT null
            AND tmdr.tbmdr_date BETWEEN tbmpro_start_date AND tbmpro_end_date
    ) fix_discount_promo_count_voucher,
    (
        SELECT
            COALESCE(max(tmp.tbmpro_disc_percentage),0)
        FROM
            tb_master_promotion tmp
        WHERE
            tmp.tbmpro_status = 23
            AND tmp.tbmpro_disc_percentage IS NOT NULL
            AND tmp.tbmpro_disc_amount IS null
            AND tmdr.tbmdr_date BETWEEN tbmpro_start_date AND tbmpro_end_date
    ) discount_percentage_promo_max,
    (
        SELECT
            COALESCE(avg(tmp.tbmpro_disc_percentage), 0)
        FROM
            tb_master_promotion tmp
        WHERE
            tmp.tbmpro_status = 23
            AND tmp.tbmpro_disc_percentage IS NOT NULL
            AND tmp.tbmpro_disc_amount IS null
            AND tmdr.tbmdr_date BETWEEN tbmpro_start_date AND tbmpro_end_date
    ) discount_percentage_promo_avg,
    (
        SELECT
            COALESCE(min(tmp.tbmpro_disc_percentage), 0)
        FROM
            tb_master_promotion tmp
        WHERE
            tmp.tbmpro_status = 23
            AND tmp.tbmpro_disc_percentage IS NOT NULL
            AND tmp.tbmpro_disc_amount IS null
            AND tmdr.tbmdr_date BETWEEN tbmpro_start_date AND tbmpro_end_date
    ) discount_percentage_promo_min,
    (
        SELECT
            COALESCE(max(tmp.tbmpro_min_amount_purchased), 0)
        FROM
            tb_master_promotion tmp
        WHERE
            tmp.tbmpro_status = 23
            AND tmdr.tbmdr_date BETWEEN tbmpro_start_date AND tbmpro_end_date
    ) max_min_amount_purchased,
    (
        SELECT
            COALESCE(min(tmp.tbmpro_min_amount_purchased), 0)
        FROM
            tb_master_promotion tmp
        WHERE
            tmp.tbmpro_status = 23
            AND tmdr.tbmdr_date BETWEEN tbmpro_start_date AND tbmpro_end_date
    ) min_min_amount_purchased,
    (
        SELECT
            COALESCE(max(tmp.tbmpro_max_dicount_amount), max(tmp.tbmpro_disc_amount))
        FROM
            tb_master_promotion tmp
        WHERE
            tmp.tbmpro_status = 23
            AND tmdr.tbmdr_date BETWEEN tbmpro_start_date AND tbmpro_end_date
    ) max_max_discount_amount,
    (
        SELECT
            COALESCE(min(tmp.tbmpro_max_dicount_amount), min(tbmpro_disc_amount))
        FROM
            tb_master_promotion tmp
        WHERE
            tmp.tbmpro_status = 23
            AND tmdr.tbmdr_date BETWEEN tbmpro_start_date AND tbmpro_end_date
    ) min_max_discount_amount,
    (
        SELECT
            COALESCE(avg(tmp.tbmpro_max_dicount_amount), avg(tbmpro_disc_amount))
        FROM
            tb_master_promotion tmp
        WHERE
            tmp.tbmpro_status = 23
            AND tmdr.tbmdr_date BETWEEN tbmpro_start_date AND tbmpro_end_date
    ) avg_max_discount_amount
FROM
    tb_master_date_range tmdr;
