Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 61E7226F697
	for <lists+kvmarm@lfdr.de>; Fri, 18 Sep 2020 09:18:32 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CBA084B44E;
	Fri, 18 Sep 2020 03:18:31 -0400 (EDT)
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
	with ESMTP id WWz5wbJnxSRR; Fri, 18 Sep 2020 03:18:31 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8D4334B43C;
	Fri, 18 Sep 2020 03:18:30 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E03714B378
 for <kvmarm@lists.cs.columbia.edu>; Fri, 18 Sep 2020 03:18:29 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lPp-UjDfe-42 for <kvmarm@lists.cs.columbia.edu>;
 Fri, 18 Sep 2020 03:18:28 -0400 (EDT)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id BDAD34B33A
 for <kvmarm@lists.cs.columbia.edu>; Fri, 18 Sep 2020 03:18:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600413508;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UayBdJRC8Dc6q3iwkfKhighJ8Kurx0LGvj81jk1QulA=;
 b=AjJPin45PUM5Zf93NrsGzZJqmg2X4hGMZ4+iH2Ns4/e2HX9IqhvDQKOvytE7EnzgoVIvJX
 XnQToI1zznYIpIN0L7X8f6f3jXt/WrXSy/OhUv3P7upp9V5ukc/GCwj5xItwjvlsNmsea5
 jZK7v8MOJ7EV2v81MJiWcUD+nEyB930=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-IoD1hUjtPM-ntVodmjwVnw-1; Fri, 18 Sep 2020 03:18:26 -0400
X-MC-Unique: IoD1hUjtPM-ntVodmjwVnw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 30B396408E;
 Fri, 18 Sep 2020 07:18:25 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.192.125])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 319EC60C13;
 Fri, 18 Sep 2020 07:18:22 +0000 (UTC)
Date: Fri, 18 Sep 2020 09:18:20 +0200
From: Andrew Jones <drjones@redhat.com>
To: Peng Liang <liangpeng10@huawei.com>
Subject: Re: [RFC v2 1/7] arm64: add a helper function to traverse
 arm64_ftr_regs
Message-ID: <20200918071820.e6hghta4yclio7ca@kamzik.brq.redhat.com>
References: <20200917120101.3438389-1-liangpeng10@huawei.com>
 <20200917120101.3438389-2-liangpeng10@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200917120101.3438389-2-liangpeng10@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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

On Thu, Sep 17, 2020 at 08:00:55PM +0800, Peng Liang wrote:
> If we want to emulate ID registers, we need to initialize ID registers
> firstly.  This commit is to add a helper function to traverse
> arm64_ftr_regs so that we can initialize ID registers from
> arm64_ftr_regs.
> 
> Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
> Signed-off-by: Peng Liang <liangpeng10@huawei.com>
> ---
>  arch/arm64/include/asm/cpufeature.h |  2 ++
>  arch/arm64/kernel/cpufeature.c      | 13 +++++++++++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> index 89b4f0142c28..2ba7c4f11d8a 100644
> --- a/arch/arm64/include/asm/cpufeature.h
> +++ b/arch/arm64/include/asm/cpufeature.h
> @@ -79,6 +79,8 @@ struct arm64_ftr_reg {
>  
>  extern struct arm64_ftr_reg arm64_ftr_reg_ctrel0;
>  
> +int arm64_cpu_ftr_regs_traverse(int (*op)(u32, u64, void *), void *argp);
> +
>  /*
>   * CPU capabilities:
>   *
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 6424584be01e..698b32705544 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -1112,6 +1112,19 @@ u64 read_sanitised_ftr_reg(u32 id)
>  	return regp->sys_val;
>  }
>  
> +int arm64_cpu_ftr_regs_traverse(int (*op)(u32, u64, void *), void *argp)
> +{
> +	int i, ret;
> +
> +	for (i = 0; i <  ARRAY_SIZE(arm64_ftr_regs); i++) {
> +		ret = (*op)(arm64_ftr_regs[i].sys_id,
> +			    arm64_ftr_regs[i].reg->sys_val, argp);
> +		if (ret < 0)
> +			return ret;
> +	}
> +	return 0;
> +}
> +
>  #define read_sysreg_case(r)	\
>  	case r:		return read_sysreg_s(r)
>  
> -- 
> 2.26.2
>

Skimming the rest of the patches to see how this is used I only saw a
single callsite. Why wouldn't we just put this simple for-loop right
there at that callsite? Or, IOW, I think this traverse function should
be dropped.

Thanks,
drew

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
