Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 5658148AAB3
	for <lists+kvmarm@lfdr.de>; Tue, 11 Jan 2022 10:41:00 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CFFA24B231;
	Tue, 11 Jan 2022 04:40:59 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.912
X-Spam-Level: 
X-Spam-Status: No, score=0.912 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	DNS_FROM_AHBL_RHSBL=2.699, FREEMAIL_FROM=0.001, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@gmail.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id X9SUb+MFZSqz; Tue, 11 Jan 2022 04:40:59 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id AC4C54B1EC;
	Tue, 11 Jan 2022 04:40:58 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E85FE4B15E
 for <kvmarm@lists.cs.columbia.edu>; Tue, 11 Jan 2022 04:40:56 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IJ7hGAEMUkc0 for <kvmarm@lists.cs.columbia.edu>;
 Tue, 11 Jan 2022 04:40:55 -0500 (EST)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id D729B4B134
 for <kvmarm@lists.cs.columbia.edu>; Tue, 11 Jan 2022 04:40:55 -0500 (EST)
Received: by mail-pj1-f46.google.com with SMTP id
 g11-20020a17090a7d0b00b001b2c12c7273so1589584pjl.0
 for <kvmarm@lists.cs.columbia.edu>; Tue, 11 Jan 2022 01:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=29eYrea5TDtnK5EIdmX1Jj/oj6JLKnkcWRIn4vZIh5c=;
 b=RD5XB8O2H5sDfMBSzLDqjPQ6w8nUiKM4fPElrmz1ywPkPhbTgt9w/fBGAZ6MWRAkBG
 AMv6BOonqA8uAyAac6tIA2pz8kslC2OiCWkhe7dHJXTl4Il5s3CW24pECot9fJH8TXG2
 U+JhWUsGAYpjCpjUlEABLiV/kbuZw9R9QyCaz0bPBFvRDZemd78bHj2zwqLnzeTMMkF4
 GfYnzt63Io59m6xdTWLMILLJK/Z6j68B7Z6ZrIJTO/rKrxT3s6qLbvzG8rnw9EgOBGOd
 MwnLOBtvD0wPnYiHLzbPiB4zpBoQ2y/GilmaF1BjxgjxaBIw8ck+73wqWZoGKCkf86ee
 7pTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=29eYrea5TDtnK5EIdmX1Jj/oj6JLKnkcWRIn4vZIh5c=;
 b=s3BTgKRlvaUXpEcUxOhNHyPizoRdpAd3AR/qpdHy3Gdn7XhrZ/X6Z+ofbiL10UDU0l
 fDdnjABRgaiu27YF6o0e1+ea538Dzj9NuTuQ5DeaVLyKvsyDH2kKQnrZu4iEc1izWPCC
 lltVUdEZlAYR7ICoprDWpIkwDSRrQuBQhmE6unGAgYthL3hTCgjLO8YVOgRFaCo1ghnp
 F9hPNs3SWcdVdtDyxhpp4uPSruKpARzL5kc3xWk3fZeKJ7+hzv4qt2r9cfZJm0rrIAmF
 YCXBWyYaUiZKwFvXNPWlLmXV93TO0JPvfXeh8vPwTwx8q8RhPsznlA1T3RzKE9+0H2eV
 7g4Q==
X-Gm-Message-State: AOAM533vuv0nIxjPrHidDrJD1uisJNBBsYL1B3WtH5aHFuuG+54+cc7n
 jTUCy/J5JtuyvsMszMTKHSI=
X-Google-Smtp-Source: ABdhPJy4DNY+E2ONe6nBqviW4EdiG118126QljAAFfPBhjQJAPp+0nuqGn10nq9mOvyxudbM4wYNAg==
X-Received: by 2002:a63:6e87:: with SMTP id j129mr3340098pgc.572.1641894055129; 
 Tue, 11 Jan 2022 01:40:55 -0800 (PST)
Received: from [30.43.104.246] ([47.89.83.37])
 by smtp.gmail.com with ESMTPSA id x29sm919279pfh.175.2022.01.11.01.40.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Jan 2022 01:40:54 -0800 (PST)
Message-ID: <89165079-d2a6-fad8-3a9c-dcb46a8acdc7@gmail.com>
Date: Tue, 11 Jan 2022 17:40:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v4 02/21] KVM: arm64: Add SDEI virtualization
 infrastructure
Content-Language: en-US
To: Gavin Shan <gshan@redhat.com>, kvmarm@lists.cs.columbia.edu
References: <20210815001352.81927-1-gshan@redhat.com>
 <20210815001352.81927-3-gshan@redhat.com>
From: Shannon Zhao <shannon.zhaosl@gmail.com>
In-Reply-To: <20210815001352.81927-3-gshan@redhat.com>
Cc: maz@kernel.org, pbonzini@redhat.com, will@kernel.org,
 linux-kernel@vger.kernel.org, Jonathan.Cameron@huawei.com
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



On 2021/8/15 8:13, Gavin Shan wrote:
> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index e9a2b8f27792..2f021aa41632 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -150,6 +150,8 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
>   
>   	kvm_vgic_early_init(kvm);
>   
> +	kvm_sdei_init_vm(kvm);
> +
>   	/* The maximum number of VCPUs is limited by the host's GIC model */
>   	kvm->arch.max_vcpus = kvm_arm_default_max_vcpus();
Hi, Is it possible to let user space to choose whether enabling SEDI or 
not rather than enable it by default?
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
