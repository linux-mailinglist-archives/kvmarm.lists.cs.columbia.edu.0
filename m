Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id AAAD24F1373
	for <lists+kvmarm@lfdr.de>; Mon,  4 Apr 2022 12:54:37 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1317A4B27E;
	Mon,  4 Apr 2022 06:54:37 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.789
X-Spam-Level: 
X-Spam-Status: No, score=-1.789 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001]
	autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CLySt3JYZTRy; Mon,  4 Apr 2022 06:54:36 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CFF514B1C7;
	Mon,  4 Apr 2022 06:54:35 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 5B96949EFC
 for <kvmarm@lists.cs.columbia.edu>; Mon,  4 Apr 2022 06:54:35 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id n8bL6nA9GrgO for <kvmarm@lists.cs.columbia.edu>;
 Mon,  4 Apr 2022 06:54:34 -0400 (EDT)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 3838549EFB
 for <kvmarm@lists.cs.columbia.edu>; Mon,  4 Apr 2022 06:54:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649069674;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x9+MGQ9pc0+gu5/aAz5h5cWsJ9sz5YMy85FxqLq15ig=;
 b=B010EvDDVi0HOTmFzpRWGeuXnIzvrBjwiFichyFzzxXyLJoAWvpxnn195TlioaiUOk47pf
 M//PcuoVUh0tWj38/UnkHUnjMdYLk5YqVFGXGgHP8vtzXmaFq+MUQ3CCjCSWorq+UovJpB
 L10ZK45CcJlgpN84RcKtKrdW9KTGTLI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-557-rgKEaItKOT6OFJFE16bHMQ-1; Mon, 04 Apr 2022 06:54:29 -0400
X-MC-Unique: rgKEaItKOT6OFJFE16bHMQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 58B1128EC103;
 Mon,  4 Apr 2022 10:54:28 +0000 (UTC)
Received: from [10.72.12.126] (ovpn-12-126.pek2.redhat.com [10.72.12.126])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BFD3DC584FA;
 Mon,  4 Apr 2022 10:54:21 +0000 (UTC)
Subject: Re: [PATCH] KVM: arm64: fix returnvar.cocci warnings
To: kernel test robot <lkp@intel.com>, kvmarm@lists.cs.columbia.edu
References: <20220403153911.12332-11-gshan@redhat.com>
 <YkrH6t5QVUREfijB@fdced1fdac95>
From: Gavin Shan <gshan@redhat.com>
Message-ID: <3afd08d2-223c-ea02-0983-616fee32e587@redhat.com>
Date: Mon, 4 Apr 2022 18:54:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <YkrH6t5QVUREfijB@fdced1fdac95>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
Cc: kbuild-all@lists.01.org, maz@kernel.org, linux-kernel@vger.kernel.org,
 eauger@redhat.com, shan.gavin@gmail.com, Jonathan.Cameron@huawei.com,
 pbonzini@redhat.com, vkuznets@redhat.com, will@kernel.org
X-BeenThere: kvmarm@lists.cs.columbia.edu
X-Mailman-Version: 2.1.14
Precedence: list
Reply-To: Gavin Shan <gshan@redhat.com>
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

On 4/4/22 6:26 PM, kernel test robot wrote:
> From: kernel test robot <lkp@intel.com>
> 
> arch/arm64/kvm/sdei.c:346:15-18: Unneeded variable: "ret". Return "SDEI_SUCCESS" on line 352
> 
> 
>   Remove unneeded variable used to store return value.
> 
> Generated by: scripts/coccinelle/misc/returnvar.cocci
> 
> CC: Gavin Shan <gshan@redhat.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: kernel test robot <lkp@intel.com>
> ---
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Gavin-Shan/Support-SDEI-Virtualization/20220403-234350
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git be2d3ecedd9911fbfd7e55cc9ceac5f8b79ae4cf
> :::::: branch date: 19 hours ago
> :::::: commit date: 19 hours ago
> 
>   arch/arm64/kvm/sdei.c |    3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> --- a/arch/arm64/kvm/sdei.c
> +++ b/arch/arm64/kvm/sdei.c
> @@ -343,13 +343,12 @@ out:
>   static unsigned long hypercall_mask(struct kvm_vcpu *vcpu, bool mask)
>   {
>   	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
> -	unsigned long ret = SDEI_SUCCESS;
>   
>   	spin_lock(&vsdei->lock);
>   	vsdei->masked = mask ? 1 : 0;
>   	spin_unlock(&vsdei->lock);
>   
> -	return ret;
> +	return SDEI_SUCCESS;
>   }
>   
>   int kvm_sdei_call(struct kvm_vcpu *vcpu)
> 

Thanks for reporting the warning. I will fold the changes in next respin
if needed.

Thanks,
Gavin

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
