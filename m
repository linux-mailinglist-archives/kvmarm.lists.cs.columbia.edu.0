Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id D7CE22B4F18
	for <lists+kvmarm@lfdr.de>; Mon, 16 Nov 2020 19:22:17 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6FC444C139;
	Mon, 16 Nov 2020 13:22:17 -0500 (EST)
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
	with ESMTP id GdCr42uj71nL; Mon, 16 Nov 2020 13:22:17 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 404A94C13A;
	Mon, 16 Nov 2020 13:22:16 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id EDE284C074
 for <kvmarm@lists.cs.columbia.edu>; Mon, 16 Nov 2020 13:22:14 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DGC+Sl7ozUL1 for <kvmarm@lists.cs.columbia.edu>;
 Mon, 16 Nov 2020 13:22:13 -0500 (EST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E9C084C139
 for <kvmarm@lists.cs.columbia.edu>; Mon, 16 Nov 2020 13:22:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1605550933;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WTH8Zd5sAmskzAYo30mvhMBg66bSsnSUzhU1/p/F/PA=;
 b=fig8gqSZMioPRjk1gTW8MI1tXJmRNW0bBeyYa8X4p/DgXGH5q9e+4Z8Z/jXB2SInziLNIl
 7j0tivGrER4dBlrxjdG4PI9+mV2Sclh/0wxFwJNbN08aOX86jjHqhPN86v/91/vdBh+7/l
 +1SOzQHbveAhgPEuRXyy+Os8G1T66pM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-42-DsoziD3lPLmPja9cVbSurg-1; Mon, 16 Nov 2020 13:22:11 -0500
X-MC-Unique: DsoziD3lPLmPja9cVbSurg-1
Received: by mail-wm1-f72.google.com with SMTP id h2so91962wmm.0
 for <kvmarm@lists.cs.columbia.edu>; Mon, 16 Nov 2020 10:22:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WTH8Zd5sAmskzAYo30mvhMBg66bSsnSUzhU1/p/F/PA=;
 b=dIOo3Cll1wARbNRQu68h0EnGx4y3CmIq6O1wdF99L6Tj9dEx+K/Ah6mOoqorxBHsR0
 /Kbmh2TtWdBpagvVJPKzx28y5ehEYxXx3/nmkYTrG7Q0Gl2vDhZdIGEs0QDlpj5QZILk
 3IFA6sM+aZvgwwOSM/Kz1HWz4NJz/u1XDny+miS0IKFyHwZXI/cNYLSjPOnjftY2mFHk
 fve4P+LKqVes8LZYMSj8BiKTv69WVbRTdfxv7F/G7FU+J4fyoIQMyPwguWVVncEAkfnR
 xZPSYUEegmNHcWrLQdxSzRDV5ZuRT8uGm1fmfGPLNG06TAgzLnNqNmbhQgpm3AprMcqe
 gsCw==
X-Gm-Message-State: AOAM5324z/M+UINXqWXsNyTt5KNBfk8mc8ms/TnJfM2kmAw5vMYP/NBu
 WPGscU/JFewhAycHukwcKCnf7M3G77gf6aNLhDIwXETFHc/Azpq2yGLdTrljSIUDx/oHtDcfb1n
 vo9u/ZS+sqbZubagHsp6V9l/q
X-Received: by 2002:a5d:5222:: with SMTP id i2mr21960370wra.247.1605550929825; 
 Mon, 16 Nov 2020 10:22:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzygKN/jKZPOR2Tp8R1RkidCe1Eg2IUxg/VtBLvORkfaFPUmdDs+xVTr36C8G5FbkcJI0uy0Q==
X-Received: by 2002:a5d:5222:: with SMTP id i2mr21960352wra.247.1605550929645; 
 Mon, 16 Nov 2020 10:22:09 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id p10sm24465695wre.2.2020.11.16.10.22.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2020 10:22:08 -0800 (PST)
Subject: Re: [PATCH] memory: Skip dirty tracking for un-migratable memory
 regions
To: Zenghui Yu <yuzenghui@huawei.com>, qemu-devel@nongnu.org
References: <20201116132210.1730-1-yuzenghui@huawei.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5f5cc5a8-c5e4-4a69-5fdd-7020459d9d17@redhat.com>
Date: Mon, 16 Nov 2020 19:22:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201116132210.1730-1-yuzenghui@huawei.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: cohuck@redhat.com, kwankhede@nvidia.com, alex.williamson@redhat.com,
 qemu-arm@nongnu.org, kvmarm@lists.cs.columbia.edu
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

On 16/11/20 14:22, Zenghui Yu wrote:
> It makes no sense to track dirty pages for those un-migratable memory
> regions (e.g., Memory BAR region of the VFIO PCI device) and doing so
> will potentially lead to some unpleasant issues during migration [1].
> 
> Skip dirty tracking for those regions by evaluating if the region is
> migratable before setting dirty_log_mask (DIRTY_MEMORY_MIGRATION).
> 
> [1] https://lists.gnu.org/archive/html/qemu-devel/2020-11/msg03757.html
> 
> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
> ---
>   softmmu/memory.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/softmmu/memory.c b/softmmu/memory.c
> index 71951fe4dc..aa393f1bb0 100644
> --- a/softmmu/memory.c
> +++ b/softmmu/memory.c
> @@ -1806,7 +1806,10 @@ bool memory_region_is_ram_device(MemoryRegion *mr)
>   uint8_t memory_region_get_dirty_log_mask(MemoryRegion *mr)
>   {
>       uint8_t mask = mr->dirty_log_mask;
> -    if (global_dirty_log && (mr->ram_block || memory_region_is_iommu(mr))) {
> +    RAMBlock *rb = mr->ram_block;
> +
> +    if (global_dirty_log && ((rb && qemu_ram_is_migratable(rb)) ||
> +                             memory_region_is_iommu(mr))) {
>           mask |= (1 << DIRTY_MEMORY_MIGRATION);
>       }
>       return mask;
> 

Queued, thanks.

Paolo

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
