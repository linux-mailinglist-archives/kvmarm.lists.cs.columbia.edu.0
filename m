Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 6E62422EA0D
	for <lists+kvmarm@lfdr.de>; Mon, 27 Jul 2020 12:30:37 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id F41864B9C2;
	Mon, 27 Jul 2020 06:30:36 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.091
X-Spam-Level: 
X-Spam-Status: No, score=-4.091 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ThK43txLHOfA; Mon, 27 Jul 2020 06:30:36 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 092504B9CB;
	Mon, 27 Jul 2020 06:30:36 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id CCF8E4B88B
 for <kvmarm@lists.cs.columbia.edu>; Mon, 27 Jul 2020 06:30:34 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6f5RqIyuJF4n for <kvmarm@lists.cs.columbia.edu>;
 Mon, 27 Jul 2020 06:30:34 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id EF15E4B8DC
 for <kvmarm@lists.cs.columbia.edu>; Mon, 27 Jul 2020 06:30:33 -0400 (EDT)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id EC33B20786;
 Mon, 27 Jul 2020 10:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1595845833;
 bh=uUBNvzg2ahFLshwdZjYVVAYODV7Yiud3YVtWJ2BgPlE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Qlr59OqAYvDXjI25VMFMB/svOpvvlOOktQKdQ//3ebf/w06fH2l5gz6MEsrFoHjtZ
 WMKmYQjQ7RAtJBmFMK0ujm64fHijK1WsjK3Xvk8KOIzsYhLUHBjl3VoBZHN/520Ia0
 kd/UJN+o6UKNqT7cEJdgsE5YbkJFProL0mWMzsFQ=
Date: Mon, 27 Jul 2020 11:30:28 +0100
From: Will Deacon <will@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH 2/7] KVM: arm64: Rename kvm_vcpu_dabt_isextabt()
Message-ID: <20200727103028.GB20194@willie-the-truck>
References: <20200724143506.17772-1-will@kernel.org>
 <20200724143506.17772-3-will@kernel.org>
 <87tuxuwmqn.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87tuxuwmqn.wl-maz@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
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

On Sun, Jul 26, 2020 at 12:15:44PM +0100, Marc Zyngier wrote:
> On Fri, 24 Jul 2020 15:35:01 +0100,
> Will Deacon <will@kernel.org> wrote:
> > 
> > kvm_vcpu_dabt_isextabt() is not specific to data aborts and has nothing
> > to do with sign extension.
> 
> Not sign extension, but external abort (it reads as "is external
> abort?").
> 
> This is in keeping with all the other helpers (kvm_vcpu_foo_isbar). If
> you want to drop the "data" part (which is indeed not correct), how
> about kvm_vcpu_abt_isexternal? or kvm_vcpu_abt_issea?

kvm_vcpu_abt_issea() would be great -- the problem is that I confused
kvm_vcpu_dabt_issext() and kvm_vcpu_dabt_isextabt() when I was hacking
and if you get the wrong one then you're really hosed!

I'll update for v2.

Cheers,

Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
