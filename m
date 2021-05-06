Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 05179375018
	for <lists+kvmarm@lfdr.de>; Thu,  6 May 2021 09:24:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 85ECB4B4E6;
	Thu,  6 May 2021 03:24:22 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.909
X-Spam-Level: 
X-Spam-Status: No, score=0.909 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, T_DKIM_INVALID=0.01]
	autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@infradead.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id D-zj6nS7BKJj; Thu,  6 May 2021 03:24:22 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4854A4B4E5;
	Thu,  6 May 2021 03:24:21 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 642D74B4E4
 for <kvmarm@lists.cs.columbia.edu>; Thu,  6 May 2021 03:24:20 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RJqPZM-ikV3y for <kvmarm@lists.cs.columbia.edu>;
 Thu,  6 May 2021 03:24:17 -0400 (EDT)
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 53EE64B4DF
 for <kvmarm@lists.cs.columbia.edu>; Thu,  6 May 2021 03:24:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=mmRnwL0+7c5+Z5SO1e0LYjJ5FVGGCBEN51tuNvrP2X0=; b=dpl4IyQPo0BlhWM2jTUcSNiOM5
 /T1JxZKErUyUJ9ETGjthgTvZ6+0OE2eNrB29F18aCLTSE3AY/xVRTw0W6UErf9xzj/pLYAIKskR24
 9gkXrFzSnnoR6b0tbjou7qUCFLHVaZaFpamiS+LSYEmXJ79F/OeUbkj/AyGD+HpBOz7desj14+edY
 lUSejZFA7BuloJKBWWjRevjeIajZvfhMZGc2TxvSzC/4NWlQelWzgRFJ0GQWskjKdESm2Q71fXyDM
 MKGsLUXv63Uiz1DdJstZdNuaRRiLTFtehgz1ms52fqVkX+gi+cE6P/G5IoCOYg3wFwXgGl1M0HtoM
 TzrY8boA==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat
 Linux)) id 1leYKz-001QP0-T6; Thu, 06 May 2021 07:22:27 +0000
Date: Thu, 6 May 2021 08:22:21 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [RFC 1/2] vfio/pci: keep the prefetchable attribute of a BAR
 region in VMA
Message-ID: <20210506072221.GA338890@infradead.org>
References: <BL0PR12MB2532CC436EBF626966B15994BD5E9@BL0PR12MB2532.namprd12.prod.outlook.com>
 <87eeeqvm1d.wl-maz@kernel.org>
 <BL0PR12MB25329EF5DFA7BBAA732064A7BD5C9@BL0PR12MB2532.namprd12.prod.outlook.com>
 <87bl9sunnw.wl-maz@kernel.org>
 <c1bd514a531988c9@bloch.sibelius.xs4all.nl>
 <BL0PR12MB253296086906C4A850EC68E6BD5B9@BL0PR12MB2532.namprd12.prod.outlook.com>
 <20210503084432.75e0126d@x1.home.shazbot.org>
 <BL0PR12MB2532BEAE226E7D68A8A2F97EBD5B9@BL0PR12MB2532.namprd12.prod.outlook.com>
 <20210504083005.GA12290@willie-the-truck>
 <20210505180228.GA3874@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210505180228.GA3874@arm.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Marc Zyngier <maz@kernel.org>,
 Shanker Donthineni <sdonthineni@nvidia.com>, Vikram Sethi <vsethi@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Sequeira <jsequeira@nvidia.com>, Will Deacon <will@kernel.org>,
 "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Mark Kettenis <mark.kettenis@xs4all.nl>
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

On Wed, May 05, 2021 at 07:02:31PM +0100, Catalin Marinas wrote:
> > Furthermore, ioremap() already gives you a Device memory type, and we're
> > tight on MAIR space.
> 
> We have MT_DEVICE_GRE currently reserved though no in-kernel user, we
> might as well remove it.

Please do.  The more we can cut down on different memory types, the
better.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
