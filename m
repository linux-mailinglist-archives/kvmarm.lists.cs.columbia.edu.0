Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id AC3773C9E8
	for <lists+kvmarm@lfdr.de>; Tue, 11 Jun 2019 13:22:04 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 01E8A4A522;
	Tue, 11 Jun 2019 07:22:04 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kiY+aj179MQs; Tue, 11 Jun 2019 07:22:03 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C60E84A511;
	Tue, 11 Jun 2019 07:22:02 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 4DA1F4A4E9
 for <kvmarm@lists.cs.columbia.edu>; Tue, 11 Jun 2019 07:22:02 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NuiZYo2P3Uec for <kvmarm@lists.cs.columbia.edu>;
 Tue, 11 Jun 2019 07:22:00 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E456D4A4DF
 for <kvmarm@lists.cs.columbia.edu>; Tue, 11 Jun 2019 07:22:00 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3EDEC344;
 Tue, 11 Jun 2019 04:22:00 -0700 (PDT)
Received: from localhost (e113682-lin.copenhagen.arm.com [10.32.144.41])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 28CEC3F557;
 Tue, 11 Jun 2019 04:23:42 -0700 (PDT)
Date: Tue, 11 Jun 2019 13:21:58 +0200
From: Christoffer Dall <christoffer.dall@arm.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: Reference count on pages held in secondary MMUs
Message-ID: <20190611112158.GA5318@e113682-lin.lund.arm.com>
References: <20190609081805.GC21798@e113682-lin.lund.arm.com>
 <3ca445bb-0f48-3e39-c371-dd197375c966@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3ca445bb-0f48-3e39-c371-dd197375c966@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Cc: kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org
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

On Sun, Jun 09, 2019 at 11:37:19AM +0200, Paolo Bonzini wrote:
> On 09/06/19 10:18, Christoffer Dall wrote:
> > In some sense, we are thus maintaining a 'hidden', or internal,
> > reference to the page, which is not counted anywhere.
> > 
> > I am wondering if it would be equally valid to take a reference on the
> > page, and remove that reference when unmapping via MMU notifiers, and if
> > so, if there would be any advantages/drawbacks in doing so?
> 
> If I understand correctly, I think the MMU notifier would not fire if
> you took an actual reference; the page would be pinned in memory and
> could not be swapped out.
> 

That was my understanding too, but I can't find the code path that would
support this theory.

The closest thing I could find was is_page_cache_freeable(), and as far
as I'm able to understand that code, that is called (via pageout()) later in
shrink_page_list() than try_to_unmap() which fires the MMU notifiers
through the rmap code.

It is entirely possible that I'm looking at the wrong place and missing
something overall though?


Thanks,

    Christoffer
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
