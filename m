Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 800341C4075
	for <lists+kvmarm@lfdr.de>; Mon,  4 May 2020 18:51:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 018FA4B3DB;
	Mon,  4 May 2020 12:51:44 -0400 (EDT)
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
	with ESMTP id rQ8Ok4bUS3fa; Mon,  4 May 2020 12:51:43 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id AFCF04B3CE;
	Mon,  4 May 2020 12:51:42 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id DD2274B346
 for <kvmarm@lists.cs.columbia.edu>; Mon,  4 May 2020 12:51:41 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uIgAUtQQRKWr for <kvmarm@lists.cs.columbia.edu>;
 Mon,  4 May 2020 12:51:39 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id DB5C74B343
 for <kvmarm@lists.cs.columbia.edu>; Mon,  4 May 2020 12:51:39 -0400 (EDT)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9CA80206D9;
 Mon,  4 May 2020 16:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1588611098;
 bh=vNjcj7BiW7fsrp1PHDFOxUtfyekks+fuqVJ5fa+MBVU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=F+xJ6rUn2jyOJhjTTP4RDpIU9PMA0E4wiN0tBoAsaa01z99VfvRWlchg0ha7hBAtZ
 D4LGUXdjQ2cM6CbLAuhdcWlaT6Waym4whpQThp95vDGN1kAIoigsCu7mQ9r9jikuGr
 RstFdo9WOMEId9nXKZkHbsRmA3PK4kDvnNFbz9Sk=
Date: Mon, 4 May 2020 17:51:33 +0100
From: Will Deacon <will@kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [GIT PULL] KVM/arm fixes for 5.7, take #2
Message-ID: <20200504165132.GA1833@willie-the-truck>
References: <20200501101204.364798-1-maz@kernel.org>
 <20200504113051.GB1326@willie-the-truck>
 <df78d984-6ce3-f887-52a9-a3e9164a6dee@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <df78d984-6ce3-f887-52a9-a3e9164a6dee@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: kvm@vger.kernel.org, Fangrui Song <maskray@google.com>,
 Marc Zyngier <maz@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu
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

On Mon, May 04, 2020 at 06:05:51PM +0200, Paolo Bonzini wrote:
> On 04/05/20 13:30, Will Deacon wrote:
> > I don't see this queued up in the kvm tree, which appears to have been
> > sitting dormant for 10 days. Consequently, there are fixes sitting in
> > limbo and we /still/ don't have a sensible base for arm64/kvm patches
> > targetting 5.8.
> > 
> > Paolo -- how can I help get this stuff moving again? I'm more than happy
> > to send this lot up to Linus via arm64 if you're busy atm. Please just
> > let me know.
> 
> 10 days is one week during which I could hardly work and the two
> adjacent weekends.  So this is basically really bad timing in Marc's
> first pull request, that he couldn't have anticipated.

Understood, and thanks for the quick reply. If possible, please just let us
know in future as we can probably figure something out rather than having
things sit in limbo.

> I have pulled both trees now, so you can base 5.8 development on
> kvm/master.  It will get to Linus in a couple days.

Thanks, Paolo!

Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
