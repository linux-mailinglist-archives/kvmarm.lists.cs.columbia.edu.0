Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id D21AF496C27
	for <lists+kvmarm@lfdr.de>; Sat, 22 Jan 2022 12:32:55 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2E90A49E0E;
	Sat, 22 Jan 2022 06:32:55 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.911
X-Spam-Level: 
X-Spam-Status: No, score=0.911 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699,
	RCVD_IN_DNSWL_BLOCKED=0.001, T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001]
	autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gVY-Qx5xbXB0; Sat, 22 Jan 2022 06:32:55 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1E1CE48F9C;
	Sat, 22 Jan 2022 06:32:54 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 5AE8C43C96
 for <kvmarm@lists.cs.columbia.edu>; Sat, 22 Jan 2022 06:32:52 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id r5C7oRdcRFeq for <kvmarm@lists.cs.columbia.edu>;
 Sat, 22 Jan 2022 06:32:51 -0500 (EST)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 006DC49AF9
 for <kvmarm@lists.cs.columbia.edu>; Sat, 22 Jan 2022 06:32:50 -0500 (EST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 5C6C5B817A0;
 Sat, 22 Jan 2022 11:32:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A61B5C004E1;
 Sat, 22 Jan 2022 11:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1642851167;
 bh=da9dcIw8+ZO22yZ/mXsw9PbOSUJDP1ZUMBvg+J6Y+LA=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=ks68lFAOpH1zQrQYK3tbSAH07QNmXRSUZ4HSHotHR3Nj1uIYk5ArtYW7tvlRVILTN
 ftPzxhl8DyhRKH4cCo4hHkZvaMW0WRK0axAZH6PD7A8Um57lfA4wYLp+WxHof65hm1
 +Wf42STgLh9fyfkUST91YxTU+W4vz8TIMmXTpGpu8iqjvNUj1f/W/fjpNj2sGXCAXW
 6LUKYH2e4mCpS+RO4Fo7EQh7EHQyyeYhkfn7bDPLCYhqMwzUnGIipmj30Lv49rNyKG
 /T15PE7c3cJYa2m+98qqZaQq1CnX85Tb3KtAt6po8Uskt35+Qx3VjjWunx/3r8CJuZ
 4SPcOLyPAr73Q==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <maz@kernel.org>)
 id 1nBEdR-0025B5-Og; Sat, 22 Jan 2022 11:32:45 +0000
MIME-Version: 1.0
Date: Sat, 22 Jan 2022 11:32:45 +0000
From: Marc Zyngier <maz@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH] KVM: arm64: vgic-v3: Restrict SEIS workaround to known
 broken systems
In-Reply-To: <CAMj1kXEmNpTGtZU=ZkOTpYpG7bdaubUx3-Zzpf-D1unjk43AYQ@mail.gmail.com>
References: <20220122103912.795026-1-maz@kernel.org>
 <CAMj1kXEmNpTGtZU=ZkOTpYpG7bdaubUx3-Zzpf-D1unjk43AYQ@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <8d8b93e7251b0373d897a2f9222b0520@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: ardb@kernel.org, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, james.morse@arm.com,
 suzuki.poulose@arm.com, alexandru.elisei@arm.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kvm@vger.kernel.org, Android Kernel Team <kernel-team@android.com>,
 kvmarm <kvmarm@lists.cs.columbia.edu>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
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

On 2022-01-22 11:14, Ard Biesheuvel wrote:
> On Sat, 22 Jan 2022 at 11:39, Marc Zyngier <maz@kernel.org> wrote:
>> 
>> Contrary to what df652bcf1136 ("KVM: arm64: vgic-v3: Work around GICv3
>> locally generated SErrors") was asserting, there is at least one other
>> system out there (Cavium ThunderX2) implementing SEIS, and not in
>> an obviously broken way.
>> 
>> So instead of imposing the M1 workaround on an innocent bystander,
>> let's limit it to the two known broken Apple implementations.
>> 
>> Fixes: df652bcf1136 ("KVM: arm64: vgic-v3: Work around GICv3 locally 
>> generated SErrors")
>> Reported-by: Ard Biesheuvel <ardb@kernel.org>
>> Signed-off-by: Marc Zyngier <maz@kernel.org>
> 
> Thanks for the fix.
> 
> Tested-by: Ard Biesheuvel <ardb@kernel.org>
> Acked-by: Ard Biesheuvel <ardb@kernel.org>

Thanks for that.

> 
> One nit below.
> 
>> ---
>>  arch/arm64/kvm/hyp/vgic-v3-sr.c |  3 +++
>>  arch/arm64/kvm/vgic/vgic-v3.c   | 17 +++++++++++++++--
>>  2 files changed, 18 insertions(+), 2 deletions(-)
>> 
>> diff --git a/arch/arm64/kvm/hyp/vgic-v3-sr.c 
>> b/arch/arm64/kvm/hyp/vgic-v3-sr.c
>> index 20db2f281cf2..4fb419f7b8b6 100644
>> --- a/arch/arm64/kvm/hyp/vgic-v3-sr.c
>> +++ b/arch/arm64/kvm/hyp/vgic-v3-sr.c
>> @@ -983,6 +983,9 @@ static void __vgic_v3_read_ctlr(struct kvm_vcpu 
>> *vcpu, u32 vmcr, int rt)
>>         val = ((vtr >> 29) & 7) << ICC_CTLR_EL1_PRI_BITS_SHIFT;
>>         /* IDbits */
>>         val |= ((vtr >> 23) & 7) << ICC_CTLR_EL1_ID_BITS_SHIFT;
>> +       /* SEIS */
>> +       if (kvm_vgic_global_state.ich_vtr_el2 & ICH_VTR_SEIS_MASK)
>> +               val |= BIT(ICC_CTLR_EL1_SEIS_SHIFT);
>>         /* A3V */
>>         val |= ((vtr >> 21) & 1) << ICC_CTLR_EL1_A3V_SHIFT;
>>         /* EOImode */
>> diff --git a/arch/arm64/kvm/vgic/vgic-v3.c 
>> b/arch/arm64/kvm/vgic/vgic-v3.c
>> index 78cf674c1230..d34a795f730c 100644
>> --- a/arch/arm64/kvm/vgic/vgic-v3.c
>> +++ b/arch/arm64/kvm/vgic/vgic-v3.c
>> @@ -609,6 +609,18 @@ static int __init early_gicv4_enable(char *buf)
>>  }
>>  early_param("kvm-arm.vgic_v4_enable", early_gicv4_enable);
>> 
>> +static struct midr_range broken_seis[] = {
> 
> Can this be const?

Absolutely. I'll fold that in.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
