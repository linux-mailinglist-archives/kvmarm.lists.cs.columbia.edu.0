Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 56CEA2D48F5
	for <lists+kvmarm@lfdr.de>; Wed,  9 Dec 2020 19:28:10 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D3AF24B1AA;
	Wed,  9 Dec 2020 13:28:09 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.909
X-Spam-Level: 
X-Spam-Status: No, score=0.909 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699,
	RCVD_IN_DNSWL_NONE=-0.0001, T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@linaro.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tP1DT973POo7; Wed,  9 Dec 2020 13:28:09 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B806C4B175;
	Wed,  9 Dec 2020 13:28:08 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 69D9B4B137
 for <kvmarm@lists.cs.columbia.edu>; Wed,  9 Dec 2020 13:28:07 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lpTNh1ntAMkm for <kvmarm@lists.cs.columbia.edu>;
 Wed,  9 Dec 2020 13:28:06 -0500 (EST)
Received: from mail-oi1-f196.google.com (mail-oi1-f196.google.com
 [209.85.167.196])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 59ABA4B11C
 for <kvmarm@lists.cs.columbia.edu>; Wed,  9 Dec 2020 13:28:06 -0500 (EST)
Received: by mail-oi1-f196.google.com with SMTP id d189so2717488oig.11
 for <kvmarm@lists.cs.columbia.edu>; Wed, 09 Dec 2020 10:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=EMdXn/we+ASAb31gRQdJr6+sKTP4Qjrqm7l5vM7/2N0=;
 b=uBjDfzU8tJe6+V30aOzUET0Fi/1DWGtprJdABI/JEt+ZE2s94Y30fhKOBxmqCUuDeF
 fCcuThp2wkHoxOI9GJmd/AiRPoHa0OZCK5WvKsYdMHLxuoZqZkPae4ik5Rs50LTv7UeP
 WBe9p+LoNI1L76wVobsLQC868+hlmkTN5wIhYZYSXca0eIiTDq7OWBi6ZpodCQNmeqSp
 f9iV5sMKIXZ7cde2m1WxX3kjYqxldYCrtpw2IF15hMkzldHDeUBuifaPwEl/hkntsmNy
 KxRuzDUyZHihNDp5TVjZ9G5WE5RYOOhQgQS2IIcd5F33cWzTIOb/CxOyKXAwwGHpqBlh
 CLpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=EMdXn/we+ASAb31gRQdJr6+sKTP4Qjrqm7l5vM7/2N0=;
 b=IpSiitldVCeKRm5kYYlwRC3olH9tlCfZRrhrppx1cmio8h7G27cd3pEoeJu/sNkuT7
 yqyu3GygYCRXPqMP9OiK8g7e7hph4Bj2xUQPA2cdOnwio8815XwhikVBcHhB6K3UaBl5
 QAxnylqchTogTWcd8y9Vyk0AEktCBkEDPKeQNsU2fZTR7r9b66s8whCQV+xJzoPBrsS+
 02vFmVycRtyN8UsJ3fflI8XjB00zVBVlOp+aTwFRTBF0mg6PHfvinATGFnX7k4Hbfhtk
 kdXf/eTEV6gZDAojLDt7TxnMHnO1kGyOMASdL3DPEinO6Sl/0IjDxrg0oIhFZQKaO8cd
 sF0g==
X-Gm-Message-State: AOAM533z3ykfP9gm/uZd3rMM+7ekjivdBaDS06wlq/K9pBNdml/Jji1u
 +5XEeqdAig6AF0zfYt5hnbIaIg==
X-Google-Smtp-Source: ABdhPJwXF7F87GnE1UfMS2EBOABWhLPgRg1PmpgpVMqLuUiQHVmPOMnB+cm8yzRRg6ho4iiOn74A4w==
X-Received: by 2002:aca:5889:: with SMTP id m131mr2737051oib.41.1607538485699; 
 Wed, 09 Dec 2020 10:28:05 -0800 (PST)
Received: from [10.10.121.52] (fixed-187-189-51-144.totalplay.net.
 [187.189.51.144])
 by smtp.gmail.com with ESMTPSA id k5sm461045oot.30.2020.12.09.10.28.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Dec 2020 10:28:04 -0800 (PST)
Subject: Re: [PATCH v5 0/2] MTE support for KVM guest
To: Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>
References: <46fd98a2-ee39-0086-9159-b38c406935ab@arm.com>
 <CAFEAcA_Q8RSB-zcS8+cEfvWz_0U5GLzmsf12m_7BFjX8h-1hrA@mail.gmail.com>
 <b975422f-14fd-13b3-c8ca-e8b1a68c0837@arm.com>
 <0d0eb6da6a11f76d10e532c157181985@kernel.org> <20201207163405.GD1526@gaia>
 <874kkx5thq.wl-maz@kernel.org> <20201208172143.GB13960@gaia>
 <7ff14490e253878d0735633b792e1ea9@kernel.org> <20201209124443.GB13566@gaia>
 <ef14a5158fc65c00f6c3c842cfa83b2c@kernel.org> <20201209152741.GC13566@gaia>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8c39b104-39c3-7cca-82b9-2e47d7cb9a9a@linaro.org>
Date: Wed, 9 Dec 2020 12:27:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201209152741.GC13566@gaia>
Content-Language: en-US
Cc: Juan Quintela <quintela@redhat.com>, Dave Martin <Dave.Martin@arm.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
 arm-mail-list <linux-arm-kernel@lists.infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Steven Price <steven.price@arm.com>,
 Will Deacon <will@kernel.org>, kvmarm <kvmarm@lists.cs.columbia.edu>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
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

On 12/9/20 9:27 AM, Catalin Marinas wrote:
> On Wed, Dec 09, 2020 at 01:25:18PM +0000, Marc Zyngier wrote:
>> Would this syscall operate on the guest address space? Or on the VMM's
>> own mapping?
...
> Whatever is easier for the VMM, I don't think it matters as long as the
> host kernel can get the actual physical address (and linear map
> correspondent). Maybe simpler if it's the VMM address space as the
> kernel can check the access permissions in case you want to hide the
> guest memory from the VMM for other reasons (migration is also off the
> table).

Indeed, such a syscall is no longer specific to vmm's and may be used for any
bulk move of tags that userland might want.

> Without syscalls, an option would be for the VMM to create two mappings:
> one with PROT_MTE for migration and the other without for normal DMA
> etc. That's achievable using memfd_create() or shm_open() and two mmap()
> calls, only one having PROT_MTE. The VMM address space should be
> sufficiently large to map two guest IPAs.

I would have thought that the best way is to use TCO, so that we don't have to
have dual mappings (and however many MB of extra page tables that might imply).


r~
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
