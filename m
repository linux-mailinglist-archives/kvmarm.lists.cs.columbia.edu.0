Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id A61EE610E58
	for <lists+kvmarm@lfdr.de>; Fri, 28 Oct 2022 12:23:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D987540BE7;
	Fri, 28 Oct 2022 06:23:45 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.79
X-Spam-Level: 
X-Spam-Status: No, score=-1.79 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, SPF_HELO_PASS=-0.001, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@linux.dev
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Qo9dMhCkgWTU; Fri, 28 Oct 2022 06:23:45 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1BF6140FAC;
	Fri, 28 Oct 2022 06:23:44 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 264F940D02
 for <kvmarm@lists.cs.columbia.edu>; Fri, 28 Oct 2022 06:23:43 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dyyzb6nFcHj9 for <kvmarm@lists.cs.columbia.edu>;
 Fri, 28 Oct 2022 06:23:41 -0400 (EDT)
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id C6CFF40BE7
 for <kvmarm@lists.cs.columbia.edu>; Fri, 28 Oct 2022 06:23:41 -0400 (EDT)
Date: Fri, 28 Oct 2022 10:23:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1666952620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L4OIthJifQ5swLs+ejUqtpsuyuxlkNQcRrSkG5lvVuU=;
 b=vxttRypFANLybcEOz+fXk4/ydf1CvcSqFUutaV/7xpJMPOb2OZ4PiEVY4zUSMWcHw26Zc5
 q/g+CCWNjfxFxRy+CYfZl/2OqGAJKnj/dmLyGDt2KiupdcXSq8PPC5suvcsqloVUhO2a+a
 wNmoPX+2gFxpD5fxvVbo4twcmTwuO0U=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Quentin Perret <qperret@google.com>
Subject: Re: [PATCH 2/2] KVM: arm64: Redefine pKVM memory transitions in
 terms of source/target
Message-ID: <Y1utqG5f0lRrNwlI@google.com>
References: <20221028083448.1998389-1-oliver.upton@linux.dev>
 <20221028083448.1998389-3-oliver.upton@linux.dev>
 <Y1uncNq2oyc5wALG@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y1uncNq2oyc5wALG@google.com>
X-Migadu-Flow: FLOW_OUT
Cc: kvm@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
 Will Deacon <will@kernel.org>, kvmarm@lists.linux.dev,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
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

Quentin,

On Fri, Oct 28, 2022 at 09:57:04AM +0000, Quentin Perret wrote:
> Hey Oliver,
> 
> On Friday 28 Oct 2022 at 08:34:48 (+0000), Oliver Upton wrote:
> > Perhaps it is just me, but the 'initiator' and 'completer' terms are
> > slightly confusing descriptors for the addresses involved in a memory
> > transition. Apply a rename to instead describe memory transitions in
> > terms of a source and target address.
> 
> Just to provide some rationale for the initiator/completer terminology,
> the very first implementation we did of this used 'sender/recipient (or
> something along those lines I think), and we ended up confusing
> ourselves massively. The main issue is that memory doesn't necessarily
> 'flow' in the same direction as the transition. It's all fine for a
> donation or a share, but reclaim and unshare become funny. 'The
> recipient of an unshare' can be easily misunderstood, I think.
> 
> So yeah, we ended up with initiator/completer, which may not be the
> prettiest terminology, but it was useful to disambiguate things at
> least.

I see, thanks for the background :) If I've managed to re-ambiguate the
language here then LMK. Frankly, I'm more strongly motivated on the
first patch anyway.

--
Thanks,
Oliver
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
