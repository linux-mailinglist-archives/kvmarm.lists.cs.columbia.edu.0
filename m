Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id B5948212409
	for <lists+kvmarm@lfdr.de>; Thu,  2 Jul 2020 15:02:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4CB3E4B5FF;
	Thu,  2 Jul 2020 09:02:02 -0400 (EDT)
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
	with ESMTP id Z803qSaEOdYS; Thu,  2 Jul 2020 09:02:02 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1D2194B5FA;
	Thu,  2 Jul 2020 09:02:01 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 585684B5F0
 for <kvmarm@lists.cs.columbia.edu>; Thu,  2 Jul 2020 09:02:00 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id j63oDtlm4AeZ for <kvmarm@lists.cs.columbia.edu>;
 Thu,  2 Jul 2020 09:01:55 -0400 (EDT)
Received: from us-smtp-1.mimecast.com (us-smtp-2.mimecast.com [207.211.31.81])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id AD6824B59D
 for <kvmarm@lists.cs.columbia.edu>; Thu,  2 Jul 2020 09:01:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593694915;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v8SnQ4u0UTLmhKt73+PAqeYdxoNSV8q95I5k2+Mk11E=;
 b=QsUNtgkEIlIv2Tjby72mO7MB6t6zNkTq2pDfhvYwLRJw+Ltycvi7fGR++J2PHL79oiQ5Lf
 uJJkIelP7TnFg8MQ3qzMSwQ3li1toS9icg16AG4Wr72+Lb66KLTGu+MuHNDe9mmCqa6Xle
 o9fFJjIryH00XX+b3pzQ1qDUGJNQcdc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-323-3QslMo8oMuerZaJzE0OIgg-1; Thu, 02 Jul 2020 09:01:53 -0400
X-MC-Unique: 3QslMo8oMuerZaJzE0OIgg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 364B0A0BD7;
 Thu,  2 Jul 2020 13:01:51 +0000 (UTC)
Received: from [10.36.112.70] (ovpn-112-70.ams2.redhat.com [10.36.112.70])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9EE3C73FC7;
 Thu,  2 Jul 2020 13:01:49 +0000 (UTC)
Subject: Re: [kvm-unit-tests PATCH v2 4/8] arm64: its: Handle its command
 queue wrapping
To: Jingyi Wang <wangjingyi11@huawei.com>, drjones@redhat.com,
 kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu
References: <20200702030132.20252-1-wangjingyi11@huawei.com>
 <20200702030132.20252-5-wangjingyi11@huawei.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <870ae6e6-0c02-1770-085b-4e031e391a24@redhat.com>
Date: Thu, 2 Jul 2020 15:01:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200702030132.20252-5-wangjingyi11@huawei.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: maz@kernel.org
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

Hi Jingyi,

On 7/2/20 5:01 AM, Jingyi Wang wrote:
> Because micro-bench may send a large number of ITS commands, we
> should handle ITS command queue wrapping as kernel instead of just
> failing the test.
> 
> Signed-off-by: Jingyi Wang <wangjingyi11@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric

> ---
>  lib/arm64/gic-v3-its-cmd.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/arm64/gic-v3-its-cmd.c b/lib/arm64/gic-v3-its-cmd.c
> index 2c208d1..34574f7 100644
> --- a/lib/arm64/gic-v3-its-cmd.c
> +++ b/lib/arm64/gic-v3-its-cmd.c
> @@ -164,8 +164,9 @@ static struct its_cmd_block *its_allocate_entry(void)
>  {
>  	struct its_cmd_block *cmd;
>  
> -	assert((u64)its_data.cmd_write < (u64)its_data.cmd_base + SZ_64K);
>  	cmd = its_data.cmd_write++;
> +	if ((u64)its_data.cmd_write  == (u64)its_data.cmd_base + SZ_64K)
> +		its_data.cmd_write = its_data.cmd_base;
>  	return cmd;
>  }
>  
> 

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
