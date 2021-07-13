Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id B8CAE3C7267
	for <lists+kvmarm@lfdr.de>; Tue, 13 Jul 2021 16:40:01 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 033694A5A0;
	Tue, 13 Jul 2021 10:40:01 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.391
X-Spam-Level: 
X-Spam-Status: No, score=-1.391 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@armlinux.org.uk
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1uaH+hy4aCVR; Tue, 13 Jul 2021 10:40:00 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id DF91D4A500;
	Tue, 13 Jul 2021 10:39:59 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 291DE4A4E1
 for <kvmarm@lists.cs.columbia.edu>; Tue, 13 Jul 2021 10:39:58 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id R947cieO6t42 for <kvmarm@lists.cs.columbia.edu>;
 Tue, 13 Jul 2021 10:39:56 -0400 (EDT)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 8CA764A4A4
 for <kvmarm@lists.cs.columbia.edu>; Tue, 13 Jul 2021 10:39:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SJJMrxtMNFqRvemONP1f4NnQi5qafts1cHoez9F3skE=; b=gl70oHKF6x5JHToNhVhDWqKOL
 JPTvLKHhNDqsg5zHBfI7iMMI17d3Z5JZA4HtyKekNYDXXXnYdfZI9QM3hKg9lyHSYz2eR1j7teD+D
 stciPEAXNl1laacDnsuHrcuym53mrrwHFvM42qvEh+zwSNVKI5g3tkaLXq+xhxR+0+Zp6nk08EO2x
 VMvDpW3eDqlraIQUBNqpcfo4KYWqZYXyycg7Pzlx+Z+9KOJbbSyvGPMIAq65AsuhRJiHodJKSpBV7
 wvfmX4+NHUbtchvCyy13+nNhl61XEaftoRi/3S2fmGEoX4jcSXOLt8KSOkr/zCZeT8SzmKJ0p3Iaf
 Gq9U1G/9A==;
Received: from shell.armlinux.org.uk
 ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46056)
 by pandora.armlinux.org.uk with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <linux@armlinux.org.uk>)
 id 1m3JZg-0006DA-4G; Tue, 13 Jul 2021 15:39:52 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
 (envelope-from <linux@shell.armlinux.org.uk>)
 id 1m3JZd-0000OC-Uk; Tue, 13 Jul 2021 15:39:49 +0100
Date: Tue, 13 Jul 2021 15:39:49 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH 1/3] KVM: arm64: Narrow PMU sysreg reset values to
 architectural requirements
Message-ID: <20210713143949.GJ22278@shell.armlinux.org.uk>
References: <20210713135900.1473057-1-maz@kernel.org>
 <20210713135900.1473057-2-maz@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210713135900.1473057-2-maz@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: kernel-team@android.com, kvm@vger.kernel.org,
 Robin Murphy <robin.murphy@arm.com>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
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

On Tue, Jul 13, 2021 at 02:58:58PM +0100, Marc Zyngier wrote:
> +static void reset_pmu_reg(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
> +{
> +	u64 n, mask;
> +
> +	/* No PMU available, any PMU reg may UNDEF... */
> +	if (!kvm_arm_support_pmu_v3())
> +		return;
> +
> +	n = read_sysreg(pmcr_el0) >> ARMV8_PMU_PMCR_N_SHIFT;
> +	n &= ARMV8_PMU_PMCR_N_MASK;
> +
> +	reset_unknown(vcpu, r);
> +
> +	mask = BIT(ARMV8_PMU_CYCLE_IDX);
> +	if (n)
> +		mask |= GENMASK(n - 1, 0);
> +
> +	__vcpu_sys_reg(vcpu, r->reg) &= mask;

Would this read more logically to structure it as:

	mask = BIT(ARMV8_PMU_CYCLE_IDX);

	n = read_sysreg(pmcr_el0) >> ARMV8_PMU_PMCR_N_SHIFT;
	n &= ARMV8_PMU_PMCR_N_MASK;
	if (n)
		mask |= GENMASK(n - 1, 0);

	reset_unknown(vcpu, r);
	__vcpu_sys_reg(vcpu, r->reg) &= mask;

?

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
