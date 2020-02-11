Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7081598A4
	for <lists+kvmarm@lfdr.de>; Tue, 11 Feb 2020 19:31:07 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 267EC4AEC3;
	Tue, 11 Feb 2020 13:31:07 -0500 (EST)
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
	with ESMTP id VR9ZzaUXM1Te; Tue, 11 Feb 2020 13:31:07 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 33BD14AEB4;
	Tue, 11 Feb 2020 13:31:06 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 615334AE96
 for <kvmarm@lists.cs.columbia.edu>; Tue, 11 Feb 2020 13:31:05 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Oux-qctz4jVg for <kvmarm@lists.cs.columbia.edu>;
 Tue, 11 Feb 2020 13:31:04 -0500 (EST)
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [205.139.110.61])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 8FEBC4AE9A
 for <kvmarm@lists.cs.columbia.edu>; Tue, 11 Feb 2020 13:31:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581445864;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vQe3nGagGzeCsufC3rqZRuUQ8B4VGRBcrcOfQrGBV8w=;
 b=XizbppCkcIq3S0jPR6Yg3/Y+HDcyF02GFLkUuS+eqEqnhruL49WoKpIjI40/YDmU0CcGE5
 FxxH19lIGS8qlUcOo+uE6iQwKluCR30kSE1VFvNyGnzE0Uigbzn3EgNZc2JYdQYSq3FxwQ
 KQvD88omyJGCgb1qA5XQDq1/s5+E8G0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-MhMVp186MkW1lxqSwApFkQ-1; Tue, 11 Feb 2020 13:31:00 -0500
X-MC-Unique: MhMVp186MkW1lxqSwApFkQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2ED611005510;
 Tue, 11 Feb 2020 18:30:58 +0000 (UTC)
Received: from [10.36.116.37] (ovpn-116-37.ams2.redhat.com [10.36.116.37])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8935689F38;
 Tue, 11 Feb 2020 18:30:53 +0000 (UTC)
Subject: Re: [kvm-unit-tests PATCH v2 6/9] arm: pmu: Test chained counter
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200130112510.15154-1-eric.auger@redhat.com>
 <20200130112510.15154-7-eric.auger@redhat.com>
 <CAFEAcA_jfZKjey8komTt97Mu-oFjWyFNG2cY4-o8yFAP1oGiug@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <5f11c69b-655a-2fa9-462f-9fd6ebdb501d@redhat.com>
Date: Tue, 11 Feb 2020 19:30:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_jfZKjey8komTt97Mu-oFjWyFNG2cY4-o8yFAP1oGiug@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: kvm-devel <kvm@vger.kernel.org>, Marc Zyngier <maz@kernel.org>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Andre Przywara <andre.przywara@arm.com>, Andrew Murray <andrew.murray@arm.com>,
 kvmarm@lists.cs.columbia.edu, Eric Auger <eric.auger.pro@gmail.com>
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

Hi Peter,

On 2/11/20 5:24 PM, Peter Maydell wrote:
> On Thu, 30 Jan 2020 at 11:26, Eric Auger <eric.auger@redhat.com> wrote:
>>
>> Add 2 tests exercising chained counters. The first one uses
>> CPU_CYCLES and the second one uses SW_INCR.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> +static void test_chained_sw_incr(void)
>> +{
>> +       uint32_t events[] = { 0x0 /* SW_INCR */, 0x0 /* SW_INCR */};
> 
> Cut-n-paste error? This test relies on the CHAIN event but it
> isn't present in this list of events to pass to satisfy_prerequisites(),
> so I suspect the second element should be "0x1e /* CHAIN */" ?
No that's not a cut-n-paste error. I may rename the test into test_sw_incr.

It starts by testing unchained SW_INCR.

chained SW_INCR testing start with
/* 64b SW_INCR */


> 
> (This makes the test fail on QEMU TCG, because we don't implement
> CHAIN.)
OK

Thanks

Eric
> 
> thanks
> -- PMM
> 

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
