Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 282BD1B246D
	for <lists+kvmarm@lfdr.de>; Tue, 21 Apr 2020 12:55:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B15794B15E;
	Tue, 21 Apr 2020 06:55:56 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RLKwGIxl0sVF; Tue, 21 Apr 2020 06:55:56 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 98BFF4B13D;
	Tue, 21 Apr 2020 06:55:55 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 8E6994B13D
 for <kvmarm@lists.cs.columbia.edu>; Mon, 20 Apr 2020 17:00:13 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id H0-zOsorJ5R3 for <kvmarm@lists.cs.columbia.edu>;
 Mon, 20 Apr 2020 17:00:12 -0400 (EDT)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 889704B136
 for <kvmarm@lists.cs.columbia.edu>; Mon, 20 Apr 2020 17:00:12 -0400 (EDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id CAA6FAC7F;
 Mon, 20 Apr 2020 21:00:09 +0000 (UTC)
Date: Mon, 20 Apr 2020 13:56:41 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v2] kvm: Replace vcpu->swait with rcuwait
Message-ID: <20200420205641.6sgsllj6pmsnwrvp@linux-p48b>
References: <20200324044453.15733-1-dave@stgolabs.net>
 <20200324044453.15733-4-dave@stgolabs.net>
 <20200420164132.tjzk5ebx35m66yce@linux-p48b>
 <418acdb5001a9ae836095b7187338085@misterjones.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <418acdb5001a9ae836095b7187338085@misterjones.org>
User-Agent: NeoMutt/20180716
X-Mailman-Approved-At: Tue, 21 Apr 2020 06:55:53 -0400
Cc: kvm@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>, peterz@infradead.org,
 will@kernel.org, bigeasy@linutronix.de, linux-kernel@vger.kernel.org,
 rostedt@goodmis.org, linux-mips@vger.kernel.org,
 Paul Mackerras <paulus@ozlabs.org>, joel@joelfernandes.org,
 pbonzini@redhat.com, tglx@linutronix.de, torvalds@linux-foundation.org,
 kvmarm@lists.cs.columbia.edu
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

On Mon, 20 Apr 2020, Marc Zyngier wrote:

>This looks like a change in the semantics of the tracepoint. Before this
>change, 'waited' would have been true if the vcpu waited at all. Here, 
>you'd
>have false if it has been interrupted by a signal, even if the vcpu 
>has waited
>for a period of time.

Hmm but sleeps are now uninterruptible as we're using TASK_IDLE.

Thanks,
Davidlohr
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
