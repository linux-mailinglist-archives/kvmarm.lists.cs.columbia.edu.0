Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id AC1842A1837
	for <lists+kvmarm@lfdr.de>; Sat, 31 Oct 2020 15:35:42 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2E93D4B64A;
	Sat, 31 Oct 2020 10:35:42 -0400 (EDT)
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
	with ESMTP id jBUFU3zMXiHo; Sat, 31 Oct 2020 10:35:42 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1E6B94B654;
	Sat, 31 Oct 2020 10:35:41 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A712F4B62A
 for <kvmarm@lists.cs.columbia.edu>; Sat, 31 Oct 2020 10:35:39 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 21BmjqrWefpC for <kvmarm@lists.cs.columbia.edu>;
 Sat, 31 Oct 2020 10:35:38 -0400 (EDT)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id DDB164B624
 for <kvmarm@lists.cs.columbia.edu>; Sat, 31 Oct 2020 10:35:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604154938;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H0lkAu0LuB0tOs+5f8N9+fz1OpdbLPMVMxAKM8Po2Ws=;
 b=AnkGIgHkHqImsSyjqON4dnWKBBR6YJOI12a0jgbAEaQBfZhDHl+6abVRz8tG5GmbrX4HMC
 f33JQ2ishKRexCV0HhNPZ1mFuRRnBzfkahoBV3vW/pI3jlB6JoQN3nm1QiYubuz6oZItMF
 Quk1Y7FWvY6csti8zwzYKk+jVGH0M6c=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-ZxIxgxJ8OIOUP3tmpq2ZOg-1; Sat, 31 Oct 2020 10:35:34 -0400
X-MC-Unique: ZxIxgxJ8OIOUP3tmpq2ZOg-1
Received: by mail-wr1-f72.google.com with SMTP id q15so4067355wrw.8
 for <kvmarm@lists.cs.columbia.edu>; Sat, 31 Oct 2020 07:35:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:references:from:subject:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=H0lkAu0LuB0tOs+5f8N9+fz1OpdbLPMVMxAKM8Po2Ws=;
 b=Mcxy+StuUdGCHo4NcmdY/+qc/n5PR5Ek+t0ASLZronuEWEj5rDnO++Y7JNlWEkKZn4
 Iv0eX654SlkCSTE9LKKkfodMvcg0dtpxe8QDiubv16rl7zlszMwpkkG/xmlU3EzqvANi
 66RxDL0GvI9G+AddHfprIW3XjWBrp4Yes/o1H2AxpgB4+NLAG7EvAZsIc8g1LkRJ3brD
 uLvTirH5inYYM+vCvbJEjWN9mkM7qBPDhwanxjJoloem+r/funrOsTGU4Ia3rDn+cHdG
 sLt/0lwnNZyCBew2DqfA6iIQ3Zau01qzocLSw8HwMdqLDA1u5854+/qdo7HOByzqZl0I
 n59w==
X-Gm-Message-State: AOAM53157ariH8SGn1pupoSq8JOPVsxcVnNLe4NFQZpQf3FeXp5uOoVX
 25wV3Ct89H17JdwBKEUNBPWhIaH3lAdbAW5oTccj7sV1jSREaTNXe/pPl9Iyydj7T+xc61V2cbh
 FFQDmX5KXUmf6a1RGB8sx9Z27
X-Received: by 2002:adf:bc13:: with SMTP id s19mr9937625wrg.338.1604154932833; 
 Sat, 31 Oct 2020 07:35:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzRUEvE78CjaR4PD/v54GUMMq51fFQdnVnGD7YpW4KmEScBQ8r2gsS4wkXgkWdYcQLslmW02A==
X-Received: by 2002:adf:bc13:: with SMTP id s19mr9937597wrg.338.1604154932571; 
 Sat, 31 Oct 2020 07:35:32 -0700 (PDT)
Received: from [192.168.178.64] ([151.20.250.56])
 by smtp.gmail.com with ESMTPSA id c185sm8913539wma.44.2020.10.31.07.35.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 31 Oct 2020 07:35:31 -0700 (PDT)
To: Marc Zyngier <maz@kernel.org>
References: <20201030164017.244287-1-maz@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [GIT PULL] KVM/arm64 fixes for 5.10, take #1
Message-ID: <6a598342-93dd-58dc-1615-b9773605f32c@redhat.com>
Date: Sat, 31 Oct 2020 15:35:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201030164017.244287-1-maz@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: kvm@vger.kernel.org, kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, Will Deacon <will@kernel.org>,
 Qais Yousef <qais.yousef@arm.com>
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

On 30/10/20 17:40, Marc Zyngier wrote:
> Hi Paolo,
> 
> It was good to see you (and everyone else) at KVM Forum this week!
> 
> And to celebrate, here's a first batch of fixes for KVM/arm64. A bunch
> of them are addressing issues introduced by the invasive changes that
> took place in the 5.10 merge window (MM, nVHE host entry). A few
> others are addressing some older bugs (VFIO PTE mappings, AArch32
> debug, composite huge pages), and a couple of improvements
> (HYP-visible capabilities are made more robust).

Better now than later! Thanks, pulled.

Paolo

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
