Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 9663A38B901
	for <lists+kvmarm@lfdr.de>; Thu, 20 May 2021 23:31:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 27A544B11A;
	Thu, 20 May 2021 17:31:09 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.91
X-Spam-Level: 
X-Spam-Status: No, score=0.91 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nCgB+10AqQy3; Thu, 20 May 2021 17:31:09 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 64CC44B301;
	Thu, 20 May 2021 17:31:07 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 6807B4B200
 for <kvmarm@lists.cs.columbia.edu>; Thu, 20 May 2021 17:31:06 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mStg87mQXIXz for <kvmarm@lists.cs.columbia.edu>;
 Thu, 20 May 2021 17:31:04 -0400 (EDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com
 [209.85.167.46])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 454424B1F7
 for <kvmarm@lists.cs.columbia.edu>; Thu, 20 May 2021 17:31:04 -0400 (EDT)
Received: by mail-lf1-f46.google.com with SMTP id b26so10577720lfq.4
 for <kvmarm@lists.cs.columbia.edu>; Thu, 20 May 2021 14:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ewcVH7ybbe/n8+nzkmMx0r+7XrGSbJUpsG/BLFE/JFQ=;
 b=jpeIoJrgehHbS+dqP1XgldW7z0+b6uDeFAQscuvdUA7ixmeNWeVyBJNSOh385SIop4
 0AU5LmfVSLuXSjZu8U1wrY2yxYClU7lXVipZshhIRUvwLM1JcxYNHKem7dob9IYYRBJ2
 2tpUy6rqNwF41OOtfpMZkVtjrkhIOc4dCwFEL1v0cQ57U399s5NU+SFQgDNRqo5gj9E6
 KFnKqObImtNXHbuPZauwVNxBLtTbsgiGD7G9PBoorNL2jO5/2+bMgIZUSoHfDT4l0Fcs
 TjD4Xles7GK111G6w5yj1ySilbKPpWIi41sQW5p4q1aA4kNQoEtHnVZA4K74Lk/29p4T
 DMPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ewcVH7ybbe/n8+nzkmMx0r+7XrGSbJUpsG/BLFE/JFQ=;
 b=tR80wJQ63EGXedjN7NM5nJlUdO72YLWnK3nciqc+jkmEBoBUtu4LqyFJWSAo0ELwJ8
 sQFO5saGyuEC35yvccnrD/ok8FEMxMg6+5VTQt2V90n3ZDRVvx0JctCcqhUtwQ8PPxU/
 o8bQq2GBux458/DsD/H+X//ORG8B+jk2mSRl+sPAYu2+qjFbER8mS8tN2UZjIU0NSuaN
 H1Vi7HMpxL+ybiVu4j8/86qlHe7D0cpuUCEYn0k5IlsWe6Hja0OAmEtTh5Jwu3OJjl+c
 CfE1F00f3eF+TWm+Dnnztwhurh89nzhnD3ll7dCSlOrG7ZZuUhmRUNRzJdSZOkNEqszw
 Jptg==
X-Gm-Message-State: AOAM5316auZMYdPrwA3NYeOPKGdpgCWX2/dz1D7qWl5De5Xglepem/OP
 CK629RsXpfMpTcptT51JQmNBNuyFKjX7vtpXYHdPGQ==
X-Google-Smtp-Source: ABdhPJztD/SkZ7Km31dTkM1ndTf/yzu3dibr8iXoJiQ8HR9DqiV/tJikxnMjLumsw6a8jfdUBB2g9BvOsiKf10pB0rk=
X-Received: by 2002:a05:6512:228d:: with SMTP id
 f13mr4039027lfu.178.1621546262478; 
 Thu, 20 May 2021 14:31:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210517145314.157626-1-jingzhangos@google.com>
 <20210517145314.157626-5-jingzhangos@google.com> <YKWKbfXwVx0+G0OX@google.com>
In-Reply-To: <YKWKbfXwVx0+G0OX@google.com>
From: Jing Zhang <jingzhangos@google.com>
Date: Thu, 20 May 2021 16:30:50 -0500
Message-ID: <CAAdAUtgdWR0fi0NkPEKTbeNLpoi2j1M8xo0-LpSVM03GhRmJ5g@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] KVM: selftests: Add selftest for KVM statistics
 data binary interface
To: Ricardo Koller <ricarkol@google.com>
Cc: KVM <kvm@vger.kernel.org>, David Hildenbrand <david@redhat.com>,
 Paul Mackerras <paulus@ozlabs.org>,
 Linuxkselftest <linux-kselftest@vger.kernel.org>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, Will Deacon <will@kernel.org>,
 KVMARM <kvmarm@lists.cs.columbia.edu>,
 Emanuele Giuseppe Esposito <eesposit@redhat.com>,
 LinuxS390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.ibm.com>,
 Oliver Upton <oupton@google.com>, Marc Zyngier <maz@kernel.org>,
 Huacai Chen <chenhuacai@kernel.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 David Rientjes <rientjes@google.com>, KVMPPC <kvm-ppc@vger.kernel.org>,
 Jim Mattson <jmattson@google.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Sean Christopherson <seanjc@google.com>, Cornelia Huck <cohuck@redhat.com>,
 Peter Shier <pshier@google.com>, LinuxMIPS <linux-mips@vger.kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>
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

On Wed, May 19, 2021 at 5:00 PM Ricardo Koller <ricarkol@google.com> wrote:
>
> On Mon, May 17, 2021 at 02:53:14PM +0000, Jing Zhang wrote:
> > Add selftest to check KVM stats descriptors validity.
> >
> > Signed-off-by: Jing Zhang <jingzhangos@google.com>
> > ---
> >  tools/testing/selftests/kvm/.gitignore        |   1 +
> >  tools/testing/selftests/kvm/Makefile          |   3 +
> >  .../testing/selftests/kvm/include/kvm_util.h  |   3 +
> >  .../selftests/kvm/kvm_bin_form_stats.c        | 379 ++++++++++++++++++
> >  tools/testing/selftests/kvm/lib/kvm_util.c    |  12 +
> >  5 files changed, 398 insertions(+)
> >  create mode 100644 tools/testing/selftests/kvm/kvm_bin_form_stats.c
> >
> > diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
> > index bd83158e0e0b..35796667c944 100644
> > --- a/tools/testing/selftests/kvm/.gitignore
> > +++ b/tools/testing/selftests/kvm/.gitignore
> > @@ -43,3 +43,4 @@
> >  /memslot_modification_stress_test
> >  /set_memory_region_test
> >  /steal_time
> > +/kvm_bin_form_stats
> > diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
> > index e439d027939d..2984c86c848a 100644
> > --- a/tools/testing/selftests/kvm/Makefile
> > +++ b/tools/testing/selftests/kvm/Makefile
> > @@ -76,6 +76,7 @@ TEST_GEN_PROGS_x86_64 += kvm_page_table_test
> >  TEST_GEN_PROGS_x86_64 += memslot_modification_stress_test
> >  TEST_GEN_PROGS_x86_64 += set_memory_region_test
> >  TEST_GEN_PROGS_x86_64 += steal_time
> > +TEST_GEN_PROGS_x86_64 += kvm_bin_form_stats
> >
> >  TEST_GEN_PROGS_aarch64 += aarch64/get-reg-list
> >  TEST_GEN_PROGS_aarch64 += aarch64/get-reg-list-sve
> > @@ -87,6 +88,7 @@ TEST_GEN_PROGS_aarch64 += kvm_create_max_vcpus
> >  TEST_GEN_PROGS_aarch64 += kvm_page_table_test
> >  TEST_GEN_PROGS_aarch64 += set_memory_region_test
> >  TEST_GEN_PROGS_aarch64 += steal_time
> > +TEST_GEN_PROGS_aarch64 += kvm_bin_form_stats
> >
> >  TEST_GEN_PROGS_s390x = s390x/memop
> >  TEST_GEN_PROGS_s390x += s390x/resets
> > @@ -96,6 +98,7 @@ TEST_GEN_PROGS_s390x += dirty_log_test
> >  TEST_GEN_PROGS_s390x += kvm_create_max_vcpus
> >  TEST_GEN_PROGS_s390x += kvm_page_table_test
> >  TEST_GEN_PROGS_s390x += set_memory_region_test
> > +TEST_GEN_PROGS_s390x += kvm_bin_form_stats
> >
> >  TEST_GEN_PROGS += $(TEST_GEN_PROGS_$(UNAME_M))
> >  LIBKVM += $(LIBKVM_$(UNAME_M))
> > diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
> > index a8f022794ce3..ee01a67022d9 100644
> > --- a/tools/testing/selftests/kvm/include/kvm_util.h
> > +++ b/tools/testing/selftests/kvm/include/kvm_util.h
> > @@ -387,4 +387,7 @@ uint64_t get_ucall(struct kvm_vm *vm, uint32_t vcpu_id, struct ucall *uc);
> >  #define GUEST_ASSERT_4(_condition, arg1, arg2, arg3, arg4) \
> >       __GUEST_ASSERT((_condition), 4, (arg1), (arg2), (arg3), (arg4))
> >
> > +int vm_get_statsfd(struct kvm_vm *vm);
> > +int vcpu_get_statsfd(struct kvm_vm *vm, uint32_t vcpuid);
> > +
> >  #endif /* SELFTEST_KVM_UTIL_H */
> > diff --git a/tools/testing/selftests/kvm/kvm_bin_form_stats.c b/tools/testing/selftests/kvm/kvm_bin_form_stats.c
> > new file mode 100644
> > index 000000000000..dae44397d0f4
> > --- /dev/null
> > +++ b/tools/testing/selftests/kvm/kvm_bin_form_stats.c
> > @@ -0,0 +1,379 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * kvm_bin_form_stats
> > + *
> > + * Copyright (C) 2021, Google LLC.
> > + *
> > + * Test the fd-based interface for KVM statistics.
> > + */
> > +
> > +#define _GNU_SOURCE /* for program_invocation_short_name */
> > +#include <fcntl.h>
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <string.h>
> > +#include <errno.h>
> > +
> > +#include "test_util.h"
> > +
> > +#include "kvm_util.h"
> > +#include "asm/kvm.h"
> > +#include "linux/kvm.h"
> > +
> > +int vm_stats_test(struct kvm_vm *vm)
> > +{
> > +     ssize_t ret;
> > +     int i, stats_fd, err = -1;
> > +     size_t size_desc, size_data = 0;
> > +     struct kvm_stats_header header;
> > +     struct kvm_stats_desc *stats_desc, *pdesc;
> > +     struct kvm_vm_stats_data *stats_data;
> > +
> > +     /* Get fd for VM stats */
> > +     stats_fd = vm_get_statsfd(vm);
> > +     if (stats_fd < 0) {
> > +             perror("Get VM stats fd");
> > +             return err;
> > +     }
>
> It seems that the only difference between vm_stats_test and
> vcpu_stats_test is what function to use for getting the fd.  If that's
> the case, it might be better to move all the checks to a common
> function.
>
> > +     /* Read kvm vm stats header */
> > +     ret = read(stats_fd, &header, sizeof(header));
> > +     if (ret != sizeof(header)) {
> > +             perror("Read VM stats header");
> > +             goto out_close_fd;
> > +     }
> > +     size_desc = sizeof(*stats_desc) + header.name_size;
> > +     /* Check id string in header, that should start with "kvm" */
> > +     if (strncmp(header.id, "kvm", 3) ||
> > +                     strlen(header.id) >= KVM_STATS_ID_MAXLEN) {
> > +             printf("Invalid KVM VM stats type!\n");
> > +             goto out_close_fd;
> > +     }
> > +     /* Sanity check for other fields in header */
> > +     if (header.count == 0) {
> > +             err = 0;
> > +             goto out_close_fd;
> > +     }
>
> As mentioned by David, it would be better to replace the checks with
> TEST_ASSERT's. Most other selftests rely on TEST_ASSERT.
>
> > +     /* Check overlap */
> > +     if (header.desc_offset == 0 || header.data_offset == 0 ||
> > +                     header.desc_offset < sizeof(header) ||
> > +                     header.data_offset < sizeof(header)) {
> > +             printf("Invalid offset fields in header!\n");
> > +             goto out_close_fd;
> > +     }
> > +     if (header.desc_offset < header.data_offset &&
> > +                     (header.desc_offset + size_desc * header.count >
> > +                     header.data_offset)) {
>
> Could you make the check more strict?
>
> TEST_ASSERT(header.desc_offset + size_desc * header.count == header.data_offset,
>         "The data block should be at the end of the descriptor block.");
>
> > +             printf("VM Descriptor block is overlapped with data block!\n");
> > +             goto out_close_fd;
> > +     }
> > +
> > +     /* Allocate memory for stats descriptors */
> > +     stats_desc = calloc(header.count, size_desc);
> > +     if (!stats_desc) {
> > +             perror("Allocate memory for VM stats descriptors");
> > +             goto out_close_fd;
> > +     }
> > +     /* Read kvm vm stats descriptors */
> > +     ret = pread(stats_fd, stats_desc,
> > +                     size_desc * header.count, header.desc_offset);
>
> You could stress kvm_vm_stats_read() more by calling pread for more
> offsets. For example, for every descriptor:
>
>         pread(..., header.desc_offset + i * size_desc)
>
> I realize that the typical usage will be to read once for all
> descriptors. But kvm_vm_stats_read (and kvm_vcpu_stats_read) need to
> handle any offset, and doing so seems to be quite complicated.
>
> Actually, you could stress kvm_vm_stats_read() even more by calling it
> for _every_ possible offset (and eventually invalid offsets and sizes).
> One easier way to check this is by calling read all descriptors into
> some reference buffer using a single pread, and then call it for all
> offsets while comparing against the reference buf.
>
> > +     if (ret != size_desc * header.count) {
> > +             perror("Read KVM VM stats descriptors");
> > +             goto out_free_desc;
> > +     }
> > +     /* Sanity check for fields in descriptors */
> > +     for (i = 0; i < header.count; ++i) {
> > +             pdesc = (void *)stats_desc + i * size_desc;
>
> cast to (struct kvm_stats_desc *)
>
> > +             /* Check type,unit,scale boundaries */
> > +             if ((pdesc->flags & KVM_STATS_TYPE_MASK) > KVM_STATS_TYPE_MAX) {
> > +                     printf("Unknown KVM stats type!\n");
> > +                     goto out_free_desc;
> > +             }
> > +             if ((pdesc->flags & KVM_STATS_UNIT_MASK) > KVM_STATS_UNIT_MAX) {
> > +                     printf("Unknown KVM stats unit!\n");
> > +                     goto out_free_desc;
> > +             }
> > +             if ((pdesc->flags & KVM_STATS_SCALE_MASK) >
> > +                             KVM_STATS_SCALE_MAX) {
> > +                     printf("Unknown KVM stats scale!\n");
> > +                     goto out_free_desc;
> > +             }
> > +             /* Check exponent for stats unit
> > +              * Exponent for counter should be greater than or equal to 0
> > +              * Exponent for unit bytes should be greater than or equal to 0
> > +              * Exponent for unit seconds should be less than or equal to 0
> > +              * Exponent for unit clock cycles should be greater than or
> > +              * equal to 0
> > +              */
> > +             switch (pdesc->flags & KVM_STATS_UNIT_MASK) {
> > +             case KVM_STATS_UNIT_NONE:
> > +             case KVM_STATS_UNIT_BYTES:
> > +             case KVM_STATS_UNIT_CYCLES:
> > +                     if (pdesc->exponent < 0) {
> > +                             printf("Unsupported KVM stats unit!\n");
> > +                             goto out_free_desc;
> > +                     }
> > +                     break;
> > +             case KVM_STATS_UNIT_SECONDS:
> > +                     if (pdesc->exponent > 0) {
> > +                             printf("Unsupported KVM stats unit!\n");
> > +                             goto out_free_desc;
> > +                     }
> > +                     break;
>
>                 default:
>                         TEST_FAIL("Unexpected unit ...");
>
> > +             }
> > +             /* Check name string */
> > +             if (strlen(pdesc->name) >= header.name_size) {
> > +                     printf("KVM stats name(%s) too long!\n", pdesc->name);
> > +                     goto out_free_desc;
> > +             }
>
> Tighter check:
>
> TEST_ASSERT(header.name_size > 0 &&
>         strlen(pdesc->name) + 1 == header.name_size);
>
> > +             /* Check size field, which should not be zero */
> > +             if (pdesc->size == 0) {
> > +                     printf("KVM descriptor(%s) with size of 0!\n",
> > +                                     pdesc->name);
> > +                     goto out_free_desc;
> > +             }
> > +             size_data += pdesc->size * sizeof(stats_data->value[0]);
> > +     }
> > +     /* Check overlap */
> > +     if (header.data_offset < header.desc_offset &&
> > +             header.data_offset + size_data > header.desc_offset) {
> > +             printf("Data block is overlapped with Descriptor block!\n");
> > +             goto out_free_desc;
> > +     }
>
> This won't be needed if you use the suggested TEST_ASSERT (the other
> overlap check).
>
> > +     /* Check validity of all stats data size */
> > +     if (size_data < header.count * sizeof(stats_data->value[0])) {
> > +             printf("Data size is not correct!\n");
> > +             goto out_free_desc;
> > +     }
>
> Tighter check:
>
> TEST_ASSERT(size_data == header.count * stats_data->value[0]);
>
The value of size_data should be equal or larger than
header.count * stats_data->value[0], since some stats may
have size (the size field in descriptor) larger than 1.
> > +
> > +     /* Allocate memory for stats data */
> > +     stats_data = malloc(size_data);
> > +     if (!stats_data) {
> > +             perror("Allocate memory for VM stats data");
> > +             goto out_free_desc;
> > +     }
> > +     /* Read kvm vm stats data */
> > +     ret = pread(stats_fd, stats_data, size_data, header.data_offset);
> > +     if (ret != size_data) {
> > +             perror("Read KVM VM stats data");
> > +             goto out_free_data;
> > +     }
> > +
> > +     err = 0;
> > +out_free_data:
> > +     free(stats_data);
> > +out_free_desc:
> > +     free(stats_desc);
> > +out_close_fd:
> > +     close(stats_fd);
> > +     return err;
> > +}
> > +
> > +int vcpu_stats_test(struct kvm_vm *vm, int vcpu_id)
> > +{
> > +     ssize_t ret;
> > +     int i, stats_fd, err = -1;
> > +     size_t size_desc, size_data = 0;
> > +     struct kvm_stats_header header;
> > +     struct kvm_stats_desc *stats_desc, *pdesc;
> > +     struct kvm_vcpu_stats_data *stats_data;
> > +
> > +     /* Get fd for VCPU stats */
> > +     stats_fd = vcpu_get_statsfd(vm, vcpu_id);
> > +     if (stats_fd < 0) {
> > +             perror("Get VCPU stats fd");
> > +             return err;
> > +     }
> > +     /* Read kvm vcpu stats header */
> > +     ret = read(stats_fd, &header, sizeof(header));
> > +     if (ret != sizeof(header)) {
> > +             perror("Read VCPU stats header");
> > +             goto out_close_fd;
> > +     }
> > +     size_desc = sizeof(*stats_desc) + header.name_size;
> > +     /* Check id string in header, that should start with "kvm" */
> > +     if (strncmp(header.id, "kvm", 3) ||
> > +                     strlen(header.id) >= KVM_STATS_ID_MAXLEN) {
> > +             printf("Invalid KVM VCPU stats type!\n");
> > +             goto out_close_fd;
> > +     }
> > +     /* Sanity check for other fields in header */
> > +     if (header.count == 0) {
> > +             err = 0;
> > +             goto out_close_fd;
> > +     }
> > +     /* Check overlap */
> > +     if (header.desc_offset == 0 || header.data_offset == 0 ||
> > +                     header.desc_offset < sizeof(header) ||
> > +                     header.data_offset < sizeof(header)) {
> > +             printf("Invalid offset fields in header!\n");
> > +             goto out_close_fd;
> > +     }
> > +     if (header.desc_offset < header.data_offset &&
> > +                     (header.desc_offset + size_desc * header.count >
> > +                     header.data_offset)) {
> > +             printf("VCPU Descriptor block is overlapped with data block!\n");
> > +             goto out_close_fd;
> > +     }
>
> Same as above (tighter check).
>
> > +
> > +     /* Allocate memory for stats descriptors */
> > +     stats_desc = calloc(header.count, size_desc);
> > +     if (!stats_desc) {
> > +             perror("Allocate memory for VCPU stats descriptors");
> > +             goto out_close_fd;
> > +     }
> > +     /* Read kvm vcpu stats descriptors */
> > +     ret = pread(stats_fd, stats_desc,
> > +                     size_desc * header.count, header.desc_offset);
> > +     if (ret != size_desc * header.count) {
> > +             perror("Read KVM VCPU stats descriptors");
> > +             goto out_free_desc;
> > +     }
> > +     /* Sanity check for fields in descriptors */
> > +     for (i = 0; i < header.count; ++i) {
> > +             pdesc = (void *)stats_desc + i * size_desc;
> > +             /* Check boundaries */
> > +             if ((pdesc->flags & KVM_STATS_TYPE_MASK) > KVM_STATS_TYPE_MAX) {
> > +                     printf("Unknown KVM stats type!\n");
> > +                     goto out_free_desc;
> > +             }
> > +             if ((pdesc->flags & KVM_STATS_UNIT_MASK) > KVM_STATS_UNIT_MAX) {
> > +                     printf("Unknown KVM stats unit!\n");
> > +                     goto out_free_desc;
> > +             }
> > +             if ((pdesc->flags & KVM_STATS_SCALE_MASK) >
> > +                             KVM_STATS_SCALE_MAX) {
> > +                     printf("Unknown KVM stats scale!\n");
> > +                     goto out_free_desc;
> > +             }
> > +             /* Check exponent for stats unit
> > +              * Exponent for counter should be greater than or equal to 0
> > +              * Exponent for unit bytes should be greater than or equal to 0
> > +              * Exponent for unit seconds should be less than or equal to 0
> > +              * Exponent for unit clock cycles should be greater than or
> > +              * equal to 0
> > +              */
> > +             switch (pdesc->flags & KVM_STATS_UNIT_MASK) {
> > +             case KVM_STATS_UNIT_NONE:
> > +             case KVM_STATS_UNIT_BYTES:
> > +             case KVM_STATS_UNIT_CYCLES:
> > +                     if (pdesc->exponent < 0) {
> > +                             printf("Unsupported KVM stats unit!\n");
> > +                             goto out_free_desc;
> > +                     }
> > +                     break;
> > +             case KVM_STATS_UNIT_SECONDS:
> > +                     if (pdesc->exponent > 0) {
> > +                             printf("Unsupported KVM stats unit!\n");
> > +                             goto out_free_desc;
> > +                     }
> > +                     break;
> > +             }
> > +             /* Check name string */
> > +             if (strlen(pdesc->name) >= header.name_size) {
> > +                     printf("KVM stats name(%s) too long!\n", pdesc->name);
> > +                     goto out_free_desc;
> > +             }
> > +             /* Check size field, which should not be zero */
> > +             if (pdesc->size == 0) {
> > +                     printf("KVM descriptor(%s) with size of 0!\n",
> > +                                     pdesc->name);
> > +                     goto out_free_desc;
> > +             }
> > +             size_data += pdesc->size * sizeof(stats_data->value[0]);
> > +     }
> > +     /* Check overlap */
> > +     if (header.data_offset < header.desc_offset &&
> > +             header.data_offset + size_data > header.desc_offset) {
> > +             printf("Data block is overlapped with Descriptor block!\n");
> > +             goto out_free_desc;
> > +     }
> > +     /* Check validity of all stats data size */
> > +     if (size_data < header.count * sizeof(stats_data->value[0])) {
> > +             printf("Data size is not correct!\n");
> > +             goto out_free_desc;
> > +     }
> > +
> > +     /* Allocate memory for stats data */
> > +     stats_data = malloc(size_data);
> > +     if (!stats_data) {
> > +             perror("Allocate memory for VCPU stats data");
> > +             goto out_free_desc;
> > +     }
> > +     /* Read kvm vcpu stats data */
> > +     ret = pread(stats_fd, stats_data, size_data, header.data_offset);
> > +     if (ret != size_data) {
> > +             perror("Read KVM VCPU stats data");
> > +             goto out_free_data;
> > +     }
> > +
> > +     err = 0;
> > +out_free_data:
> > +     free(stats_data);
> > +out_free_desc:
> > +     free(stats_desc);
> > +out_close_fd:
> > +     close(stats_fd);
> > +     return err;
> > +}
> > +
> > +/*
> > + * Usage: kvm_bin_form_stats [#vm] [#vcpu]
> > + * The first parameter #vm set the number of VMs being created.
> > + * The second parameter #vcpu set the number of VCPUs being created.
> > + * By default, 1 VM and 1 VCPU for the VM would be created for testing.
> > + */
> > +
> > +int main(int argc, char *argv[])
> > +{
> > +     int max_vm = 1, max_vcpu = 1, ret, i, j, err = -1;
> > +     struct kvm_vm **vms;
> > +
> > +     /* Get the number of VMs and VCPUs that would be created for testing. */
> > +     if (argc > 1) {
> > +             max_vm = strtol(argv[1], NULL, 0);
> > +             if (max_vm <= 0)
> > +                     max_vm = 1;
> > +     }
> > +     if (argc > 2) {
> > +             max_vcpu = strtol(argv[2], NULL, 0);
> > +             if (max_vcpu <= 0)
> > +                     max_vcpu = 1;
> > +     }
> > +
> > +     /* Check the extension for binary stats */
> > +     ret = kvm_check_cap(KVM_CAP_STATS_BINARY_FD);
> > +     if (ret < 0) {
> > +             printf("Binary form statistics interface is not supported!\n");
> > +             return err;
> > +     }
> > +
> > +     /* Create VMs and VCPUs */
> > +     vms = malloc(sizeof(vms[0]) * max_vm);
> > +     if (!vms) {
> > +             perror("Allocate memory for storing VM pointers");
> > +             return err;
> > +     }
> > +     for (i = 0; i < max_vm; ++i) {
> > +             vms[i] = vm_create(VM_MODE_DEFAULT,
> > +                             DEFAULT_GUEST_PHY_PAGES, O_RDWR);
> > +             for (j = 0; j < max_vcpu; ++j)
> > +                     vm_vcpu_add(vms[i], j);
> > +     }
> > +
> > +     /* Check stats read for every VM and VCPU */
> > +     for (i = 0; i < max_vm; ++i) {
> > +             if (vm_stats_test(vms[i]))
> > +                     goto out_free_vm;
> > +             for (j = 0; j < max_vcpu; ++j) {
> > +                     if (vcpu_stats_test(vms[i], j))
> > +                             goto out_free_vm;
> > +             }
> > +     }
> > +
> > +     err = 0;
> > +out_free_vm:
> > +     for (i = 0; i < max_vm; ++i)
> > +             kvm_vm_free(vms[i]);
> > +     free(vms);
> > +     return err;
> > +}
> > diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> > index fc83f6c5902d..d9e0b2c8b906 100644
> > --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> > +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> > @@ -2090,3 +2090,15 @@ unsigned int vm_calc_num_guest_pages(enum vm_guest_mode mode, size_t size)
> >       n = DIV_ROUND_UP(size, vm_guest_mode_params[mode].page_size);
> >       return vm_adjust_num_guest_pages(mode, n);
> >  }
> > +
> > +int vm_get_statsfd(struct kvm_vm *vm)
> > +{
> > +     return ioctl(vm->fd, KVM_STATS_GETFD, NULL);
> > +}
> > +
> > +int vcpu_get_statsfd(struct kvm_vm *vm, uint32_t vcpuid)
> > +{
> > +     struct vcpu *vcpu = vcpu_find(vm, vcpuid);
> > +
> > +     return ioctl(vcpu->fd, KVM_STATS_GETFD, NULL);
> > +}
> > --
> > 2.31.1.751.gd2f1c929bd-goog
> >
> > _______________________________________________
> > kvmarm mailing list
> > kvmarm@lists.cs.columbia.edu
> > https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
