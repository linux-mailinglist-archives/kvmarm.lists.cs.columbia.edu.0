Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id BA6514ADA97
	for <lists+kvmarm@lfdr.de>; Tue,  8 Feb 2022 14:58:44 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 664004B1C4;
	Tue,  8 Feb 2022 08:58:44 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.91
X-Spam-Level: 
X-Spam-Status: No, score=0.91 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@linuxfoundation.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YqW7Edp3Cjfr; Tue,  8 Feb 2022 08:58:42 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E3C414B192;
	Tue,  8 Feb 2022 08:58:29 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 665894A0FC
 for <kvmarm@lists.cs.columbia.edu>; Mon,  7 Feb 2022 20:52:10 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rPMH+Y9npEbs for <kvmarm@lists.cs.columbia.edu>;
 Mon,  7 Feb 2022 20:52:08 -0500 (EST)
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com
 [209.85.166.42])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 6045949F13
 for <kvmarm@lists.cs.columbia.edu>; Mon,  7 Feb 2022 20:52:08 -0500 (EST)
Received: by mail-io1-f42.google.com with SMTP id e79so19278518iof.13
 for <kvmarm@lists.cs.columbia.edu>; Mon, 07 Feb 2022 17:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linuxfoundation.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=VVsBaOfs/7J2tKPg/nkJEpQFhB56yFe94/gz0cZz844=;
 b=Idhy3Zup7v6F59V0YGJpgy53axlGiO59cFHrx83+9QUidJCfFFmja14ARN6515iD9Q
 7lCo8tYOftshGQD4hahzVcbGX98va4hvlsnLxWqHFGiqt8ADiRbHaRv36mS4ONRhPVor
 YbEkY3+IxHyRVcwTs/IYwFcgk8RclPADLuweY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VVsBaOfs/7J2tKPg/nkJEpQFhB56yFe94/gz0cZz844=;
 b=XxQ9tpUkUe6wBtrmelkwnYwYFJq/CnrT9NRHGawQ2xpc12n8JI/RAcqHJaSEAPIc6a
 T9j5jKueRyKRJw+cCNAzJF8nKdXc58w9CSH2pJ/uEn/NiyuJrd0IWWR3pZlKRdtdVi+A
 kKcmSWQZ6CDqXoD6lZhw+qn/IwaNZj60JCikaGUrWE9VbtyYQwc3StrkzUDGKRHcEAxb
 BZzyiz5goxcJfQMGSZiEOT+OFsbzbI2A7VCxkpTWecyVaBzb6uuAgKTAWijFoAH3pitS
 2CRiqnpEoE0xJmy740+EYSCiMg39Lw9FD2r0AjDnfcfxdwsd6ll+02cjt32lgaLItu2v
 3EgQ==
X-Gm-Message-State: AOAM533I26tUNg+gpU8BdYIkM+C9DzhDBSiAP7r/0mgs3gp1RdboWCOg
 1QINViWOHM7SQBcAUBN6qHzUUQ==
X-Google-Smtp-Source: ABdhPJyhMkZJLdTLBA03u7Op1mAfUo7BEAmoQGpx+Hcm93jqW11wx3t8ozXdSXeLu/jT/Dcy3+NzCA==
X-Received: by 2002:a6b:8dd7:: with SMTP id p206mr1043445iod.81.1644285127564; 
 Mon, 07 Feb 2022 17:52:07 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
 by smtp.gmail.com with ESMTPSA id w11sm6592977ill.46.2022.02.07.17.52.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Feb 2022 17:52:07 -0800 (PST)
Subject: Re: [PATCH v11 40/40] kselftest/arm64: Add SME support to syscall ABI
 test
To: Mark Brown <broonie@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Shuah Khan <shuah@kernel.org>
References: <20220207152109.197566-1-broonie@kernel.org>
 <20220207152109.197566-41-broonie@kernel.org>
From: Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <676aa270-7801-9689-7c88-27368f32a532@linuxfoundation.org>
Date: Mon, 7 Feb 2022 18:52:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220207152109.197566-41-broonie@kernel.org>
Content-Language: en-US
X-Mailman-Approved-At: Tue, 08 Feb 2022 08:58:27 -0500
Cc: Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
 Luis Machado <luis.machado@arm.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>,
 linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org,
 Alan Hayward <alan.hayward@arm.com>, Shuah Khan <skhan@linuxfoundation.org>,
 kvmarm@lists.cs.columbia.edu, Salil Akerkar <Salil.Akerkar@arm.com>
X-BeenThere: kvmarm@lists.cs.columbia.edu
X-Mailman-Version: 2.1.14
Precedence: list
List-Id: Where KVM/ARM decisions are made <kvmarm.lists.cs.columbia.edu>
List-Unsubscribe: <https://lists.cs.columbia.edu/mailman/options/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=unsubscribe>
List-Archive: <https://lists.cs.columbia.edu/pipermail/kvmarm>
List-Post: <mailto:kvmarm@lists.cs.columbia.edu>
List-Help: <mailto:kvmarm-request@lists.cs.columbia.edu?subject=help>
List-Subscribe: <https://lists.cs.columbia.edu/mailman/listinfo/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

On 2/7/22 8:21 AM, Mark Brown wrote:
> For every possible combination of SVE and SME vector length verify that for
> each possible value of SVCR after a syscall we leave streaming mode and ZA
> is preserved. We don't need to take account of any streaming/non streaming
> SVE vector length changes in the assembler code since the store instructions
> will handle the vector length for us. We log if the system supports FA64 and
> only try to set FFR in streaming mode if it does.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>   .../selftests/arm64/abi/syscall-abi-asm.S     |  69 +++++-
>   .../testing/selftests/arm64/abi/syscall-abi.c | 204 ++++++++++++++++--
>   .../testing/selftests/arm64/abi/syscall-abi.h |  15 ++
>   3 files changed, 265 insertions(+), 23 deletions(-)
>   create mode 100644 tools/testing/selftests/arm64/abi/syscall-abi.h
> 

> diff --git a/tools/testing/selftests/arm64/abi/syscall-abi.c b/tools/testing/selftests/arm64/abi/syscall-abi.c
> index 1e13b7523918..b632bfe9e022 100644
> --- a/tools/testing/selftests/arm64/abi/syscall-abi.c
> +++ b/tools/testing/selftests/arm64/abi/syscall-abi.c
> @@ -18,9 +18,13 @@
>   
>   #include "../../kselftest.h"
>   
> +#include "syscall-abi.h"
> +
>   #define NUM_VL ((SVE_VQ_MAX - SVE_VQ_MIN) + 1)
>   
> -extern void do_syscall(int sve_vl);
> +static int default_sme_vl;
> +
> +extern void do_syscall(int sve_vl, int sme_vl);
>   
>   static void fill_random(void *buf, size_t size)
>   {
> @@ -48,14 +52,15 @@ static struct syscall_cfg {
>   uint64_t gpr_in[NUM_GPR];
>   uint64_t gpr_out[NUM_GPR];
>   
> -static void setup_gpr(struct syscall_cfg *cfg, int sve_vl)
> +static void setup_gpr(struct syscall_cfg *cfg, int sve_vl, int sme_vl,
> +		      uint64_t svcr)
>   {
>   	fill_random(gpr_in, sizeof(gpr_in));
>   	gpr_in[8] = cfg->syscall_nr;
>   	memset(gpr_out, 0, sizeof(gpr_out));
>   }
>   
> -static int check_gpr(struct syscall_cfg *cfg, int sve_vl)
> +static int check_gpr(struct syscall_cfg *cfg, int sve_vl, int sme_vl, uint64_t svcr)
>   {
>   	int errors = 0;
>   	int i;
> @@ -79,13 +84,15 @@ static int check_gpr(struct syscall_cfg *cfg, int sve_vl)
>   uint64_t fpr_in[NUM_FPR * 2];
>   uint64_t fpr_out[NUM_FPR * 2];
>   
> -static void setup_fpr(struct syscall_cfg *cfg, int sve_vl)
> +static void setup_fpr(struct syscall_cfg *cfg, int sve_vl, int sme_vl,
> +		      uint64_t svcr)
>   {
>   	fill_random(fpr_in, sizeof(fpr_in));
>   	memset(fpr_out, 0, sizeof(fpr_out));
>   }
>   
> -static int check_fpr(struct syscall_cfg *cfg, int sve_vl)
> +static int check_fpr(struct syscall_cfg *cfg, int sve_vl, int sme_vl,
> +		     uint64_t svcr)
>   {
>   	int errors = 0;
>   	int i;
> @@ -109,13 +116,15 @@ static uint8_t z_zero[__SVE_ZREG_SIZE(SVE_VQ_MAX)];
>   uint8_t z_in[SVE_NUM_PREGS * __SVE_ZREG_SIZE(SVE_VQ_MAX)];
>   uint8_t z_out[SVE_NUM_PREGS * __SVE_ZREG_SIZE(SVE_VQ_MAX)];
>   
> -static void setup_z(struct syscall_cfg *cfg, int sve_vl)
> +static void setup_z(struct syscall_cfg *cfg, int sve_vl, int sme_vl,
> +		    uint64_t svcr)
>   {
>   	fill_random(z_in, sizeof(z_in));
>   	fill_random(z_out, sizeof(z_out));
>   }
>   
> -static int check_z(struct syscall_cfg *cfg, int sve_vl)
> +static int check_z(struct syscall_cfg *cfg, int sve_vl, int sme_vl,
> +		   uint64_t svcr)
>   {
>   	size_t reg_size = sve_vl;
>   	int errors = 0;
> @@ -126,13 +135,17 @@ static int check_z(struct syscall_cfg *cfg, int sve_vl)
>   
>   	/*
>   	 * After a syscall the low 128 bits of the Z registers should
> -	 * be preserved and the rest be zeroed or preserved.
> +	 * be preserved and the rest be zeroed or preserved, except if
> +	 * we were in streaming mode in which case the low 128 bits may
> +	 * also be cleared by the transition out of streaming mode.
>   	 */
>   	for (i = 0; i < SVE_NUM_ZREGS; i++) {
>   		void *in = &z_in[reg_size * i];
>   		void *out = &z_out[reg_size * i];
>   
> -		if (memcmp(in, out, SVE_VQ_BYTES) != 0) {
> +		if ((memcmp(in, out, SVE_VQ_BYTES) != 0) &&
> +		    !((svcr & SVCR_SM_MASK) &&
> +		      memcmp(z_zero, out, SVE_VQ_BYTES) == 0)) {
>   			ksft_print_msg("%s SVE VL %d Z%d low 128 bits changed\n",
>   				       cfg->name, sve_vl, i);
>   			errors++;
> @@ -145,13 +158,15 @@ static int check_z(struct syscall_cfg *cfg, int sve_vl)
>   uint8_t p_in[SVE_NUM_PREGS * __SVE_PREG_SIZE(SVE_VQ_MAX)];
>   uint8_t p_out[SVE_NUM_PREGS * __SVE_PREG_SIZE(SVE_VQ_MAX)];
>   
> -static void setup_p(struct syscall_cfg *cfg, int sve_vl)
> +static void setup_p(struct syscall_cfg *cfg, int sve_vl, int sme_vl,
> +		    uint64_t svcr)
>   {
>   	fill_random(p_in, sizeof(p_in));
>   	fill_random(p_out, sizeof(p_out));
>   }
>   
> -static int check_p(struct syscall_cfg *cfg, int sve_vl)
> +static int check_p(struct syscall_cfg *cfg, int sve_vl, int sme_vl,
> +		   uint64_t svcr)
>   {
>   	size_t reg_size = sve_vq_from_vl(sve_vl) * 2; /* 1 bit per VL byte */
>   
> @@ -175,8 +190,19 @@ static int check_p(struct syscall_cfg *cfg, int sve_vl)
>   uint8_t ffr_in[__SVE_PREG_SIZE(SVE_VQ_MAX)];
>   uint8_t ffr_out[__SVE_PREG_SIZE(SVE_VQ_MAX)];
>   
> -static void setup_ffr(struct syscall_cfg *cfg, int sve_vl)
> +static void setup_ffr(struct syscall_cfg *cfg, int sve_vl, int sme_vl,
> +		      uint64_t svcr)
>   {
> +	/*
> +	 * If we are in streaming mode and do not have FA64 then FFR
> +	 * is unavailable.
> +	 */
> +	if ((svcr & SVCR_SM_MASK) &&
> +	    !(getauxval(AT_HWCAP2) & HWCAP2_SME_FA64)) {
> +		memset(&ffr_in, 0, sizeof(ffr_in));
> +		return;
> +	}
> +
>   	/*
>   	 * It is only valid to set a contiguous set of bits starting
>   	 * at 0.  For now since we're expecting this to be cleared by
> @@ -186,7 +212,8 @@ static void setup_ffr(struct syscall_cfg *cfg, int sve_vl)
>   	fill_random(ffr_out, sizeof(ffr_out));
>   }
>   
> -static int check_ffr(struct syscall_cfg *cfg, int sve_vl)
> +static int check_ffr(struct syscall_cfg *cfg, int sve_vl, int sme_vl,
> +		     uint64_t svcr)
>   {
>   	size_t reg_size = sve_vq_from_vl(sve_vl) * 2;  /* 1 bit per VL byte */
>   	int errors = 0;
> @@ -195,6 +222,10 @@ static int check_ffr(struct syscall_cfg *cfg, int sve_vl)
>   	if (!sve_vl)
>   		return 0;
>   
> +	if ((svcr & SVCR_SM_MASK) &&
> +	    !(getauxval(AT_HWCAP2) & HWCAP2_SME_FA64))
> +		return 0;
> +
>   	/* After a syscall the P registers should be preserved or zeroed */
>   	for (i = 0; i < reg_size; i++)
>   		if (ffr_out[i] && (ffr_in[i] != ffr_out[i]))
> @@ -206,8 +237,65 @@ static int check_ffr(struct syscall_cfg *cfg, int sve_vl)
>   	return errors;
>   }
>   
> -typedef void (*setup_fn)(struct syscall_cfg *cfg, int sve_vl);
> -typedef int (*check_fn)(struct syscall_cfg *cfg, int sve_vl);
> +uint64_t svcr_in, svcr_out;
> +
> +static void setup_svcr(struct syscall_cfg *cfg, int sve_vl, int sme_vl,
> +		    uint64_t svcr)
> +{
> +	svcr_in = svcr;
> +}
> +
> +static int check_svcr(struct syscall_cfg *cfg, int sve_vl, int sme_vl,
> +		      uint64_t svcr)
> +{
> +	int errors = 0;
> +
> +	if (svcr_out & SVCR_SM_MASK) {
> +		ksft_print_msg("%s Still in SM, SVCR %llx\n",
> +			       cfg->name, svcr_out);
> +		errors++;
> +	}
> +
> +	if ((svcr_in & SVCR_ZA_MASK) != (svcr_out & SVCR_ZA_MASK)) {
> +		ksft_print_msg("%s PSTATE.ZA changed, SVCR %llx != %llx\n",
> +			       cfg->name, svcr_in, svcr_out);
> +		errors++;
> +	}
> +
> +	return errors;
> +}
> +
> +uint8_t za_in[SVE_NUM_PREGS * __SVE_ZREG_SIZE(SVE_VQ_MAX)];
> +uint8_t za_out[SVE_NUM_PREGS * __SVE_ZREG_SIZE(SVE_VQ_MAX)];
> +
> +static void setup_za(struct syscall_cfg *cfg, int sve_vl, int sme_vl,
> +		     uint64_t svcr)
> +{
> +	fill_random(za_in, sizeof(za_in));
> +	memset(za_out, 0, sizeof(za_out));
> +}
> +
> +static int check_za(struct syscall_cfg *cfg, int sve_vl, int sme_vl,
> +		    uint64_t svcr)
> +{
> +	size_t reg_size = sme_vl * sme_vl;

Is there possibilty of size_t overfolow here?

> +	int errors = 0;
> +
> +	if (!(svcr & SVCR_ZA_MASK))
> +		return 0;
> +
> +	if (memcmp(za_in, za_out, reg_size) != 0) {
> +		ksft_print_msg("SME VL %d ZA does not match\n", sme_vl);

Print the expected value in addition to the sme_val.

> +		errors++;
> +	}
> +
> +	return errors;
> +}
> +
> +typedef void (*setup_fn)(struct syscall_cfg *cfg, int sve_vl, int sme_vl,
> +			 uint64_t svcr);
> +typedef int (*check_fn)(struct syscall_cfg *cfg, int sve_vl, int sme_vl,
> +			uint64_t svcr);
>   
>   /*
>    * Each set of registers has a setup function which is called before
> @@ -225,20 +313,23 @@ static struct {
>   	{ setup_z, check_z },
>   	{ setup_p, check_p },
>   	{ setup_ffr, check_ffr },
> +	{ setup_svcr, check_svcr },
> +	{ setup_za, check_za },
>   };
>   
> -static bool do_test(struct syscall_cfg *cfg, int sve_vl)
> +static bool do_test(struct syscall_cfg *cfg, int sve_vl, int sme_vl,
> +		    uint64_t svcr)
>   {
>   	int errors = 0;
>   	int i;
>   
>   	for (i = 0; i < ARRAY_SIZE(regset); i++)
> -		regset[i].setup(cfg, sve_vl);
> +		regset[i].setup(cfg, sve_vl, sme_vl, svcr);
>   
> -	do_syscall(sve_vl);
> +	do_syscall(sve_vl, sme_vl);
>   
>   	for (i = 0; i < ARRAY_SIZE(regset); i++)
> -		errors += regset[i].check(cfg, sve_vl);
> +		errors += regset[i].check(cfg, sve_vl, sme_vl, svcr);
>   
>   	return errors == 0;
>   }
> @@ -246,9 +337,10 @@ static bool do_test(struct syscall_cfg *cfg, int sve_vl)
>   static void test_one_syscall(struct syscall_cfg *cfg)
>   {
>   	int sve_vq, sve_vl;
> +	int sme_vq, sme_vl;
>   
>   	/* FPSIMD only case */
> -	ksft_test_result(do_test(cfg, 0),
> +	ksft_test_result(do_test(cfg, 0, default_sme_vl, 0),
>   			 "%s FPSIMD\n", cfg->name);
>   
>   	if (!(getauxval(AT_HWCAP) & HWCAP_SVE))
> @@ -265,8 +357,36 @@ static void test_one_syscall(struct syscall_cfg *cfg)
>   		if (sve_vq != sve_vq_from_vl(sve_vl))
>   			sve_vq = sve_vq_from_vl(sve_vl);
>   
> -		ksft_test_result(do_test(cfg, sve_vl),
> +		ksft_test_result(do_test(cfg, sve_vl, default_sme_vl, 0),
>   				 "%s SVE VL %d\n", cfg->name, sve_vl);

Print default_sme_vl as well.

> +
> +		if (!(getauxval(AT_HWCAP2) & HWCAP2_SME))
> +			continue;
> +
> +		for (sme_vq = SVE_VQ_MAX; sme_vq > 0; --sme_vq) {
> +			sme_vl = prctl(PR_SME_SET_VL, sme_vq * 16);
> +			if (sme_vl == -1)
> +				ksft_exit_fail_msg("PR_SME_SET_VL failed: %s (%d)\n",
> +						   strerror(errno), errno);
> +
> +			sme_vl &= PR_SME_VL_LEN_MASK;
> +
> +			if (sme_vq != sve_vq_from_vl(sme_vl))
> +				sme_vq = sve_vq_from_vl(sme_vl);
> +
> +			ksft_test_result(do_test(cfg, sve_vl, sme_vl,
> +						 SVCR_ZA_MASK | SVCR_SM_MASK),
> +					 "%s SVE VL %d/SME VL %d SM+ZA\n",
> +					 cfg->name, sve_vl, sme_vl);
> +			ksft_test_result(do_test(cfg, sve_vl, sme_vl,
> +						 SVCR_SM_MASK),
> +					 "%s SVE VL %d/SME VL %d SM\n",
> +					 cfg->name, sve_vl, sme_vl);
> +			ksft_test_result(do_test(cfg, sve_vl, sme_vl,
> +						 SVCR_ZA_MASK),
> +					 "%s SVE VL %d/SME VL %d ZA\n",
> +					 cfg->name, sve_vl, sme_vl);
> +		}
>   	}
>   }
>   
> @@ -299,14 +419,54 @@ int sve_count_vls(void)
>   	return vl_count;
>   }
>   
> +int sme_count_vls(void)
> +{
> +	unsigned int vq;
> +	int vl_count = 0;
> +	int vl;
> +
> +	if (!(getauxval(AT_HWCAP2) & HWCAP2_SME))
> +		return 0;
> +
> +	/* Ensure we configure a SME VL, used to flag if SVCR is set */
> +	default_sme_vl = 16;
> +
> +	/*
> +	 * Enumerate up to SVE_VQ_MAX vector lengths
> +	 */
> +	for (vq = SVE_VQ_MAX; vq > 0; --vq) {
> +		vl = prctl(PR_SME_SET_VL, vq * 16);
> +		if (vl == -1)
> +			ksft_exit_fail_msg("PR_SME_SET_VL failed: %s (%d)\n",
> +					   strerror(errno), errno);
> +
> +		vl &= PR_SME_VL_LEN_MASK;
> +
> +		if (vq != sve_vq_from_vl(vl))
> +			vq = sve_vq_from_vl(vl);
> +
> +		vl_count++;
> +	}
> +
> +	return vl_count;
> +}
> +
>   int main(void)
>   {
>   	int i;
> +	int tests = 1;  /* FPSIMD */
>   
>   	srandom(getpid());
>   
>   	ksft_print_header();
> -	ksft_set_plan(ARRAY_SIZE(syscalls) * (sve_count_vls() + 1));
> +	tests += sve_count_vls();
> +	tests += (sve_count_vls() * sme_count_vls()) * 3;
> +	ksft_set_plan(ARRAY_SIZE(syscalls) * tests);
> +
> +	if (getauxval(AT_HWCAP2) & HWCAP2_SME_FA64)
> +		ksft_print_msg("SME with FA64\n");
> +	else if (getauxval(AT_HWCAP2) & HWCAP2_SME)
> +		ksft_print_msg("SME without FA64\n");
>   
>   	for (i = 0; i < ARRAY_SIZE(syscalls); i++)
>   		test_one_syscall(&syscalls[i]);
> diff --git a/tools/testing/selftests/arm64/abi/syscall-abi.h b/tools/testing/selftests/arm64/abi/syscall-abi.h
> new file mode 100644
> index 000000000000..bda5a87ad381
> --- /dev/null
> +++ b/tools/testing/selftests/arm64/abi/syscall-abi.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2021 ARM Limited.
> + */
> +
> +#ifndef SYSCALL_ABI_H
> +#define SYSCALL_ABI_H
> +
> +#define SVCR_ZA_MASK		2
> +#define SVCR_SM_MASK		1
> +
> +#define SVCR_ZA_SHIFT		1
> +#define SVCR_SM_SHIFT		0
> +
> +#endif
> 

With these fixed or explained

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
