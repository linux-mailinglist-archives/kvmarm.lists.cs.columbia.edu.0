Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 87EF1212466
	for <lists+kvmarm@lfdr.de>; Thu,  2 Jul 2020 15:18:01 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0C8824B60D;
	Thu,  2 Jul 2020 09:18:01 -0400 (EDT)
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
	with ESMTP id wNysDV583Fg3; Thu,  2 Jul 2020 09:18:00 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CA2244B604;
	Thu,  2 Jul 2020 09:17:59 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 3C8DF4B5CC
 for <kvmarm@lists.cs.columbia.edu>; Thu,  2 Jul 2020 09:17:58 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id deUYKqkBqNcx for <kvmarm@lists.cs.columbia.edu>;
 Thu,  2 Jul 2020 09:17:57 -0400 (EDT)
Received: from us-smtp-1.mimecast.com (us-smtp-1.mimecast.com [207.211.31.81])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 46A074B476
 for <kvmarm@lists.cs.columbia.edu>; Thu,  2 Jul 2020 09:17:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593695877;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iPqmxCco2qOcPw6NCGzpbeppRDF5Nngtn4bMyEz2Q8g=;
 b=jG26Z2atWAtPxgu3qY2P4esKNtto0zU0Jv/qAUd8DAnSCatE8ZfwZQHpCLCMVhWa24sY0W
 w9i5tKX8Ufrnv3j8qhZoE5m68NQARe8B9SHaJgDI7iuIbjTDWqGyRitUIwMNeXAoL/AbM8
 rAJCUMhsN2lDoQ2UpAvxQaiU/21IM1w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-RM255m1bMSK_e0Skae9WbA-1; Thu, 02 Jul 2020 09:17:55 -0400
X-MC-Unique: RM255m1bMSK_e0Skae9WbA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EAE9819253C2;
 Thu,  2 Jul 2020 13:17:53 +0000 (UTC)
Received: from [10.36.112.70] (ovpn-112-70.ams2.redhat.com [10.36.112.70])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5DCCD5DD61;
 Thu,  2 Jul 2020 13:17:52 +0000 (UTC)
Subject: Re: [kvm-unit-tests PATCH v2 6/8] arm64: microbench: Allow each test
 to specify its running times
To: Andrew Jones <drjones@redhat.com>, Jingyi Wang <wangjingyi11@huawei.com>
References: <20200702030132.20252-1-wangjingyi11@huawei.com>
 <20200702030132.20252-7-wangjingyi11@huawei.com>
 <20200702052942.laodlgq2yrlxwsh4@kamzik.brq.redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <0ac90a80-2180-ee07-b614-dc2466b711a5@redhat.com>
Date: Thu, 2 Jul 2020 15:17:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200702052942.laodlgq2yrlxwsh4@kamzik.brq.redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: maz@kernel.org, kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org
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

Hi Jingyi,

On 7/2/20 7:29 AM, Andrew Jones wrote:
> On Thu, Jul 02, 2020 at 11:01:30AM +0800, Jingyi Wang wrote:
>> For some test in micro-bench can be time consuming, we add a
>> micro-bench test parameter to allow each individual test to specify
>> its running times.
>>
>> Signed-off-by: Jingyi Wang <wangjingyi11@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
>> ---
>>  arm/micro-bench.c | 25 ++++++++++++++-----------
>>  1 file changed, 14 insertions(+), 11 deletions(-)
>>
>> diff --git a/arm/micro-bench.c b/arm/micro-bench.c
>> index aeb60a7..506d2f9 100644
>> --- a/arm/micro-bench.c
>> +++ b/arm/micro-bench.c
>> @@ -223,17 +223,18 @@ struct exit_test {
>>  	const char *name;
>>  	bool (*prep)(void);
>>  	void (*exec)(void);
>> +	u32 times;
>>  	bool run;
>>  };
>>  
>>  static struct exit_test tests[] = {
>> -	{"hvc",			NULL,		hvc_exec,		true},
>> -	{"mmio_read_user",	NULL,		mmio_read_user_exec,	true},
>> -	{"mmio_read_vgic",	NULL,		mmio_read_vgic_exec,	true},
>> -	{"eoi",			NULL,		eoi_exec,		true},
>> -	{"ipi",			ipi_prep,	ipi_exec,		true},
>> -	{"ipi_hw",		ipi_hw_prep,	ipi_exec,		true},
>> -	{"lpi",			lpi_prep,	lpi_exec,		true},
>> +	{"hvc",			NULL,		hvc_exec,		NTIMES,		true},
>> +	{"mmio_read_user",	NULL,		mmio_read_user_exec,	NTIMES,		true},
>> +	{"mmio_read_vgic",	NULL,		mmio_read_vgic_exec,	NTIMES,		true},
>> +	{"eoi",			NULL,		eoi_exec,		NTIMES,		true},
>> +	{"ipi",			ipi_prep,	ipi_exec,		NTIMES,		true},
>> +	{"ipi_hw",		ipi_hw_prep,	ipi_exec,		NTIMES,		true},
>> +	{"lpi",			lpi_prep,	lpi_exec,		NTIMES,		true},
> 
> Now that we no longer use 'NTIMES' in functions we don't really need the
> define at all. We can just put 65536 directly into the table here for
> each test that needs 65536 times.
> 
> Thanks,
> drew
> 
>>  };
>>  
>>  struct ns_time {
>> @@ -254,7 +255,7 @@ static void ticks_to_ns_time(uint64_t ticks, struct ns_time *ns_time)
>>  
>>  static void loop_test(struct exit_test *test)
>>  {
>> -	uint64_t start, end, total_ticks, ntimes = NTIMES;
>> +	uint64_t start, end, total_ticks, ntimes = 0;
>>  	struct ns_time total_ns, avg_ns;
>>  
>>  	if (test->prep) {
>> @@ -265,15 +266,17 @@ static void loop_test(struct exit_test *test)
>>  	}
>>  	isb();
>>  	start = read_sysreg(cntpct_el0);
>> -	while (ntimes--)
>> +	while (ntimes < test->times) {
>>  		test->exec();
>> +		ntimes++;
>> +	}
>>  	isb();
>>  	end = read_sysreg(cntpct_el0);
>>  
>>  	total_ticks = end - start;
>>  	ticks_to_ns_time(total_ticks, &total_ns);
>> -	avg_ns.ns = total_ns.ns / NTIMES;
>> -	avg_ns.ns_frac = total_ns.ns_frac / NTIMES;
>> +	avg_ns.ns = total_ns.ns / ntimes;
>> +	avg_ns.ns_frac = total_ns.ns_frac / ntimes;
>>  
>>  	printf("%-30s%15" PRId64 ".%-15" PRId64 "%15" PRId64 ".%-15" PRId64 "\n",
>>  		test->name, total_ns.ns, total_ns.ns_frac, avg_ns.ns, avg_ns.ns_frac);
>> -- 
>> 2.19.1
>>
>>

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
