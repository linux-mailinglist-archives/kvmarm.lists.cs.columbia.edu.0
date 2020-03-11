Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED6E181CC3
	for <lists+kvmarm@lfdr.de>; Wed, 11 Mar 2020 16:48:07 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 054C14A94D;
	Wed, 11 Mar 2020 11:48:07 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.909
X-Spam-Level: 
X-Spam-Status: No, score=0.909 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699,
	RCVD_IN_DNSWL_NONE=-0.0001, T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id a4qjWCj6kRpx; Wed, 11 Mar 2020 11:48:06 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C1BBE4A542;
	Wed, 11 Mar 2020 11:48:05 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 86CD34A534
 for <kvmarm@lists.cs.columbia.edu>; Wed, 11 Mar 2020 11:48:04 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id P5ngy-wOXG8o for <kvmarm@lists.cs.columbia.edu>;
 Wed, 11 Mar 2020 11:48:03 -0400 (EDT)
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id AF2654A528
 for <kvmarm@lists.cs.columbia.edu>; Wed, 11 Mar 2020 11:48:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583941683;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UcFcy+P5OSEH/ZlLu1SpwRmiQzxtCziFp2P7AeR9cGw=;
 b=Rto73vXWMmxED4p+0SVaRsEPGI1I9Rc25ARATESEZGewl+6Q+f52BcHpvmFbetjZFydQda
 iZ2pjdSzVqJZOR6PfnBfdg0kfQEPhi6NGHthZx0Mb4OLBc3tt/SD5m+Nr4YySX+jhx8+iY
 bHGkrj1YWDnKoksvH3EQhFnLnqYqjPI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418-l7dWPsJ1OFO0_BN3Bsfawg-1; Wed, 11 Mar 2020 11:47:59 -0400
X-MC-Unique: l7dWPsJ1OFO0_BN3Bsfawg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A78918A72A3;
 Wed, 11 Mar 2020 15:47:58 +0000 (UTC)
Received: from [10.36.118.12] (unknown [10.36.118.12])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EADFA60BEE;
 Wed, 11 Mar 2020 15:47:51 +0000 (UTC)
Subject: Re: [kvm-unit-tests PATCH v6 07/13] arm/arm64: ITS:
 its_enable_defaults
To: Andrew Jones <drjones@redhat.com>
References: <20200311135117.9366-1-eric.auger@redhat.com>
 <20200311135117.9366-8-eric.auger@redhat.com>
 <20200311153842.knuyqfnzqopb35gj@kamzik.brq.redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <75e9a1b2-8bd1-232a-91e4-5bd606c70c1a@redhat.com>
Date: Wed, 11 Mar 2020 16:47:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200311153842.knuyqfnzqopb35gj@kamzik.brq.redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: thuth@redhat.com, kvm@vger.kernel.org, maz@kernel.org,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, andre.przywara@arm.com,
 kvmarm@lists.cs.columbia.edu, eric.auger.pro@gmail.com
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

Hi Drew,
On 3/11/20 4:38 PM, Andrew Jones wrote:
> On Wed, Mar 11, 2020 at 02:51:11PM +0100, Eric Auger wrote:
>> +/* must be called after gicv3_enable_defaults */
>> +void its_enable_defaults(void)
>> +{
>> +	int i;
>> +
>> +	/* Allocate LPI config and pending tables */
>> +	gicv3_lpi_alloc_tables();
>> +
>> +	for (i = 0; i < nr_cpus; i++)
>> +		gicv3_lpi_rdist_enable(i);
> 
> You still haven't explained what's wrong with for_each_present_cpu.

The previous comment you did was related to a spurious change I made in
gicv3_lpi_alloc_tables. This change was removed in v5:
[kvm-unit-tests PATCH v5 05/13] arm/arm64: gicv3: Set the LPI config and
pending tables

I did not understand from your comment you wanted all locations to use
for_each_present_cpu(). I have nothing against it ;-)

 Also,
> I see you've added 'i < nr_cpus' loops in arm/gic.c too. I'd prefer we not
> assume that all cpu's are present (even though, currently, they must be),
> because we may want to integrate cpu hotplug tests with these tests at
> some point.

OK

Thanks

Eric
> 
>> +
>> +	writel(GITS_CTLR_ENABLE, its_data.base + GITS_CTLR);
>> +}
>> -- 
>> 2.20.1
>>
>>
> 

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
