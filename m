Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id BC7C9229D41
	for <lists+kvmarm@lfdr.de>; Wed, 22 Jul 2020 18:40:55 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5A4D44B2A8;
	Wed, 22 Jul 2020 12:40:55 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3] autolearn=no
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AeV8+qXyZtct; Wed, 22 Jul 2020 12:40:54 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5E5424B297;
	Wed, 22 Jul 2020 12:40:53 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 20B204B285
 for <kvmarm@lists.cs.columbia.edu>; Wed, 22 Jul 2020 12:40:52 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 21SExJJc50He for <kvmarm@lists.cs.columbia.edu>;
 Wed, 22 Jul 2020 12:40:50 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B2B9A4B294
 for <kvmarm@lists.cs.columbia.edu>; Wed, 22 Jul 2020 12:40:50 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C66C531B;
 Wed, 22 Jul 2020 09:40:49 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 962E03F66E;
 Wed, 22 Jul 2020 09:40:48 -0700 (PDT)
Date: Wed, 22 Jul 2020 17:40:46 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v2 0/4] Manage vcpu flags from the host
Message-ID: <20200722164045.GQ30452@arm.com>
References: <20200713210505.2959828-1-ascull@google.com>
 <20200722162429.GP30452@arm.com>
 <7cbc5c0450035a576d87bf4821dc36a0@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7cbc5c0450035a576d87bf4821dc36a0@kernel.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Cc: kernel-team@android.com, kvmarm@lists.cs.columbia.edu
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

On Wed, Jul 22, 2020 at 05:36:34PM +0100, Marc Zyngier wrote:
> On 2020-07-22 17:24, Dave Martin wrote:
> >On Mon, Jul 13, 2020 at 10:05:01PM +0100, Andrew Scull wrote:
> >>The aim is to keep management of the flags in the host and out of hyp
> >>where possible. I find this makes it easier to understand how the flags
> >>are used as the responsibilities are clearly divided.
> >>
> >>The series applies on top of kvmarm/next after VHE and nVHE have been
> >>separated.
> >
> >(A commit ID would be useful for someone trying to the patches.)
> >
> >>From v1 <20200710095754.3641976-1-ascull@google.com>:
> >
> >(Nit: Is there some easy way of looking up mails by Message-ID?
> >
> >Otherwise, it can be helpful to have a mail archive URL here, e.g.,
> >lore.kernel.org)
> 
> I routinely use https://lore.kernel.org/r/<msgid>, which does
> the right thing.  But indeed, including the link directly is
> the preferred course of action, and saves having to assemble
> the URL by hand.

Cool, I'll make a mental note.

Now I just need to start posting non-unique message-IDs ;)

Cheers
---Dave
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
