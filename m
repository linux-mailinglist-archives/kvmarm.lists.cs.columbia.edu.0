Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB4329291F
	for <lists+kvmarm@lfdr.de>; Mon, 19 Oct 2020 16:18:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 11CB24B688;
	Mon, 19 Oct 2020 10:18:27 -0400 (EDT)
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
	with ESMTP id lwAT+TPsUdMa; Mon, 19 Oct 2020 10:18:26 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E62DC4B673;
	Mon, 19 Oct 2020 10:18:25 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D598E4B4A0
 for <kvmarm@lists.cs.columbia.edu>; Mon, 19 Oct 2020 10:18:24 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dIaoZvVJDWGK for <kvmarm@lists.cs.columbia.edu>;
 Mon, 19 Oct 2020 10:18:24 -0400 (EDT)
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com
 [209.85.218.66])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id E29564B492
 for <kvmarm@lists.cs.columbia.edu>; Mon, 19 Oct 2020 10:18:23 -0400 (EDT)
Received: by mail-ej1-f66.google.com with SMTP id ce10so14160546ejc.5
 for <kvmarm@lists.cs.columbia.edu>; Mon, 19 Oct 2020 07:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=P+q5eYuI1k2apwhrOjSGFGRHo5809gNHaxtenpNMuYw=;
 b=MczSj6+E+TEhn3EmNgvtfVGUNeTN65ETQn8oj+HFePDmEj2lsrhjWodyiSMAg6RpKT
 2+kiYIRLNP0W7O2qdRMjCW+j8weNipZVBX2q9w8Ci4ydrIwmGVgNqm5keZV33N7gjPcu
 4QX8jUPxFaXeyD+sox2QMUbhMsg3ugWN8xXzPrqIGiTihy80L44c9ASAqPxF0aC6Yg0I
 g3SDYH33fDJY6vZHkeHmomE3y5rhd+QXpZYGDTRIgTMKjU4B16EAYnexwX21FgxKrnNa
 V5f9qD4iVZwbTNSyhruBMB8AUn3Ok8PPqVekpDQmYYu8RMfpp2S1aXfuKcXBZBdPznk8
 qQ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=P+q5eYuI1k2apwhrOjSGFGRHo5809gNHaxtenpNMuYw=;
 b=VoxP9FEgMN3uwMZ6yandAZhYgatdD1G4d26VGCuE/8cANmquIyn7/rYrdby0JvxA/P
 +bagRo46jjju3vjEwLaZZf1ae9MRo+/ypy6DmAN2n1g9HBefSwbHnkQ6s44Jc2WdvZkX
 EnN0GOTFQiQ5IvPio6paBMloQMGXCuKDzVUjP4S7pwuDZjkfc8GVJzVpOQ4rlOB7HZvW
 Ye0uXJh5RrWaCX7Oaj0ks1bWNfB34sUoNvjFFL3/IpVgu+4wgNdltVwyejEKaKY7Ne9X
 +jDKCqXDqPIuR547AD5Z7W02+PBk9B7cME4BvdwE8pcGQ87LDAGyazniZpVvn/cDAYTh
 +OPg==
X-Gm-Message-State: AOAM533UOCJVMRz2/PmEjQNZfrxRu8Qs41nUN/gRT6UwyI78ezjKEFiH
 0DGZOFSTADf9q199lgrYwqMNsRd/Tx/AVwDWcPQGOg==
X-Google-Smtp-Source: ABdhPJw3vW4GnAqPbWP30F0VUJ7G6Yt8X9gS2VaxnQj6oSBN9PU9jmUQyfruo6m9TLe6heauDs/6WHB+Df/7MFucyiY=
X-Received: by 2002:a17:906:c7d9:: with SMTP id
 dc25mr110314ejb.482.1603117102813; 
 Mon, 19 Oct 2020 07:18:22 -0700 (PDT)
MIME-Version: 1.0
References: <20201015040639.70C6D414009F@webmail.sinamail.sina.com.cn>
 <7fecfc67da4caab1d677a8b4cd5386b3@kernel.org>
 <20201015133505.ubxvbrt6xyvl4362@kamzik.brq.redhat.com>
 <16400df4bdf79b8b22e824eb1a20e2b4@kernel.org>
 <20201015144104.ytwzpxjlsgyun3ob@kamzik.brq.redhat.com>
 <CAFEAcA-LBmbjp-Teb35f=O-1QtMLd8bAuq5XaCz9URdQZ1jxow@mail.gmail.com>
 <20201019092525.ekvgbcwwtm63pueu@kamzik.brq.redhat.com>
 <20201019113157.GN32292@arm.com>
 <CAFEAcA8oncKmGxKGEZBg9Pnm4hjSO8u9KSv4YxFWxX0+LJ5E2g@mail.gmail.com>
 <20201019134043.vqusmzhqp7owjt6x@kamzik.brq.redhat.com>
In-Reply-To: <20201019134043.vqusmzhqp7owjt6x@kamzik.brq.redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Oct 2020 15:18:11 +0100
Message-ID: <CAFEAcA8RB6MTnv0qavxWs28=pbT16i9dT1pd+0Dy9HxPVk+bZA@mail.gmail.com>
Subject: Re: Kernel patch cases qemu live migration failed.
To: Andrew Jones <drjones@redhat.com>
Cc: Marc Zyngier <maz@kernel.org>, xu910121@sina.com,
 Dave Martin <Dave.Martin@arm.com>, kvmarm <kvmarm@lists.cs.columbia.edu>,
 qemu-devel <qemu-devel@nongnu.org>
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

On Mon, 19 Oct 2020 at 14:40, Andrew Jones <drjones@redhat.com> wrote:
>
> On Mon, Oct 19, 2020 at 12:43:33PM +0100, Peter Maydell wrote:
> > Well, ID regs are special in the architecture -- they always exist
> > and must RAZ/WI, even if they're not actually given any fields yet.
> > This is different from other "unused" parts of the system register
> > encoding space, which UNDEF.
>
> Table D12-2 confirms the register should be RAZ, as it says the register
> is "RO, but RAZ if SVE is not implemented". Does "RO" imply "WI", though?
> For the guest we inject an exception on writes, and for userspace we
> require the value to be preserved on write.

Sorry, I mis-spoke. They're RAZ, but not WI, just RO (which is to say
they'll UNDEF if you try to write to them).

> I think we should follow the spec, even for userspace access, and be RAZ
> for when the feature isn't implemented. As for writes, assuming the
> exception injection is what we want for the guest (not WI), then that's
> correct. For userspace, I think we should continue forcing preservation
> (which will force preservation of zero when it's RAZ).

Yes, that sounds right.

thanks
-- PMM
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
