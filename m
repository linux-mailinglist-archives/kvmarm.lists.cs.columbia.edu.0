Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 977432A1A29
	for <lists+kvmarm@lfdr.de>; Sat, 31 Oct 2020 19:54:04 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2C2A94B621;
	Sat, 31 Oct 2020 14:54:04 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.091
X-Spam-Level: 
X-Spam-Status: No, score=-4.091 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9XAVZna6NE6m; Sat, 31 Oct 2020 14:54:04 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D548C4B646;
	Sat, 31 Oct 2020 14:54:02 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 9A4624B617
 for <kvmarm@lists.cs.columbia.edu>; Sat, 31 Oct 2020 14:54:01 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3wtPGrmvdWS8 for <kvmarm@lists.cs.columbia.edu>;
 Sat, 31 Oct 2020 14:54:00 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 99D8A4B60B
 for <kvmarm@lists.cs.columbia.edu>; Sat, 31 Oct 2020 14:54:00 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 782A5205ED;
 Sat, 31 Oct 2020 18:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1604170439;
 bh=HvDtIcBTZHfDsPAUi0HpgUv6w8RVXhfLSLkNClG2LZE=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=wn/RcwW3+g7WQtgl/Qkzckxgw27QWa6gX8garulc+M8QnqMIKuxBMyHSQdAHGTB5T
 Aax0Ia6pERZzkNQpQ3uyTLMGIvOwbpn/bU4lkl/zWGAcm/mzxyYDBWUz1pHAjKv1+P
 he5Nxx8CX0hjTHs03RGV4Q97PLc2Rt6pqDURpjgs=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=wait-a-minute.misterjones.org)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94)
 (envelope-from <maz@kernel.org>)
 id 1kYw0j-0069TJ-G0; Sat, 31 Oct 2020 18:53:57 +0000
Date: Sat, 31 Oct 2020 18:53:56 +0000
Message-ID: <875z6qdy63.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Andrew Jones <drjones@redhat.com>
Subject: Re: [PATCH 3/4] KVM: selftests: Update aarch64 get-reg-list blessed
 list
In-Reply-To: <20201029201703.102716-4-drjones@redhat.com>
References: <20201029201703.102716-1-drjones@redhat.com>
 <20201029201703.102716-4-drjones@redhat.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL/10.8 EasyPG/1.0.0 Emacs/26.3
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: drjones@redhat.com, kvm@vger.kernel.org,
 kvmarm@lists.cs.columbia.edu, pbonzini@redhat.com, Dave.Martin@arm.com,
 peter.maydell@linaro.org, eric.auger@redhat.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kvm@vger.kernel.org, Dave.Martin@arm.com, pbonzini@redhat.com,
 kvmarm@lists.cs.columbia.edu
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

On Thu, 29 Oct 2020 20:17:02 +0000,
Andrew Jones <drjones@redhat.com> wrote:
> 
> The new registers come from the following commits:
> 
> commit 99adb567632b ("KVM: arm/arm64: Add save/restore support for
> firmware workaround state")
> 
> commit c773ae2b3476 ("KVM: arm64: Save/Restore guest DISR_EL1")
> 
> commit 03fdfb269009 ("KVM: arm64: Don't write junk to sysregs on reset")
> 
> The last commit, which adds ARM64_SYS_REG(3, 3, 9, 12, 0) (PMCR_EL0),
> and was committed for v5.3, doesn't indicate in its commit message that
> enumerating it for save/restore was the plan, so doing so may have
> been by accident.

It definitely was.

> It's a good idea anyway, though, since the other PMU registers have
> been enumerated since v4.10.

Quite. The state of the PMU is pretty much unknown on restore until then.

> 
> Signed-off-by: Andrew Jones <drjones@redhat.com>
> ---
>  tools/testing/selftests/kvm/aarch64/get-reg-list.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kvm/aarch64/get-reg-list.c b/tools/testing/selftests/kvm/aarch64/get-reg-list.c
> index 3aeb3de780a1..3ff097f6886e 100644
> --- a/tools/testing/selftests/kvm/aarch64/get-reg-list.c
> +++ b/tools/testing/selftests/kvm/aarch64/get-reg-list.c
> @@ -352,7 +352,8 @@ int main(int ac, char **av)
>  }
>  
>  /*
> - * The current blessed list comes from kernel version v4.15 with --core-reg-fixup
> + * The current blessed list was primed with the output of kernel version
> + * v4.15 with --core-reg-fixup and then later updated with new registers.

Maybe have a reference to the last kernel version this was checked
against? Either here or in the commit message?

Thanks,

	M.

-- 
Without deviation from the norm, progress is not possible.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
