Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 12DF33F2C6B
	for <lists+kvmarm@lfdr.de>; Fri, 20 Aug 2021 14:46:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 80FBB4B0CB;
	Fri, 20 Aug 2021 08:46:27 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.209
X-Spam-Level: 
X-Spam-Status: No, score=0.209 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_LOW=-0.7,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1XLFet2+VNTY; Fri, 20 Aug 2021 08:46:27 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 902324B0DD;
	Fri, 20 Aug 2021 08:46:23 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 40DB54B0CB
 for <kvmarm@lists.cs.columbia.edu>; Fri, 20 Aug 2021 08:46:22 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id t6XmrccuyLd7 for <kvmarm@lists.cs.columbia.edu>;
 Fri, 20 Aug 2021 08:46:21 -0400 (EDT)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 5680B4B0A0
 for <kvmarm@lists.cs.columbia.edu>; Fri, 20 Aug 2021 08:46:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1629463581;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ec6wyQR9c8nnL/eIyo5QCfAh05t7TesL5t+9W2wsXXM=;
 b=bkBGiZj8vxWRDS5psyjJwC7mXYOJIPAsnAOz2BDSbVqI+VgUMbILotYhiKMtJA1eW3yZLt
 ETTgT51soAFs719DT55WzjP+QLZ/FA5TKcfb86teutF+9+X4t7RfA1K2M/aXVCrclZ5Qi1
 YZecQDoZ2iyzdLumEO20S5MWxteAArI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-599-FblG6u4AP4KYVzcnF4xSJQ-1; Fri, 20 Aug 2021 08:46:19 -0400
X-MC-Unique: FblG6u4AP4KYVzcnF4xSJQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E7A0D1018F74;
 Fri, 20 Aug 2021 12:46:16 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-5.gru2.redhat.com [10.97.112.5])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 602BD69CBC;
 Fri, 20 Aug 2021 12:46:16 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
 id AEDE0418AE12; Fri, 20 Aug 2021 09:46:11 -0300 (-03)
Date: Fri, 20 Aug 2021 09:46:11 -0300
From: Marcelo Tosatti <mtosatti@redhat.com>
To: Oliver Upton <oupton@google.com>
Subject: Re: [PATCH v7 3/6] KVM: x86: Report host tsc and realtime values in
 KVM_GET_CLOCK
Message-ID: <20210820124611.GA77176@fuller.cnet>
References: <20210816001130.3059564-1-oupton@google.com>
 <20210816001130.3059564-4-oupton@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210816001130.3059564-4-oupton@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: Catalin Marinas <catalin.marinas@arm.com>, kvm@vger.kernel.org,
 Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Raghavendra Rao Anata <rananta@google.com>, Peter Shier <pshier@google.com>,
 Sean Christopherson <seanjc@google.com>, David Matlack <dmatlack@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, Jim Mattson <jmattson@google.com>
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

On Mon, Aug 16, 2021 at 12:11:27AM +0000, Oliver Upton wrote:
> Handling the migration of TSCs correctly is difficult, in part because
> Linux does not provide userspace with the ability to retrieve a (TSC,
> realtime) clock pair for a single instant in time. In lieu of a more
> convenient facility, KVM can report similar information in the kvm_clock
> structure.
> 
> Provide userspace with a host TSC & realtime pair iff the realtime clock
> is based on the TSC. If userspace provides KVM_SET_CLOCK with a valid
> realtime value, advance the KVM clock by the amount of elapsed time. Do
> not step the KVM clock backwards, though, as it is a monotonic
> oscillator.
> 
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Oliver Upton <oupton@google.com>

This is a good idea. Userspace could check if host and destination
clocks are up to a certain difference and not use the feature if
not appropriate.

Is there a qemu patch for it?

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
