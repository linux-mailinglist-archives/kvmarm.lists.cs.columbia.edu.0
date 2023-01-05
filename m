Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 66B4B65F561
	for <lists+kvmarm@lfdr.de>; Thu,  5 Jan 2023 21:48:35 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B5EFA4B3DB;
	Thu,  5 Jan 2023 15:48:34 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -6.79
X-Spam-Level: 
X-Spam-Status: No, score=-6.79 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, RCVD_IN_DNSWL_HI=-5, SPF_HELO_PASS=-0.001,
	T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@linux.dev
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EYeosWIqZ17u; Thu,  5 Jan 2023 15:48:34 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6AFEE4B3F5;
	Thu,  5 Jan 2023 15:48:33 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B95B54B3F5
 for <kvmarm@lists.cs.columbia.edu>; Thu,  5 Jan 2023 15:48:31 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id L-Li2Zv2UMaG for <kvmarm@lists.cs.columbia.edu>;
 Thu,  5 Jan 2023 15:48:30 -0500 (EST)
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 96BAA4B3F3
 for <kvmarm@lists.cs.columbia.edu>; Thu,  5 Jan 2023 15:48:30 -0500 (EST)
Date: Thu, 5 Jan 2023 20:48:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1672951709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aYVWC4sBVgWrlftRY/Wjwf7HrIxSM4JPLvpreSFfkAc=;
 b=LgjU7AxU13CeHxxXWLLpwOOH5ZSC/3yZk+Yl//JoD5VDml1Sy6Yh3KLVvULVDKlvJXIKb/
 tmKISIzCGNty273PY3SF6qOSJCq9HRNTKXvytFIAPNgHG5U4XiQXojMUv9cwj5/CyyOoN2
 bGdRhh/FGQo/Uo6dCrNYdHW1xt1nOSQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: Re: [PATCH v4 6/7] KVM: arm64: Mask FEAT_CCIDX
Message-ID: <Y7c3mQS1zqw0UATF@google.com>
References: <20221221204016.658874-1-akihiko.odaki@daynix.com>
 <20221221204016.658874-7-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221221204016.658874-7-akihiko.odaki@daynix.com>
X-Migadu-Flow: FLOW_OUT
Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>, Hector Martin <marcan@marcan.st>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, Marc Zyngier <maz@kernel.org>,
 Sven Peter <sven@svenpeter.dev>, linux-kernel@vger.kernel.org,
 Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
 asahi@lists.linux.dev, Catalin Marinas <catalin.marinas@arm.com>,
 kvmarm@lists.linux.dev, kvmarm@lists.cs.columbia.edu,
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

Hi Akihiko,

On Thu, Dec 22, 2022 at 05:40:15AM +0900, Akihiko Odaki wrote:
> The CCSIDR access handler masks the associativity bits according to the
> bit layout for processors without FEAT_CCIDX. KVM also assumes CCSIDR is
> 32-bit where it will be 64-bit if FEAT_CCIDX is enabled. Mask FEAT_CCIDX
> so that these assumptions hold.
> 
> Suggested-by: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  arch/arm64/kvm/sys_regs.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index f4a7c5abcbca..aeabf1f3370b 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -1124,6 +1124,12 @@ static u64 read_id_reg(const struct kvm_vcpu *vcpu, struct sys_reg_desc const *r
>  						      ID_DFR0_PERFMON_SHIFT,
>  						      kvm_vcpu_has_pmu(vcpu) ? ID_DFR0_PERFMON_8_4 : 0);
>  		break;
> +	case SYS_ID_AA64MMFR2_EL1:
> +		val &= ~ID_AA64MMFR2_EL1_CCIDX_MASK;
> +		break;
> +	case SYS_ID_MMFR4_EL1:
> +		val &= ~ARM64_FEATURE_MASK(ID_MMFR4_CCIDX);
> +		break;

Not that it is necessarily worth addressing, but I wanted to point
something out.

This change breaks migration from older kernels on implementations w/
FEAT_CCIDX. There is most likely exactly 0 of those in the wild, but
we need to be careful changing user-visible stuff like this.

--
Thanks,
Oliver
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
