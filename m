Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 81A173753D6
	for <lists+kvmarm@lfdr.de>; Thu,  6 May 2021 14:28:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id DE6B94B5D2;
	Thu,  6 May 2021 08:28:01 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.209
X-Spam-Level: 
X-Spam-Status: No, score=0.209 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_LOW=-0.7,
	T_DKIM_INVALID=0.01] autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id STeD8RWWGZiC; Thu,  6 May 2021 08:28:00 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C8E3D4B5DB;
	Thu,  6 May 2021 08:28:00 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C25E54B5DC
 for <kvmarm@lists.cs.columbia.edu>; Thu,  6 May 2021 08:27:57 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Dr7EIBSJlr+I for <kvmarm@lists.cs.columbia.edu>;
 Thu,  6 May 2021 08:27:56 -0400 (EDT)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D06634B5D2
 for <kvmarm@lists.cs.columbia.edu>; Thu,  6 May 2021 08:27:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1620304076;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g/Jq4Aja0bCfCKVzxKal7zHdzh6q0/QEvd13TJdhL7A=;
 b=Pm0797BhSfUA8Q3O0/h9wvbabYd45GjimzL5pqvt3zhB6VdamjoswxvX5HasMqRaucZbGy
 YIHpc6ljkd0/lDU37hTV7jLCglI9+QhxAFmWizU6R1n5Wex6TzVo7gKwVENHGh4NyED5iF
 mZDN7vgVUTaFbib7iWjtHm2RFAIwpCQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-vygwBAVtMOasz9eHhQIczQ-1; Thu, 06 May 2021 08:27:55 -0400
X-MC-Unique: vygwBAVtMOasz9eHhQIczQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E81E61922963;
 Thu,  6 May 2021 12:27:53 +0000 (UTC)
Received: from [10.36.113.191] (ovpn-113-191.ams2.redhat.com [10.36.113.191])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5EFAD5D9E2;
 Thu,  6 May 2021 12:27:52 +0000 (UTC)
Subject: Re: [PATCH v2 2/5] KVM: selftests: Introduce UCALL_UNHANDLED for
 unhandled vector reporting
To: Andrew Jones <drjones@redhat.com>, Ricardo Koller <ricarkol@google.com>
References: <20210430232408.2707420-1-ricarkol@google.com>
 <20210430232408.2707420-3-ricarkol@google.com>
 <20210503110909.n7chjg2run6gaeq3@gator.home>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <da543870-bde1-8ac3-16b8-d253ce3423ce@redhat.com>
Date: Thu, 6 May 2021 14:27:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210503110909.n7chjg2run6gaeq3@gator.home>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: pbonzini@redhat.com, kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
 maz@kernel.org
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

Hi Ricardo,

On 5/3/21 1:09 PM, Andrew Jones wrote:
> On Fri, Apr 30, 2021 at 04:24:04PM -0700, Ricardo Koller wrote:
>> x86, the only arch implementing exception handling, reports unhandled
>> vectors using port IO at a specific port number. This replicates what
>> ucall already does.
>>
>> Introduce a new ucall type, UCALL_UNHANDLED, for guests to report
>> unhandled exceptions. Then replace the x86 unhandled vector exception
>> reporting to use it instead of port IO.  This new ucall type will be
>> used in the next commits by arm64 to report unhandled vectors as well.
>>
>> Tested: Forcing a page fault in the ./x86_64/xapic_ipi_test
>> 	halter_guest_code() shows this:
>>
>> 	$ ./x86_64/xapic_ipi_test
>> 	...
>> 	  Unexpected vectored event in guest (vector:0xe)
>>
>> Signed-off-by: Ricardo Koller <ricarkol@google.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric

>> ---
>>  tools/testing/selftests/kvm/include/kvm_util.h    |  1 +
>>  .../selftests/kvm/include/x86_64/processor.h      |  2 --
>>  .../testing/selftests/kvm/lib/x86_64/processor.c  | 15 ++++++---------
>>  3 files changed, 7 insertions(+), 11 deletions(-)
>>
>> diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
>> index bea4644d645d..7880929ea548 100644
>> --- a/tools/testing/selftests/kvm/include/kvm_util.h
>> +++ b/tools/testing/selftests/kvm/include/kvm_util.h
>> @@ -347,6 +347,7 @@ enum {
>>  	UCALL_SYNC,
>>  	UCALL_ABORT,
>>  	UCALL_DONE,
>> +	UCALL_UNHANDLED,
>>  };
>>  
>>  #define UCALL_MAX_ARGS 6
>> diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
>> index 12889d3e8948..ff4da2f95b13 100644
>> --- a/tools/testing/selftests/kvm/include/x86_64/processor.h
>> +++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
>> @@ -53,8 +53,6 @@
>>  #define CPUID_PKU		(1ul << 3)
>>  #define CPUID_LA57		(1ul << 16)
>>  
>> -#define UNEXPECTED_VECTOR_PORT 0xfff0u
>> -
>>  /* General Registers in 64-Bit Mode */
>>  struct gpr64_regs {
>>  	u64 rax;
>> diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
>> index e156061263a6..96e2bd9d66eb 100644
>> --- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
>> +++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
>> @@ -1207,7 +1207,7 @@ static void set_idt_entry(struct kvm_vm *vm, int vector, unsigned long addr,
>>  
>>  void kvm_exit_unexpected_vector(uint32_t value)
>>  {
>> -	outl(UNEXPECTED_VECTOR_PORT, value);
>> +	ucall(UCALL_UNHANDLED, 1, value);
>>  }
>>  
>>  void route_exception(struct ex_regs *regs)
>> @@ -1260,16 +1260,13 @@ void vm_install_vector_handler(struct kvm_vm *vm, int vector,
>>  
>>  void assert_on_unhandled_exception(struct kvm_vm *vm, uint32_t vcpuid)
>>  {
>> -	if (vcpu_state(vm, vcpuid)->exit_reason == KVM_EXIT_IO
>> -		&& vcpu_state(vm, vcpuid)->io.port == UNEXPECTED_VECTOR_PORT
>> -		&& vcpu_state(vm, vcpuid)->io.size == 4) {
>> -		/* Grab pointer to io data */
>> -		uint32_t *data = (void *)vcpu_state(vm, vcpuid)
>> -			+ vcpu_state(vm, vcpuid)->io.data_offset;
>> +	struct ucall uc;
>>  
>> +	if (get_ucall(vm, vcpuid, &uc) == UCALL_UNHANDLED) {
>> +		uint64_t vector = uc.args[0];
>>  		TEST_ASSERT(false,
>> -			    "Unexpected vectored event in guest (vector:0x%x)",
>> -			    *data);
>> +			    "Unexpected vectored event in guest (vector:0x%lx)",
>> +			    vector);
> 
> nit: Could have changed this TEST_ASSERT(false, ...) to TEST_FAIL while
> touching it.
> 
>>  	}
>>  }
>>  
>> -- 
>> 2.31.1.527.g47e6f16901-goog
>>
> 
> Reviewed-by: Andrew Jones <drjones@redhat.com>
> 
> Thanks,
> drew
> 

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
