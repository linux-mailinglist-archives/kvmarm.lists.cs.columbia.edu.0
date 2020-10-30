Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF722A0CD2
	for <lists+kvmarm@lfdr.de>; Fri, 30 Oct 2020 18:49:41 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D6CEF4B536;
	Fri, 30 Oct 2020 13:49:40 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BsEPH6QjYXic; Fri, 30 Oct 2020 13:49:40 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A41F24B4E8;
	Fri, 30 Oct 2020 13:49:39 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 9B3DE4B41F
 for <kvmarm@lists.cs.columbia.edu>; Fri, 30 Oct 2020 13:49:38 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ps-OoUtvJYYm for <kvmarm@lists.cs.columbia.edu>;
 Fri, 30 Oct 2020 13:49:37 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 5C35D4B367
 for <kvmarm@lists.cs.columbia.edu>; Fri, 30 Oct 2020 13:49:37 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C4D551063;
 Fri, 30 Oct 2020 10:49:36 -0700 (PDT)
Received: from [192.168.0.110] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0A3353F719;
 Fri, 30 Oct 2020 10:49:35 -0700 (PDT)
Subject: Re: [kvm-unit-tests RFC PATCH v2 3/5] arm64: spe: Add introspection
 test
To: Auger Eric <eric.auger@redhat.com>, kvm@vger.kernel.org,
 kvmarm@lists.cs.columbia.edu
References: <20201027171944.13933-1-alexandru.elisei@arm.com>
 <20201027171944.13933-4-alexandru.elisei@arm.com>
 <5745ad18-be1a-da91-7289-a48682ad59a5@redhat.com>
 <66ff5a16-1771-9423-9205-5aabb4635c1b@arm.com>
 <c78da5aa-f429-d651-c460-b6cc46d6f188@redhat.com>
From: Alexandru Elisei <alexandru.elisei@arm.com>
Message-ID: <96204ef8-7afc-2dd4-f226-8efcbacaa564@arm.com>
Date: Fri, 30 Oct 2020 17:50:35 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <c78da5aa-f429-d651-c460-b6cc46d6f188@redhat.com>
Content-Language: en-US
Cc: pbonzini@redhat.com
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

Hi Eric,

On 10/30/20 5:09 PM, Auger Eric wrote:
> Hi Alexandru,
>
> On 10/30/20 4:59 PM, Alexandru Elisei wrote:
> [..]
>>>> +	spe.align = 1 << spe.align;
>>>> +
>>>> +	pmsidr = read_sysreg_s(SYS_PMSIDR_EL1);
>>>> +
>>>> +	interval = (pmsidr >> SYS_PMSIDR_EL1_INTERVAL_SHIFT) & SYS_PMSIDR_EL1_INTERVAL_MASK;
>>>> +	spe.min_interval = spe_min_interval(interval);
>>>> +
>>>> +	spe.max_record_size = (pmsidr >> SYS_PMSIDR_EL1_MAXSIZE_SHIFT) & \
>>>> +		      SYS_PMSIDR_EL1_MAXSIZE_MASK;
>>>> +	spe.max_record_size = 1 << spe.max_record_size;
>>>> +
>>>> +	spe.countsize = (pmsidr >> SYS_PMSIDR_EL1_COUNTSIZE_SHIFT) & \
>>>> +			SYS_PMSIDR_EL1_COUNTSIZE_MASK;
>>>> +
>>>> +	spe.fl_cap = pmsidr & BIT(SYS_PMSIDR_EL1_FL_SHIFT);
>>>> +	spe.ft_cap = pmsidr & BIT(SYS_PMSIDR_EL1_FT_SHIFT);
>>>> +	spe.fe_cap = pmsidr & BIT(SYS_PMSIDR_EL1_FE_SHIFT);
>>> Why did you remove the report_info() section? I think those human
>>> readable info can be useful.
>> I made them part of the test. Since the architecture says they are 1, I think
>> making sure their value matches is more useful than printing something that the
>> architecture guarantees.
> OK for those caps which are always 1 anyway but I was more thinking about
>
> report_info("Align= %d bytes, Min Interval=%d Single record Max Size =
> %d bytes", spe.align, spe.min_interval, spe.maxsize);
>
> I'd prefer to keep it.

Oh, I think I see what you mean, I chose to print them using printf in main().
This is very similar to what the timer test does, only it does it directly in
main(), instead of calling another function (print_timer_info(), in the case of
the timer test). I can move the printfs to spe_probe() if that's what you prefer.

Thanks,

Alex

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
