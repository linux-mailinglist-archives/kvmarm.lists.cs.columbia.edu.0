Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 3640012FC1F
	for <lists+kvmarm@lfdr.de>; Fri,  3 Jan 2020 19:12:27 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C3CC94A576;
	Fri,  3 Jan 2020 13:12:26 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fVi4-xSy4k12; Fri,  3 Jan 2020 13:12:26 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8B9B94A528;
	Fri,  3 Jan 2020 13:12:25 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 16E234A528
 for <kvmarm@lists.cs.columbia.edu>; Fri,  3 Jan 2020 13:12:24 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id thR8LS7p0rBO for <kvmarm@lists.cs.columbia.edu>;
 Fri,  3 Jan 2020 13:12:22 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D0DF64A36B
 for <kvmarm@lists.cs.columbia.edu>; Fri,  3 Jan 2020 13:12:22 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 74A2F1FB;
 Fri,  3 Jan 2020 10:12:22 -0800 (PST)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 20C783F703;
 Fri,  3 Jan 2020 10:12:21 -0800 (PST)
Date: Fri, 3 Jan 2020 18:12:18 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [kvm-unit-tests PATCH 03/10] arm: pmu: Add a pmu struct
Message-ID: <20200103181218.09681724@donnerap.cambridge.arm.com>
In-Reply-To: <20191216204757.4020-4-eric.auger@redhat.com>
References: <20191216204757.4020-1-eric.auger@redhat.com>
 <20191216204757.4020-4-eric.auger@redhat.com>
Organization: ARM
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Cc: kvm@vger.kernel.org, maz@kernel.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvmarm@lists.cs.columbia.edu, eric.auger.pro@gmail.com
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

On Mon, 16 Dec 2019 21:47:50 +0100
Eric Auger <eric.auger@redhat.com> wrote:

> This struct aims at storing information potentially used by
> all tests such as the pmu version, the read-only part of the
> PMCR, the number of implemented event counters, ...
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> ---
>  arm/pmu.c | 30 +++++++++++++++++++++++++-----
>  1 file changed, 25 insertions(+), 5 deletions(-)
> 
> diff --git a/arm/pmu.c b/arm/pmu.c
> index e5e012d..d24857e 100644
> --- a/arm/pmu.c
> +++ b/arm/pmu.c
> @@ -33,7 +33,14 @@
>  
>  #define NR_SAMPLES 10
>  
> -static unsigned int pmu_version;
> +struct pmu {
> +	unsigned int version;
> +	unsigned int nb_implemented_counters;
> +	uint32_t pmcr_ro;
> +};
> +
> +static struct pmu pmu;
> +
>  #if defined(__arm__)
>  #define ID_DFR0_PERFMON_SHIFT 24
>  #define ID_DFR0_PERFMON_MASK  0xf
> @@ -265,7 +272,7 @@ static bool check_cpi(int cpi)
>  static void pmccntr64_test(void)
>  {
>  #ifdef __arm__
> -	if (pmu_version == 0x3) {
> +	if (pmu.version == 0x3) {
>  		if (ERRATA(9e3f7a296940)) {
>  			write_sysreg(0xdead, PMCCNTR64);
>  			report(read_sysreg(PMCCNTR64) == 0xdead, "pmccntr64");
> @@ -278,9 +285,22 @@ static void pmccntr64_test(void)
>  /* Return FALSE if no PMU found, otherwise return TRUE */
>  static bool pmu_probe(void)
>  {
> -	pmu_version = get_pmu_version();
> -	report_info("PMU version: %d", pmu_version);
> -	return pmu_version != 0 && pmu_version != 0xf;
> +	uint32_t pmcr;
> +
> +	pmu.version = get_pmu_version();
> +	report_info("PMU version: %d", pmu.version);
> +
> +	if (pmu.version == 0 || pmu.version == 0xF)
> +		return false;
> +
> +	pmcr = get_pmcr();
> +	pmu.pmcr_ro = pmcr & 0xFFFFFF80;
> +	pmu.nb_implemented_counters =
> +		(pmcr >> PMU_PMCR_N_SHIFT) & PMU_PMCR_N_MASK;
> +	report_info("Implements %d event counters",
> +		    pmu.nb_implemented_counters);
> +
> +	return true;
>  }
>  
>  int main(int argc, char *argv[])

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
