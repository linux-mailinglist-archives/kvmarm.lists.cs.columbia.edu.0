Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id DA9CD48F21F
	for <lists+kvmarm@lfdr.de>; Fri, 14 Jan 2022 22:51:30 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1D8CE49EC5;
	Fri, 14 Jan 2022 16:51:29 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.912
X-Spam-Level: 
X-Spam-Status: No, score=0.912 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_BLOCKED=0.001,
	T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nvWXLw0vntP0; Fri, 14 Jan 2022 16:51:28 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id BC55D49DFF;
	Fri, 14 Jan 2022 16:51:27 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 4502149DFF
 for <kvmarm@lists.cs.columbia.edu>; Fri, 14 Jan 2022 16:51:26 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jgr1xl16dYBG for <kvmarm@lists.cs.columbia.edu>;
 Fri, 14 Jan 2022 16:51:25 -0500 (EST)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 20A7649DE3
 for <kvmarm@lists.cs.columbia.edu>; Fri, 14 Jan 2022 16:51:25 -0500 (EST)
Received: by mail-pl1-f182.google.com with SMTP id a7so11464487plh.1
 for <kvmarm@lists.cs.columbia.edu>; Fri, 14 Jan 2022 13:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=CDsGS2jq8SAFd9OvPx49AGjFg/2s2ed5RyEVXzRWnAo=;
 b=cfjpva8bdcPLTTQoIPCixVnAFaxsDELlb/9JwStbXYQvRDZGYhfWD3/1KeCmYuq1Yy
 IupWGk+fR/uoJLiecnN6JvPjTin7H2Hska91lSfi0kRro7XHjZ6Rzw5/PBWb3KmK74HI
 6pCTKoDjaCjUtQcw4EmIb5Vfnyj3Gkuo0vj2jqbXi6WAKriAHyY1Sgq+jO+4eA5weoen
 ZrIWRe1oHnOOA/6QybWEb2IdUiv7mV9Bj9zx4zNCcwBb//Iynkc59wxBPmD0p9oUP07a
 L+eJCdTyRQg1pRPFhhLwPjoPg8fhQ884XaKcHU6+jI7Zd1mjfSkV4huFnNNCOGyPSI2t
 Jc6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=CDsGS2jq8SAFd9OvPx49AGjFg/2s2ed5RyEVXzRWnAo=;
 b=Z6mNqc4/MPjbf3oF9s9azjK5R6TpdXwb977NNeK14ISCkCNC1Dfc/0T/MOfTdaqGPq
 jOEy/z/kSE83FT6ziJs8XLJFYt8TyzNq3psIw23S/QmAIlHFtMToLyoztrbAMAYvfhrf
 VsPR112g9fpYosPLfbZugTuHxBxLbQlce168mOM2yNeKIjg73QC/uEsV6P8u371sxEHM
 tlUCcgaKyKyimkoFEjR2A5npM1gj9EfFfZITMvPgZebGSE36rkpMOf8t6ie/tqxl8POf
 duwAavVcTyOB4UE4SbzsHUezxtL2TKNuOjo2xft8BtqKb3oUSgMUsGbYQFl1d053yW3x
 ngIw==
X-Gm-Message-State: AOAM531qdRrK6tSi2imgN/0Jsmf8tvxfodDfAFDbQ/KGurpdcR83Bo13
 K9mvgxfD8QJ/EPkG/fSTRTvvNncXB2gUz3FbJKQ8jw==
X-Google-Smtp-Source: ABdhPJxoOISTy68Z7laSCPjCr0YLWiNLl+ousUKcH2g0/tuXUHAGX63U2SWCQe4kEq9CrnNG7uifRtzx5bVqMY3fqWc=
X-Received: by 2002:a17:902:ea10:b0:14a:6c29:a6a5 with SMTP id
 s16-20020a170902ea1000b0014a6c29a6a5mr11540567plg.172.1642197084066; Fri, 14
 Jan 2022 13:51:24 -0800 (PST)
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
From: Reiji Watanabe <reijiw@google.com>
Date: Fri, 14 Jan 2022 13:51:07 -0800
Message-ID: <CAAeT=Fz2q4PfJMXes3A9f+c01NnyORbvUrzJZO=ew-LsjPq2jQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 01/11] KVM: Capture VM start
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 Peter Shier <pshier@google.com>, linux-kernel@vger.kernel.org,
 Marc Zyngier <maz@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
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

The pseudo firmware hvc registers, which this series are adding, are
used by KVM to identify available hvc features for the guest, and not
directly exposed to the guest as registers.
The ways the KVM code in the series consumes the registers' values are
very limited, and no KVM data/state is created based on their values.
But, as the code that consumes the registers grows in the future,
I wouldn't be surprised if KVM consumes them differently than it does
now (e.g. create another data structure based on the register values).
I'm not sure though :)

The restriction, with which KVM doesn't need to worry about the changes
in the registers after KVM_RUN, could potentially protect or be useful
to protect KVM and simplify future changes/maintenance of the KVM codes
that consumes the values.
I thought this was one of the reasons for having the restriction.

Thanks,
Reiji
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
