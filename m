Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 2892D48E1A4
	for <lists+kvmarm@lfdr.de>; Fri, 14 Jan 2022 01:42:39 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 65F5F49F17;
	Thu, 13 Jan 2022 19:42:38 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.911
X-Spam-Level: 
X-Spam-Status: No, score=0.911 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	DNS_FROM_AHBL_RHSBL=2.699, T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001]
	autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id y79945zfalSp; Thu, 13 Jan 2022 19:42:38 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3E4B749F3E;
	Thu, 13 Jan 2022 19:42:37 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 3093849F1C
 for <kvmarm@lists.cs.columbia.edu>; Thu, 13 Jan 2022 19:42:36 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mvfH8uAYSBgl for <kvmarm@lists.cs.columbia.edu>;
 Thu, 13 Jan 2022 19:42:35 -0500 (EST)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com
 [209.85.219.179])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 1651049F17
 for <kvmarm@lists.cs.columbia.edu>; Thu, 13 Jan 2022 19:42:35 -0500 (EST)
Received: by mail-yb1-f179.google.com with SMTP id c6so19935137ybk.3
 for <kvmarm@lists.cs.columbia.edu>; Thu, 13 Jan 2022 16:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=icBlwwG2S2E04P2qTRk86rIfnSaHc8RFayb+HCWMsy8=;
 b=tKuXvh3Jl6y3jS3nNpMOtk5TYed9in2+9l0MQDWeBPTgmc9SfhBhxTcP+2aSyAp96d
 6Iuq865Zw7Rv6MeKqikBZeELMIR3n1NXcsa49mOnzXgLfaBe2NVGgJGlfwI+8ti9Gmna
 PTbc/eW26Nz3E3gyxZf+B2y6zSNCWJ9SQz6us+FTQFdkT5aLcAXPU3xX6/bhFErjBd8W
 XcCBIxd+0ZDk0DQpEt4x+iNtipwd6dDLD40i1xllnZ1fsSbTiuARx8VsDYRj+5WdiBen
 nZBCp+ypPa5GJ11ow81b7st46ISyajSOqdIv4ZoUhDBN3yzG7OfkEKaFm5mGxaViCAWZ
 I7TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=icBlwwG2S2E04P2qTRk86rIfnSaHc8RFayb+HCWMsy8=;
 b=He69WRnMGwqw41Mp/IgHVyCeat1Qf2bgzZZfNK9uwS0PHIn+FZIFMYOxmyFoH85B74
 q/xix5wLOtw/sJNTrecKkX6apuBegBOuKb/6dsBvD3qk3OkI9NvhvMa6XMoez+APH9tu
 GknCFgZEWUMl+DYxMrw1ndC4f9lyjbZy6Cs46MxTFf5nU/hI+WV0IKZ2MjClNpshFR4z
 0vqGTBgUkHFXmAotYo8ULet3vNlCDRn+RnmYUntvsQw+cyvJC3Ghm8LZ/plyfV6Bz2ko
 3Y96ckRn05UJHggd6Klv1A/1IWcDOkJohRsOMQgG3v+/QcCz6LZTGGE+CcfSOnxxrO1E
 QWkw==
X-Gm-Message-State: AOAM533iunzzQa2VGnJWiEtPT5KByGGoQMFK9D4iNCK77ag1HJdlD+9C
 ZXBotCKi13GyBQJ0oj/wAgweFQRLQoEjIjdwxpnRfw==
X-Google-Smtp-Source: ABdhPJzA5ysrjGHDfSMMHKV/CX9xt6B+hEhmXIe4BPrNn8IqXhCDlvsfXi2BIWVHktBVEEvOLNqxRSnYpiZnTbZ78qg=
X-Received: by 2002:a25:d801:: with SMTP id p1mr6233026ybg.543.1642120954230; 
 Thu, 13 Jan 2022 16:42:34 -0800 (PST)
MIME-Version: 1.0
References: <20220104194918.373612-1-rananta@google.com>
 <20220104194918.373612-2-rananta@google.com>
 <CAAeT=Fxyct=WLUvfbpROKwB9huyt+QdJnKTaj8c5NKk+UY51WQ@mail.gmail.com>
 <CAJHc60za+E-zEO5v2QeKuifoXznPnt5n--g1dAN5jgsuq+SxrA@mail.gmail.com>
 <CALMp9eQDzqoJMck=_agEZNU9FJY9LB=iW-8hkrRc20NtqN=gDA@mail.gmail.com>
 <CAJHc60xZ9emY9Rs9ZbV+AH-Mjmkyg4JZU7V16TF48C-HJn+n4A@mail.gmail.com>
 <CALMp9eTPJZDtMiHZ5XRiYw2NR9EBKSfcP5CYddzyd2cgWsJ9hw@mail.gmail.com>
 <CAJHc60xD2U36pM4+Dq3yZw6Cokk-16X83JHMPXj4aFnxOJ3BUQ@mail.gmail.com>
 <CALMp9eR+evJ+w9VTSvR2KHciQDgTsnS=bh=1OUL4yy8gG6O51A@mail.gmail.com>
 <CAJHc60zw1o=JdUJ+sNNtv3mc_JTRMKG3kPp=-cchWkHm74hUYA@mail.gmail.com>
 <YeBfj89mIf8SezfD@google.com>
In-Reply-To: <YeBfj89mIf8SezfD@google.com>
From: Raghavendra Rao Ananta <rananta@google.com>
Date: Thu, 13 Jan 2022 16:42:23 -0800
Message-ID: <CAJHc60wRrgnvwqPWdXdvoqT0V9isXW5xH=btgdjPWQkqVW31Pw@mail.gmail.com>
Subject: Re: [RFC PATCH v3 01/11] KVM: Capture VM start
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
 Peter Shier <pshier@google.com>, linux-kernel@vger.kernel.org,
 Catalin Marinas <catalin.marinas@arm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

On Thu, Jan 13, 2022 at 9:21 AM Sean Christopherson <seanjc@google.com> wrote:
>
> On Wed, Jan 12, 2022, Raghavendra Rao Ananta wrote:
> > On Tue, Jan 11, 2022 at 11:16 AM Jim Mattson <jmattson@google.com> wrote:
> > > Perhaps it would help if you explained *why* you are doing this. It
> > > sounds like you are either trying to protect against a malicious
> > > userspace, or you are trying to keep userspace from doing something
> > > stupid. In general, kvm only enforces constraints that are necessary
> > > to protect the host. If that's what you're doing, I don't understand
> > > why live migration doesn't provide an end-run around your protections.
> > It's mainly to safeguard the guests. With respect to migration, KVM
> > and the userspace are collectively playing a role here. It's up to the
> > userspace to ensure that the registers are configured the same across
> > migrations and KVM ensures that the userspace doesn't modify the
> > registers after KVM_RUN so that they don't see features turned OFF/ON
> > during execution. I'm not sure if it falls into the definition of
> > protecting the host. Do you see a value in adding this extra
> > protection from KVM?
>
> Short answer: probably not?
>
> There is precedent for disallowing userspace from doing stupid things, but that's
> either for KVM's protection (as Jim pointed out), or because KVM can't honor the
> change, e.g. x86 is currently in the process of disallowing most CPUID changes
> after KVM_RUN because KVM itself consumes the CPUID information and KVM doesn't
> support updating some of it's own internal state (because removing features like
> GB hugepage support is nonsensical and would require a large pile of complicated,
> messy code).
>
> Restricing CPUID changes does offer some "protection" to the guest, but that's
> not the goal.  E.g. KVM won't detect CPUID misconfiguration in the migration
> case, and trying to do so is a fool's errand.
>
> If restricting updates in the arm64 is necessary to ensure KVM provides sane
> behavior, then it could be justified.  But if it's purely a sanity check on
> behalf of the guest, then it's not justified.
Agreed that KVM doesn't really safeguard the guests, but just curious,
is there really a downside in adding this thin layer of safety check?
On the bright side, the guests would be safe, and it could save the
developers some time in hunting down the bugs in this path, no?

Regards,
Raghavendra
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
