Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id D5AE71598A7
	for <lists+kvmarm@lfdr.de>; Tue, 11 Feb 2020 19:31:49 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 89E884AF1D;
	Tue, 11 Feb 2020 13:31:49 -0500 (EST)
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
	with ESMTP id pcQoGNNgxk8L; Tue, 11 Feb 2020 13:31:49 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 788CD4AF13;
	Tue, 11 Feb 2020 13:31:48 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 514254AF04
 for <kvmarm@lists.cs.columbia.edu>; Tue, 11 Feb 2020 13:31:47 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TLc7XO3hdo99 for <kvmarm@lists.cs.columbia.edu>;
 Tue, 11 Feb 2020 13:31:46 -0500 (EST)
Received: from us-smtp-delivery-1.mimecast.com
 (us-smtp-delivery-1.mimecast.com [207.211.31.120])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 72B284AEE2
 for <kvmarm@lists.cs.columbia.edu>; Tue, 11 Feb 2020 13:31:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581445906;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hd8VPzkhK8n9/lwhgrwAyRD2bhnpTGXUCuZRADWF3wk=;
 b=BAxuw2sqGYBH/LCd+g1Jut/WCnvNXBdTMnUJ/5z5t0pvmdJvDNROHPJcOkEIFNwRIBeCa/
 npjiHZc+wcVaFHJnShIKoOjliEs44CDBqRVDvXunTZUltPO4eqYG4fSVQ3I6ru/j/AVZEV
 jF0N49B5+90A5EfDePDEB4+BaFn8pOw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-63-2Smuds_WMvW744S-HoF1CA-1; Tue, 11 Feb 2020 13:31:42 -0500
X-MC-Unique: 2Smuds_WMvW744S-HoF1CA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 142A5477;
 Tue, 11 Feb 2020 18:31:40 +0000 (UTC)
Received: from [10.36.116.37] (ovpn-116-37.ams2.redhat.com [10.36.116.37])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6303960499;
 Tue, 11 Feb 2020 18:31:35 +0000 (UTC)
Subject: Re: [kvm-unit-tests PATCH v2 5/9] arm: pmu: Basic event counter Tests
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200130112510.15154-1-eric.auger@redhat.com>
 <20200130112510.15154-6-eric.auger@redhat.com>
 <CAFEAcA9Yc9dKTCcP3fP93tQU62Q=2FYOoYGvUqfiOMY=pYV_RA@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <94fcec29-d44a-98cf-c397-b23b5d355eac@redhat.com>
Date: Tue, 11 Feb 2020 19:31:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9Yc9dKTCcP3fP93tQU62Q=2FYOoYGvUqfiOMY=pYV_RA@mail.gmail.com>
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

On 2/11/20 5:27 PM, Peter Maydell wrote:
> On Thu, 30 Jan 2020 at 11:26, Eric Auger <eric.auger@redhat.com> wrote:
>>
>> Adds the following tests:
>> - event-counter-config: test event counter configuration
>> - basic-event-count:
>>   - programs counters #0 and #1 to count 2 required events
>>   (resp. CPU_CYCLES and INST_RETIRED). Counter #0 is preset
>>   to a value close enough to the 32b
>>   overflow limit so that we check the overflow bit is set
>>   after the execution of the asm loop.
>> - mem-access: counts MEM_ACCESS event on counters #0 and #1
>>   with and without 32-bit overflow.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
>> +static bool satisfy_prerequisites(uint32_t *events, unsigned int nb_events)
>> +{
>> +       int i;
>> +
>> +       if (pmu.nb_implemented_counters < nb_events) {
>> +               report_skip("Skip test as number of counters is too small (%d)",
>> +                           pmu.nb_implemented_counters);
>> +               return false;
>> +       }
>> +
>> +       for (i = 0; i < nb_events; i++) {
>> +               if (!is_event_supported(events[i], false)) {
>> +                       report_skip("Skip test as event %d is not supported",
>> +                                   events[i]);
> 
> Event numbers are given in hex in the Arm ARM and also
> specified in hex in your test source code. I think it
> would be more helpful if the message here used "0x%x", to
> save the reader having to do the decimal-to-hex conversion
> to find the event in the spec or the test case.
Sure I will fix that

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
