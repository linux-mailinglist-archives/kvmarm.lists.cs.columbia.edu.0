Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2DB2B141
	for <lists+kvmarm@lfdr.de>; Mon, 27 May 2019 11:26:12 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 523044A4EA;
	Mon, 27 May 2019 05:26:11 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.798
X-Spam-Level: 
X-Spam-Status: No, score=0.798 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001,
	SPF_HELO_PASS=-0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hYZwrl92uEuw; Mon, 27 May 2019 05:26:11 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2A5884A4E6;
	Mon, 27 May 2019 05:26:10 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 435254A369
 for <kvmarm@lists.cs.columbia.edu>; Mon, 27 May 2019 05:26:08 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KW-3+BEwZVDO for <kvmarm@lists.cs.columbia.edu>;
 Mon, 27 May 2019 05:26:06 -0400 (EDT)
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id A427B4A332
 for <kvmarm@lists.cs.columbia.edu>; Mon, 27 May 2019 05:26:06 -0400 (EDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id BF9BB26B; Mon, 27 May 2019 11:26:04 +0200 (CEST)
Date: Mon, 27 May 2019 11:26:04 +0200
From: Joerg Roedel <joro@8bytes.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v7 0/7] Add virtio-iommu driver
Message-ID: <20190527092604.GB21613@8bytes.org>
References: <20190115121959.23763-1-jean-philippe.brucker@arm.com>
 <20190512123022-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190512123022-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: virtio-dev@lists.oasis-open.org, kevin.tian@intel.com,
 lorenzo.pieralisi@arm.com, tnowicki@caviumnetworks.com,
 devicetree@vger.kernel.org, linux-pci@vger.kernel.org, jasowang@redhat.com,
 will.deacon@arm.com, robin.murphy@arm.com,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 robh+dt@kernel.org, marc.zyngier@arm.com, bhelgaas@google.com,
 frowand.list@gmail.com, kvmarm@lists.cs.columbia.edu
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

On Sun, May 12, 2019 at 12:31:59PM -0400, Michael S. Tsirkin wrote:
> OK this has been in next for a while.
> 
> Last time IOMMU maintainers objected. Are objections
> still in force?
> 
> If not could we get acks please?

No objections against the code, I only hesitated because the Spec was
not yet official.

So for the code:

	Acked-by: Joerg Roedel <jroedel@suse.de>

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
