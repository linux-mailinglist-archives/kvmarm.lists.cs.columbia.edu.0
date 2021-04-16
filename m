Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 78AC4361F04
	for <lists+kvmarm@lfdr.de>; Fri, 16 Apr 2021 13:44:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E5FEE4B30B;
	Fri, 16 Apr 2021 07:44:41 -0400 (EDT)
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
	with ESMTP id 1JT7RVssvZNe; Fri, 16 Apr 2021 07:44:41 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id AB8E64B2B8;
	Fri, 16 Apr 2021 07:44:40 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 909724B29B
 for <kvmarm@lists.cs.columbia.edu>; Fri, 16 Apr 2021 07:44:38 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id C6e1f7Yj+tmo for <kvmarm@lists.cs.columbia.edu>;
 Fri, 16 Apr 2021 07:44:37 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 963394B28B
 for <kvmarm@lists.cs.columbia.edu>; Fri, 16 Apr 2021 07:44:37 -0400 (EDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1D13161057;
 Fri, 16 Apr 2021 11:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1618573476;
 bh=g1GQ3fMRsXXUxb3TziyhacMOOpriyOWdQMsWa6+jGug=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=BJi5NHc+XLro4v3JuXfxVimD3qTxlRIlEQW0jKcbC1fkOeMbhX+QD36Vpgv/m5ZWS
 w9k0pCOsSSy5e1rtpgZ6meO2kxgPq/nHRJ8xHTAE/3ueN6qs6pqlukQ1HUBO0cBT9Z
 1AQShBFk27Hug5dFGtBphwLSnqUSmscREcGT3KDTwjeLt7aURG5nZp5OsnGRS8Tf1v
 cyIiJ5wZAAlMJuC7YOXtzgBlbuPlBe1viVwrvSNQ2ApaD5WM28tOf9xQWfW9Tzj99G
 Xv0t+SbyVly+TfTJMs7hkGCjxMV0CtCIjWPw5NkGbs+NBYqqEsV1nMMDioVyRJhgy+
 nG5AVY/FWbnzA==
Date: Fri, 16 Apr 2021 14:44:26 +0300
From: Mike Rapoport <rppt@kernel.org>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [RFC/RFT PATCH 1/3] memblock: update initialization of reserved
 pages
Message-ID: <YHl4mqgh5CtNk1l7@kernel.org>
References: <20210407172607.8812-1-rppt@kernel.org>
 <20210407172607.8812-2-rppt@kernel.org>
 <0c48f98c-7454-1458-15a5-cc5a7e1fb7cd@redhat.com>
 <CAMj1kXGw97epyP2HdHjA8Yp6+VF1j5xmd0AgVBBv3k+h_B610w@mail.gmail.com>
 <3811547a-9057-3c80-3805-2e658488ac99@redhat.com>
 <YHdPmtpzFxHE9mAt@kernel.org>
 <f5503130-c0e7-329f-86c4-727ece1c860f@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f5503130-c0e7-329f-86c4-727ece1c860f@redhat.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Mike Rapoport <rppt@linux.ibm.com>,
 Linux Memory Management List <linux-mm@kvack.org>,
 kvmarm <kvmarm@lists.cs.columbia.edu>, Marc Zyngier <maz@kernel.org>,
 Will Deacon <will@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
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

On Thu, Apr 15, 2021 at 11:30:12AM +0200, David Hildenbrand wrote:
> > Not sure we really need a new pagetype here, PG_Reserved seems to be quite
> > enough to say "don't touch this".  I generally agree that we could make
> > PG_Reserved a PageType and then have several sub-types for reserved memory.
> > This definitely will add clarity but I'm not sure that this justifies
> > amount of churn and effort required to audit uses of PageResrved().
> > > Then, we could mostly avoid having to query memblock at runtime to figure
> > > out that this is special memory. This would obviously be an extension to
> > > this series. Just a thought.
> > 
> > Stop pushing memblock out of kernel! ;-)
> 
> Can't stop. Won't stop. :D
> 
> It's lovely for booting up a kernel until we have other data-structures in
> place ;)

A bit more seriously, we don't have any data structure that reliably
represents physical memory layout and arch-independent fashion. 
memblock is probably the best starting point for eventually having one.

-- 
Sincerely yours,
Mike.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
