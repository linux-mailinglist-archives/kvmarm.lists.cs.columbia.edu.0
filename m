Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 4E30A243757
	for <lists+kvmarm@lfdr.de>; Thu, 13 Aug 2020 11:10:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id DDAB54B980;
	Thu, 13 Aug 2020 05:10:44 -0400 (EDT)
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
	with ESMTP id BUqtikqMi9WS; Thu, 13 Aug 2020 05:10:44 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D5FC84B95E;
	Thu, 13 Aug 2020 05:10:43 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id CCB924B90D
 for <kvmarm@lists.cs.columbia.edu>; Thu, 13 Aug 2020 05:10:41 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OCAPntIguBfx for <kvmarm@lists.cs.columbia.edu>;
 Thu, 13 Aug 2020 05:10:40 -0400 (EDT)
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id EC0BA4B90A
 for <kvmarm@lists.cs.columbia.edu>; Thu, 13 Aug 2020 05:10:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597309840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WYmYa3wTyDs0toSRca/6MeoUa3K+VKgT/BatpPaLiVM=;
 b=FOY3Ek+sIUhIYp0IqT/mCX/zX7KpUinPTtGZpPUGcvbbqyl+kl+F17LHo6LrTGOJcWC/lR
 2CD/oSeAdFnIX7TBEiQw/8kNaFk+3GBr2RWsGmjt3CyLMDJEKO1XgvIGSIXsJeo1FkswNv
 o6IjVXMvNkVZhnVry7mKQRjFF5XOBk8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-527-yMOGQ8ArPayW01NhAjnAhg-1; Thu, 13 Aug 2020 05:10:38 -0400
X-MC-Unique: yMOGQ8ArPayW01NhAjnAhg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DEF7E1008548;
 Thu, 13 Aug 2020 09:10:36 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.192.72])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E6FBB54596;
 Thu, 13 Aug 2020 09:10:34 +0000 (UTC)
Date: Thu, 13 Aug 2020 11:10:32 +0200
From: Andrew Jones <drjones@redhat.com>
To: Peng Liang <liangpeng10@huawei.com>
Subject: Re: [RFC 4/4] kvm: arm64: add KVM_CAP_ARM_CPU_FEATURE extension
Message-ID: <20200813091032.blyfvuiti7m2xw5i@kamzik.brq.redhat.com>
References: <20200813060517.2360048-1-liangpeng10@huawei.com>
 <20200813060517.2360048-5-liangpeng10@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200813060517.2360048-5-liangpeng10@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: zhang.zhanghailiang@huawei.com, kvm@vger.kernel.org, maz@kernel.org,
 will@kernel.org, kvmarm@lists.cs.columbia.edu
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

On Thu, Aug 13, 2020 at 02:05:17PM +0800, Peng Liang wrote:
> Add KVM_CAP_ARM_CPU_FEATURE extension for userpace to check whether KVM
> supports to set CPU features in AArch64.
> 
> Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
> Signed-off-by: Peng Liang <liangpeng10@huawei.com>
> ---
>  arch/arm64/kvm/arm.c     | 1 +
>  include/uapi/linux/kvm.h | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index 18ebbe1c64ee..72b9e8fc606f 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -194,6 +194,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>  	case KVM_CAP_ARM_IRQ_LINE_LAYOUT_2:
>  	case KVM_CAP_ARM_NISV_TO_USER:
>  	case KVM_CAP_ARM_INJECT_EXT_DABT:
> +	case KVM_CAP_ARM_CPU_FEATURE:
>  		r = 1;
>  		break;
>  	case KVM_CAP_ARM_SET_DEVICE_ADDR:
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 1029444d04aa..0eca4f7c7fef 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -1035,6 +1035,7 @@ struct kvm_ppc_resize_hpt {
>  #define KVM_CAP_LAST_CPU 184
>  #define KVM_CAP_SMALLER_MAXPHYADDR 185
>  #define KVM_CAP_S390_DIAG318 186
> +#define KVM_CAP_ARM_CPU_FEATURE 187
>  
>  #ifdef KVM_CAP_IRQ_ROUTING
>  
> -- 
> 2.18.4
>

All new caps should be documented in Documentation/virt/kvm/api.rst

Thanks,
drew 

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
