Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 31B203EA1F7
	for <lists+kvmarm@lfdr.de>; Thu, 12 Aug 2021 11:22:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id BE10C407F4;
	Thu, 12 Aug 2021 05:22:46 -0400 (EDT)
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
	with ESMTP id GITgdXMHsvuG; Thu, 12 Aug 2021 05:22:46 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C265C4086D;
	Thu, 12 Aug 2021 05:22:42 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 3D906407F4
 for <kvmarm@lists.cs.columbia.edu>; Thu, 12 Aug 2021 05:22:41 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id m6cosUn4o5b6 for <kvmarm@lists.cs.columbia.edu>;
 Thu, 12 Aug 2021 05:22:40 -0400 (EDT)
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com
 [209.85.167.181])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 14953402DB
 for <kvmarm@lists.cs.columbia.edu>; Thu, 12 Aug 2021 05:22:40 -0400 (EDT)
Received: by mail-oi1-f181.google.com with SMTP id w6so9271687oiv.11
 for <kvmarm@lists.cs.columbia.edu>; Thu, 12 Aug 2021 02:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Ow8pOCC7Pfffi05timzyvoLwa6w/ZcLDyaYIxhtLEXc=;
 b=BEnTTEkeoRG+ar6fm5BoupukkxVmIStsqg6p9X1L2YewdIyTkSQj1WN+P6+otJ0++C
 OtX9opzFHCsNib5ayBH3jRJZa30tRdmfcDXAgnJh9+DmlgcpBNLpFCd4UVvvzyfris/w
 nnstb7QJaX4Qdo8LEROO46qPuYSm8vYSv/psYVhvHn+iUtQmSXiiWUPmR/0m+vfmnoH3
 KK7LL5G5h8tKWRidLASXmAOKd1dXuJ8aXoPGuJiKY1l7gqxEI7DbdTfujtppYtzNT+9H
 qzhuzhUZqiCR/wo61T46BUT+5gIQQtGg0xW9QMFzqKarfdR6aBTXX1cMQt3qlC1dttYd
 a7VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Ow8pOCC7Pfffi05timzyvoLwa6w/ZcLDyaYIxhtLEXc=;
 b=mMVf3TO1EVVxGpLvSr9HKe1WZ0mBxK6jFUi3rkMiY/syzqioK1y/rNdI3r68McN5dG
 el50wvJ1vur1Zvave1yFhz61i6Qbmeh1W9AH8HxdMpPb024xMnv2/0llH3DCMaYY2/td
 UKow1elEls/sdhVPh9hIo1LzTNZBASpo2vr/Mm12URtmEKRrZ/ElCKFrKRf681sluP8c
 iSzpPzjPtSn2CFxnOjeimdx8yLa5j1GB0WPZpVeyh9cZByBqPjozK8sGsC+72yl9ORKv
 BKNvJWEJQR4v5qFN3IqEcDfnS08/JnVWrqMRf4nN/c6NnlTZFd2hMby9jeRjzWyuLmZB
 /QEg==
X-Gm-Message-State: AOAM532us8u5KXFZ+RW13/qCoA4htQR3JnfuCvU5H096DKvQNDt0rxEH
 kfXyJI57tHMtUc6hyNEhxie7LBKEIcyAutZZdYo/TQ==
X-Google-Smtp-Source: ABdhPJyKVto4075gxkTTsWk/Og0Ua476G6PD6Md0kKz1KwdQr50M8mhKFW7wA41+P4p5DR5rb+t8mWsbdIpVjfh3lzI=
X-Received: by 2002:aca:220a:: with SMTP id b10mr10613392oic.8.1628760159300; 
 Thu, 12 Aug 2021 02:22:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210719160346.609914-1-tabba@google.com>
 <20210719160346.609914-2-tabba@google.com>
 <20210812085857.GB5912@willie-the-truck>
In-Reply-To: <20210812085857.GB5912@willie-the-truck>
From: Fuad Tabba <tabba@google.com>
Date: Thu, 12 Aug 2021 11:22:03 +0200
Message-ID: <CA+EHjTx++8neadZ=i5Gu-mCeZFC=CBLJ4bd_=QefBoHBb5Qe9Q@mail.gmail.com>
Subject: Re: [PATCH v3 01/15] KVM: arm64: placeholder to check if VM is
 protected
To: Will Deacon <will@kernel.org>
Cc: kernel-team@android.com, kvm@vger.kernel.org, maz@kernel.org,
 pbonzini@redhat.com, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
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

Hi Will,


On Thu, Aug 12, 2021 at 10:59 AM Will Deacon <will@kernel.org> wrote:
>
> On Mon, Jul 19, 2021 at 05:03:32PM +0100, Fuad Tabba wrote:
> > Add a function to check whether a VM is protected (under pKVM).
> > Since the creation of protected VMs isn't enabled yet, this is a
> > placeholder that always returns false. The intention is for this
> > to become a check for protected VMs in the future (see Will's RFC
> > [*]).
> >
> > No functional change intended.
> >
> > Signed-off-by: Fuad Tabba <tabba@google.com>
> >
> > [*] https://lore.kernel.org/kvmarm/20210603183347.1695-1-will@kernel.org/
>
> You can make this a Link: tag.

Of course. Thanks!
/fuad
> Anyway, I think it makes lots of sense to decouple this from the user-ABI
> series:
>
> Acked-by: Will Deacon <will@kernel.org>
>
> Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
