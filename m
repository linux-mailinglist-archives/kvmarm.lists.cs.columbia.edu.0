Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 3969B41F271
	for <lists+kvmarm@lfdr.de>; Fri,  1 Oct 2021 18:48:14 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id BC48940762;
	Fri,  1 Oct 2021 12:48:13 -0400 (EDT)
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
	with ESMTP id 0MYVMRQwV40n; Fri,  1 Oct 2021 12:48:13 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B742B4B0BD;
	Fri,  1 Oct 2021 12:48:12 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D08D54ACC9
 for <kvmarm@lists.cs.columbia.edu>; Fri,  1 Oct 2021 12:48:10 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uVECu95on+HN for <kvmarm@lists.cs.columbia.edu>;
 Fri,  1 Oct 2021 12:48:10 -0400 (EDT)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 00F1E40762
 for <kvmarm@lists.cs.columbia.edu>; Fri,  1 Oct 2021 12:48:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1633106889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E+wXL4FLopuVdUPifEc7KhUXBKpFTStH9lCl7cgYkOQ=;
 b=LyIBMuvTTX+kDYcbw1IVMdOCEED+uGk1w/nWFW6ewR4c70jjLEIL6f3kOG/snhm0/mpIyj
 EtCuto8WWdTTdzvs5P8v87LZXMiXWFloQOEPQ9B+HiBkYt2k4W+mx2Z0jVkOqkhpdPA3dO
 xiEEJjPrlRITCl4Yd7VBQUbXa7rSTSM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-474-L_CinQP4MM-L2do7NVyHrQ-1; Fri, 01 Oct 2021 12:48:08 -0400
X-MC-Unique: L_CinQP4MM-L2do7NVyHrQ-1
Received: by mail-ed1-f69.google.com with SMTP id
 y15-20020a50ce0f000000b003dab997cf7dso7423738edi.9
 for <kvmarm@lists.cs.columbia.edu>; Fri, 01 Oct 2021 09:48:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=E+wXL4FLopuVdUPifEc7KhUXBKpFTStH9lCl7cgYkOQ=;
 b=BwH884wNrFnJMWDc4bgeq7X5LbP6pDYhaZ90KvDdsvNbMblEQS7FNNDyUnJtTJrBHT
 MRR7X9lUW9UTMpxSN3fcUfBVDoYGf7U1B0rrfmNbRz45l0BN0h/N1U3PVGj6+NV6/Ig7
 q6/yhCRhqfbVFxVHGc5gXCSuYM4+4Bm+KTuKuhsPzkpWPsAVSPKHKOhGSsmUP76qgx73
 4nRsMtWQd3TPVLTZM/2516ZQZ+EaBhwFDUnRIO9/GUXGEbNPIa5gfihBb5o7K/9qcroZ
 CSfcNpZbJUi5AlzXVeuSIFekfKgcIcwzNu5d+Kp5gvWiKVWaYuiC06d0YBJHl+GEIcKd
 UB6g==
X-Gm-Message-State: AOAM532ja5o5eukfI9Ptwa+h7yH2mF/QvQBIisOgOik21hAu3zEF6QQE
 QTusoptghl1O/0+cgVKWMTnYZJeBYfFgmid+wlxzj/UZAp7qgseP7yIfSzV7ECX37UsdH7XPxtm
 S5dYmCVOySV8CZnQ6SILdLPda
X-Received: by 2002:a50:becf:: with SMTP id e15mr15556192edk.114.1633106887591; 
 Fri, 01 Oct 2021 09:48:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyY/s9Eboq39fJzh2TN3pYZqcwpynGpENIpX504ZIFL6jL/Hkr+B3PpnPZt2v05b/8B27zGqA==
X-Received: by 2002:a50:becf:: with SMTP id e15mr15556157edk.114.1633106887363; 
 Fri, 01 Oct 2021 09:48:07 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e?
 ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id kw10sm3170950ejc.71.2021.10.01.09.48.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Oct 2021 09:48:06 -0700 (PDT)
Message-ID: <ec78c9ec-bba6-eac7-ac07-5614f0e0d709@redhat.com>
Date: Fri, 1 Oct 2021 18:48:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH v8 5/7] kvm: x86: protect masterclock with a seqcount
To: Oliver Upton <oupton@google.com>, kvm@vger.kernel.org,
 kvmarm@lists.cs.columbia.edu
References: <20210916181538.968978-1-oupton@google.com>
 <20210916181538.968978-6-oupton@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20210916181538.968978-6-oupton@google.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Peter Shier <pshier@google.com>, Marc Zyngier <maz@kernel.org>,
 David Matlack <dmatlack@google.com>, linux-arm-kernel@lists.infradead.org,
 Jim Mattson <jmattson@google.com>
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

On 16/09/21 20:15, Oliver Upton wrote:
> +	seq = read_seqcount_begin(&ka->pvclock_sc);
> +	do {
> +		use_master_clock = ka->use_master_clock;

Oops, the "seq" assignment should be inside the "do".  With that fixed, 
my tests seem to work.  I will shortly push the result to kvm/queue.

Paolo

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
