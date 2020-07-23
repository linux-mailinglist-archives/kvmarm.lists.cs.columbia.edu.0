Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 6844122D823
	for <lists+kvmarm@lfdr.de>; Sat, 25 Jul 2020 16:28:00 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id DF83E4B693;
	Sat, 25 Jul 2020 10:27:59 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.911
X-Spam-Level: 
X-Spam-Status: No, score=0.911 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	DNS_FROM_AHBL_RHSBL=2.699, FREEMAIL_FROM=0.001,
	RCVD_IN_DNSWL_NONE=-0.0001, T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@gmail.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2KpfprtwRB-V; Sat, 25 Jul 2020 10:27:59 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9FA564B68E;
	Sat, 25 Jul 2020 10:27:58 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id DE34E4B122
 for <kvmarm@lists.cs.columbia.edu>; Thu, 23 Jul 2020 11:59:37 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7g9oCVE4ezk4 for <kvmarm@lists.cs.columbia.edu>;
 Thu, 23 Jul 2020 11:59:36 -0400 (EDT)
Received: from mail-qt1-f193.google.com (mail-qt1-f193.google.com
 [209.85.160.193])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id C92C04B11B
 for <kvmarm@lists.cs.columbia.edu>; Thu, 23 Jul 2020 11:59:36 -0400 (EDT)
Received: by mail-qt1-f193.google.com with SMTP id e12so4739524qtr.9
 for <kvmarm@lists.cs.columbia.edu>; Thu, 23 Jul 2020 08:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=2EtxXZTz1kWJ0O2qTRyRyFGBjpXTKARYoyOSnP+i+Z8=;
 b=VJOz/w2ybxBPDrWIucdRYvA/77lMC2/FtrhIlZAdU9I2iWr+k05fQkXhmW6/gHmMBI
 fPGi0hVS8Q2oNReoMRsf5TMZGWAkU+BAwL3shApQsP7X2RUSBCkngA8mfmGEfhVc4gI1
 HHtuf8I0aJSr6RnGJ7RVYgJwzoPbLour7hSbzfIGLMzoUM1zjp0jQcNlD0O9oQC97Gsi
 cLsXUnH/e4mAW/th0+cLZdRjXRTW86gXySMbDMrYeyPlZy1Hdtk2wv5znnc4CzaHxNLx
 pM7Wa+xwhOnOR4Sce/ht00bCm4CF1gys0Yp5wuSO+wr52pcpxnEot5xpwqvAJJEJ2hml
 0zlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=2EtxXZTz1kWJ0O2qTRyRyFGBjpXTKARYoyOSnP+i+Z8=;
 b=Qf+5zzPb9bO+UNdFiZfevAPTUdrtYHdVv7VHOUWPh18nCa/EDPNB7R0lm9BZkjkVGM
 hJV+h3WGeyyZIsw0/PdupD84QLM9ZKvGbeaJ/OOH3tSrB2c0KMasifJllv3Q/nc1h6gE
 27QmcX3+CRUeGm1LDPKL0moYYLkMLo/8KuHdFvQgu+cpVsudEaotfge17NW4V0VZgosy
 mzUASC4yQg9uTXxaj65CZ6s+UTK5khG7/pkjoaHuNvPD/UPR2LemCEM9yTBTcu5jYTXe
 DD1SStNYqW/TqxFXDxKXMJHc8Nkz0Vlb2VH9nLPC0nr4Wz26troglVA0XblM4Uiburnp
 +vkA==
X-Gm-Message-State: AOAM531GLYk+T23m1M5WvHZD0hroDWrsXmSwUDTpUmRvhkd/z9bII+Z8
 WyTOlT4urGpmsnuVCKTV5lo=
X-Google-Smtp-Source: ABdhPJxN1siVEMQTxmAZmPE5w2CdYkPu1C7QJuy61MtFQ71rjCZxMEOLNGHX4IkN9Sarmpsnt1p9Nw==
X-Received: by 2002:ac8:345c:: with SMTP id v28mr4912521qtb.171.1595519976114; 
 Thu, 23 Jul 2020 08:59:36 -0700 (PDT)
Received: from ubuntu-n2-xlarge-x86 ([2604:1380:45d1:2600::1])
 by smtp.gmail.com with ESMTPSA id v58sm1841331qtj.56.2020.07.23.08.59.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2020 08:59:35 -0700 (PDT)
Date: Thu, 23 Jul 2020 08:59:34 -0700
From: Nathan Chancellor <natechancellor@gmail.com>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH] KVM: arm64: Prevent vcpu_has_ptrauth from generating OOL
 functions
Message-ID: <20200723155934.GA3929837@ubuntu-n2-xlarge-x86>
References: <20200722162231.3689767-1-maz@kernel.org>
 <20200723025142.GA361584@ubuntu-n2-xlarge-x86>
 <0fab73670fa24d1c08711991133e4255@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0fab73670fa24d1c08711991133e4255@kernel.org>
X-Mailman-Approved-At: Sat, 25 Jul 2020 10:27:57 -0400
Cc: kvm@vger.kernel.org, kernel-team@android.com,
 Nick Desaulniers <ndesaulniers@google.com>,
 linux-arm-kernel@lists.infradead.org, Will Deacon <will@kernel.org>,
 kvmarm@lists.cs.columbia.edu
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

On Thu, Jul 23, 2020 at 09:17:15AM +0100, Marc Zyngier wrote:
> Hi Nathan,
> 
> On 2020-07-23 03:51, Nathan Chancellor wrote:
> > On Wed, Jul 22, 2020 at 05:22:31PM +0100, Marc Zyngier wrote:
> > > So far, vcpu_has_ptrauth() is implemented in terms of
> > > system_supports_*_auth()
> > > calls, which are declared "inline". In some specific conditions (clang
> > > and SCS), the "inline" very much turns into an "out of line", which
> > > leads to a fireworks when this predicate is evaluated on a non-VHE
> > > system (right at the beginning of __hyp_handle_ptrauth).
> > > 
> > > Instead, make sure vcpu_has_ptrauth gets expanded inline by directly
> > > using the cpus_have_final_cap() helpers, which are __always_inline,
> > > generate much better code, and are the only thing that make sense when
> > > running at EL2 on a nVHE system.
> > > 
> > > Fixes: 29eb5a3c57f7 ("KVM: arm64: Handle PtrAuth traps early")
> > > Reported-by: Nathan Chancellor <natechancellor@gmail.com>
> > > Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> > > Signed-off-by: Marc Zyngier <maz@kernel.org>
> > 
> > Thank you for the quick fix! I have booted a mainline kernel with this
> > patch with Shadow Call Stack enabled and verified that using KVM no
> > longer causes a panic.
> 
> Great! I'll try and ferry this to mainline  as quickly as possible.

Awesome, I will keep an eye out.

> > Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
> > Tested-by: Nathan Chancellor <natechancellor@gmail.com>
> > 
> > For the future, is there an easy way to tell which type of system I am
> > using (nVHE or VHE)? I am new to the arm64 KVM world but it is something
> > that I am going to continue to test with various clang technologies now
> > that I have actual hardware capable of it that can run a mainline
> > kernel.
> 
> ARMv8.0 CPUs are only capable of running non-VHE. So if you have
> something based on older ARM CPUs (such as A57, A72, A53, A73, A35...),
> or licensee CPUs (ThunderX, XGene, EMag...), this will only run
> non-VHE (the host kernel runs at EL1, while the hypervisor runs at
> EL2.
> 
> From ARMv8.1 onward, VHE is normally present, and the host kernel
> can run at EL2 directly. ARM CPUs include A55, A65, A75, A76, A77,
> N1, while licensee CPUs include TX2, Kunpeng 920, and probably some
> more.
> 
> As pointed out by Zenghui in another email, KVM shows which mode
> it is using. Even without KVM, the kernel prints very early on:
> 
> [    0.000000] CPU features: detected: Virtualization Host Extensions
> 
> Note that this is only a performance difference, and that most
> features that are supported by the CPU can be used by KVM in either
> mode.
> 
> Thanks again,
> 
>         M.
> -- 
> Jazz is not dead. It just smells funny...

Excellent, thank you both for the in-depth explanation. Hopefully my
test farm continues to grow so I can stay on top of testing this stuff.

Cheers,
Nathan
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
