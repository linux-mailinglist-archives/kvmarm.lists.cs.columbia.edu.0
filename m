Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8314048FD
	for <lists+kvmarm@lfdr.de>; Thu,  9 Sep 2021 13:10:35 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 961844B119;
	Thu,  9 Sep 2021 07:10:34 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ocCyLNDY28nh; Thu,  9 Sep 2021 07:10:34 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 255004B10C;
	Thu,  9 Sep 2021 07:10:33 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 0CD634B105
 for <kvmarm@lists.cs.columbia.edu>; Thu,  9 Sep 2021 07:10:32 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aY3BcfDLAGmz for <kvmarm@lists.cs.columbia.edu>;
 Thu,  9 Sep 2021 07:10:30 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 75F0C4A7FD
 for <kvmarm@lists.cs.columbia.edu>; Thu,  9 Sep 2021 07:10:30 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B19A431B;
 Thu,  9 Sep 2021 04:10:29 -0700 (PDT)
Received: from [192.168.0.110] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4AC433F73D;
 Thu,  9 Sep 2021 04:10:27 -0700 (PDT)
Subject: Re: [kvm-unit-tests RFC PATCH 4/5] scripts: Generate kvmtool
 standalone tests
To: Andrew Jones <drjones@redhat.com>
References: <20210702163122.96110-1-alexandru.elisei@arm.com>
 <20210702163122.96110-5-alexandru.elisei@arm.com>
 <20210907102135.i2w3r7j4zyj736b5@gator>
 <ee11a10a-c3e6-b9ce-81e1-147025a9b5bd@arm.com>
 <20210908160743.l4hrl4de7wkxwuda@gator>
From: Alexandru Elisei <alexandru.elisei@arm.com>
Message-ID: <9d5da497-7070-31ef-282a-a11a86e0102e@arm.com>
Date: Thu, 9 Sep 2021 12:11:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210908160743.l4hrl4de7wkxwuda@gator>
Content-Language: en-US
Cc: lvivier@redhat.com, linux-s390@vger.kernel.org, thuth@redhat.com,
 frankja@linux.ibm.com, kvm@vger.kernel.org, david@redhat.com,
 andre.przywara@arm.com, cohuck@redhat.com, kvm-ppc@vger.kernel.org,
 vivek.gautam@arm.com, maz@kernel.org, pbonzini@redhat.com,
 imbrenda@linux.ibm.com, kvmarm@lists.cs.columbia.edu
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

On 9/8/21 5:07 PM, Andrew Jones wrote:
> On Wed, Sep 08, 2021 at 04:37:39PM +0100, Alexandru Elisei wrote:
>> Hi Drew,
>>
>> On 9/7/21 11:21 AM, Andrew Jones wrote:
>>> On Fri, Jul 02, 2021 at 05:31:21PM +0100, Alexandru Elisei wrote:
>>>> Add support for the standalone target when running kvm-unit-tests under
>>>> kvmtool.
>>>>
>>>> Example command line invocation:
>>>>
>>>> $ ./configure --target=kvmtool
>>>> $ make clean && make standalone
>>>>
>>>> Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
>>>> ---
>>>>  scripts/mkstandalone.sh | 14 +++++++-------
>>>>  1 file changed, 7 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/scripts/mkstandalone.sh b/scripts/mkstandalone.sh
>>>> index 16f461c06842..d84bdb7e278c 100755
>>>> --- a/scripts/mkstandalone.sh
>>>> +++ b/scripts/mkstandalone.sh
>>>> @@ -44,6 +44,10 @@ generate_test ()
>>>>  	config_export ARCH_NAME
>>>>  	config_export PROCESSOR
>>>>  
>>>> +	if [ "$ARCH" = "arm64" ] || [ "$ARCH" = "arm" ]; then
>>>> +		config_export TARGET
>>>> +	fi
>>> Should export unconditionally, since we'll want TARGET set
>>> unconditionally.
>> Yes, will do.
>>
>>>> +
>>>>  	echo "echo BUILD_HEAD=$(cat build-head)"
>>>>  
>>>>  	if [ ! -f $kernel ]; then
>>>> @@ -59,7 +63,7 @@ generate_test ()
>>>>  		echo 'export FIRMWARE'
>>>>  	fi
>>>>  
>>>> -	if [ "$ENVIRON_DEFAULT" = "yes" ] && [ "$ERRATATXT" ]; then
>>>> +	if [ "$TARGET" != "kvmtool" ] && [ "$ENVIRON_DEFAULT" = "yes" ] && [ "$ERRATATXT" ]; then
>>> I think it would be better to ensure that ENVIRON_DEFAULT is "no" for
>>> TARGET=kvmtool in configure.
>> From looking at the code, it is my understanding that with ENVIRON_DEFAULT=yes, an
>> initrd file is generated with the contents of erratatxt and other information, in
>> a key=value pair format. This initrd is then passed on to the test (please correct
>> me if I'm wrong). With ENVIRON_DEFAULT=no (set via ./configure
>> --disable-default-environ), this initrd is not generated.
>>
>> kvmtool doesn't have support for passing an initrd when loading firmware, so yes,
>> I believe the default should be no.
>>
>> However, I have two questions:
>>
>> 1. What happens when the user specifically enables the default environ via
>> ./configure --enable-default-environ --target=kvmtool? In my opinion, that should
>> be an error because the user wants something that is not possible with kvmtool
>> (loading an image with --firmware in kvmtool means that the initrd image it not
>> loaded into the guest memory and no node is generated for it in the dtb), but I
>> would like to hear your thoughts about it.
> As part of the forcing ENVIRON_DEFAULT to "no" for kvmtool in configure an
> error should be generated if a user tries to explicitly enable it.
>
>> 2. If the default environment is disabled, is it still possible for an user to
>> pass an initrd via other means? I couldn't find where that is implemented, so I'm
>> guessing it's not possible.
> Yes, a user could have a KVM_UNIT_TESTS_ENV environment variable set when
> they launch the tests. If that variable points to a file then it will get
> passed as an initrd. I guess you should also report a warning in arm/run
> if KVM_UNIT_TESTS_ENV is set which states that the environment file will
> be ignored when running with kvmtool.

Thank you for explaining it, I had looked at
scripts/arch-run.bash::initrd_create(), but it didn't click that setting the
KVM_UNIT_TESTS_ENV environment variable is enough to generate and use the initrd.

After looking at the code some more, in the logs the -initrd argument is shown as
a comment, instead of an actual argument that is passed to qemu:

timeout -k 1s --foreground 90s /usr/bin/qemu-system-aarch64 -nodefaults -machine
virt,gic-version=host,accel=kvm -cpu host -device virtio-serial-device -device
virtconsole,chardev=ctd -chardev testdev,id=ctd -device pci-testdev -display none
-serial stdio -kernel arm/cache.flat -smp 1 # -initrd /tmp/tmp.rUIZ3h9KLJ
QEMU_ACCEL = kvm
INFO: IDC-DIC: dcache clean to PoU required
INFO: IDC-DIC: icache invalidation to PoU required
PASS: IDC-DIC: code generation
SUMMARY: 1 tests

This is done intentionally in scripts/arch-run.bash::run_qemu(). I don't
understand the reason for that. When I first looked at the logs, I was sure that
no initrd is passed to the test. I had to go dig through the scripts to figure out
that the "#" sign (which marks the beginning of a comment) is not present in the
qemu invocation.

Thanks,

Alex

>
> There aren't currently any other ways to invoke the addition of the
> -initrd command line option, because so far we only support passing a
> single file to test (the environment "file"). If we ever want to pass
> more files, then we'd need to create a simple file system on the initrd
> and make it possible to add -initrd even when no environment is desired.
> But, that may never happen.
>
> Thanks,
> drew
>
>> Thanks,
>>
>> Alex
>>
>>>
>>>>  		temp_file ERRATATXT "$ERRATATXT"
>>>>  		echo 'export ERRATATXT'
>>>>  	fi
>>>> @@ -95,12 +99,8 @@ function mkstandalone()
>>>>  	echo Written $standalone.
>>>>  }
>>>>  
>>>> -if [ "$TARGET" = "kvmtool" ]; then
>>>> -	echo "Standalone tests not supported with kvmtool"
>>>> -	exit 2
>>>> -fi
>>>> -
>>>> -if [ "$ENVIRON_DEFAULT" = "yes" ] && [ "$ERRATATXT" ] && [ ! -f "$ERRATATXT" ]; then
>>>> +if [ "$TARGET" != "kvmtool" ] && [ "$ENVIRON_DEFAULT" = "yes" ] && \
>>>> +		[ "$ERRATATXT" ] && [ ! -f "$ERRATATXT" ]; then
>>>>  	echo "$ERRATATXT not found. (ERRATATXT=$ERRATATXT)" >&2
>>>>  	exit 2
>>>>  fi
>>>> -- 
>>>> 2.32.0
>>>>
>>> Thanks,
>>> drew 
>>>
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
