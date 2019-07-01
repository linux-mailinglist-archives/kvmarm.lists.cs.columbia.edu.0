Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id D0DAD3A453
	for <lists+kvmarm@lfdr.de>; Sun,  9 Jun 2019 10:18:11 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C4D304A508;
	Sun,  9 Jun 2019 04:18:10 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TtvC4Y1mhSIO; Sun,  9 Jun 2019 04:18:10 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8239B4A514;
	Sun,  9 Jun 2019 04:18:09 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C4B764A50C
 for <kvmarm@lists.cs.columbia.edu>; Sun,  9 Jun 2019 04:18:08 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UV0Y3YWq-Z+1 for <kvmarm@lists.cs.columbia.edu>;
 Sun,  9 Jun 2019 04:18:07 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 7C7464A508
 for <kvmarm@lists.cs.columbia.edu>; Sun,  9 Jun 2019 04:18:07 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C5F0D344;
 Sun,  9 Jun 2019 01:18:06 -0700 (PDT)
Received: from localhost (e113682-lin.copenhagen.arm.com [10.32.144.41])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 55CFC3F802;
 Sun,  9 Jun 2019 01:18:06 -0700 (PDT)
Date: Sun, 9 Jun 2019 10:18:05 +0200
From: Christoffer Dall <christoffer.dall@arm.com>
To: kvm@vger.kernel.org
Subject: Reference count on pages held in secondary MMUs
Message-ID: <20190609081805.GC21798@e113682-lin.lund.arm.com>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvmarm@lists.cs.columbia.edu
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

Hi,

I have been looking at how we deal with page_count(page) on pages held
in stage 2 page tables on KVM/arm64.

What we do currently is to drop the reference on the page we get from
get_user_pages() once the page is inserted into our stage 2 page table,
typically leaving page_count(page) == page_mapcount(page) == 1 which
represents the userspace stage 1 mapping of the page,
and we rely on MMU notifiers to remove the stage 2 mapping if
corresponding stage 1 mapping is being unmapped.

I believe this is analogous to what other architectures do?

In some sense, we are thus maintaining a 'hidden', or internal,
reference to the page, which is not counted anywhere.

I am wondering if it would be equally valid to take a reference on the
page, and remove that reference when unmapping via MMU notifiers, and if
so, if there would be any advantages/drawbacks in doing so?


Thanks,

    Christoffer
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
