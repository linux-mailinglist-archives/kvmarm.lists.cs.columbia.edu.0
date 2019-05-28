Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 048DA2C2F4
	for <lists+kvmarm@lfdr.de>; Tue, 28 May 2019 11:18:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 48A684A4F5;
	Tue, 28 May 2019 05:18:57 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id n6YgoeIrDnwP; Tue, 28 May 2019 05:18:57 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id EA7634A4EA;
	Tue, 28 May 2019 05:18:55 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E8CD94A4C9
 for <kvmarm@lists.cs.columbia.edu>; Tue, 28 May 2019 05:18:54 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dTVP0HUDq-iB for <kvmarm@lists.cs.columbia.edu>;
 Tue, 28 May 2019 05:18:53 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 5BEFE4A32E
 for <kvmarm@lists.cs.columbia.edu>; Tue, 28 May 2019 05:18:53 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3E8B3341;
 Tue, 28 May 2019 02:18:52 -0700 (PDT)
Received: from [10.1.196.129] (ostrya.cambridge.arm.com [10.1.196.129])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5B0993F59C;
 Tue, 28 May 2019 02:18:48 -0700 (PDT)
Subject: Re: [PATCH v7 0/7] Add virtio-iommu driver
To: "Michael S. Tsirkin" <mst@redhat.com>, Joerg Roedel <joro@8bytes.org>
References: <20190115121959.23763-1-jean-philippe.brucker@arm.com>
 <20190512123022-mutt-send-email-mst@kernel.org>
 <20190527092604.GB21613@8bytes.org>
 <20190527111345-mutt-send-email-mst@kernel.org>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <99ff5494-bfdf-f4ef-b2d2-c177add385c6@arm.com>
Date: Tue, 28 May 2019 10:18:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190527111345-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>,
 Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
 "tnowicki@caviumnetworks.com" <tnowicki@caviumnetworks.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Marc Zyngier <Marc.Zyngier@arm.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>, Will Deacon <Will.Deacon@arm.com>,
 Robin Murphy <Robin.Murphy@arm.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "frowand.list@gmail.com" <frowand.list@gmail.com>,
 "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>
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

On 27/05/2019 16:15, Michael S. Tsirkin wrote:
> On Mon, May 27, 2019 at 11:26:04AM +0200, Joerg Roedel wrote:
>> On Sun, May 12, 2019 at 12:31:59PM -0400, Michael S. Tsirkin wrote:
>>> OK this has been in next for a while.
>>>
>>> Last time IOMMU maintainers objected. Are objections
>>> still in force?
>>>
>>> If not could we get acks please?
>>
>> No objections against the code, I only hesitated because the Spec was
>> not yet official.
>>
>> So for the code:
>>
>> 	Acked-by: Joerg Roedel <jroedel@suse.de>
> 
> Last spec patch had a bunch of comments not yet addressed.
> But I do not remember whether comments are just about wording
> or about the host/guest interface as well.
> Jean-Philippe could you remind me please?

It's mostly wording, but there is a small change in the config space
layout and two new feature bits. I'll send a new version of the driver
when possible.

Thanks,
Jean
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
