Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id C07872D557D
	for <lists+kvmarm@lfdr.de>; Thu, 10 Dec 2020 09:31:47 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 75D5B4B1BE;
	Thu, 10 Dec 2020 03:31:47 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.91
X-Spam-Level: 
X-Spam-Status: No, score=0.91 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mpwQb788LOex; Thu, 10 Dec 2020 03:31:47 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1BE234B1B9;
	Thu, 10 Dec 2020 03:31:46 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 52BFE4B16E
 for <kvmarm@lists.cs.columbia.edu>; Wed,  9 Dec 2020 20:39:54 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZMFMOBVgDiWx for <kvmarm@lists.cs.columbia.edu>;
 Wed,  9 Dec 2020 20:39:53 -0500 (EST)
Received: from mail-qk1-f194.google.com (mail-qk1-f194.google.com
 [209.85.222.194])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 1368A4B11E
 for <kvmarm@lists.cs.columbia.edu>; Wed,  9 Dec 2020 20:39:53 -0500 (EST)
Received: by mail-qk1-f194.google.com with SMTP id 143so3399410qke.10
 for <kvmarm@lists.cs.columbia.edu>; Wed, 09 Dec 2020 17:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=UkkzP/3Zui9Zv09UQ8xwBLPz4oeTJ7sNlMALQGeGM70=;
 b=hCANu9k4ewHIF7sm5Uv/kEc/lz/9YpR/XMKI5w/v0gDeaUr9s2G3suJ+K31I9aK4ke
 GpbwzxUQd2O9XsJ5ZFD8daBsFSjz7gxo0faf8kjkYNxhH279uSM6U84NC32MIjJ+QfXh
 T/XWR0E9bxf2f8kCvbN38k2SSSh2H4AEY6f6jIOgxDrBAeJTTMic3owOqzu+XfP6b+1Q
 IHdsAAvj0Uu3zkEPHUqkaypul6c96gmzXhhKztpKXAp4jIvwIxq6q4DM9kTAW1zUiW2l
 6JIdGjevbyBTvKXoMO6Y+41+zX7sakqulVCN3Jt81e1jxiYesfoq1vXj2vUpUIbDDOmF
 IAvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UkkzP/3Zui9Zv09UQ8xwBLPz4oeTJ7sNlMALQGeGM70=;
 b=cPJM1rVl/81GmAxIT9sjaA03h85DbmjW3/z/4l1d4bFyX1PurBEGT8gl7kLgHViRWy
 SCi3PtqxfOT+g4A5EcguWMmWkW8w3rS3s1luR2Iiu6xQYcuLwJfib3nUFW7coyZcDz38
 mUaMmlfWyg5gty39hLB6OpUi/6EO349Pn4NueNcAKvKAl0rD23blFv/oTjc2CHJ8TQsU
 o9FJFGg39HK91viNqErSz3jdC2ReAUrxJffPIbzrcRXQMvzK47yiufLzlCsvwwRvj/wq
 hcVe9A5/Zyz7+bHmYL5nIgxR0CgniVHNAApmbkxm8GSqRC6yc3+hi5mNC4lU5j4jypqG
 n2XQ==
X-Gm-Message-State: AOAM533HhgcK3heK0v0tt82/9T0VpZ5LqHCiDYlTwOVkiO5UwkdcqaRx
 MrYITURlLcOi79QQXMjnVfcDlHRJd4GtGM7DRuMR7Q==
X-Google-Smtp-Source: ABdhPJwwtzbyx8dv0A/bOYjE3eOzs3Dzd25CeqEwi5hkYuP378MTpDXYUPC+uMy3SAH/E3OYSul0Sai4Dwdkz425wO0=
X-Received: by 2002:a05:620a:805:: with SMTP id
 s5mr6444986qks.80.1607564392357; 
 Wed, 09 Dec 2020 17:39:52 -0800 (PST)
MIME-Version: 1.0
References: <20200721041742.197354-1-sergey.senozhatsky@gmail.com>
 <20200817020310.GA1210848@jagdpanzerIV.localdomain>
 <fe72592c-c721-bece-1469-95eebf931299@huawei.com>
 <cbcfb402b7fdb8a2a45b80fbb0e79f3e@kernel.org>
 <20200911085841.GB562@jagdpanzerIV.localdomain>
 <CAJWu+oq26OK1-7Ze2pb5xpRJ-tS9wtXOdGFrYpHq+fhkyGhjkA@mail.gmail.com>
 <fdc35e25f2bc2cdfa0849a84802eafd6@kernel.org>
In-Reply-To: <fdc35e25f2bc2cdfa0849a84802eafd6@kernel.org>
From: Joel Fernandes <joelaf@google.com>
Date: Wed, 9 Dec 2020 20:39:41 -0500
Message-ID: <CAJWu+ooy=r=G+AnyriQDA9_4CJqfO6hkf=c8heV8HV+yNea_PQ@mail.gmail.com>
Subject: Re: [RFC][PATCH 0/4] arm64:kvm: teach guest sched that VCPUs can be
 preempted
To: Marc Zyngier <maz@kernel.org>
X-Mailman-Approved-At: Thu, 10 Dec 2020 03:31:44 -0500
Cc: LKML <linux-kernel@vger.kernel.org>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 Suleiman Souhlal <suleiman@google.com>, Will Deacon <will@kernel.org>,
 kvmarm@lists.cs.columbia.edu,
 "moderated list:ARM64 PORT \(AARCH64 ARCHITECTURE\)"
 <linux-arm-kernel@lists.infradead.org>
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

Hi Marc, nice to hear from you.

On Wed, Dec 9, 2020 at 4:43 AM Marc Zyngier <maz@kernel.org> wrote:
>
> Hi all,
>
> On 2020-12-08 20:02, Joel Fernandes wrote:
> > On Fri, Sep 11, 2020 at 4:58 AM Sergey Senozhatsky
> > <sergey.senozhatsky@gmail.com> wrote:
> >>
> >> My apologies for the slow reply.
> >>
> >> On (20/08/17 13:25), Marc Zyngier wrote:
> >> >
> >> > It really isn't the same thing at all. You are exposing PV spinlocks,
> >> > while Sergey exposes preemption to vcpus.
> >> >
> >>
> >> Correct, we see vcpu preemption as a "fundamental" feature, with
> >> consequences that affect scheduling, which is a core feature :)
> >>
> >> Marc, is there anything in particular that you dislike about this RFC
> >> patch set? Joel has some ideas, which we may discuss offline if that
> >> works for you.
> >
> > Hi Marc, Sergey, Just checking what is the latest on this series?
>
> I was planning to give it a go, but obviously got sidetracked. :-(

Ah, that happens.

> > About the idea me and Sergey discussed, at a high level we discussed
> > being able to share information similar to "Is the vCPU preempted?"
> > using a more arch-independent infrastructure. I do not believe this
> > needs to be arch-specific. Maybe the speciifc mechanism about how to
> > share a page of information needs to be arch-specific, but the actual
> > information shared need not be.
>
> We already have some information sharing in the form of steal time
> accounting, and I believe this "vcpu preempted" falls in the same
> bucket. It looks like we could implement the feature as an extension
> of the steal-time accounting, as the two concepts are linked
> (one describes the accumulation of non-running time, the other is
> instantaneous).

Yeah I noticed the steal stuff. Will go look more into that.

> > This could open the door to sharing
> > more such information in an arch-independent way (for example, if the
> > scheduler needs to know other information such as the capacity of the
> > CPU that the vCPU is on).
>
> Quentin and I have discussed potential ways of improving guest
> scheduling
> on terminally broken systems (otherwise known as big-little), in the
> form of a capacity request from the guest to the host. I'm not really
> keen on the host exposing its own capacity, as that doesn't tell the
> host what the guest actually needs.

I am not sure how a capacity request could work well. It seems the
cost of a repeated hypercall could be prohibitive. In this case, a
lighter approach might be for KVM to restrict vCPU threads to run on
certain types of cores, and pass the capacity information to the guest
at guest's boot time. This would be a one-time cost to pay. And then,
then the guest scheduler can handle the scheduling appropriately
without any more hypercalls. Thoughts?

- Joel
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
