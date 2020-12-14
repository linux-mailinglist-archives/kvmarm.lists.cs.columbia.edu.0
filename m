Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 870BE2D992D
	for <lists+kvmarm@lfdr.de>; Mon, 14 Dec 2020 14:48:16 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id F247A4B678;
	Mon, 14 Dec 2020 08:48:15 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.909
X-Spam-Level: 
X-Spam-Status: No, score=0.909 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699,
	RCVD_IN_DNSWL_NONE=-0.0001, T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Gor9hq1fY1H2; Mon, 14 Dec 2020 08:48:15 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E30234B666;
	Mon, 14 Dec 2020 08:48:14 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 57DF34B529
 for <kvmarm@lists.cs.columbia.edu>; Mon, 14 Dec 2020 08:48:13 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rlej3K5TLd2B for <kvmarm@lists.cs.columbia.edu>;
 Mon, 14 Dec 2020 08:48:12 -0500 (EST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 7432F4B4D9
 for <kvmarm@lists.cs.columbia.edu>; Mon, 14 Dec 2020 08:48:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607953692;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MZMh9xgwSrcXF2aRTMmuCo54VTLyRe6KjJIxuq1WfcY=;
 b=HrHm0ynoG/E5kSIY/K5xARWqSjU1SMDWZye33TUsE9zCVta+P7MhhVJavpNxz1WE1wre8P
 cTtI8OieaE2TkVik4uXSZBzKR1vN71HUGviSpkmfDMEh46dNO5cLB1/KEbSmA9c3Kh4DL+
 g2Sx3cMdET6XxdeDMS2C5UhCHWHmS6c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-csCaedztMXuvF9KfS-fMjQ-1; Mon, 14 Dec 2020 08:48:08 -0500
X-MC-Unique: csCaedztMXuvF9KfS-fMjQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D8499801817;
 Mon, 14 Dec 2020 13:48:06 +0000 (UTC)
Received: from [10.36.115.41] (ovpn-115-41.ams2.redhat.com [10.36.115.41])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 13BDC10016FE;
 Mon, 14 Dec 2020 13:48:04 +0000 (UTC)
Subject: Re: [PATCH 5/5] KVM: arm64: Remove redundant call to
 kvm_pmu_vcpu_reset()
To: Alexandru Elisei <alexandru.elisei@arm.com>,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 maz@kernel.org, james.morse@arm.com, julien.thierry.kdev@gmail.com,
 suzuki.poulose@arm.com
References: <20201201150157.223625-1-alexandru.elisei@arm.com>
 <20201201150157.223625-6-alexandru.elisei@arm.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <9f68ed5e-371e-6c0c-7ba3-b14ff059430f@redhat.com>
Date: Mon, 14 Dec 2020 14:48:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20201201150157.223625-6-alexandru.elisei@arm.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
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

Alexandru,

On 12/1/20 4:01 PM, Alexandru Elisei wrote:
> KVM_ARM_VCPU_INIT ioctl calls kvm_reset_vcpu(), which in turn resets the
> PMU with a call to kvm_pmu_vcpu_reset(). The function zeroes the PMU
> chained counters bitmap and stops all the counters with a perf event
> attached. Because it is called before the VCPU has had the chance to run,
> no perf events are in use and none are released.
> 
> kvm_arm_pmu_v3_enable(), called by kvm_vcpu_first_run_init() only if the
> VCPU has not been initialized, also resets the PMU. kvm_pmu_vcpu_reset() in
This sounds strange to me. kvm_vcpu_first_run_init() only is called if
kvm_vcpu_initialized(vcpu) is true.
> this case does the exact same thing as the previous call, so remove it.
> 
> Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
> ---
>  arch/arm64/kvm/pmu-emul.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm64/kvm/pmu-emul.c b/arch/arm64/kvm/pmu-emul.c
> index 398f6df1bbe4..4ad66a532e38 100644
> --- a/arch/arm64/kvm/pmu-emul.c
> +++ b/arch/arm64/kvm/pmu-emul.c
> @@ -850,8 +850,6 @@ int kvm_arm_pmu_v3_enable(struct kvm_vcpu *vcpu)
>  		   return -EINVAL;
>  	}
>  
> -	kvm_pmu_vcpu_reset(vcpu);
> -
this patch does not apply for me (vcpu->arch.pmu.ready = true; ?)

Thanks

Eric
>  	return 0;
>  }
>  
> 

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
