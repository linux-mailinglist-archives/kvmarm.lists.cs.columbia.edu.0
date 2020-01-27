Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 278C214A55F
	for <lists+kvmarm@lfdr.de>; Mon, 27 Jan 2020 14:46:34 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7F6624AEE8;
	Mon, 27 Jan 2020 08:46:33 -0500 (EST)
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
	with ESMTP id P+mYANJ55yKn; Mon, 27 Jan 2020 08:46:33 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 405454AEC6;
	Mon, 27 Jan 2020 08:46:32 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C61874AEBF
 for <kvmarm@lists.cs.columbia.edu>; Mon, 27 Jan 2020 08:46:30 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id abKIY3C3PRyQ for <kvmarm@lists.cs.columbia.edu>;
 Mon, 27 Jan 2020 08:46:29 -0500 (EST)
Received: from mail-io1-f65.google.com (mail-io1-f65.google.com
 [209.85.166.65])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id CA2274ACE9
 for <kvmarm@lists.cs.columbia.edu>; Mon, 27 Jan 2020 08:46:29 -0500 (EST)
Received: by mail-io1-f65.google.com with SMTP id h8so10007477iob.2
 for <kvmarm@lists.cs.columbia.edu>; Mon, 27 Jan 2020 05:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=eq3JQW8Til6OlewIurvKZ6yaFYM/l603C+HIJHEMB0c=;
 b=Hpj17Zs8Zuyd5ePaFoTmcbQgV8pucl+bbvypSnw6q77X+iKCdOQR8nQeiSP+53UaUW
 690HG6Qoh1GBTnbvcjH+3+Fmz30c2iiybD3EckA44dkDJ2yHEfz3Q1ksxQ+eCvV79i/j
 /7Y4lrFWciMe+EpgWZv54TdF50a1+l7YS5BW3dqUcpWL3xn5FoXvYxHrxbnSsaMWQUUc
 +1GEbb0k6TtYfkdIjSo3UzZcVPRdkquJSA4ihEIa/gL91Ine/6iOiyCi10s9a5xQz8SN
 XsXkdr6Sy43gkicC3yYvfkhfG97OBLYy4jaLsIMypQlrLMmyu7m9iTZORBgMec6obqRz
 KqCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eq3JQW8Til6OlewIurvKZ6yaFYM/l603C+HIJHEMB0c=;
 b=rBCoRGOqtGGdxei7fXo+MCRHTWz3EWK9m0i/gsuLqL8XjsH0CkFVYf7HugTQF1TQwo
 RhYLaZklMByJi8nP+Y5c3tKb5HdPfeQfdX8epCABVpgl0LnMzUHKomHfthZ+36FfWzs8
 vMCP8Us+R6OQ8oFN9RvXWtK1krYW8WNM5WDoZmNRamX+TNzXBHM4vD3elhS2dQcC+Hfc
 sRdlNeDk7bICflAd0dKl5+KbBOLA1zasauU0LPpS2cZ5uMgP6BQXNuGPc8C6IWRkP0vj
 ZZP42XQDSLjK81bGsiAh90KTtwfqO3NU8WYXk0N1wmZezVQyLHfEbcYvLjAMTeZ0fvjG
 Y0ew==
X-Gm-Message-State: APjAAAWVR1zyAsgjHVfgbgOw6RweuwBse9PFvBkS6ZykLjfFJJvsXWb0
 m4XBhhvvKaNpnTbxmVPsxmBF2oEPlbeuUsSjp7T2mQ==
X-Google-Smtp-Source: APXvYqzJlX/Q0HCE6FDbMkOd2bOk33RfK1OKjHmBhyU3TPobFfd9EmZwXNBaQzzY0gD8feoU43LveSHRNtTHZgTA7ME=
X-Received: by 2002:a6b:dc1a:: with SMTP id s26mr12145159ioc.307.1580132789103; 
 Mon, 27 Jan 2020 05:46:29 -0800 (PST)
MIME-Version: 1.0
References: <20200121123356.203000-1-james.morse@arm.com>
 <CADSWDzubQHvG8_c6a7E=basbtXxW-7u_ZVRz6+M7zGOAYYxz7A@mail.gmail.com>
 <20200126115602.6e67b11b@why>
In-Reply-To: <20200126115602.6e67b11b@why>
From: Beata Michalska <beata.michalska@linaro.org>
Date: Mon, 27 Jan 2020 13:46:18 +0000
Message-ID: <CADSWDzuW4ZGyvprmOOv_=TqBm4yCHp32sMZs8fp-1wB3e-2y4g@mail.gmail.com>
Subject: Re: [PATCH 0/2] KVM: arm: fix KVM_CAP_ARM_INJECT_EXT_DABT for aarch32
 guests
To: Marc Zyngier <maz@kernel.org>
Cc: kvmarm@lists.cs.columbia.edu
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

Hi Marc,

On Sun, 26 Jan 2020 at 11:56, Marc Zyngier <maz@kernel.org> wrote:
>
> On Fri, 24 Jan 2020 15:39:29 +0000
> Beata Michalska <beata.michalska@linaro.org> wrote:
>
> Hi Beata,
>
> > Hi James,
> >
> > Thanks for the fixes - they work like a charm.
> >
> > On Tue, 21 Jan 2020 at 12:34, James Morse <james.morse@arm.com> wrote:
> > >
> > > Beata reports that KVM_CAP_ARM_INJECT_EXT_DABT doesn't do the expected
> > > thing for aarch32 guests. We get the wrong register layout, and weren't
> > > even trying to set a 'external abort' in the first place!
> > >
> > > Both patches are intended as fixes, but patch 2 is somewhat in the eye
> > > of the beholder. I don't know why an imp-def exception was picked...
> > >
> > On a side note - currently KVM exposes capability that is not fully supported
> > (till the fix gets applied) and there is no easy way for the user space to
> > determine whether the injection will work as expected and whether it is safe to
> > use it or not. Although this is addressing a problem that is not that common
> > (I suppose) but still it might be worth to add a way for the kernel to inform
> > the user-space that it is all good to go? There has been a 'similar' case in the
> > past with KVM_SET_USER_MEMORY_REGION, where fixes where needed
> > and those were announced through new caps. Now, I'm not sure if adding new
> > capability would be the best approach here though it seems that there is not
> > much of a choice?
>
> My take on this particular issue is that although the functionality is
> not perfectly working (far from it), it isn't completely broken (the
> guest does get some form of abort). Furthermore, we tend to add this
> kind of discovery mechanism when the userspace interface is broken, not
> when we have an implementation defect in the CPU emulation.
>
Indeed, the guest will get 'the' abort with a small catch though:
the fault handler will actually manage to handle it leading to the faulting
instruction being restarted, trapping thereby the guest in a vicious
circle. This is trading in abnormal termination of the guest (aka 'no idea what
has just happened' ) for rather meaningless back-and-forth with the host kernel.

> The real question is whether there anything out there that would depend
> on such broken behaviour?
>
AFAICT, that would be Qemu trying to handle 'nicely' all the unexpected cases,
where guest triggers the DABT with no valid instruction syndrome (changes on
the way). Now, I agree this is not the most common case ever, but still.
Currently the guest will keep on repeating the same mistake ... until
it gets told
it's high time to stop trying. And that becomes arbitrary without implementing
some additional logic behind it - a bit of an overkill.

BR


Beata
> Thanks,
>
>         M.
> --
> Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
