Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id DD205423B46
	for <lists+kvmarm@lfdr.de>; Wed,  6 Oct 2021 12:12:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6BF9B4B2AB;
	Wed,  6 Oct 2021 06:12:48 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.209
X-Spam-Level: 
X-Spam-Status: No, score=0.209 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_LOW=-0.7,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8RT9Pj-mgZxh; Wed,  6 Oct 2021 06:12:48 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 722914B267;
	Wed,  6 Oct 2021 06:12:47 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E1AEE4B267
 for <kvmarm@lists.cs.columbia.edu>; Wed,  6 Oct 2021 06:12:45 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CgRl-ES6T+KY for <kvmarm@lists.cs.columbia.edu>;
 Wed,  6 Oct 2021 06:12:42 -0400 (EDT)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D05DD4B234
 for <kvmarm@lists.cs.columbia.edu>; Wed,  6 Oct 2021 06:12:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1633515162;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LVKa10Ka2NztPVFkO4ojxiDXv4AaKaB2OGd/MiltWxs=;
 b=F4OSKO9cPo44jqVLXy1//MuOE8DY4rMe3u8bcBKNaaGClaKaIhyE+6fBs87VTy20Ih4CM7
 0HnqHBu047/zSO9rU1xsOEIA+hX8/TXHgpjFr6jy3ECBaPYPfu4VFqWL2CwNsHy11sYYqT
 DWjCua6h5ljknOtwGCgKDTTsTqBitac=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-154-D1Zq3tN7NHGpbugTZwpNZg-1; Wed, 06 Oct 2021 06:12:39 -0400
X-MC-Unique: D1Zq3tN7NHGpbugTZwpNZg-1
Received: by mail-ed1-f69.google.com with SMTP id
 1-20020a508741000000b003da559ba1eeso2162989edv.13
 for <kvmarm@lists.cs.columbia.edu>; Wed, 06 Oct 2021 03:12:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=LVKa10Ka2NztPVFkO4ojxiDXv4AaKaB2OGd/MiltWxs=;
 b=J4Tiysx3erXhWSvoWxI5Dfw71jx+in2nNFjleFePByU/97/+CgmzudLVjhZAzpntpp
 HEwY2jZna0V+3SRCRMQb+qspAwr7fthiuaou3zntAyaatHT1hXE0b6tWBSJqNqle5Smy
 sQ/lR9LY5mOhEPtsj6zQuM05Y5XxYS82mHKIaouwV8hEtzosvbjFyvPTVlFD9/Znib8H
 5m2tV+yIf0WLbH960Xr9wFebY9BvUTIpgF8NQeaitOii2xpf8prieebx8XzKZ0c4Uu8A
 bH03THMq0ZIP5+K8n2LCc0/9i+JmYqha9mAgce0EbK7bWzc8cX2/1qejW0m79s/we464
 Oo6Q==
X-Gm-Message-State: AOAM531cS6g15O/zdrUBjBfizUGCRgcTxVjJ2NjkFLQs1gFsTjgznj3E
 Dk4laQSuLYjDn0qT6oyt8cBVJ+ZKSOWIF+LrPzXXc7xOybYLXf1B9HgwZAmhwR++8dg3Kkr7zUz
 r+3f0ub+mTF3TSDklwohxr+Nr
X-Received: by 2002:a17:907:785a:: with SMTP id
 lb26mr30740278ejc.77.1633515158422; 
 Wed, 06 Oct 2021 03:12:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyqZuM9LLB357DG8BTmc0wddDVHkGSLTZqlWFSDFmapsNWHXkLzwSDxzDoCFY/er6q5YbEReQ==
X-Received: by 2002:a17:907:785a:: with SMTP id
 lb26mr30740256ejc.77.1633515158261; 
 Wed, 06 Oct 2021 03:12:38 -0700 (PDT)
Received: from gator.home (cst2-174-28.cust.vodafone.cz. [31.30.174.28])
 by smtp.gmail.com with ESMTPSA id lb12sm8932498ejc.28.2021.10.06.03.12.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Oct 2021 03:12:37 -0700 (PDT)
Date: Wed, 6 Oct 2021 12:12:36 +0200
From: Andrew Jones <drjones@redhat.com>
To: Ricardo Koller <ricarkol@google.com>
Subject: Re: [PATCH v4 10/11] KVM: arm64: selftests: Add test for legacy
 GICv3 REDIST base partially above IPA range
Message-ID: <20211006101236.5hqyaqbf2km2vqfh@gator.home>
References: <20211005011921.437353-1-ricarkol@google.com>
 <20211005011921.437353-11-ricarkol@google.com>
MIME-Version: 1.0
In-Reply-To: <20211005011921.437353-11-ricarkol@google.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=drjones@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: shuah@kernel.org, kvm@vger.kernel.org, maz@kernel.org, pshier@google.com,
 Paolo Bonzini <pbonzini@redhat.com>, kvmarm@lists.cs.columbia.edu
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

On Mon, Oct 04, 2021 at 06:19:20PM -0700, Ricardo Koller wrote:
> Add a new test into vgic_init which checks that the first vcpu fails to
> run if there is not sufficient REDIST space below the addressable IPA
> range.  This only applies to the KVM_VGIC_V3_ADDR_TYPE_REDIST legacy API
> as the required REDIST space is not know when setting the DIST region.
> 
> Note that using the REDIST_REGION API results in a different check at
> first vcpu run: that the number of redist regions is enough for all
> vcpus. And there is already a test for that case in, the first step of
> test_v3_new_redist_regions.
> 
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Ricardo Koller <ricarkol@google.com>
> ---
>  .../testing/selftests/kvm/aarch64/vgic_init.c | 34 +++++++++++++++++++
>  1 file changed, 34 insertions(+)
>

Reviewed-by: Andrew Jones <drjones@redhat.com>

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
