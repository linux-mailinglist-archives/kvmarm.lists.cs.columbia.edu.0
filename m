Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 27F68205898
	for <lists+kvmarm@lfdr.de>; Tue, 23 Jun 2020 19:27:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 879D14B15B;
	Tue, 23 Jun 2020 13:27:05 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oAx8EO1dHNJK; Tue, 23 Jun 2020 13:27:05 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7CED84B153;
	Tue, 23 Jun 2020 13:27:04 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 003524B117
 for <kvmarm@lists.cs.columbia.edu>; Tue, 23 Jun 2020 13:27:04 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BaU+0k68TULT for <kvmarm@lists.cs.columbia.edu>;
 Tue, 23 Jun 2020 13:27:02 -0400 (EDT)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 9315D4B10F
 for <kvmarm@lists.cs.columbia.edu>; Tue, 23 Jun 2020 13:27:02 -0400 (EDT)
IronPort-SDR: XWXo2YAOU7LkY2o9oUcvKT2aqF/Bp5dWa29ZvfgFeO0fZSEs2Xo6dXAUrKuFK1wNEg+/deQAMC
 ez6tQpcYLycA==
X-IronPort-AV: E=McAfee;i="6000,8403,9661"; a="131571504"
X-IronPort-AV: E=Sophos;i="5.75,272,1589266800"; d="scan'208";a="131571504"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2020 10:26:59 -0700
IronPort-SDR: dFkTC0Q3VbYtMwEZFits5/7wHj7dRqejoXJIagA8vcDlFKA9TiqfEssKP0af/RV+QvSnY0a5QI
 IIkrU34/15jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,272,1589266800"; d="scan'208";a="478939562"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com)
 ([10.54.74.152])
 by fmsmga005.fm.intel.com with ESMTP; 23 Jun 2020 10:26:58 -0700
Date: Tue, 23 Jun 2020 10:26:58 -0700
From: Sean Christopherson <sean.j.christopherson@intel.com>
To: Marc Zyngier <maz@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 00/21] KVM: Cleanup and unify kvm_mmu_memory_cache usage
Message-ID: <20200623172658.GF23842@linux.intel.com>
References: <20200622200822.4426-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200622200822.4426-1-sean.j.christopherson@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Cc: linux-arch@vger.kernel.org, Junaid Shahid <junaids@google.com>,
 Wanpeng Li <wanpengli@tencent.com>, kvm@vger.kernel.org,
 Joerg Roedel <joro@8bytes.org>, Peter Shier <pshier@google.com>,
 linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Ben Gardon <bgardon@google.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, Peter Feiner <pfeiner@google.com>,
 kvmarm@lists.cs.columbia.edu, Jim Mattson <jmattson@google.com>
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

On Mon, Jun 22, 2020 at 01:08:01PM -0700, Sean Christopherson wrote:
> Note, patch 18 will conflict with the p4d rework in 5.8.  I originally
> stated I would send v2 only after that got pulled into Paolo's tree, but
> I got my timing wrong, i.e. I was thinking that would have already
> happened.  I'll send v3 if necessary.  I wanted to get v2 out there now
> that I actually compile tested other architectures.

Gah, too impatient by one day :-)  I'll spin v3 later in the week.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
